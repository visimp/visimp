# Introduction

`visimp` is a simple, modular Neovim configuration. By itself, `visimp` is
actually nothing more than a Neovim plugin. As such, you just need to `require`
it from your Neovim config and you're good to go (see
[Configuration](CONFIG.md)).

`visimp` is designed as a collection of _layers_, which is a pretty common
structure in vi distributions. A layer is an extension to Neovim's
functionalities. `visimp` also features a package manager that automatically
installs the dependencies needed by your desired layers. The layers and the
package manager are described in more detail below.

## Layers

Two types of layers exist:

- "standard" layers encapsulate generic functionalities, such as `theme` for
  theming, `languages` for language support, and `snippet` for code snippets.
  Often, generic layers are just wrappers for other Neovim plugins; take, for
  instance, the `autopairs` and `grammarly` layers.
- "language" layers feature support for a specific language, and are loaded by
  the `languages` meta-layer. For example, `c`, `html`, `latex`, and `lua` are
  all language layers. They usually provide a way to specify (or disable) your
  desired language server or toggle common functionality for the specific
  language.

One layer may declare others as its dependencies. Layer dependencies are
always acyclic in `visimp`. You can read more in the [Layer](LAYER.md) section.

## Package Manager

Every layer internally declares the plugins it depends on. On startup, the
package manager automatically installs the plugins needed by each enabled layer.
In other words, plugins needed uniquely by disabled layers are not installed.
The most useful package manager commands are:

- `:PakInstall`, which automatically installs the needed plugins if some are
  missing;
- `:PakUpdate`, which updates the currently installed packages.
- `:PakList`, which lists the currently installed packages;
