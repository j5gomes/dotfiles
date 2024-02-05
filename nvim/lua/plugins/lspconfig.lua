return {
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        bashls = {},
        yamlls = {},
        marksman = {},
        powershell_es = {},
        tsserver = {},
        tailwindcss = {},
        svelte = {},
        shfmt = {},
      },
    },
  },
}
