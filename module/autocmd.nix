{
  config = {
    autoGroups.highlight_on_yank.clear = true;

    autoCmd = [
      {
        event = "TextYankPost";
        group = "highlight_on_yank";
        callback = {
          __raw = ''function() vim.highlight.on_yank() end'';
        };
      }
    ];
  };
}
