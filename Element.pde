/**
 * Represents an element in world. This is an abstract class that must be
 * overriden by a subclass to be useful.
 */
abstract class Element {
  private String name;
  private int col;
  private int row;

  /**
   * Creates a new element at the given position, defined by the lower left
   * corner of the element geometry.
   *
   * @param col   the column of the element
   * @param row   the row of the element
   */
  public Element(String name, int col, int row) {
    this.name = name;
    this.col = col;
    this.row = row;
  }

  /**
   * Gets the raw geometry of the element, as an array of positions, relative
   * to the origin.
   *
   * @return the geometry of the element
   */
  protected abstract Position2D[] getRawGeometry();

  /**
   * Gets the type of the element.
   */
  public abstract int getType();

  /**
   * Invoked periodically by the world to allow the element to update itself. The
   * element can request updates from the world by returning a request.
   */
  public abstract ElementRequest update();
  
  /**
   * Reports the results of a SONAR scan to an element. This method can be overridden
   * by elements that require the scan.
   *
   * @param scanResults The results of the SONAR scan, reported as a grid of cells
   * surrounding the element.
   */
  public void reportSonarResults(IReadonlyCell[][] scanResults) {
    // Do nothing here.
  }

  /**
   * Gets the name of the element.
   */
  public String getName() {
    return this.name;
  }

  /**
   * Gets the current position of the element.
   *
   * @return the position of the element
   */
  public Position2D getPosition() {
    return new Position2D(col, row);
  }

  /**
   * Gets the geometry of the element, as an array of positions, relative to
   * the current position of the element.
   *
   * @return the geometry of the element relative to its current position.
   */
  public Position2D[] getGeometry() {
    return this.getGeometry(this.getPosition());
  }

  /**
   * Gets the geometry of the element, as an array of positions, relative to
   * the given position.
   *
   * @param position  the position to translate the geometry based on
   * @return the geometry of the element relative to its current position.
   */
  public Position2D[] getGeometry(Position2D position) {
    Position2D[] rawGeometry = this.getRawGeometry();
    Position2D[] geometry = new Position2D[rawGeometry.length];

    for (int index = 0; index < geometry.length; index++) {
      geometry[index] = rawGeometry[index]
        .translate(position.col, position.row);
    }
    return geometry;
  }

  /**
   * Incrementally moves the element relative to its current position. This
   * method should only be invoked by the world.
   *
   * @param deltaCol  the amount to move the element in the horizontal
   * direction
   * @param deltaRow  the amount to move the element in the vertical direction
   */
  public void moveRelative(int deltaCol, int deltaRow) {
    this.col += deltaCol;
    this.row += deltaRow;
  }

  /**
   * Incrementally moves the element relative to its current position. This
   * method should only be invoked by the world.
   *
   * @param deltaPosition  the amount to move the element
   */
  public void moveRelative(Position2D deltaPosition) {
    this.col += deltaPosition.col;
    this.row += deltaPosition.row;
  }

  /**
   * Moves the element to the given position. This method should only be
   * invoked by the world.
   *
   * @param col   the new column of the element
   * @param row   the new row of the element
   */
  public void moveTo(int col, int row) {
    this.col = col;
    this.row = row;
  }

  /**
   * Moves the element to the given position. This method should only be
   * invoked by the world.
   *
   * @param position   the new position of the element
   */
  public void moveTo(Position2D position) {
    this.col = position.col;
    this.row = position.row;
  }
}
