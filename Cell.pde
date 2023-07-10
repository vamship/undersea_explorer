/**
 * Represents a cell on the grid.
 */
interface ICell {
  
  /**
   * Determines if the cell has any salvage pieces.
   *
   * @return True if the cell has salvage pieces, false otherwise.
   */
  public boolean hasSalvage();
  
  /**
   * Determines if the cell has a player submersible
   *
   * @return True if the cell has a player submersible, false otherwise.
   */
  public boolean hasPlayer();
  
  /**
   * Determines if the cell has a salvage ship.
   *
   * @return True if the cell has a salvage ship, false otherwise.
   */
  public boolean hasSalvageShip();
  
  /**
   * Determines if the cell has an obstacle.
   *
   * @return True if the cell has an obstacle, false otherwise.
   */
  public boolean hasObstacle();
}

/**
 * Represents a single cell on the world grid. Each cell can be occupied by one
 * or more elements.
 */
class Cell implements ICell {
  private int contents;

  /**
   * Initializes a new Cell with default values.
   */
  public Cell() {
    this.contents = 0x00;
  }

  /**
   * @override
   */
  public boolean hasSalvage() {
    return (this.contents & ElementType.SALVAGE) != 0;
  }

  /**
   * @override
   */
  public boolean hasPlayer() {
    return (this.contents & ElementType.PLAYER_SUB) != 0;
  }

  /**
   * @override
   */
  public boolean hasSalvageShip() {
    return (this.contents & ElementType.SALVAGE_SHIP) != 0;
  }

  /**
   * @override
   */
  public boolean hasObstacle() {
    return (this.contents & ElementType.OBSTACLE) != 0;
  }

  /**
   * Checks if the cell can be occupied by an element of the given type.
   *
   * @param type The type of element to check for.
   * @return True if the cell can be occupied by the given element type.
   */
  public boolean canBeOccupied(int type) {
    return (this.contents & type) == 0;
  }

  /**
   * Occupies the cell using an element of the given type.
   *
   * @param type The type of element to occupy the cell with.
   * @return True if the cell was successfully occupied, false otherwise.
   */
  public boolean occupy(int type) {
    if (!this.canBeOccupied(type)) {
      return false;
    }

    this.contents |= type;
    return true;
  }

  /**
   * Empties the cell of the given element type.
   *
   * @param type The type of element to empty the cell of.
   */
  public void empty(int type) {
    this.contents &= ~type;
  }
}
