# bible-jeopardy
Bible-themed Jeopardy built in Godot 4.5 with English and Brazilian Portuguese support. Features a verse-of-the-day splash, text-to-speech for questions (when available), and AI players that fill open seats.

## How to play
- Players: always three slots. Player 1 uses keyboard (Space to buzz); connected controllers fill Player 2/3, otherwise AIs step in. Use mouse or controller focus to pick answers after buzzing.
- Rounds: two standard boards then a Final Round.
  - Each board shows 3 categories × 3 clues. Round 1 values: 400/800/1200. Round 2 values: 800/1200/2000.
  - One hidden “double points” clue per board randomly doubles its value.
  - 30 seconds to answer; wrong answers subtract the clue value. Everyone else can buzz after a miss; all players (or the timer) exhausted ends the clue.
  - AI buzzes if humans do not (default 5 seconds).
- Final Round: a single hard clue from a random category.
  - First buzzer sets a wager between 100 and their current score (uses absolute value if negative).
  - Optional hint costs 10% of the wager and reveals the first letter and length of the answer.
  - Correct/incorrect adjusts the score by the wager amount.
- Pause with `Esc`. Language and music volume live in Settings. The verse panel appears on the title screen.

## Development

### Formatting (GDScript)
- Install the formatter: `pip install "gdtoolkit==4.*"` (or use `pipx install "gdtoolkit==4.*"`).
- Format the project: `gdformat .` (runs the GDScript formatter similar to Prettier).
- Optional: `pre-commit install` will wire the gdformat hook from `.pre-commit-config.yaml` so commits stay formatted automatically.
