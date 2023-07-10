static final int MAX_HEIGHT = 4; //<>//
static final int MAX_WIDTH = 4;
static final float SALVAGE_PROBABILITY = 100;
/**
 * A game element that represents salvage.
 */
class Salvage extends Element {
  private Position2D[] rawGeometry;

  /**
   * Creates a new salvage object.
   *
   * @param name the name of the new salvage ship
   * @param col the column of the new salvage ship
   * @param row the row of the new salvage ship
   * @param isHorizontal whether the new salvage ship is oriented horizontally
   * or vertically on the grid
   */
  public Salvage(String name, int col, int row) {
    super(name, col, row);
    ArrayList<Position2D> posList = new ArrayList<>();

    for (int colIndex = 0; colIndex < MAX_WIDTH; colIndex++) {
      for (int rowIndex = 0; rowIndex < MAX_HEIGHT; rowIndex++) {
        if (random(100) > 100.0 - SALVAGE_PROBABILITY) {
          posList.add(new Position2D(colIndex, rowIndex));
        }
      }
    }
    this.rawGeometry = posList.toArray(new Position2D[posList.size()]);
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
    return ElementType.SALVAGE;
  }

  /**
   * @override
   */
  public ElementRequest update() {
    return new EmptyRequest();
  }

  /**
   * Attempts to retrieve a piece of salvage from a given position.
   * The specified position is absolute, not relative to the element.
   *
   * @param position The position from which to retrieve salvage.
   * @return True if an item could be salvaged, false otherwise.
   */
  public boolean retrieveSalvage(Position2D position) {
    for (int index = 0; index<this.rawGeometry.length; index++) {
      Position2D pos = this.rawGeometry[index].translate(this.getPosition());
      if (pos.equals(position)) {
        this.removeSalvage(index);
        return true;
      }
    }
    return false;
  }

  /**
   * Removes a piece of salvage from the raw geometry of the element.
   *
   * @param removeIndex The index of the salvage item in the geometry
   */
  private void removeSalvage(int removeIndex) {
    if (this.rawGeometry.length == 0
      || removeIndex > this.rawGeometry.length) {
      return;
    }

    Position2D[] newGeometry = new Position2D[this.rawGeometry.length - 1];
    int targetIndex = 0;
    for (int index = 0; index<this.rawGeometry.length; index++) {
      if (index != removeIndex) {
        newGeometry[targetIndex] = this.rawGeometry[index];
        targetIndex++;
      }
    }
    this.rawGeometry = newGeometry;
  }
}
