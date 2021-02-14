local M = {}
local fn = vim.fn

M.options = {
    index = true,
    show_modify = false,
    no_name = '[No Name]'
}

function M.tabline()
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
        if M.options.index then
            s = s .. index .. ':'
        end

        if bufname ~= '' then
            s = s .. '[' .. fn.fnamemodify(bufname, ':t') .. '] '
        else
            s = s .. M.options.no_name .. ' '
        end
        if M.options.show_modify and bufmodified then
            s = s .. '[+] '
        end
    end

    s = s .. '%#TabLineFill#'
    print(s)

    return s
end

function M.setup(user_options)
    M.options = vim.tbl_extend('force', M.options, user_options)

    vim.o.showtabline = 2
    vim.o.tabline = [[%!luaeval('require("tabline").tabline()')]]
end

return M
