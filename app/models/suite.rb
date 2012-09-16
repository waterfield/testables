class Suite
  include Mongoid::Document

  field :name, type: String

  belongs_to :project

  has_many :test_runs
  has_many :tasks

  def task!(contents, attrs={})
    tasks.create! attrs.merge(contents: project.task.merge(contents))
  end

  def test!
    task! type: 'rspec_suite'
  end

  def group_size
    1
  end

  def start_tests files
    run = test_runs.create!(
      file_count: files.size,
      files_done: 0
    )
    files.in_groups_of(group_size).each do |group|
      task!({
        type: 'rspec_test',
        files: group,
      },{
        test_run_id: run.id
      })
    end
  end

end
