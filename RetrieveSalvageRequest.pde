/**
 * Request to retrieve salvage from a given position.
 */
class RetrieveSalvageRequest extends ElementRequest<Position2D> {
  Position2D salvagePosition;

 /**
   * Creates a salvage retieve request that an item be salvaged from
   * a given position.
   *
   * @param deltaCol The column from which to retrieve salvage.
   * @param deltaRow The row from which to retrieve salvage.
   */
  public RetrieveSalvageRequest(int deltaCol, int deltaRow) {
    this(new Position2D(deltaCol, deltaRow));
  }

  /**
   * Creates a salvage retieve request that an item be salvaged from
   * a given position.
   *
   * @param moveStep The position from which to salvage.
   */
  public RetrieveSalvageRequest(Position2D salvagePosition) {
    this.salvagePosition = salvagePosition;
  }

  /**
   * @override
   */
  public Position2D getData() {
    return this.salvagePosition;
  }
}
