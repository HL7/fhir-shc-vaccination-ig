require 'rspec/core/rake_task'

desc "Run RSpec"
RSpec::Core::RakeTask.new do |t|
  t.verbose = true
  t.pattern = "spec/date_time_precision_spec.rb"
end

namespace :spec do
  desc "Run format specs"
  RSpec::Core::RakeTask.new(:format) do |t|
    t.verbose = true
    t.pattern = "spec/format_spec.rb"
  end

  desc "Run ActiveSupport specs"
  RSpec::Core::RakeTask.new(:active_support) do |t|
    t.verbose = true
    t.pattern = "spec/active_support_spec.rb"
  end

  desc "Run gem compatibility specs"
  RSpec::Core::RakeTask.new(:compatibility) do |t|
    t.verbose = true
    t.pattern = "spec/compatibility_spec.rb"
  end
end