local opt = vim.opt

opt.relativenumber = true
opt.number = true
opt.wrap = false

opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true

vim.api.nvim_create_autocmd("VimEnter", {
  pattern = "*.cpp",
  callback = function()
    if vim.fn.filereadable("test") == 0 then
        local clipboard_content = vim.fn.systemlist('xclip -o -selection clipboard')
        if #clipboard_content > 0 then
            vim.fn.writefile(clipboard_content, "test")
        else
            vim.fn.writefile({}, "test")
        end
    end

    vim.cmd("vsplit test | wincmd l")
    vim.cmd("wincmd H")
    vim.cmd("wincmd h")
    vim.bo.bufhidden = "hide"   -- Keep buffer when hidden
  end
})
