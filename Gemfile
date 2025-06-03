source 'https://rubygems.org'

# Specify your gem's dependencies in inheritance_integer_type.gemspec
gemspec

ar_version = ENV["ACTIVE_RECORD_VERSION"] || "default"

ar = case ar_version
when "master"
  { github: "rails/rails" }
when "default"
  ">= 6.0"
else
  "~> #{ar_version}"
end

gem "activerecord", ar

group :development, :test do
  gem "appraisal", "2.5.0"
end