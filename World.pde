static final int SONAR_RANGE = 2; //<>//
static final int SALVAGE_RETRIVAL_RANGE = 1;
static final int SALVAGE_DEPOSIT_RANGE = 1;
static final int MAX_MOVE_COL_INCREMENT = 1;
static final int MAX_MOVE_ROW_INCREMENT = 1;

/**
 * Represents the game world grid, and manages the different elements within it.
 */
class World {
  private int maxRows;
  private int maxCols;
  private Cell[][] grid;
  private ArrayList<Element> elements;
  private HashMap<String, Integer> scores;

  /**
   * Creates a new grid with the specified number of rows and columns.
   * @param maxRows The number of rows in the grid.
   * @param maxCols The number of columns in the grid.
   */
  public World(int maxRows, int maxCols) {
    this.maxRows = maxRows;
    this.maxCols = maxCols;
    this.grid = new Cell[maxCols][maxRows];
    this.elements = new ArrayList<Element>();
    this.scores = new HashMap<String, Integer>();

    this.clear();
  }

  /**
   * Checks if a given column/row pair is within range for the world.
   *
   * @param col The column position
   * @param row The row position
   * @return True if the pair is valid, false if it is outside the world.
   */
  private boolean isInRange(int col, int row) {
    return !(col < 0 || col >= this.maxCols || row < 0 || row >= this.maxRows);
  }

  /**
   * Checks if the specified cells can be occupied.
   *
   * @param positionList The list of coordinates to check.
   * @param element The element that will occupy the cells.
   * @return True if all cells can be occupied, false otherwise.
   */
  private boolean canOccupyCells(Position2D[] positionList, Element element) {
    for (Position2D coordinates : positionList) {
      if (!this.isInRange(coordinates.col, coordinates.row)) {
        return false;
      }

      Cell cell = this.grid[coordinates.col][coordinates.row];
      if (!cell.canBeOccupied(element)) {
        return false;
      }
    }
    return true;
  }

  /**
   * Occupies the specified cells with the specified type only if all cells
   * can be occupied. This operation will fail if any of the cells cannot be
   * occupied.
   *
   * @param positionList The list of coordinates to occupy.
   * @param element The element that will occupy the cells.
   * @return True if all cells were occupied, false otherwise.
   */
  private boolean occupyCells(Position2D[] positionList, Element element) {
    for (Position2D coordinates : positionList) {
      Cell cell = this.grid[coordinates.col][coordinates.row];
      if (!cell.canBeOccupied(element)) {
        return false;
      }
    }

    for (Position2D coordinates : positionList) {
      Cell cell = this.grid[coordinates.col][coordinates.row];
      cell.occupy(element);
    }
    return true;
  }

  /**
   * Empties the specified cells of the specified type of occupation.
   *
   * @param positionList The list of coordinates to empty.
   * @param element The element to remove from the cells.
   *
   * @return True if all cells were emptied, false otherwise.
   */
  private void emptyCells(Position2D[] positionList, Element element) {
    for (Position2D coordinates : positionList) {
      if (!this.isInRange(coordinates.col, coordinates.row)) {

        // This should ideally never happen
        println("!!! Attempted to empty cells outside of grid.");
        return;
      }
      Cell cell = this.grid[coordinates.col][coordinates.row];
      cell.empty(element);
    }
  }

  /**
   * Processes a request by an element to move its position.
   *
   * @param element The element that made the request.
   * @param request The move request received from the element.
   */
  private void processRequest(Element element, MoveRequest request) {
    Position2D deltaStep = request.getData();
    deltaStep = new Position2D(
      min(deltaStep.col, MAX_MOVE_COL_INCREMENT),
      min(deltaStep.row, MAX_MOVE_ROW_INCREMENT));

    Position2D newPosition = element.getPosition().translate(deltaStep);
    Position2D[] oldGeometry = element.getGeometry();
    Position2D[] newGeometry = element.getGeometry(newPosition);

    this.emptyCells(oldGeometry, element);
    if (this.canOccupyCells(newGeometry, element)) {
      this.occupyCells(newGeometry, element);
      element.moveRelative(deltaStep);
    } else {
      this.occupyCells(oldGeometry, element);
    }
  }

  /**
   * Salvage request that requests the retrieval of salvage from a location
   * near the element.
   *
   * @param element The element that made the request.
   * @param request The salvage request received from the element.
   */
  private void processRequest(Element element, RetrieveSalvageRequest request) {
    Position2D salvagePos = request.getData();
    Position2D elementPos = element.getPosition();

    if (abs(salvagePos.col - elementPos.col) > SALVAGE_RETRIVAL_RANGE ||
      abs(salvagePos.row - elementPos.row) > SALVAGE_RETRIVAL_RANGE) {
      println("Attempt to retrieve salvage from too far (" + element.getName() + ")");
      return;
    }

    Cell targetCell = this.grid[salvagePos.col][salvagePos.row];
    if (targetCell.hasSalvage()) {
      Salvage salvageElement = targetCell.getSalvage();
      salvageElement.retrieveSalvage(salvagePos);
      this.emptyCells(new Position2D[] { salvagePos }, salvageElement);
    }
  }

  /**
   * Salvage request that requests the deposit of salvage to a location
   * corresponding to a salvage ship.
   *
   * @param element The element that made the request.
   * @param request The salvage deposit request received from the element.
   */
  private void processRequest(Element element, DepositSalvageRequest request) {
    Position2D shipPos = request.getData();
    Position2D elementPos = element.getPosition();

    if (abs(shipPos.col - elementPos.col) > SALVAGE_DEPOSIT_RANGE ||
      abs(shipPos.row - elementPos.row) > SALVAGE_DEPOSIT_RANGE) {
      println("Attempt to deposit salvage from too far (" + element.getName() + ")");
      return;
    }

    Cell targetCell = this.grid[shipPos.col][shipPos.row];
    if (targetCell.hasSalvageShip()) {
      SalvageShip salvageShipElement = targetCell.getSalvageShip();
      salvageShipElement.canDepositSalvage(shipPos);
      int salvageCount = ((Submersible)element).redeemSalvage();
      String name = element.getName();
      this.scores.put(name, this.scores.get(name) + salvageCount);
    }
  }

  /**
   * SONAR scan request. Scans the area around the element and reports
   * results to the element.
   *
   * @param element The element that made the request.
   * @param request The salvage request received from the element.
   */
  private void processRequest(Element element, SonarRequest request) {
    Position2D position = element.getPosition();
    int width = (SONAR_RANGE * 2) + 1;
    int height = (SONAR_RANGE * 2) + 1;

    IReadonlyCell[][] scanResults = new IReadonlyCell[width][height];

    for (int colIndex = 0; colIndex < width; colIndex++) {
      for (int rowIndex = 0; rowIndex < height; rowIndex++) {
        int col = position.col + colIndex - 1;
        int row = position.row + rowIndex - 1;

        IReadonlyCell cell = this.isInRange(col, row)?
                                this.grid[col][row]: null;
        scanResults[colIndex][rowIndex] = cell;
      }
    }

    element.reportSonarResults(scanResults);
  }

  /**
   * Do nothing request.
   */
  private void processRequest(Element element, EmptyRequest request) {
    // Do nothing here.
  }

  /**
   * Catch all reuest processing handler.
   */
  private void processRequest(Element element, ElementRequest request) {
    println("!!! Unsupported request type.");
  }

  /**
   * Clears the game world grid. Sets all cells to empty.
   */
  public void clear() {
    for (int colIndex = 0; colIndex < maxCols; colIndex++) {
      for (int rowIndex = 0; rowIndex < maxRows; rowIndex++) {
        this.grid[colIndex][rowIndex] = new Cell();
      }
    }
  }

  /**
   * Gets the cell at the specified coordinates.
   *
   * @param row The row of the cell to get.
   * @param col The column of the cell to get.
   * @return The cell at the specified coordinates.
   */
  public Cell getCell(int row, int col) {
    return this.grid[col][row];
  }

  /**
   * Adds an element to the game world.
   *
   * @param element The element to add.
   * @return True if the element was added, false otherwise.
   */
  public boolean addElement(Element element) {
    Position2D[] geometry = element.getGeometry();

    if (element instanceof Submersible) {
      Submersible submersible = (Submersible)element;
      this.scores.put(submersible.getName(), 0);
    }

    if (!this.canOccupyCells(geometry, element)) {
      return false;
    }

    this.occupyCells(geometry, element);
    this.elements.add(element);
    return true;
  }

  /**
   * Returns the scores associated with the submersibles.
   */
  public ScoreRecord[] getScores() {
    ScoreRecord[] scoreRecords = new ScoreRecord[this.scores.size()];

    int index = 0;
    for(String key : this.scores.keySet()) {
        scoreRecords[index] = new ScoreRecord(key, this.scores.get(key));
        index++;
    }
    return scoreRecords;
  }

  /**
   * Executes a single update cycle on the world.
   */
  public void update() {
    for (Element element : this.elements) {
      ElementRequest request = element.update();
      if (request instanceof MoveRequest) {
        this.processRequest(element, (MoveRequest)request);
      } else if (request instanceof SonarRequest) {
        this.processRequest(element, (SonarRequest)request);
      } else if (request instanceof RetrieveSalvageRequest) {
        this.processRequest(element, (RetrieveSalvageRequest)request);
      } else if (request instanceof DepositSalvageRequest) {
        this.processRequest(element, (DepositSalvageRequest)request);
      } else if (request instanceof EmptyRequest) {
        this.processRequest(element, (EmptyRequest)request);
      } else {
        this.processRequest(element, request);
      }
    }
  }
}
