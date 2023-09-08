return {
  cmd = { "docker-langserver", "--stdio" },
  filetype = { "dockerfile" },
  single_file_support = true,
  -- Dockerls options -> "https://github.com/rcjsuen/dockerfile-language-server-nodejs#language-server-settings"
  settings = {
    docker = {
      languagueserver = {
        diagnostics = {
          -- values must be equal to "ignore", "warning", or "error"
          deprecatedMaintainer = "error",
          directiveCasing = "error",
          emptyContinuationLine = "error",
          instructionCasing = "error",
          instructionCmdMultiple = "error",
          instructionEntrypointMultiple = "error",
          instructionHealthcheckMultiple = "error",
          instructionJSONInSingleQuotes = "error",
        },
        formatter = {
          ignoreMultilineInstructions = false,
        },
      },
    },
  },
}
