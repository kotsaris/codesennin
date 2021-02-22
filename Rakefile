require 'html-proofer'

task :test do
  sh "bundle exec jekyll build --trace"
  HTMLProofer.check_directory('./_site').run
end

task :host do
  sh "bundle exec rake test && jekyll serve -d /_site --watch --force_polling -H 0.0.0.0 -P 4000"
end