module Client

  # This module provides handy git commands.
  #
  # Expects the context to provide methods:
  #   url:  URL to git repository
  #   path: local path to clone to
  #   sh:   shell execution (from `Runner`)
  module GitCommands

    # Clone the repository at `url` into the
    # local folder at `path`.
    def clone_repo
      opts = git_options.join ' '
      sh "rm -rf #{path}",
         "git clone #{url} #{path} #{opts}"
    end

    def git_options
      [
        # '--progress'        # shows 'Receiving objects' and such,
      ]                       # but really meant just for TTYs
    end
  end
end
