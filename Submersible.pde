static final int MAX_SALVAGE_STORAGE = 2;

/**
 * Base class for a player submersible.
 */
class Submersible extends Element {
  private final Position2D[] rawGeometry;
  private int salvageCount = 0;

  /**
   * Creates a new submersible.
   *
   * @param name the name of the new submersible
   * @param col the column of the submersible
   * @param row the row of the submersible
   */
  public Submersible(String name, int col, int row) {
    super(name, col, row);

    this.rawGeometry = new Position2D[] { new Position2D(0, 0) };
  }

  /**
   * Returns the salvage count contained within the submersible.
   */
  public int getSalvageCount() {
    return this.salvageCount;
  }

  /**
   * Provides a piece of salvage to the submersible.
   */
  public void addSalvage() {
    this.salvageCount = max(this.salvageCount + 1, MAX_SALVAGE_STORAGE);
  }

  /**
   * Removes a piece of salvage from the submersible.
   */
  public int redeemSalvage() {
      if(this.salvageCount > 0) {
          this.salvageCount--;
          return 1;
      }
      return 0;
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
    return ElementType.PLAYER_SUB;
  }

  /**
   * @override
   */
  public ElementRequest update() {
    //return new SonarRequest();
    return new RetrieveSalvageRequest(
        new Position2D(3, 4).translate(this.getPosition())
    );
  }
  
  /**
   * @override
   */
  public void reportSonarResults(ICell[][] scanResults) {
    for (int colIndex = 0; colIndex < scanResults.length; colIndex++) {
      for (int rowIndex = 0; rowIndex < scanResults[colIndex].length; rowIndex++) {
        ICell cell = scanResults[colIndex][rowIndex];
        if(cell != null) {
          print(" (" + colIndex + ", " + rowIndex + ") " + cell.hasSalvage());
        } else {
          print (" (x, x) NA   ");
        }
      }
      println("");
    }
    println("--");
  }
}
