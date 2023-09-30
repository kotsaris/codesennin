require 'html-proofer'

task :test do
  sh "bundle exec jekyll build --trace"
  HTMLProofer.check_directory('./_site',{
    :url_swap => { /#{"https://codesennin.com"}/ => '' },
    :http_status_ignore => [999,302],
    }).run
end

task :host do
  sh "bundle exec rake test && jekyll serve --livereload --force-polling "
end