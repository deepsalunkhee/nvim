---------------------------------------------------------
--  WHICH-KEY CONFIGURATION - INTERACTIVE KEYMAP GUIDE
---------------------------------------------------------
-- This plugin shows an interactive popup with all available keymaps
-- Press <leader> and wait to see available commands
-- Press <leader>km to see the complete keymap guide

return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	config = function()
		local wk = require("which-key")

		wk.setup({
			plugins = {
				marks = true,
				registers = true,
				spelling = {
					enabled = true,
					suggestions = 20,
				},
				presets = {
					operators = true,
					motions = true,
					text_objects = true,
					windows = true,
					nav = true,
					z = true,
					g = true,
				},
			},
			icons = {
				breadcrumb = "»",
				separator = "➜",
				group = "+",
			},
			win = {
				border = "rounded",
				padding = { 1, 2 },
			},
			layout = {
				height = { min = 4, max = 25 },
				width = { min = 20, max = 50 },
				spacing = 3,
				align = "left",
			},
			show_help = true,
			triggers = "auto",
		})

		---------------------------------------------------------
		-- LEADER KEY MAPPINGS (Main Categories)
		---------------------------------------------------------
		wk.add({
			-- File Explorer
			{ "<leader>e", desc = "File Explorer (netrw)" },

			-- Telescope Keymaps
			{ "<leader>f", group = "Find (Telescope)" },
			{ "<leader>ff", desc = "Find Files" },
			{ "<leader>fg", desc = "Live Grep (search text)" },
			{ "<leader>fr", desc = "Recent Files" },
			{ "<leader>fb", desc = "Buffer Search" },
			{ "<leader>fh", desc = "Help Tags" },
			{ "<leader>fs", desc = "Document Symbols (LSP)" },
			{ "<leader>fd", desc = "Diagnostics" },

			-- LSP Keymaps
			{ "<leader>r", group = "Refactor/Rename" },
			{ "<leader>rn", desc = "Rename Symbol" },
			{ "<leader>c", group = "Code" },
			{ "<leader>ca", desc = "Code Actions" },

			-- Formatter
			{ "<leader>m", group = "Format" },
			{ "<leader>mp", desc = "Format File/Range" },

			-- Keymap Guide
			{ "<leader>k", group = "Keymaps" },
			{ "<leader>km", desc = "Show Keymap Guide (this menu)" },
		})

		---------------------------------------------------------
		-- NORMAL MODE KEYMAPS (Non-leader)
		---------------------------------------------------------
		wk.add({
			-- Window Navigation
			{ "<C-h>", desc = "Move to Left Window" },
			{ "<C-j>", desc = "Move to Bottom Window" },
			{ "<C-k>", desc = "Move to Top Window" },
			{ "<C-l>", desc = "Move to Right Window" },

			-- Window Resizing
			{ "<C-Up>", desc = "Increase Window Height" },
			{ "<C-Down>", desc = "Decrease Window Height" },
			{ "<C-Left>", desc = "Decrease Window Width" },
			{ "<C-Right>", desc = "Increase Window Width" },

			-- Buffer Navigation
			{ "<S-l>", desc = "Next Buffer" },
			{ "<S-h>", desc = "Previous Buffer" },

			-- LSP Navigation
			{ "gd", desc = "Go to Definition" },
			{ "gr", desc = "Go to References" },
			{ "K", desc = "Show Hover Documentation" },
			{ "[d", desc = "Previous Diagnostic" },
			{ "]d", desc = "Next Diagnostic" },
		})

		---------------------------------------------------------
		-- VISUAL MODE KEYMAPS
		---------------------------------------------------------
		wk.add({
			mode = "v",
			{ "<", desc = "Indent Left (stay in visual)" },
			{ ">", desc = "Indent Right (stay in visual)" },
			{ "J", desc = "Move Selected Lines Down" },
			{ "K", desc = "Move Selected Lines Up" },

			-- Comment (Visual Mode)
			{ "gc", desc = "Toggle Line Comment" },
			{ "gb", desc = "Toggle Block Comment" },
		})

		---------------------------------------------------------
		-- INSERT MODE KEYMAPS (Copilot)
		---------------------------------------------------------
		wk.add({
			mode = "i",
			{ "<C-j>", desc = "Accept Copilot Suggestion" },
			{ "<C-l>", desc = "Next Copilot Suggestion" },
			{ "<C-h>", desc = "Previous Copilot Suggestion" },
			{ "<C-\\>", desc = "Trigger Copilot Suggestion" },

			-- Completion Navigation
			{ "<C-Space>", desc = "Trigger Completion" },
			{ "<C-e>", desc = "Abort Completion" },
			{ "<CR>", desc = "Confirm Completion" },
			{ "<Tab>", desc = "Next Completion Item" },
			{ "<S-Tab>", desc = "Previous Completion Item" },
			{ "<C-b>", desc = "Scroll Docs Up" },
			{ "<C-f>", desc = "Scroll Docs Down" },
		})

		---------------------------------------------------------
		-- COMMENT PLUGIN KEYMAPS (Normal Mode)
		---------------------------------------------------------
		wk.add({
			{ "gcc", desc = "Toggle Line Comment" },
			{ "gbc", desc = "Toggle Block Comment" },
			{ "gc", desc = "Comment Operator (use with motion)" },
			{ "gb", desc = "Block Comment Operator" },
			{ "gcO", desc = "Add Comment Above" },
			{ "gco", desc = "Add Comment Below" },
			{ "gcA", desc = "Add Comment at End of Line" },
		})

		---------------------------------------------------------
		-- KEYMAP TO SHOW FULL GUIDE
		---------------------------------------------------------
		vim.keymap.set("n", "<leader>km", function()
			vim.cmd("WhichKey")
		end, { desc = "Show Complete Keymap Guide" })
	end,
}

--[[
=============================================================================
QUICK START GUIDE FOR NEW USERS
=============================================================================

BASIC NAVIGATION:
  h, j, k, l          - Move left, down, up, right
  w, b                - Jump forward/backward by word
  0, $                - Jump to start/end of line
  gg, G               - Jump to top/bottom of file
  Ctrl+d, Ctrl+u      - Scroll half page down/up

MODES:
  i                   - Enter Insert mode (start typing)
  v                   - Enter Visual mode (select text)
  V                   - Enter Visual Line mode
  Esc                 - Return to Normal mode
  :                   - Enter Command mode

BASIC EDITING:
  dd                  - Delete line
  yy                  - Copy line
  p                   - Paste
  u                   - Undo
  Ctrl+r              - Redo
  x                   - Delete character

FILE OPERATIONS:
  :w                  - Save file
  :q                  - Quit
  :wq                 - Save and quit
  :q!                 - Quit without saving

FINDING THINGS:
  Space+ff            - Find files by name
  Space+fg            - Search text in files
  Space+fr            - Recent files
  Space+fb            - Search in current file

CODING FEATURES:
  gd                  - Go to definition
  K                   - Show documentation
  Space+rn            - Rename variable
  Space+ca            - Code actions
  Space+mp            - Format code

HELP:
  Space+km            - Show this keymap guide
  Space               - Wait after pressing to see all leader commands
  :help <topic>       - Vim help system

TIPS:
  - Press Space and wait to see all available commands
  - In Visual mode, select text then press gc to comment
  - Use Ctrl+j to accept Copilot suggestions
  - Use Shift+h/l to switch between open files
  
=============================================================================
]]
