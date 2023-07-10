/**
 * Request to move the element.
 */
class MoveRequest extends ElementRequest<Position2D> {
  Position2D moveStep;

  /**
   * Creates a move request that can be used to request the element
   * to be moved by some offset.
   *
   * @param moveStep The amount by which the element should be moved
   * relative to its current position.
   */
  public MoveRequest(Position2D moveStep) {
    this.moveStep = moveStep;
  }

  /**
   * @override
   */
  public Position2D getData() {
    return this.moveStep;
  }
}
