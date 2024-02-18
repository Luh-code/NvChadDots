local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"

-- if you just want default config for the servers then put them in a table
local servers = { "html", "cssls", "tsserver", "clangd" }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

--lspconfig.java_language_server.setup {
--  on_attach = on_attach,
--  capabilities = capabilities,
--  cmd = {"/home/luh/.local/share/nvim/mason/packages/java-language-server/dist/lang_server_linux.sh"}
--}

-- If you started neovim within `~/dev/xy/project-1` this would resolve to `project-1`
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')

local workspace_dir = vim.fs.dirname(vim.fs.find({'gradlew', '.git', 'mvnw'}, { upward = true })[1])
 .. project_name

lspconfig.jdtls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = {
    -- 💀
    "java", -- set to java path if $PATH env var is not set correctly

    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xmx1g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
    '--add-opens', 'java.base/java.lang=ALL-UNNAMED',

    -- 💀
    '-jar', '/home/luh/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_1.6.700.v20231214-2017.jar',
         -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^                                       ^^^^^^^^^^^^^^
         -- Must point to the                                                     Change this to
         -- eclipse.jdt.ls installation                                           the actual version


    -- 💀
    '-configuration', '/home/luh/.local/share/nvim/mason/packages/jdtls/config_linux',
                    -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        ^^^^^^
                    -- Must point to the                      Change to one of `linux`, `win` or `mac`
                    -- eclipse.jdt.ls installation            Depending on your system.


    -- 💀
    -- See `data directory configuration` section in the README
    '-data', workspace_dir--'/path/to/unique/per/project/workspace/folder'
    --"/home/luh/.local/share/nvim/mason/packages/jdtls/bin/jdtls"
  },
  --root_dir = function ()
  --  vim.fs.dirname(vim.fs.find({'gradlew', '.git', 'mvnw'}, { upward = true })[1])
  --end,
  --root_dir = require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew'})
}
-- 
-- lspconfig.pyright.setup { blabla}
