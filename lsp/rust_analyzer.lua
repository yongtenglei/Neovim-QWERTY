return {
  filetypes = { "rust" },
  cmd = { "rust-analyzer" },
  settings = {
    ["rust-analyzer"] = {
      checkOnSave = true,
      check = { command = "clippy", features = "all" },
      assist = {
        importGranularity = "module",
        importPrefix = "self",
      },
      diagnostics = {
        enable = true,
        enableExperimental = true,
      },
      cargo = {
        loadOutDirsFromCheck = true,
        features = "all",
      },
      procMacro = {
        enable = true,
      },
      inlayHints = {
        chainingHints = true,
        parameterHints = true,
        typeHints = true,
      },
    },
  },
}
