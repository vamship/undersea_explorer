World world;
int timer;

static final int ROW_COUNT = 24;
static final int COL_COUNT = 32;
static final int CELL_WIDTH = 30;
static final int CELL_HEIGHT = 30;

static final int UPDATE_FREQUENCY = 1;

static final int HEADER_HEIGHT = CELL_HEIGHT * 10;
static final int FOOTER_HEIGHT = CELL_HEIGHT * 2;
static final int LEFT_BAR_WIDTH = 0;

final color SEA_COLOR = color(0x48, 0xA1, 0xC1);
final color GRID_LINE_COLOR = color(0x62, 0x90, 0xB0);
final color SALVAGE_SHIP_COLOR = color(0x94, 0x44, 0x5E);
final color SALVAGE_COLOR = color(0x3A, 0x2A, 0x53);
final color OBSTACLE_COLOR = color(0x4C, 0x59, 0x72);


static final String PLAYER_1_SUB_NAME = "Pillar of Autumn";
static final String PLAYER_2_SUB_NAME = "Truth and Reconciliation";
static final String PLAYER_3_SUB_NAME = "Forward Unto Dawn";
static final String PLAYER_4_SUB_NAME = "Shadow of Intent";

final color PLAYER_1_SUB_COLOR = color(0xE9, 0xBA, 0x58);
final color PLAYER_2_SUB_COLOR = color(0xD0, 0x3B, 0x53); //DFDBDC
final color PLAYER_3_SUB_COLOR = color(0x7B, 0x64, 0xA5);
final color PLAYER_4_SUB_COLOR = color(0x41, 0x84, 0x46);

void settings() {
  size(COL_COUNT * CELL_WIDTH + LEFT_BAR_WIDTH, ROW_COUNT * CELL_HEIGHT + HEADER_HEIGHT + FOOTER_HEIGHT);
}

void setup() {
  world = new World(COL_COUNT, ROW_COUNT);
  world.addElement(new PillarOfAutumn(0, 0));
  timer = millis();
}

void draw() {
  drawHeader();
  drawGrid();
  drawFooter();
  
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
      rect(col * CELL_WIDTH + LEFT_BAR_WIDTH,
        row * CELL_HEIGHT + HEADER_HEIGHT,
        (col + 1) * CELL_WIDTH + LEFT_BAR_WIDTH,
        (row + 1) * CELL_HEIGHT + HEADER_HEIGHT);
    }
  }
}

void drawHeader() {
  int SCORE_TITLE_OFFSET = (int)(COL_COUNT * 0.6 * CELL_WIDTH);
  int SCORE_VALUE_OFFSET = (int)(COL_COUNT * 0.3 * CELL_WIDTH);

  int x = SCORE_TITLE_OFFSET;
  int y = CELL_HEIGHT * 2;
  ScoreRecord[] scores = world.getScores();

  fill(255, 255, 255);
  rect(0, 0, COL_COUNT * CELL_WIDTH, HEADER_HEIGHT);

  fill(0, 0, 128);
  textSize(18);
  for(ScoreRecord record: scores) {
    text(record.name, x, y);
    text(record.score, x + SCORE_VALUE_OFFSET, y);
    y += CELL_HEIGHT * 2;
  }
}

void drawFooter() {
  fill(255, 255, 255);
  rect(0, ROW_COUNT * CELL_HEIGHT + HEADER_HEIGHT, 
      COL_COUNT * CELL_WIDTH, FOOTER_HEIGHT);
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
      return PLAYER_2_SUB_COLOR;
    } else if(sub.getName().equals(PLAYER_3_SUB_NAME)) {
      return PLAYER_3_SUB_COLOR;
    } else if(sub.getName().equals(PLAYER_4_SUB_NAME)) {
      return PLAYER_4_SUB_COLOR;
    } else {
      return color(255, 0, 0);
    }
  } else {

    return SEA_COLOR;
  }
}
