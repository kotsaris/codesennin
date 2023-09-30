require 'html-proofer'

task :test do
  sh "bundle exec jekyll build --trace"
  HTMLProofer.check_directory('./_site',{
    :url_swap => { /#{"https://codesennin.com"}/ => '' },
    :ignore_status_codes => [999, 302],
    :ignore_urls => [ "https://www.its.net.gr/", "https://www.fulltiltpoker.com/"]
    }).run
end

task :host do
  sh "bundle exec rake test && jekyll serve --livereload --force-polling "
end