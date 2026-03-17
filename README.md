# peasy-document

[![Gem Version](https://badge.fury.io/rb/peasy-document.svg)](https://rubygems.org/gems/peasy-document)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)

Ruby client for the [PeasyFormats](https://peasyformats.com) API — convert between Markdown, HTML, CSV, JSON, and YAML document formats. Zero dependencies beyond Ruby stdlib (Net::HTTP, JSON, URI).

Built from [PeasyFormats](https://peasyformats.com), a free online document conversion toolkit with tools for transforming between structured data formats — Markdown to HTML, CSV to JSON, YAML to JSON, and more.

> **Try the interactive tools at [peasyformats.com](https://peasyformats.com)** — [Document Tools](https://peasyformats.com/), [Document Glossary](https://peasyformats.com/glossary/), [Document Guides](https://peasyformats.com/guides/)

## Install

```bash
gem install peasy-document
```

Or add to your Gemfile:

```ruby
gem "peasy-document"
```

## Quick Start

```ruby
require "peasy_document"

client = PeasyDocument::Client.new

# List available document tools
tools = client.list_tools
tools["results"].each do |tool|
  puts "#{tool["name"]}: #{tool["description"]}"
end
```

## API Client

The client wraps the [PeasyFormats REST API](https://peasyformats.com/developers/) using only Ruby standard library — no external dependencies.

```ruby
require "peasy_document"

client = PeasyDocument::Client.new
# Or with a custom base URL:
# client = PeasyDocument::Client.new(base_url: "https://custom.example.com")

# List tools with pagination and filters
tools = client.list_tools(page: 1, limit: 10, search: "markdown")

# Get a specific tool by slug
tool = client.get_tool("markdown-to-html")
puts "#{tool["name"]}: #{tool["description"]}"

# Search across all content
results = client.search("markdown")
puts "Found #{results["results"]["tools"].length} tools"

# Browse the glossary
glossary = client.list_glossary(search: "csv")
glossary["results"].each do |term|
  puts "#{term["term"]}: #{term["definition"]}"
end

# Discover guides
guides = client.list_guides(category: "document")
guides["results"].each do |guide|
  puts "#{guide["title"]} (#{guide["audience_level"]})"
end

# List file format conversions
conversions = client.list_conversions(source: "json")

# Get format details
format = client.get_format("json")
puts "#{format["name"]} (#{format["extension"]}): #{format["mime_type"]}"
```

### Available Methods

| Method | Description |
|--------|-------------|
| `list_tools` | List tools (paginated, filterable) |
| `get_tool(slug)` | Get tool by slug |
| `list_categories` | List tool categories |
| `list_formats` | List file formats |
| `get_format(slug)` | Get format by slug |
| `list_conversions` | List format conversions |
| `list_glossary` | List glossary terms |
| `get_glossary_term(slug)` | Get glossary term |
| `list_guides` | List guides |
| `get_guide(slug)` | Get guide by slug |
| `list_use_cases` | List use cases |
| `search(query)` | Search across all content |
| `list_sites` | List Peasy sites |
| `openapi_spec` | Get OpenAPI specification |

All list methods accept keyword arguments: `page:`, `limit:`, `category:`, `search:`.

Full API documentation at [peasyformats.com/developers/](https://peasyformats.com/developers/).
OpenAPI 3.1.0 spec: [peasyformats.com/api/openapi.json](https://peasyformats.com/api/openapi.json).

## Learn More

- **Tools**: [Markdown to HTML](https://peasyformats.com/tools/markdown-to-html/) · [CSV to JSON](https://peasyformats.com/tools/csv-to-json/) · [All Tools](https://peasyformats.com/)
- **Guides**: [How to Convert Markdown](https://peasyformats.com/guides/how-to-convert-markdown/) · [All Guides](https://peasyformats.com/guides/)
- **Glossary**: [What is CSV?](https://peasyformats.com/glossary/csv/) · [All Terms](https://peasyformats.com/glossary/)
- **Formats**: [JSON](https://peasyformats.com/formats/json/) · [All Formats](https://peasyformats.com/formats/)
- **API**: [REST API Docs](https://peasyformats.com/developers/) · [OpenAPI Spec](https://peasyformats.com/api/openapi.json)

## Also Available

| Language | Package | Install |
|----------|---------|---------|
| **Python** | [peasy-document](https://pypi.org/project/peasy-document/) | `pip install "peasy-document[all]"` |
| **TypeScript** | [peasy-document](https://www.npmjs.com/package/peasy-document) | `npm install peasy-document` |
| **Go** | [peasy-document-go](https://pkg.go.dev/github.com/peasytools/peasy-document-go) | `go get github.com/peasytools/peasy-document-go` |
| **Rust** | [peasy-document](https://crates.io/crates/peasy-document) | `cargo add peasy-document` |

## Peasy Developer Tools

Part of the [Peasy Tools](https://peasytools.com) open-source developer ecosystem.

| Package | PyPI | npm | RubyGems | Description |
|---------|------|-----|----------|-------------|
| peasy-pdf | [PyPI](https://pypi.org/project/peasy-pdf/) | [npm](https://www.npmjs.com/package/peasy-pdf) | [Gem](https://rubygems.org/gems/peasy-pdf) | PDF merge, split, rotate, compress — [peasypdf.com](https://peasypdf.com) |
| peasy-image | [PyPI](https://pypi.org/project/peasy-image/) | [npm](https://www.npmjs.com/package/peasy-image) | [Gem](https://rubygems.org/gems/peasy-image) | Image resize, crop, convert, compress — [peasyimage.com](https://peasyimage.com) |
| peasy-audio | [PyPI](https://pypi.org/project/peasy-audio/) | [npm](https://www.npmjs.com/package/peasy-audio) | [Gem](https://rubygems.org/gems/peasy-audio) | Audio trim, merge, convert, normalize — [peasyaudio.com](https://peasyaudio.com) |
| peasy-video | [PyPI](https://pypi.org/project/peasy-video/) | [npm](https://www.npmjs.com/package/peasy-video) | [Gem](https://rubygems.org/gems/peasy-video) | Video trim, resize, thumbnails, GIF — [peasyvideo.com](https://peasyvideo.com) |
| peasy-css | [PyPI](https://pypi.org/project/peasy-css/) | [npm](https://www.npmjs.com/package/peasy-css) | [Gem](https://rubygems.org/gems/peasy-css) | CSS minify, format, analyze — [peasycss.com](https://peasycss.com) |
| peasy-compress | [PyPI](https://pypi.org/project/peasy-compress/) | [npm](https://www.npmjs.com/package/peasy-compress) | [Gem](https://rubygems.org/gems/peasy-compress) | ZIP, TAR, gzip compression — [peasytools.com](https://peasytools.com) |
| **peasy-document** | [PyPI](https://pypi.org/project/peasy-document/) | [npm](https://www.npmjs.com/package/peasy-document) | [Gem](https://rubygems.org/gems/peasy-document) | **Markdown, HTML, CSV, JSON conversion — [peasyformats.com](https://peasyformats.com)** |
| peasytext | [PyPI](https://pypi.org/project/peasytext/) | [npm](https://www.npmjs.com/package/peasytext) | [Gem](https://rubygems.org/gems/peasytext) | Text case conversion, slugify, word count — [peasytext.com](https://peasytext.com) |

## License

MIT
