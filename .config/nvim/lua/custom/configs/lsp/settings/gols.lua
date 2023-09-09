return {
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gotmpl" },
  single_file_support = true,
  -- gopls options -> "https://github.com/golang/tools/blob/master/gopls/doc/settings.md"
  settings = {
    gopls = {
      build = {
        buildFlags = {},
        env = {},
        directoryFilters = {"-node_modules"},
        templateExtensions = {},
        memoryMode = "Normal",
        expandWorkspaceToModule = true,
        experimentalWorkspaceModule = false,
        experimentalPackageCacheKey = true,
        allowModfileModifications = false,
        allowImplicitNetworkAccess = false,
        experimentalUseInvalidMetadata = false,
      },
      formatting = {
        gofumpt = false,
        codelenses = {
          gc_details = false,
          generate = true,
          regenerate_cgo = true,
          tidy = true,
          upgrade_dependency = true,
          vendor = true,
        },
        semanticTokens = false,
      },
      ui = {
        codelenses = {
          gc_details = false,
          generate = true,
          regenerate_cgo = true,
          tidy = true,
          upgrade_dependency = true,
          vendor = true,
        },
        completion = {
          usePlaceholders = false,
          completionBudget = "100ms",
          matcher = "Fuzzy",
          experimentalPostfixCompletions = true,
        },
        diagnostic = {
          analyses = {},
          staticcheck = false,
          diagnosticsDelay = "250ms",
          experimentalWatchedFileDelay = "0s",
        },
        documentation = {
          hoverKind = "FullDocumentation",
          linkTarget = "pkg.go.dev",
          linksInHover = true,
        },
        navigation = {
          importShortcut = "Both",
          symbolMatcher = "FastFuzzy",
          symbolStyle = "Dynamic",
          verboseOutput = false,
        },
      },
    }
  },
}
