local function run_command(command)
  local handle = io.popen(command)

  if not handle then
    return ""
  end

  local result = handle:read("*a")

  handle:close()

  return result
end


function Git_backup()
  local notify = require("notify")
  local output = run_command('git log --oneline --format=%s -1')
  local current_date = run_command('date "+%Y-%m-%d"')
  local commit_message = 'backup ' .. current_date
  local notify_title = 'Git Processing'

  if output == commit_message then
    notify('Amending last commit with new changes', vim.log.levels.INFO, { title = notify_title })
    os.execute('git add -A && git commit --allow-empty --amend --no-edit')
    notify('Pushing changes to remote', vim.log.levels.INFO, { title = notify_title })
    vim.fn.jobstart({ 'git', 'push', '--force-with-lease' }, {
      stdout = false,
      on_exit = function()
        notify('Pushed changes to remote', vim.log.levels.INFO, { title = notify_title })
      end
    })
  else
    notify('Creating new commit', vim.log.levels.INFO, { title = notify_title })
    os.execute('git add -A && git commit -m "' .. commit_message .. '"')
    notify('Pushing changes to remote', vim.log.levels.INFO, { title = notify_title })
    vim.fn.jobstart({ 'git', 'push', '--force-with-lease' }, {
      stdout = false,
      on_exit = function()
        notify('Pushed changes to remote', vim.log.levels.INFO, { title = notify_title })
      end
    })
  end
end
