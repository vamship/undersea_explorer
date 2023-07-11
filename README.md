# Undersea Explorer

_A gamified learning environment for students to have fun and build their coding
skills_

## Introduction
The game comprises a grid of cells that represent an imaginary ocean in a
distant part of the world. The ocean has underwater _salvage_, _obstacles_ and
_salvage ships_. You are an entrepreneur with coding chops, trying to make a
living by retrieving salvage from the bottom of the ocean and returning them to
a salvage ship.

To do this, you must program your autonomous _submersible_ to search the ocean
floor for salvage and return them to a salvage ship. Unfortunately, you don't
know beforehand where the salvage and ships are, but your submersible has a
SONAR scanner that allows you to scan your immediate surroundings.

How successful you are depends on your algorithmic thinking and programming
skills. So pack your semicolons - we're going on an underwater adventure!

### Definitions
 - **World**: The game world, which is basically a giant ocean. The ice caps
     have melted, and there's no land. Actually, there's plenty of land - it's
     all at the bottom of the ocean. You get the idea.
 - **Cell**: A discrete location in the game identified by a column (horizontal)
     and row (vertical) position. A cell can only be occupied by one element at
     a time.
 - **Elements**: One of the items listed below. Not Earth, Fire, Wind, Water.
     1. **Salvage**: A piece of recoverable salvage from the bottom of the ocean
        that can be deposited with a salvage ship for points.
     2. **Salvage Ship**: A collection point for salvaged elements picked up by
        submersibles.
     3. **Obstacle**: A barrier that occupies space on the ocean all the way
        from the floor to the surface (yeah, I know - super realistic), but does
        nothing except block other things.
     4. **Submersible**: A player programmed ship that can pick up salvage from
        the bottom of the ocean and deposit it at ships.
 - **Points**: Goodies that a player earns for returning a pieces of salvage to
     a ship.

### Game Cycle

The game generally follows the following broad steps:
1. The world is initialized - all elements are created on the world.
2. Each element (including player developed submersibles) are periodically
   notified of an update by invoking the `update()` method. This allows each
   element to request some action to be taken by returning an `ElementRequest`
   object.
3. The element states are updated - requests made by elements are fulfilled (if
   possible)
4. The cycle repeats

#### Making Requests

Each element can request some action to be taken by the world on each update
cycle. Only one request may be made per update cycle. Requests are made by
returning an appropriate `ElementRequest` object. Some objects can include
additional parameters, while others do not.

Possible actions are:
1. Do Nothing (EmptyRequest): As the name suggests, this requests nothing of the
   world. You ask for nothing, and you get nothing. It's a zen thing.
   ```
   return new EmptyRequest(); // Nuff said
   ```

2. Move (MoveRequest): Request the element to be moved to one of the neigboring
   cells. If you request to move more than one step, the world will not oblige,
   and will only move you one step. It's a tough lesson kiddo - you don't always
   get what you want. Note that "one step" means that you'll move to any one of
   the immediate neighbors - including diagonal ones.

   Also, the world makes sure that you don't go out of bounds and fall of the
   edge, or damage yourself by crashing into other elements. It's good like
   that.

   ```
   return new MoveRequest(1, 0); // Move one column to the right

   return new MoveRequest(-1, 0); // Move one column to the left

   return new MoveRequest(-1, 1); // Move one step diagonally to the left bottom
   ```

1. SONAR Scan (SonarRequest): Request a scan of the immediate surroundings. Scan
   results will be reported to your submersible by invoking the
   `reportSonarResults()` method. This method will be called with a 3x3 grid of
   scan results, showing what exists in the cells surrounding the element. Most
   of the time (well, maybe all of the time), this only applies to player
   submersibles.

   ```
   return new SonarRequest(); //Tell me what's around me
   ```

1. Retrieve Salvage (RetrieveSalvageRequest): Attempts to retrieve a piece of
   salvage from a cell that is an immediate neighbor of the submersible.
   Remember to not reach too far. If the cell that you are targeting has a
   salvage item, you will pick it up. If not, no soup for you.

   You can also only store 2 salvage items in your submersible. If you pick up
   more than your allowed capacity, the salvage item will be destroyed and lost
   forever. No soup for anyone.

   ```
   return new RetrieveSalvageRequest(1, 1); // Try to pick up salvage from cell diagonally to the top and right
   ```

1. Deposit Salvage (DepositSalvageRequest): Attempts to Deposit a piece of
   salvage to a cell that is an immediate neighbor of the submersible.
   Remember to not reach too far. If the cell that you are targeting has a
   salvage ship, you will deposit the salvage. Easy dubs.

   ```
   return new DepositSalvageRequest(-1, -1); // Try to deposit salvage from cell diagonally to the bottom and left
   ```

## Getting Started

This game has been developed using [Processing](https://processing.org/), a
programming environment well suited for the development of simple applications
with audio visual elements. It's pretty cool - you should check it out.

The programming language used is Java (or java-like). A few subtle differences
apart, most of the code can be developed using the same ideas and principles
that one would use while writing code in Java.

In addition to basic Java programming skills, you'll need an introductory
understanding of git and source control principles and an abundance of interest
and enthusiasm.

### Prerequisites

1. Download and install Processing from [here](https://processing.org/download).
2. Ensure that you have git installed on your workstation. See
   [git installation instructions](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
   for more information.
3. Clone the project to an appropriate location on your workstation
```
git clone https://github.com/vamship/undersea_explorer
```
4. Launch Processing and open the project:
  - Start the Processing IDE
  - Click on File -> Open
  - Navigate to the folder that contains this project (cloned in the step above)
  - Click on `undersea_explorer.pde`
5. Once the project has been loaded, run it by clicking on the "Play" button at
   the top left

## Coding Your Submersible

A big part of this project is to provide students an environment where they can
play a game by writing code. The game can support up to 4 submersibles that are
competing with each other to retrieve and deposit as much salvage as possible.

### The Easy Way

The simplest way to work on this project is to make modifications to the `Pillar
of Autumn` submersible. You can do this by editing the `PillarOfAutumn.pde` file
(you won't see the `.pde` extension when you're using the IDE), and making the
changes that you want to make.

###### Rishi did all of this. Copyright 2023.

> TODO: Advanced use cases and scenarios still need to be documented. It's
> coming soon

