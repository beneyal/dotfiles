local nvimtree = require("nvim-tree.api")
vim.keymap.set("n", "<leader>nt", function() nvimtree.tree.toggle({ find_file = true }) end)
