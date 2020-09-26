## Installation

All dependencies:

```shell
rake install
```

Only symlink specific targets:

```shell
rake install symlink=editor,shell
```

Only install specific dependencies (and no symlink):

```shell
rake install deps=git,tmux symlink=
```

Force reinstall of a dependency:

```shell
rake install deps=ruby force=ruby symlink=
```
