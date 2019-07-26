require 'html-proofer'

task :test do
  sh "bundle exec jekyll build --trace"
  # ignore href="#" for the "Copy to clipboard" button
  HTMLProofer.check_directory('./_site').run
end