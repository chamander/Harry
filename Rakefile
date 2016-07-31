require_relative "lib/suite_task"

desc "Run swiftlint if available"
task :swiftlint do
  system "which -s swiftlint" and exec "swiftlint"
end

namespace :carthage do

  desc "Update dependencies, if required"
  task :update do
    system exec "carthage update --platform iphoneos --no-use-binaries --toolchain com.apple.dt.toolchain.Swift_2_3"
  end

  desc "Check build for Carthage"
  task :build do
    system exec "carthage build --no-skip-current --platform iphoneos --toolchain com.apple.dt.toolchain.Swift_2_3"
  end

end

namespace :test do

  def pretty(cmd)
    if system("which -s xcpretty")
      sh("/bin/sh", "-o", "pipefail", "-c", "env NSUnbufferedIO=YES #{cmd} | xcpretty")
    else
      sh(cmd)
    end
  end

  desc "Run iOS tests"
  task :ios do
    pretty "xcodebuild test -scheme Harry -destination 'platform=iOS Simulator,name=iPhone 6s'"
  end

end
