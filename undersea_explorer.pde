World world;
int timer;
static final int ROW_COUNT = 48;
static final int COL_COUNT = 64;
static final int CELL_WIDTH = 15;
static final int CELL_HEIGHT = 15;
static final int UPDATE_FREQUENCY = 3000;

final color SEA_COLOR = color(65, 105, 225);
final color GRID_LINE_COLOR = color(100, 149, 237);
final color SALVAGE_SHIP_COLOR = color(95, 158, 160);
final color SALVAGE_COLOR = color(160, 82, 45);
final color OBSTACLE_COLOR = color(0, 255, 0);

void settings() {
  size(COL_COUNT * CELL_WIDTH, ROW_COUNT * CELL_HEIGHT);
}

void setup() {
  background(255);
  world = new World(COL_COUNT, ROW_COUNT);
  world.addElement(new SalvageShip("ship1", 10, 10, false));
  world.addElement(new SalvageShip("ship2", 30, 30, true));
  world.addElement(new Salvage("salvage-1", 20, 20));
  world.addElement(new Salvage("salvage-1", 40, 20));
  world.addElement(new Salvage("salvage-1", 20, 40));
  world.addElement(new Submersible("sub-1", 19, 39));
  timer = millis();
}

void draw() {
  drawGrid();
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
      rect(col * CELL_WIDTH,
        row * CELL_HEIGHT,
        (col + 1) * CELL_WIDTH,
        (row + 1) * CELL_HEIGHT);
    }
  }
}

color getCellColor(Cell cell) {
  if (cell.hasSalvageShip()) {
    return SALVAGE_SHIP_COLOR;
  } else if (cell.hasObstacle()) {
    return OBSTACLE_COLOR;
  } else if (cell.hasSalvage()) {
    return SALVAGE_COLOR;
  } else {
    return SEA_COLOR;
  }
}
