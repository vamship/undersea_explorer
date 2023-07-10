/**
 * Request to deposit salvage on a salvage ship at a given position.
 */
class DepositSalvageRequest extends ElementRequest<String> {
  Position2D salvagePosition;

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
