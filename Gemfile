# frozen_string_literal: true

#### IMPORTANT #######################################################
# Gemfile is for local development ONLY; Gemfile is NOT loaded in CI #
####################################################### IMPORTANT ####

source "https://rubygems.org"

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

gemspec

platform :mri do
  # Debugging
  gem "byebug", ">= 11"
end

# Std Lib Extractions
gem "benchmark", "~> 0.4"
gem "logger", "~> 1.6", ">= 1.6.5"
