local M = {}


local config = {}


function M.setup(config_)
    config.marks_tracker_path = config_.marks_tracker_path or '.lasso-marks-tracker'
end


local function get_marks_tracker_bufnr()
    local existing_marks_tracker_bufnr = vim.fn.bufnr(config.marks_tracker_path)
    if existing_marks_tracker_bufnr ~= -1 then
        return existing_marks_tracker_bufnr
    end

    local new_marks_tracker_bufnr = vim.api.nvim_create_buf(false, false)
    vim.api.nvim_buf_set_name(new_marks_tracker_bufnr, config.marks_tracker_path)
    vim.api.nvim_buf_call(new_marks_tracker_bufnr, vim.cmd.edit)

    return new_marks_tracker_bufnr
end


function M.mark_file()
    if vim.api.nvim_buf_get_option(0, 'buftype') ~= '' then
        error('The current buffer is not associated with a regular file')
    end

    local marks_tracker_bufnr = get_marks_tracker_bufnr()

    local buffer_name = vim.fn.expand('%')
    local file_path = vim.fn.fnamemodify(buffer_name, ':~:.')

    local lines = vim.api.nvim_buf_get_lines(marks_tracker_bufnr, 0, -1, false)
    for _, line in ipairs(lines) do
        if line == file_path then return end
    end

    local content = table.concat(lines, '\n')
    if content == '' then
        -- File is empty, set first line
        vim.api.nvim_buf_set_lines(marks_tracker_bufnr, 0, 1, false, {file_path})
    else
        -- Append to the file
        vim.api.nvim_buf_set_lines(marks_tracker_bufnr, -1, -1, false, {file_path})
    end

end


function M.open_marked_file(n)
    local marks_tracker_bufnr = get_marks_tracker_bufnr()

    local n_ = n - 1  -- zero-based numbering
    local lines = vim.api.nvim_buf_get_lines(marks_tracker_bufnr, n_, n_ + 1, false)

    if #lines == 0 then
        error('Lasso marks tracker has no entry #' .. n)
    end

    local file_path = lines[1]
    vim.cmd('edit ' .. vim.fn.fnameescape(file_path))
end


function M.open_marks_tracker()
    local marks_tracker_bufnr = get_marks_tracker_bufnr()
    vim.api.nvim_win_set_buf(0, marks_tracker_bufnr)
end


-- LASSO TERMINALS


local terminal_bufnrs = {}

function M.open_terminal(n)
    local bufnr = terminal_bufnrs[n]

    if bufnr and vim.api.nvim_buf_is_valid(bufnr) then
        vim.api.nvim_win_set_buf(0, bufnr)
        return
    end

    vim.cmd('terminal')
    terminal_bufnrs[n] = vim.api.nvim_get_current_buf()
end


return M
