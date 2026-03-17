# frozen_string_literal: true

# Demo script for peasy-document-rb — Document tools client for peasydocument.com
# Run: ruby -I lib examples/demo.rb

require "peasy_document"

client = PeasyDocument::Client.new

# List available document tools
puts "=== Document Tools ==="
tools = client.list_tools(limit: 5)
tools["results"].each do |tool|
  puts "  #{tool["name"]}: #{tool["description"]}"
end
puts "  Total: #{tools["count"]} tools"

# Get a specific tool by slug
puts "\n=== Markdown to HTML Tool ==="
tool = client.get_tool("markdown-to-html")
puts "  Name: #{tool["name"]}"
puts "  Description: #{tool["description"]}"

# List tool categories
puts "\n=== Categories ==="
categories = client.list_categories
categories["results"].each do |cat|
  puts "  #{cat["name"]}"
end

# Search across all content
puts "\n=== Search: 'json' ==="
results = client.search("json")
results["results"].each do |section, items|
  puts "  #{section}: #{items.length} results" if items.is_a?(Array) && !items.empty?
end

# List glossary terms
puts "\n=== Glossary (first 3) ==="
glossary = client.list_glossary(limit: 3)
glossary["results"].each do |term|
  puts "  #{term["term"]}: #{term["definition"]&.slice(0, 80)}..."
end

# List guides
puts "\n=== Guides (first 3) ==="
guides = client.list_guides(limit: 3)
guides["results"].each do |guide|
  puts "  #{guide["title"]}"
end

puts "\nDone! Visit https://peasydocument.com for more."
