# Layer

You've seen a high-level overview of what a layer is and how it's the central
piece of your `visimp` configuration in the [introduction](INTRO.md). More
concretely, a layer `L` is a structure with the following fields:

- `L.identifier` is a unique string that identifies the layer. This identifier
  is usually a meaningful name, often matching with the lua filename;
- `L.default_config` is the layer's default configuration to be extended via a
  merge with the configuration given to `L.configure(...)`. Please see the next
  bullet point for further reference;
- `L.config` is the structure obtained from the merging of the actual config
  provided by the user with the layer's default.
- `L.deprecated` is a boolean stating whether the layer is deprecated or not. If
  it is, a noticed asking the user to disable said layer is shown when the layer
  is loaded.

There's a specific set of methods that can act on any given layer. They get
called automatically by `visimp` via the `loader` component or the setup
lifecycle. Each method has a default implementation. For side effects methods,
it is a no-op. They can be overwritten by assigning a function to the
appropriate field of the layer Below is a list of available methods.

- `L.configure(cfg)` receives as input the actual config provided by the user.
  Its job is to populate the `L.config` field, usually with a merge of `cfg`
  and `L.default_config`. This implementation is the one provided by default
  and is rarely changed.
- `L.dependencies()` returns a list of layers on which the current layer `L`
  depends. The default implementation returns an empty slice.
- `L.packages()` returns a list of plugins which the current layer `L`
  necessitates. Plugins are usually a string composed of the suffix of a
  GitHub repository URL (i.e. `https://github.com/tpope/fugitive` would be
  `tpope/fugitive`).
- `L.preload()` is called on all layers before the `load` method is called on
  any of them. This is used to modify behavior of other layers' `load`
  methods. An example is the interaction with the `lsp` layer: in order to
  enable a desired LSP, other layers need to specify it in their `preload`
  section before the `lsp` layer `load` method gets called.
- `L.load()` is designed to let layers apply side-effects on the Neovim client.
  This is where plugins are enabled, the Neovim configuration is set, etcetera.
