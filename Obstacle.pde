/**
 * A game element that represents an undersea obstacle.
 */
class Obstacle extends Element {
  private Position2D[] rawGeometry;

  /**
   * Creates a new obstacle object.
   *
   * @param name the name of the new obstacle
   * @param col the column of the new obstacle
   * @param row the row of the new obstacle
   */
  public Obstacle(String name, int col, int row) {
    super(name, col, row);
    this.rawGeometry = new Position2D[] { new Position2D(0, 0) };
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
    return ElementType.OBSTACLE;
  }

  /**
   * @override
   */
  public ElementRequest update() {
    return new EmptyRequest();
  }
}
