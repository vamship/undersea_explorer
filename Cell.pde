/**
 * Represents a read only cell on the grid.
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

  /**
   * Gets a reference any player submersible that might be occupying the cell.
   */
  public Submersible getPlayer();

  /**
   * Gets a reference any salvage ship that might be occupying the cell.
   */
  public SalvageShip getSalvageShip();

  /**
   * Gets a reference any obstacle that might be occupying the cell.
   */
  public Obstacle getObstacle();

  /**
   * Gets a reference any salvage that might be occupying the cell.
   */
  public Salvage getSalvage();
}

/**
 * Represents a single cell on the world grid. Each cell can be occupied by one
 * or more elements.
 */
class Cell implements ICell {
  private Submersible playerSub;
  private SalvageShip salvageShip;
  private Obstacle obstacle;
  private Salvage salvage;

  /**
   * Initializes a new Cell with default values.
   */
  public Cell() {
    this.playerSub = null;
    this.salvageShip = null;
    this.obstacle = null;
    this.salvage = null;
  }

  /**
   * @override
   */
  public Submersible getPlayer() {
      return this.playerSub;
  }

  /**
   * @override
   */
  public SalvageShip getSalvageShip() {
    return this.salvageShip;
  }

  /**
   * @override
   */
  public Obstacle getObstacle() {
    return this.obstacle;
  }

  /**
   * @override
   */
  public Salvage getSalvage() {
    return this.salvage;
  }

  /**
   * @override
   */
  public boolean hasSalvage() {
    return this.salvage != null;
  }

  /**
   * @override
   */
  public boolean hasPlayer() {
    return this.playerSub != null;
  }

  /**
   * @override
   */
  public boolean hasSalvageShip() {
    return this.salvageShip != null;
  }

  /**
   * @override
   */
  public boolean hasObstacle() {
    return this.obstacle != null;
  }

  /**
   * Checks if the cell can be occupied by an element.
   *
   * @param type The element to check for.
   * @return True if the cell can be occupied by the given element type.
   */
  public boolean canBeOccupied(Element element) {
    switch(element.getType()) {
        case ElementType.SALVAGE:
          return this.salvage == null
              && this.obstacle == null
              && this.playerSub == null;
        case ElementType.SALVAGE_SHIP:
          return this.salvageShip == null
              && this.obstacle == null
              && this.playerSub == null;
        case ElementType.PLAYER_SUB:
          return this.salvageShip == null
              && this.obstacle == null
              && this.salvage == null;
        case ElementType.OBSTACLE:
          return this.salvageShip == null
              && this.playerSub == null
              && this.salvage == null;
        default:
          return false;
    }
  }

  /**
   * Occupies the cell using an element.
   *
   * @param type The element to check for.
   * @return True if the cell was successfully occupied, false otherwise.
   */
  public boolean occupy(Element element) {
    if (!this.canBeOccupied(element)) {
      return false;
    }
    switch(element.getType()) {
        case ElementType.SALVAGE:
          this.salvage = (Salvage) element;
          break;
        case ElementType.SALVAGE_SHIP:
          this.salvageShip = (SalvageShip) element;
          break;
        case ElementType.PLAYER_SUB:
          this.playerSub = (Submersible) element;
          break;
        case ElementType.OBSTACLE:
          this.obstacle = (Obstacle) element;
          break;
        default:
          return false;
    }
    return true;
  }

  /**
   * Empties the cell of the given element.
   *
   * @param type The type of element to empty the cell of.
   */
  public void empty(int type) {
    switch(element.getType()) {
        case ElementType.SALVAGE:
          this.salvage = null;
          break;
        case ElementType.SALVAGE_SHIP:
          this.salvageShip = null;
          break;
        case ElementType.PLAYER_SUB:
          this.playerSub = null;
          break;
        case ElementType.OBSTACLE:
          this.obstacle = null;
          break;
    }
  }
}
