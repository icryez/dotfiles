-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
local jdtls_status, jdtls = require("jdtls")
local mason_status, mason = pcall("mason-registry")

if not jdtls_status then
    vim.notify("jdtls not found")
    return
end

if not mason_status then
    vim.notify("mason not found")
    return
end

local JDTLS_PATH = mason.get_package("jdtls"):get_install_path()
local JAVA_DEBUG_PATH = mason.get_package("java-debug-adapter"):get_install_path()
local JAVA_TEST_PATH = mason.get_package("java-test"):get_install_path()

-- Workspace
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local JDTLS_DATA = "/home/chakru/__Projects/Java_Projects/" .. project_name

local config = {
  -- The command that starts the language server
  -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
  cmd = {

    -- 💀
    'java', -- or '/path/to/java17_or_newer/bin/java'
            -- depends on if `java` is in your $PATH env variable and if it points to the right version.

    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    "-javaagent:" .. JDTLS_PATH .. "/lombok.jar",
    '-Xmx1g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
    '--add-opens', 'java.base/java.lang=ALL-UNNAMED',

    -- 💀
    "-jar",
        vim.fn.glob(JDTLS_PATH .. "/plugins/org.eclipse.equinox.launcher_*.jar", true),

       
    -- 💀
    '-configuration', JDTLS_PATH .. "/config_linux",
                    -- Must point to the                      Change to one of `linux`, `win` or `mac`
                    -- eclipse.jdt.ls installation            Depending on your system.


    -- 💀
    -- See `data directory configuration` section in the README
    '-data',  JDTLS_DATA,
  },

  -- 💀
  -- This is the default if not provided, you can remove it. Or adjust as needed.
  -- One dedicated LSP server & client will be started per unique root_dir
  root_dir = require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew'}),

  -- Here you can configure eclipse.jdt.ls specific settings
  -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
  -- for a list of options
  settings = {
    java = {
    }
  },

  -- Language server `initializationOptions`
  -- You need to extend the `bundles` with paths to jar files
  -- if you want to use additional eclipse.jdt.ls plugins.
  --
  -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
  --
  -- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
  init_options = {
    bundles = {}
  },
}
-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
require('jdtls').start_or_attach(config)
