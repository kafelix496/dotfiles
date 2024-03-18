vim.cmd [[
  augroup _markdown
    autocmd!
    autocmd FileType markdown nmap <buffer> <Space> :VimwikiToggleListItem<CR>
    autocmd FileType markdown vmap <buffer> <Space> :VimwikiToggleListItem<CR>
  augroup end
]]

local function is_in_vimwiki_directory(filePath)
  local pattern = "^(.-/?)vimwiki/.+%.md$"

  return string.match(filePath, pattern) ~= nil
end

local function get_vimwiki_directory(filePath)
  local pattern = "(.-vimwiki)/"
  local match = string.match(filePath, pattern)
  if match then
    -- Return the match including 'vimwiki'
    return match
  else
    -- Return nil if 'vimwiki' is not found in the path
    return nil
  end
end

local buf_hash = {}

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  callback = function()
    local filepath = vim.api.nvim_buf_get_name(0)

    if is_in_vimwiki_directory(filepath) then
      local vimwiki_root = get_vimwiki_directory(filepath)
      -- Set current directory to vimwiki root
      vim.api.nvim_set_current_dir(vimwiki_root)
    else
      local bufnr = vim.api.nvim_get_current_buf()
      local current_dir = vim.fn.getcwd()

      if buf_hash[bufnr] ~= nil then
        if buf_hash[bufnr] ~= current_dir then
          -- Set current directory to saved directory
          vim.api.nvim_set_current_dir(buf_hash[bufnr])
        end
      else
        buf_hash[bufnr] = current_dir
      end
    end
  end,
})
