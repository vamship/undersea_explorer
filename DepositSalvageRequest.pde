/**
 * Request to deposit salvage on a salvage ship at a given position.
 */
class DepositSalvageRequest extends ElementRequest<Position2D> {
  Position2D salvagePosition;

 /**
   * Creates a salvage deposit request to drop a salvaged item at a
   * ship located at a given position.
   *
   * @param deltaCol The column from which to retrieve salvage.
   * @param deltaRow The row from which to retrieve salvage.
   */
  public DepositSalvageRequest(int deltaCol, int deltaRow) {
    this(new Position2D(deltaCol, deltaRow));
  }

  /**
   * Creates a salvage deposit request on a salvage ship that is nearby.
   *
   * @param moveStep The position at which to deposit salvage.
   */
  public DepositSalvageRequest(Position2D salvagePosition) {
    this.salvagePosition = salvagePosition;
  }

  /**
   * @override
   */
  public Position2D getData() {
    return this.salvagePosition;
  }
}
