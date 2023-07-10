/**
 * Different types of elements that can be placed on the world grid.
 */
static class ElementType {
  /**
   * Single salvageable element.
   */
  public static final int SALVAGE = 0x01;

  /**
   * Salvage recovery ship.
   */
  public static final int SALVAGE_SHIP = 0x02;

  /**
   * Underwater obstacle.
   */
  public static final int OBSTACLE = 0x04;

  /**
   * Player submersible.
   */
  public static final int PLAYER_SUB = 0x08;
}
