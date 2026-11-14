local conform = require("conform")

local function format(bufnr)
  if vim.bo[bufnr].buftype ~= "" then
    return
  end

  local formatters = conform.list_formatters_to_run(bufnr)
  if #formatters == 0 then
    return
  end

  conform.format({ bufnr = bufnr, timeout_ms = 3000, lsp_format = "never" })
end

vim.api.nvim_create_user_command("Format", function()
  format(vim.api.nvim_get_current_buf())
end, { desc = "Format the current buffer" })

vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function(args)
    format(args.buf)
  end,
})
