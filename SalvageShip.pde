static final int MOVE_PROBABILITY = 0;

/**
 * A game element that represents a salvage ship.
 */
class SalvageShip extends Element {
  private static final int SALVAGE_SHIP_LENGTH = 3;
  private static final int SALVAGE_SHIP_WIDTH = 6;
  private final Position2D[] rawGeometry;

  /**
   * Creates a new salvage ship.
   *
   * @param name the name of the new salvage ship
   * @param col the column of the new salvage ship
   * @param row the row of the new salvage ship
   * @param isHorizontal whether the new salvage ship is oriented horizontally
   * or vertically on the grid
   */
  public SalvageShip(String name, int col, int row, boolean isHorizontal) {
    super(name, col, row);

    int width = !isHorizontal? SALVAGE_SHIP_WIDTH: SALVAGE_SHIP_LENGTH;
    int height = !isHorizontal? SALVAGE_SHIP_LENGTH: SALVAGE_SHIP_WIDTH;

    this.rawGeometry = new Position2D[width*height];
    for (int colIndex = 0; colIndex < width; colIndex++) {
      for (int rowIndex = 0; rowIndex < height; rowIndex++) {
        this.rawGeometry[(colIndex*height + rowIndex)] = new Position2D(colIndex, rowIndex);
      }
    }
  }

  /**
   * @override
   */
  protected Position2D[] getRawGeometry() {
    return this.rawGeometry;
  }

  /**
   * @override
   */
  public int getType() {
    return ElementType.SALVAGE_SHIP;
  }

  /**
   * @override
   */
  public ElementRequest update() {
    int deltaCol = random(100) < 100 - MOVE_PROBABILITY? 0: random(100)>50.0? -1:1;
    int deltaRow = random(100) < 100 - MOVE_PROBABILITY? 0: random(100)>50.0? -1:1;

    return new MoveRequest(new Position2D(deltaCol, deltaRow));
  }

  /**
   * Attempts to deposit a piece of salvage at a ship's position.
   * The specified position is absolute, not relative to the element.
   *
   * @param position The position at which the ship is expected to be.
   * @return True if an item could be deposited, false otherwise.
   */
  public boolean canDepositSalvage(Position2D position) {
    for (int index = 0; index<this.rawGeometry.length; index++) {
      Position2D pos = this.rawGeometry[index].translate(this.getPosition());
      if (pos.equals(position)) {
        return true;
      }
    }
    return false;
  }
}
