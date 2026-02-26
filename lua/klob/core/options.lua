local opt = vim.opt

opt.relativenumber = true
opt.number = true
opt.wrap = false

opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true


local function get_clipboard_content()
    if os.getenv("WAYLAND_DISPLAY") then
        -- Wayland
        return vim.fn.systemlist('wl-paste')
    else
        -- X11
        return vim.fn.systemlist('xclip -o -selection clipboard 2>/dev/null')
    end
end

vim.api.nvim_create_autocmd("VimEnter", {
    pattern = "*.cpp",
    callback = function()
        if vim.fn.filereadable("test") == 0 then
            local clipboard_content = get_clipboard_content()
            if #clipboard_content > 0 and clipboard_content[1] ~= "" then
                vim.fn.writefile(clipboard_content, "test")
            else
                vim.fn.writefile({}, "test")
            end
        end

        vim.cmd("vsplit test | wincmd l")
        vim.cmd("wincmd H")
        vim.cmd("wincmd l")
        vim.cmd("wincmd h")
        vim.bo.bufhidden = "hide"
    end
})

