local P = {}
keymaps = P
-- leader --
vim.g.mapleader = ' '

-- key_mapping --
local key_map = function(mode, key, result)
  vim.api.nvim_set_keymap(
    mode,
    key,
    result,
    {noremap = true, silent = true}
  )
end

function git_commit_all()
  vim.ui.input({ prompt = 'Msg: ' }, function(input)
    io.popen("git add src/* && git commit -am '" .. input .. "'")
  end)
end

function git_commit_push_all()
  vim.ui.input({ prompt = 'Msg: ' }, function(input)
    io.popen("git add src/* && git commit -am '" .. input .. "' && git push")
  end)
end

-- Telescope
key_map('n', '<C-p>', ':lua require"telescope.builtin".find_files()<CR>')
key_map('n', '<leader>fs', ':lua require"telescope.builtin".live_grep()<CR>')
key_map('n', '<leader>fh', ':lua require"telescope.builtin".help_tags()<CR>')
key_map('n', '<leader>fb', ':lua require"telescope.builtin".buffers()<CR>')
key_map('n', '<leader>ct', '<Cmd>TagbarToggle<CR>')

-- Git
key_map('n', '<leader>gc', ':lua git_commit_all()<CR>')
key_map('n', '<leader>ga', ':lua git_commit_push_all()<CR>')

--LSP
function P.map_lsp_keys() 
  key_map('n', '<C-]>', ':lua vim.lsp.buf.definition()<CR>')
  key_map('n', '<C-k>', ':lua vim.lsp.buf.signature_help()<CR>')
  key_map('n', '<S-R>', ':lua vim.lsp.buf.references()<CR>')
  key_map('n', '<S-H>', ':lua vim.lsp.buf.hover()<CR>')
  key_map('n', '<leader>ca', ':lua vim.lsp.buf.code_action()<CR>')
  key_map('n', '<leader>nc', ':lua vim.lsp.buf.rename()<CR>')
  key_map('n', '<leader>fr', ':lua require"telescope.builtin".lsp_references()')
end


-- nvim tree

local function on_attach(bufnr)
  local api = require('nvim-tree.api')

local function opts(desc)
    return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

key_map('n', '<leader>tt', ':lua require"nvim-tree".toggle(true)<CR>')
key_map('n', '<leader>tf', ':lua require"nvim-tree".find_file()<CR>')


vim.keymap.set('n', 'u', api.tree.change_root_to_parent, opts('Up'))
vim.keymap.set('n', '<C-]>', api.tree.change_root_to_node,          opts('CD'))
  vim.keymap.set('n', '<C-e>', api.node.open.replace_tree_buffer,     opts('Open: In Place'))
  vim.keymap.set('n', '<C-k>', api.node.show_info_popup,              opts('Info'))
  vim.keymap.set('n', '<C-r>', api.fs.rename_sub,                     opts('Rename: Omit Filename'))
  vim.keymap.set('n', '<C-t>', api.node.open.tab,                     opts('Open: New Tab'))
  vim.keymap.set('n', '<C-v>', api.node.open.vertical,                opts('Open: Vertical Split'))
  vim.keymap.set('n', '<C-x>', api.node.open.horizontal,              opts('Open: Horizontal Split'))
  vim.keymap.set('n', '<BS>',  api.node.navigate.parent_close,        opts('Close Directory'))
  vim.keymap.set('n', '<CR>',  api.node.open.edit,                    opts('Open'))
  vim.keymap.set('n', '<Tab>', api.node.open.preview,                 opts('Open Preview'))
  vim.keymap.set('n', '>',     api.node.navigate.sibling.next,        opts('Next Sibling'))
  vim.keymap.set('n', '<',     api.node.navigate.sibling.prev,        opts('Previous Sibling'))
  vim.keymap.set('n', '.',     api.node.run.cmd,                      opts('Run Command'))
  vim.keymap.set('n', '-',     api.tree.change_root_to_parent,        opts('Up'))
  vim.keymap.set('n', 'a',     api.fs.create,                         opts('Create'))
  vim.keymap.set('n', 'bd',    api.marks.bulk.delete,                 opts('Delete Bookmarked'))
  vim.keymap.set('n', 'bmv',   api.marks.bulk.move,                   opts('Move Bookmarked'))
  vim.keymap.set('n', 'B',     api.tree.toggle_no_buffer_filter,      opts('Toggle Filter: No Buffer'))
  vim.keymap.set('n', 'c',     api.fs.copy.node,                      opts('Copy'))
  vim.keymap.set('n', 'C',     api.tree.toggle_git_clean_filter,      opts('Toggle Filter: Git Clean'))
  vim.keymap.set('n', '[c',    api.node.navigate.git.prev,            opts('Prev Git'))
  vim.keymap.set('n', ']c',    api.node.navigate.git.next,            opts('Next Git'))
  vim.keymap.set('n', 'd',     api.fs.remove,                         opts('Delete'))
  vim.keymap.set('n', 'D',     api.fs.trash,                          opts('Trash'))
  vim.keymap.set('n', 'E',     api.tree.expand_all,                   opts('Expand All'))
  vim.keymap.set('n', 'e',     api.fs.rename_basename,                opts('Rename: Basename'))
  vim.keymap.set('n', ']e',    api.node.navigate.diagnostics.next,    opts('Next Diagnostic'))
  vim.keymap.set('n', '[e',    api.node.navigate.diagnostics.prev,    opts('Prev Diagnostic'))
  vim.keymap.set('n', 'F',     api.live_filter.clear,                 opts('Clean Filter'))
  vim.keymap.set('n', 'f',     api.live_filter.start,                 opts('Filter'))
  vim.keymap.set('n', 'g?',    api.tree.toggle_help,                  opts('Help'))
  vim.keymap.set('n', 'gy',    api.fs.copy.absolute_path,             opts('Copy Absolute Path'))
  vim.keymap.set('n', 'H',     api.tree.toggle_hidden_filter,         opts('Toggle Filter: Dotfiles'))
  vim.keymap.set('n', 'I',     api.tree.toggle_gitignore_filter,      opts('Toggle Filter: Git Ignore'))
  vim.keymap.set('n', 'J',     api.node.navigate.sibling.last,        opts('Last Sibling'))
  vim.keymap.set('n', 'K',     api.node.navigate.sibling.first,       opts('First Sibling'))
  vim.keymap.set('n', 'm',     api.marks.toggle,                      opts('Toggle Bookmark'))
  vim.keymap.set('n', 'o',     api.node.open.edit,                    opts('Open'))
  vim.keymap.set('n', 'O',     api.node.open.no_window_picker,        opts('Open: No Window Picker'))
  vim.keymap.set('n', 'p',     api.fs.paste,                          opts('Paste'))
  vim.keymap.set('n', 'P',     api.node.navigate.parent,              opts('Parent Directory'))
  vim.keymap.set('n', 'q',     api.tree.close,                        opts('Close'))
  vim.keymap.set('n', 'r',     api.fs.rename,                         opts('Rename'))
  vim.keymap.set('n', 'R',     api.tree.reload,                       opts('Refresh'))
  vim.keymap.set('n', 's',     api.node.run.system,                   opts('Run System'))
  vim.keymap.set('n', 'S',     api.tree.search_node,                  opts('Search'))
  vim.keymap.set('n', 'U',     api.tree.toggle_custom_filter,         opts('Toggle Filter: Hidden'))
  vim.keymap.set('n', 'W',     api.tree.collapse_all,                 opts('Collapse'))
  vim.keymap.set('n', 'x',     api.fs.cut,                            opts('Cut'))
  vim.keymap.set('n', 'y',     api.fs.copy.filename,                  opts('Copy Name'))
  vim.keymap.set('n', 'Y',     api.fs.copy.relative_path,             opts('Copy Relative Path'))
  vim.keymap.set('n', '<2-LeftMouse>',  api.node.open.edit,           opts('Open'))
  vim.keymap.set('n', '<2-RightMouse>', api.tree.change_root_to_node, opts('CD'))
end

-- bufferline
key_map('n', '<leader>bq', '<Cmd>bdelete!<CR>')
key_map('n', '<leader>bp', '<Cmd>BufferLineTogglePin<CR>')
key_map('n', '<leader>bs', '<Cmd>BufferLinePick<CR>')
key_map('n', '<C-h>', '<Cmd>BufferLineCyclePrev<CR>')
key_map('n', '<C-l>', '<Cmd>BufferLineCycleNext<CR>')

-- Terminal
key_map('', '<leader>tc', '<Cmd>ToggleTermToggleAll<CR>')

-- Debugging 

function debug_open_centered_scopes()
  local widgets = require'dap.ui.widgets'
  widgets.centered_float(widgets.scopes)
end

key_map('n', 'gs', ':lua debug_open_centered_scopes()<CR>')
key_map('n', '<F5>', ':lua require"dap".continue()<CR>')
key_map('n', '<F8>', ':lua require"dap".step_over()<CR>')
key_map('n', '<F7>', ':lua require"dap".step_into()<CR>')
key_map('n', '<S-F8>', ':lua require"dap".step_out()<CR>')
key_map('n', '<leader>b', ':lua require"dap".toggle_breakpoint()<CR>')
key_map('n', '<leader>B', ':lua require"dap".set_breakpoint(vim.fn.input("Condition: "))<CR>')
key_map('n', '<leader>bl', ':lua require"dap".set_breakpoint(nil, nil, vim.fn.input("Log: "))<CR>')
key_map('n', '<leader>dr', ':lua require"dap".repl.open()<CR>')

-- Java

-- Rust
function P.map_rust_keys(bufnr)
  P.map_lsp_keys()
  key_map('n', '<leader>rr', '<Cmd>RustRunnable<CR>')
  key_map('n', '<leader>rb', '<cmd>term cargo build<cr>')
  key_map('n', '<leader>rc', '<cmd>term cargo check<cr>')
  key_map('n', '<leader>rt', '<cmd>term cargo test<cr>')
end

function P.run_command_method_test()
  local node_utils = require'node-utils'
  local method_name = node_utils.get_current_full_method_name("\\#")
  local mvn_run = 'mvn test -Dmaven.surefire.debug -Dtest="' .. method_name .. '"' 
  vim.cmd('term ' .. mvn_run)
end

function P.run_command_class_test()
  local node_utils = require'node-utils'
  local class_name = node_utils.get_current_full_class_name()
  local mvn_run = 'mvn test -Dmaven.surefire.debug -Dtest="' .. class_name .. '"' 
  vim.cmd('term ' .. mvn_run)
end

-- Java
function P.map_java_keys(bufnr)
  P.map_lsp_keys()
  key_map('n', '<leader>oi', ':lua require("jdtls").organize_imports()<CR>')
  key_map('n', '<leader>jc', ':lua require("jdtls).compile("incremental")')
end

-- hop
key_map('n', 'f', '<cmd>HopWordCurrentLineAC<cr>')
key_map('n', '<S-F>', '<cmd>HopWordCurrentLineBC<cr>')
key_map('n', '<leader>hp', '<cmd>HopPattern<cr>')
key_map('n', 'gt', '<cmd>HopLine<cr>')
-- additional
key_map('n', '<leader>sf', ':w<CR>')
key_map('n', '<S-Q>', '<Cmd>q<CR>')


-- run debug
function get_test_runner(test_name, debug)
  if debug then
    return 'mvn test -Dmaven.surefire.debug -Dtest="' .. test_name .. '"' 
  end
  return 'mvn test -Dtest="' .. test_name .. '"' 
end

function run_java_test_method(debug)
  local utils = require'utils'
  local method_name = utils.get_current_full_method_name("\\#")
  vim.cmd('term ' .. get_test_runner(method_name, debug))
end

function run_java_test_class(debug)
  local utils = require'utils'
  local class_name = utils.get_current_full_class_name()
  vim.cmd('term ' .. get_test_runner(class_name, debug))
end

function get_spring_boot_runner(profile, debug)
  local debug_param = ""
  if debug then
    debug_param = ' -Dspring-boot.run.jvmArguments="-Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=y,address=5005" '
  end 

  local profile_param = ""
  if profile then
    profile_param = " -Dspring-boot.run.profiles=" .. profile .. " "
  end

  return 'mvn spring-boot:run ' .. profile_param .. debug_param
end

function run_spring_boot(debug)
  vim.cmd('term ' .. get_spring_boot_runner("local", debug))
end

vim.keymap.set("n", "<leader>tm", function() run_java_test_method() end)
vim.keymap.set("n", "<leader>TM", function() run_java_test_method(true) end)
vim.keymap.set("n", "<leader>tc", function() run_java_test_class() end)
vim.keymap.set("n", "<leader>TC", function() run_java_test_class(true) end)
vim.keymap.set("n", "<F9>", function() run_spring_boot() end)
vim.keymap.set("n", "<F10>", function() run_spring_boot(true) end)

function attach_to_debug()
  local dap = require('dap')
  dap.configurations.java = {
    {
      type = 'java';
      request = 'attach';
      name = "Attach to the process";
      hostName = 'localhost';
      port = '5005';
    },
  }
  dap.continue()
end 

key_map('n', '<leader>da', ':lua attach_to_debug()<CR>')
return P

