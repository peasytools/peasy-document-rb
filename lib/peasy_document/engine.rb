# frozen_string_literal: true

require "json"
require "csv"
require "yaml"

module PeasyDocument
  module_function

  def markdown_to_html(markdown)
    html = markdown.dup
    # Headers
    html.gsub!(/^### (.+)$/, "<h3>\\1</h3>")
    html.gsub!(/^## (.+)$/, "<h2>\\1</h2>")
    html.gsub!(/^# (.+)$/, "<h1>\\1</h1>")
    # Bold & italic
    html.gsub!(/\*\*(.+?)\*\*/, "<strong>\\1</strong>")
    html.gsub!(/\*(.+?)\*/, "<em>\\1</em>")
    # Code
    html.gsub!(/`(.+?)`/, "<code>\\1</code>")
    # Links
    html.gsub!(/\[(.+?)\]\((.+?)\)/, '<a href="\\2">\\1</a>')
    # Line breaks → paragraphs
    html.gsub!(/\n\n/, "</p>\n<p>")
    "<p>#{html}</p>"
  end

  def csv_to_json(csv_string)
    rows = CSV.parse(csv_string, headers: true)
    rows.map(&:to_h).to_json
  end

  def json_to_csv(json_string)
    data = JSON.parse(json_string)
    return "" if data.empty?
    CSV.generate do |csv|
      csv << data.first.keys
      data.each { |row| csv << row.values }
    end
  end

  def json_to_yaml(json_string)
    data = JSON.parse(json_string)
    data.to_yaml
  end

  def yaml_to_json(yaml_string)
    data = YAML.safe_load(yaml_string, permitted_classes: [Date, Time])
    JSON.pretty_generate(data)
  end

  def json_format(json_string)
    JSON.pretty_generate(JSON.parse(json_string))
  end

  def json_minify(json_string)
    JSON.generate(JSON.parse(json_string))
  end
end
