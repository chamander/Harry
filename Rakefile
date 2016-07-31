require_relative "lib/suite_task"

desc "Run swiftlint if available"
task :swiftlint do
  system "which -s swiftlint" and exec "swiftlint"
end
