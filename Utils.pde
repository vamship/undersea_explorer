/** //<>//
 * Interface for functions that can be used to check values for matches to
 * specific conditions.
 */
interface IChecker<T, U> {
  /**
   * Evaluates the given element against some predefined condition.
   *
   * @param element The element to be checked.
   * @return The result of the checking operation.
   */
  T evaluate(U element);
}

/**
 * Searches a 2D array for a value that matches a given condition. The first
 * non-null match is returned as soon as it is found.
 *
 * @param elements The 2D array to be searched.
 * @return The first non-null match found in the array.
 */
static <T, U> T searchItems(U[][] elements, IChecker<T, U> checker) {
  for (U[] row : elements) {
    for (U element : row) {
      if (element != null) {
        // Check the element against some condition
        T result = checker.evaluate(element);

        if (result != null) {
          return result;
        }
      }
    }
  }
  return null;
}

/**
 * Searches a 1D array for a value that matches a given condition. The first
 * non-null match is returned as soon as it is found.
 *
 * @param elements The 1D array to be searched.
 * @return The first non-null match found in the array.
 */
static <T, U> T searchItems(U[] elements, IChecker<T, U> checker) {
  for (U element : elements) {
    if (element != null) {
      // Check the element against some condition
      T result = checker.evaluate(element);

      if (result != null) {
        return result;
      }
    }
  }
  return null;
}

/**
 * Collects items from a 2D array that match a given condition. All matching
 * items are returned as a single dimensional array.
 *
 * @param elements The 2D array to be searched.
 * @return An iterable of all matching items
 */
static <T, U> Iterable<T> collectItems(U[][] elements, IChecker<T, U> checker) {
  ArrayList<T> matches = new ArrayList<>();

  for (U[] row : elements) {
    for (U element : row) {
      if (element != null) {
        // Check the element against some condition
        T result = checker.evaluate(element);

        if (result != null) {
          matches.add(result);
        }
      }
    }
  }
  return matches;
}

/**
 * Collects items from a 1D array that match a given condition. All matching
 * items are returned as a single dimensional array.
 *
 * @param elements The 1D array to be searched.
 * @return An iterable of all matching items
 */
static <T, U> Iterable<T> collectItems(U[] elements, IChecker<T, U> checker) {
  ArrayList<T> matches = new ArrayList<>();

  for (U element : elements) {
      if (element != null) {
        // Check the element against some condition
        T result = checker.evaluate(element);

        if (result != null) {
          matches.add(result);
        }
    }
  }
  return matches;
}

/**
 * Prints a two dimensional array of readonly cells along with the values
 * contained within it.
 *
 * @param cells A two dimensional array of cells
 */
static void printCells(IReadonlyCell[][] cells) {
  for (int colIndex = 0; colIndex < cells.length; colIndex++) {
    for (int rowIndex = 0; rowIndex < cells[colIndex].length; rowIndex++) {
      IReadonlyCell cell = cells[colIndex][rowIndex];
      int result = 0x0;
      if (cell != null) {
        result = result | (cell.hasSalvage()? ElementType.SALVAGE: 0x00);
        result = result | (cell.hasSalvageShip()? ElementType.SALVAGE_SHIP: 0x00);
        result = result | (cell.hasObstacle()? ElementType.OBSTACLE: 0x00);
        result = result | (cell.hasPlayer()? ElementType.PLAYER_SUB: 0x00);
      } else {
        result = result | 0xFF;
      }

      print ("| (" + colIndex + ", " + rowIndex + ") ", binary(result, 4));
    }
    println(" | ");
  }
  println("");
}
