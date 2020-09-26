## Installation

Setup dependencies and symlink files:

```shell
rake install
```

Only symlink files from specific directories:

```shell
rake symlink dirs=editor,shell
```

Only setup specific dependencies:

```shell
rake setup deps=git,tmux
```

Force reinstall of a dependency:

```shell
rake setup deps=ruby force=ruby
```
