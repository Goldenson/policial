require 'sinatra'
require 'policial'
require 'octokit'
require 'dotenv'
require 'pry'

Dotenv.load

post '/policial' do
  # Payload empty sent by github --> Why ?????
  binding.pry
  octokit = Octokit::Client.new(access_token: ENV['GITHUB_TOKEN'])
  detective = Policial::Detective.new(octokit)
  event = Policial::PullRequestEvent.new(webhook_payload)
  detective.brief(event)
  # Let's investigate this pull request...
  detective.investigate
  # Want to know the violations found?
  detective.violations
  violations = detective.violations
  # => [#<Policial::Violation:0x007ff0b5abad30 @filename="lib/test.rb", @line_number=1, ...>]
  violations.first.message
  # "Prefer single-quoted strings when you don't need string interpolation or special symbols."
end
