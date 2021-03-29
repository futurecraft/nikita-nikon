# RAKEFILE with a task to execute tests

require 'cucumber/rake/task'

task :run_cukes, :tag do |task, args|
  Cucumber::Rake::Task.new :exec_cukes do |task|
    features_list = Dir.glob 'features/**/*.feature'
    filename_pattern = Time.now.strftime("%d.%m_%H:%M:%S")
    ENV['report_path'] = "results/reports/cukes_report_#{filename_pattern}.html"

    task.cucumber_opts = features_list.join(" \n") +
      " -q -f pretty --t @#{args.tag}" +
      " -f html --out #{ENV['report_path']}"
  end
  Rake::Task[:exec_cukes].execute

  puts "REPORT PATH: < /app/#{ENV['report_path']} >"
end
