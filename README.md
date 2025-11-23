# bible-jeopardy
Bible Jeopardy

## Development

### Formatting (GDScript)
- Install the formatter: `pip install "gdtoolkit==4.*"` (or use `pipx install "gdtoolkit==4.*"`).
- Format the project: `gdformat .` (runs the GDScript formatter similar to Prettier).
- Optional: `pre-commit install` will wire the gdformat hook from `.pre-commit-config.yaml` so commits stay formatted automatically.
