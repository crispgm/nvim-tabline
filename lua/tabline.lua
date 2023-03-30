-- nvim-tabline
-- David Zhang <https://github.com/crispgm>

local M = {}
local fn = vim.fn
local a = vim.api

M.options = {
    show_index = true,
    show_modify = true,
    show_icon = false,
    fnamemodify = ':t',
    hide_if_only_tab = false,
    brackets = { '[', ']' },
    no_name = 'No Name',
    modify_indicator = ' [+]',
    inactive_tab_max_length = 0,
}

local function tabline(options)
    local s = ''
    local total = fn.tabpagenr('$')
    for index = 1, total do
        local winnr = fn.tabpagewinnr(index)
        local buflist = fn.tabpagebuflist(index)
        local bufnr = buflist[winnr]
        local bufname = fn.bufname(bufnr)
        local bufmodified = fn.getbufvar(bufnr, '&mod')

        s = s .. '%' .. index .. 'T'
        if index == fn.tabpagenr() then
            s = s .. '%#TabLineSel#'
        else
            s = s .. '%#TabLine#'
        end
        -- tab index
        s = s .. ' '
        -- index
        if options.show_index then
            s = s .. index .. ':'
        end
        -- icon
        local icon = ''
        if options.show_icon and M.has_devicons then
            local ext = fn.fnamemodify(bufname, ':e')
            icon = M.devicons.get_icon(bufname, ext, { default = true }) .. ' '
        end
        -- buf name
        s = s .. options.brackets[1]
        local pre_title_s_len = string.len(s)
        if bufname ~= '' then
            s = s .. icon .. fn.fnamemodify(bufname, options.fnamemodify)
        else
            s = s .. options.no_name
        end
        if
            options.inactive_tab_max_length
            and options.inactive_tab_max_length > 0
            and index ~= fn.tabpagenr()
        then
            s = string.sub(
                s,
                1,
                pre_title_s_len + options.inactive_tab_max_length
            )
        end
        s = s .. options.brackets[2]
        -- modify indicator
        if
            bufmodified == 1
            and options.show_modify
            and options.modify_indicator ~= nil
        then
            s = s .. options.modify_indicator
        end
        -- additional space at the end of each tab segment
        s = s .. ' '
    end

    s = s .. '%#TabLineFill#'
    return s
end

function M.setup(user_options)
    M.options = vim.tbl_extend('force', M.options, user_options)
    M.has_devicons, M.devicons = pcall(require, 'nvim-web-devicons')

    function _G.nvim_tabline()
        return tabline(M.options)
    end

    -- autocmd
    local function _callback()
        local total = fn.tabpagenr('$')
        if M.options.hide_if_only_tab and total == 1 then
            vim.o.showtabline = 0
        else
            vim.o.showtabline = 2
        end
    end

    local group = a.nvim_create_augroup('nvim-tabline', { clear = true })
    a.nvim_create_autocmd({ 'TabEnter', 'TabClosed' }, {
        group = group,
        pattern = { '*' },
        callback = _callback,
    })

    vim.o.tabline = '%!v:lua.nvim_tabline()'
    vim.g.loaded_nvim_tabline = 1
end

return M
