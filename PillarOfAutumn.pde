/**
 * The Pillar of Autumn. A great submersible by all accounts.
 */
class PillarOfAutumn extends Submersible {
  private boolean sonarCompleted;
  private int dCol;
  private int dRow;
  private int lateralMove;

  /**
   * Creates a new submersible.
   *
   * @param col the column of the submersible
   * @param row the row of the submersible
   */
  public PillarOfAutumn(int col, int row) {
    super("Pillar of Autumn", col, row);
    this.sonarCompleted = false;
    this.dCol = 0;
    this.dRow = 1;
    this.lateralMove = 0;
  }

  /**
   * @override
   */
  public ElementRequest update() {
      return new EmptyRequest();
  }

  /**
   * @override
   */
  public void reportSonarResults(IReadonlyCell[][] scanResults) {
      // What will you do here?
  }
}
