# frozen_string_literal: true

require_relative "lib/peasy_document/version"

Gem::Specification.new do |s|
  s.name        = "peasy-document"
  s.version     = PeasyDocument::VERSION
  s.summary     = "Document conversion — Markdown, HTML, CSV, JSON, YAML"
  s.description = "Document conversion library for Ruby — convert between Markdown, HTML, CSV, JSON, and YAML formats. Uses Ruby stdlib (csv, json, yaml), zero external dependencies."
  s.authors     = ["PeasyTools"]
  s.email       = ["hello@peasytools.com"]
  s.homepage    = "https://peasytools.com"
  s.license     = "MIT"
  s.required_ruby_version = ">= 3.0"

  s.files = Dir["lib/**/*.rb"]

  s.metadata = {
    "homepage_uri"      => "https://peasytools.com",
    "source_code_uri"   => "https://github.com/peasytools/peasy-document-rb",
    "changelog_uri"     => "https://github.com/peasytools/peasy-document-rb/blob/main/CHANGELOG.md",
    "documentation_uri" => "https://peasytools.com",
    "bug_tracker_uri"   => "https://github.com/peasytools/peasy-document-rb/issues",
  }
end
