World world;
int timer;

static final int ROW_COUNT = 48;
static final int COL_COUNT = 64;
static final int CELL_WIDTH = 15;
static final int CELL_HEIGHT = 15;

static final int UPDATE_FREQUENCY = 1000;

static final String PLAYER_1_SUB_NAME = "Pillar of Autumn";
static final String PLAYER_2_SUB_NAME = "Truth and Reconciliation";

static final int TOP_OFFSET = CELL_HEIGHT * 10;
static final int LEFT_OFFSET = 0;

final color SEA_COLOR = color(65, 105, 225);
final color GRID_LINE_COLOR = color(100, 149, 237);
final color SALVAGE_SHIP_COLOR = color(95, 158, 160);
final color SALVAGE_COLOR = color(160, 82, 45);
final color OBSTACLE_COLOR = color(0, 255, 0);
final color PLAYER_1_SUB_COLOR = color(250, 128, 114);
final color PLAYER_1_SUB_COLOR = color(255, 105, 180);

void settings() {
  size(COL_COUNT * CELL_WIDTH + LEFT_OFFSET, ROW_COUNT * CELL_HEIGHT + TOP_OFFSET);
}

void setup() {
  world = new World(COL_COUNT, ROW_COUNT);
  world.addElement(new SalvageShip("ship1", 10, 10, false));
  world.addElement(new SalvageShip("ship2", 30, 30, true));
  world.addElement(new Salvage("salvage-1", 20, 20));
  world.addElement(new Salvage("salvage-1", 40, 20));
  world.addElement(new Salvage("salvage-1", 20, 40));

  world.addElement(new Submersible(PLAYER_1_SUB_NAME, 9, 9));
  world.addElement(new Submersible(PLAYER_2_SUB_NAME, 19, 39));

  timer = millis();
}

void draw() {
  drawGrid();
  showScores();
  if (millis() - timer > UPDATE_FREQUENCY) {
    timer = millis();
    world.update();
  }
}

void drawGrid() {
  strokeWeight(1);
  stroke(GRID_LINE_COLOR);

  for (int col = 0; col < COL_COUNT; col++) {
    for (int row = 0; row < ROW_COUNT; row++) {
      Cell cell = world.getCell(col, row);
      color cellColor = getCellColor(cell);


      fill(cellColor);
      rect(col * CELL_WIDTH + LEFT_OFFSET,
        row * CELL_HEIGHT + TOP_OFFSET,
        (col + 1) * CELL_WIDTH + LEFT_OFFSET,
        (row + 1) * CELL_HEIGHT + TOP_OFFSET);
    }
  }
}

void showScores() {
  int SCORE_TITLE_OFFSET = (int)(COL_COUNT * 0.6 * CELL_WIDTH);
  int SCORE_VALUE_OFFSET = (int)(COL_COUNT * 0.3 * CELL_WIDTH);
  
  int x = SCORE_TITLE_OFFSET;
  int y = CELL_HEIGHT * 2;
  ScoreRecord[] scores = world.getScores();
  
  fill(255, 255, 255);
  rect(0, 0, COL_COUNT * CELL_WIDTH, TOP_OFFSET);
  
  fill(0, 0, 128);
  textSize(18);
  for(ScoreRecord record: scores) {
    text(record.name, x, y);
    text(record.score, x + SCORE_VALUE_OFFSET, y);
    y += CELL_HEIGHT * 2;
  }
}

color getCellColor(Cell cell) {
  if (cell.hasSalvageShip()) {

    return SALVAGE_SHIP_COLOR;
  } else if (cell.hasObstacle()) {

    return OBSTACLE_COLOR;
  } else if (cell.hasSalvage()) {

    return SALVAGE_COLOR;
  } else if(cell.hasPlayer()) {

    Submersible sub = cell.getPlayer();
    if(sub.getName().equals(PLAYER_1_SUB_NAME)) {
      return PLAYER_1_SUB_COLOR;
    } else if(sub.getName().equals(PLAYER_2_SUB_NAME)) {

      return PLAYER_SUB_COLOR;
    }
  } else {

    return SEA_COLOR;
  }
}
