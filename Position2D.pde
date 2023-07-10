/**
 * Represents a position on the world grid.
 */
class Position2D {

  /**
   * The row of the position.
   */
  public final int row;

  /**
   * The column of the position.
   */
  public final int col;

  /**
   * Constructs a new position.
   *
   * @param col the column of the position
   * @param row the row of the position
   */
  public Position2D(int col, int row) {
    this.row = row;
    this.col = col;
  }

  /**
   * Initializes a new position at (0, 0).
   */
  public Position2D() {
    this(0, 0);
  }

  /**
   * Returns a new position that is translated by the given amount.
   *
   * @param deltaCols the number of columns to translate by
   * @param deltaRows the number of rows to translate by
   * @return a new position that is translated by the given amount
   */
  public Position2D translate(int deltaCols, int deltaRows) {
    return new Position2D(col + deltaCols, row + deltaRows);
  }


  /**
   * Returns a new position that is translated by the given amount.
   *
   * @param deltaPosition A position object representing the delta
   translation
   * @return a new position that is translated by the given amount
   */
  public Position2D translate(Position2D deltaPosition) {
    return new Position2D(col + deltaPosition.col, row + deltaPosition.row);
  }

  /**
   * Returns a clone of the current object.
   * @return a clone of this object.
   */
  public Position2D clone() {
    return new Position2D(this.col, this.row);
  }
  
  /**
   * @override
   */
  public boolean equals(Position2D pos) {
    return pos != null && 
      (pos.col == this.col && pos.row == this.row);
  }
}
