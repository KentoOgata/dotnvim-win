local cmp = require('cmp')

cmp.setup {
  experimental = {
    ghost_text = true,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  sources = {
    { name = 'buffer' },
  },
  mapping = {
    ['<CR>'] = function(fallback)
      if cmp.visible() then
        cmp.confirm { select = true }
      else
        fallback()
      end
    end,
    ['<C-g>'] = function(fallback)
      if cmp.visible() then
        cmp.abort()
      else
        fallback()
      end
    end,
    ['<C-n>'] = function()
      if cmp.visible() then
        cmp.select_next_item { cmp.SelectBehavior.Select }
      else
        cmp.complete()
      end
    end,
    ['<C-p>'] = function()
      if cmp.visible() then
        cmp.select_prev_item { cmp.SelectBehavior.Select }
      else
        cmp.complete()
      end
    end,
  },
}

cmp.setup.filetype('vim', {
  sources = {
    { name = 'cmdline' },
    { name = 'buffer' },
  },
})

cmp.setup.filetype('lua', {
  sources = {
    { name = 'nvim_lua' },
    { name = 'buffer' },
  },
})

cmp.setup.cmdline(':', {
  sources = {
    {
      name = 'cmdline',
      option = {
        ignore_cmds = { 'Man', '!', [[\]] },
      },
    },
  },
  mapping = {
    ['<TAB>'] = {
      c = function()
        if cmp.visible() then
          cmp.select_next_item { cmp.SelectBehavior.Insert }
        else
          cmp.complete()
        end
      end,
    },
    ['<S-TAB>'] = {
      c = function()
        if cmp.visible() then
          cmp.select_prev_item { cmp.SelectBehavior.Insert }
        else
          cmp.complete()
        end
      end,
    },
    ['<C-g>'] = {
      c = function(fallback)
        if cmp.visible() then
          cmp.abort()
        else
          fallback()
        end
      end,
    },
  },
})

cmp.setup.cmdline('/', {
  sources = {
    { name = 'buffer' },
  },
  mapping = {
    ['<TAB>'] = {
      c = function()
        if cmp.visible() then
          cmp.select_next_item { cmp.SelectBehavior.Insert }
        else
          cmp.complete()
        end
      end,
    },
    ['<S-TAB>'] = {
      c = function()
        if cmp.visible() then
          cmp.select_prev_item { cmp.SelectBehavior.Insert }
        else
          cmp.complete()
        end
      end,
    },
    ['<C-g>'] = {
      c = function(fallback)
        if cmp.visible() then
          cmp.abort()
        else
          fallback()
        end
      end,
    },
  },
})
