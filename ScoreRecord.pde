/**
 * Represents a score record
 */
class ScoreRecord {
    /**
     * The name of the player's ship
     */
    public final String name;

    /**
     * The name of the player's ship
     */
    public final int score;

    /**
     * Creates a new score record
     * @param name The name of the player's ship
     * @param score The score of the player's ship
     */
    public ScoreRecord(String name, int score) {
        this.name = name;
        this.score = score;
    }
}
