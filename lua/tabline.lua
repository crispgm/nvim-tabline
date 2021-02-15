-- nvim-tabline
-- David Zhang <https://github.com/crispgm>

local M = {}
local fn = vim.fn

M.options = {
    show_index = true,
    show_modify = true,
    no_name = '[No Name]'
}

local function tabline(options)
    local s = ''
    for index = 1, fn.tabpagenr('$') do
        local winnr = fn.tabpagewinnr(index)
        local buflist = fn.tabpagebuflist(index)
        local bufnr = buflist[winnr]
        local bufname = fn.bufname(bufnr)
        local bufmodified = fn.getbufvar(bufnr, "&mod")

        s = s .. '%' .. index .. 'T'
        if index == fn.tabpagenr() then
            s = s .. '%#TabLineSel#'
        else
            s = s .. '%#TabLine#'
        end
        s = s .. ' '
        if options.show_index then
            s = s .. index .. ':'
        end

        if bufname ~= '' then
            s = s .. '[' .. fn.fnamemodify(bufname, ':t') .. '] '
        else
            s = s .. options.no_name .. ' '
        end
        if options.show_modify and bufmodified == 1 then
            s = s .. '[+] '
        end
    end

    s = s .. '%#TabLineFill#'

    return s
end

function M.setup(user_options)
    M.options = vim.tbl_extend('force', M.options, user_options)

    function _G.nvim_tabline()
        return tabline(M.options)
    end

    vim.o.showtabline = 2
    vim.o.tabline = "%!v:lua.nvim_tabline()"

    vim.g.loaded_nvim_tabline = 1
end

return M
