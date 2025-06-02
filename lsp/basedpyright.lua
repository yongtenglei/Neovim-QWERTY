return {
  name = "basedpyright",
  filetypes = { "python" },
  cmd = { "basedpyright-langserver", "--stdio" },
  settings = {
    basedpyright = {
      disableOrganizeImports = true,
      typeCheckingMode = "off",
      analysis = {
        autoSearchPaths = true,
        autoImportCompletions = true,
        useLibraryCodeForTypes = false,
        diagnosticMode = "openFilesOnly",
        inlayHints = {
          variableTypes = true,
          callArgumentNames = true,
          functionReturnTypes = true,
          genericTypes = false,
        },
      },
    },
  },
}
