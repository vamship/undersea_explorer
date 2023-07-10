/**
 * Test submersible that can be used to test the game.
 */
class TestSubmersible extends Submersible {
  private boolean sonarCompleted;
  private int dCol;
  private int dRow;

  /**
   * Creates a new test submersible.
   *
   * @param name the name of the new submersible
   * @param col the column of the submersible
   * @param row the row of the submersible
   */
  public TestSubmersible(String name, int col, int row) {
    super(name, col, row);
    this.sonarCompleted = false;
    this.dCol = 0;
    this.dRow = 1;
  }

  /**
   * @override
   */
  public ElementRequest update() {
      if(this.sonarCompleted) {
        this.sonarCompleted = false;
        return new MoveRequest(dCol, dRow);
      } else {
        this.sonarCompleted = true;
        return new SonarRequest();
      }
  }

  /**
   * @override
   */
  public void reportSonarResults(IReadonlyCell[][] scanResults) {
      //if(scanResults[0][1] == null) {
      //  this.dRow = 1;
      //} else {
      //  this.dRow = -1;
      //}
    /* for (int colIndex = 0; colIndex < scanResults.length; colIndex++) { */
    /*   for (int rowIndex = 0; rowIndex < scanResults[colIndex].length; rowIndex++) { */
    /*     IReadonlyCell cell = scanResults[colIndex][rowIndex]; */
    /*     if(cell != null) { */
    /*       print(" (" + colIndex + ", " + rowIndex + ") " + cell.hasSalvage()); */
    /*     } else { */
    /*       print (" (x, x) NA   "); */
    /*     } */
    /*   } */
    /*   println(""); */
    /* } */
    /* println("--"); */
  }

}
