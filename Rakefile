require 'html/proofer'

task :test do
  sh "bundle exec jekyll build"
  options = { :alt_ignore => [/.*/], :disable_external=> true, :href_ignore => ['#'] }
  HTML::Proofer.new("./_site",  options).run
end
