if ENV['CODECLIMATE_REPO_TOKEN'].nil?
  require 'simplecov'
  SimpleCov.start do
    coverage_dir 'tmp/coverage'
  end
else
  require "codeclimate-test-reporter"
  CodeClimate::TestReporter.start
end

require 'ice_cube'
require 'ice_cube_ex'