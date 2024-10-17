{ pkgs }:
{
  pkg = pkgs.vimPlugins.nvim-cmp;
  event = [
    "InsertEnter"
    "CmdlineEnter"
  ];
  dependencies = [
    pkgs.vimPlugins.lspkind-nvim
    {
      pkg = pkgs.vimPlugins.cmp-nvim-lua;
      opts = { };
    }
    {
      pkg = pkgs.vimPlugins.luasnip;
      dependencies = [ pkgs.vimPlugins.cmp_luasnip ];
    }
    {
      pkg = pkgs.vimPlugins.cmp-nvim-lsp;
      config = true;
    }
    {
      pkg = pkgs.vimPlugins.cmp-nvim-lsp-signature-help;
      opts = { };
    }
    {
      pkg = pkgs.vimPlugins.cmp-buffer;
      opts = { };
    }
    {
      pkg = pkgs.vimPlugins.cmp-path;
      opts = { };
    }
    {
      pkg = pkgs.vimPlugins.cmp-cmdline;
      opts = { };
    }
  ];
  config = # lua
    ''
      function()
      	local cmp = require("cmp")
      	local luasnip = require("luasnip")
      	local lspkind = require("lspkind")
      	require("luasnip/loaders/from_vscode").lazy_load()

      	cmp.setup({
      		formatting = {
      			format = lspkind.cmp_format({
      				mode = "symbol_text",
      				maxwidth = 60,
      				ellipsis_char = "...",
      				show_labelDetails = false,
      				before = function(entry, vim_item)
      					return vim_item
      				end,
      			}),
      		},
      		snippet = {
      			expand = function(args)
      				luasnip.lsp_expand(args.body)
      			end,
      		},
      		sources = cmp.config.sources({
      			{ name = "nvim_lsp_signature_help" },
      			{ name = "nvim_lsp" },
      			{ name = "nvim_lua" },
      			{ name = "luasnip" },
      		}, {
      			{ name = "buffer" },
      			{ name = "path" },
      		}),
      		mapping = cmp.mapping.preset.insert({
      			["<C-Space>"] = cmp.mapping.complete(),
      			["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
      			["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
      			["<C-b>"] = cmp.mapping.scroll_docs(-4),
      			["<C-f>"] = cmp.mapping.scroll_docs(4),
      			["<C-y>"] = cmp.mapping.confirm({ select = true }),
      		}),
      		window = {
      			completion = {
      				border = "rounded",
      			},
      			documentation = {
      				border = "rounded",
      			},
      		},
      		experimental = {
      			ghost_text = true,
      		},
      	})

      	cmp.setup.cmdline(":", {
      		mapping = cmp.mapping.preset.cmdline(),
      		sources = cmp.config.sources({
      			{ name = "path" },
      		}, {
      			{ name = "cmdline" },
      		}),
      	})
      end
    '';
}
