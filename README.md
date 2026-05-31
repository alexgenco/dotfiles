## Installation

Install dev tools and symlink dotfiles:

```shell
rake install
```

Only install specific dev tools:

```shell
rake tools only=git,tmux
```

Force reinstall of a dependency:

```shell
rake tools only=tmux force=tmux
```
