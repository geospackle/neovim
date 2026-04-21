local ft = require('guard.filetype')
ft('lua'):fmt('lsp')
    :append('stylua')
--:lint('selene')

ft('python'):fmt('black')
    :lint('ruff')

-- Call setup() LAST!
require('guard').setup({
    -- Choose to format on every write to a buffer
    fmt_on_save = true,
    -- Use lsp if no formatter was defined for this filetype
    lsp_as_default_formatter = false,
    -- By default, Guard writes the buffer on every format
    -- You can disable this by setting:
    -- save_on_fmt = false,
})

require('dap-go').setup {
    dap_configurations = {
        {
            type = "go",
            name = "Debug qa-local",
            request = "launch",
            program = "${file}",
            env = {
                APP_ENV = "qa-local"
            },
        },
    },
}

local dap, dapui = require("dap"), require("dapui")
dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
end
require('dap-python').setup('~/.virtualenvs/debugpy/bin/python')
table.insert(require('dap').configurations.python, {
    type = 'python',
    request = 'launch',
    name = 'Debug file poetry',
    code = 'poetry run python ${file}',
    -- ... more options, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings
})

table.insert(require('dap').configurations.python, {
    type = 'python',
    request = 'launch',
    name = 'pdm pytest',
    code = 'pdm run coverage run -m pytest tests/test_types.py -k "test_generic_type"',
    -- ... more options, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings
})

table.insert(require('dap').configurations.python, 1, {
    type = 'python',
    request = 'launch',
    name = 'pytest',
    module = 'pytest',
    --args = {'tests/test_plugins.py'},
    -- ... more options, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings
})

table.insert(require('dap').configurations.python, {
    name = "pytest: Current File",
    type = "python",
    request = "launch",
    module = "pytest",
    args = {
        "${file}",
        --"-sv",
        --"--log-cli-level=INFO",
        --"--log-file=test_out.log"
    },
    console = "integratedTerminal",
})

table.insert(require('dap').configurations.python, {
    name = "pytest: specific test",
    type = "python",
    request = "launch",
    module = "pytest",
    args = {
        "${file}::test_datetime",
        --"-sv",
        --"--log-cli-level=INFO",
        --"--log-file=test_out.log"
    },
    console = "integratedTerminal",
})
