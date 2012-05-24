module TestRunsHelper
  def label_color test_run
    if test_run.passed?
      "success"
    else
      "important"
    end
  end
end