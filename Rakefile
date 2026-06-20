require 'html-proofer'

task :build do
  sh "bundle exec jekyll build --trace"
end

task :test do
  Rake::Task[:build].invoke

  ignored_urls = [
    "https://www.its.net.gr/",
    "https://www.fulltiltpoker.com/"
  ]

  if ENV["HTMLPROOFER_IGNORE_EXTERNAL"] == "true"
    ignored_urls << %r{^https?://}
  end

  HTMLProofer.check_directory('./_site',{
    :url_swap => { /#{"https://codesennin.com"}/ => '' },
    :ignore_status_codes => [999, 302],
    :ignore_urls => ignored_urls
    }).run
end

task :host do
  sh "bundle exec rake test && jekyll serve --livereload --force-polling "
end

task :serve do
  sh "jekyll serve --livereload --force-polling "
end
