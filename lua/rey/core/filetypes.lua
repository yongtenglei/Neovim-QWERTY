vim.filetype.add({
  filename = {
    [".env"] = "sh",
    [".envrc"] = "sh",
  },
  pattern = {
    ["*.env"] = "sh",
    ["*.envrc"] = "sh",
    ["*.http"] = "http",
  },
})
