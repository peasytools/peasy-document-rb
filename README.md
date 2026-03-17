# peasy-document

[![Gem Version](https://badge.fury.io/rb/peasy-document.svg)](https://rubygems.org/gems/peasy-document)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)

Ruby client for the [PeasyFormats](https://peasyformats.com) API -- convert between Markdown, JSON, YAML, CSV, and other document formats with tools for format identification, MIME type lookup, and structured data transformation. Zero dependencies beyond Ruby stdlib (Net::HTTP, JSON, URI).

Built from [PeasyFormats](https://peasyformats.com), a comprehensive document conversion toolkit offering free online tools for transforming between structured data formats. The glossary covers document formats from lightweight Markdown to structured JSON and YAML, while guides explain format conversion strategies and encoding best practices.

> **Try the interactive tools at [peasyformats.com](https://peasyformats.com)** -- [Markdown to HTML](https://peasyformats.com/doc/markdown-to-html/), [YAML/JSON Converter](https://peasyformats.com/doc/yaml-json-converter/), [Format Identifier](https://peasyformats.com/doc/format-identifier/), and more.

<p align="center">
  <img src="demo.gif" alt="peasy-document demo -- Markdown, JSON, YAML, and CSV conversion tools in Ruby terminal" width="800">
</p>

## Table of Contents

- [Install](#install)
- [Quick Start](#quick-start)
- [What You Can Do](#what-you-can-do)
  - [Document Conversion Tools](#document-conversion-tools)
  - [Browse Document Format Reference](#browse-document-format-reference)
  - [Search and Discovery](#search-and-discovery)
- [API Client](#api-client)
  - [Available Methods](#available-methods)
- [Learn More About Document Formats](#learn-more-about-document-formats)
- [Also Available](#also-available)
- [Peasy Developer Tools](#peasy-developer-tools)
- [License](#license)

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

## What You Can Do

### Document Conversion Tools

Document format conversion is a core workflow for developers, data engineers, and content authors. Converting Markdown to HTML powers static site generators and documentation systems. Transforming JSON to YAML (and vice versa) is essential for configuration management across Kubernetes, Docker Compose, and CI/CD pipelines. CSV-to-JSON conversion bridges the gap between spreadsheet data and web APIs.

| Tool | Description | Use Case |
|------|-------------|----------|
| Markdown to HTML | Convert Markdown syntax to semantic HTML | Static sites, documentation pipelines |
| YAML/JSON Converter | Bidirectional YAML and JSON transformation | Kubernetes configs, API payloads |
| Format Identifier | Detect file format from content or extension | File upload validation, data pipelines |

```ruby
require "peasy_document"

client = PeasyDocument::Client.new

# Fetch the Markdown to HTML conversion tool
tool = client.get_tool("markdown-to-html")
puts "Tool: #{tool["name"]}"           # Markdown to HTML converter
puts "Category: #{tool["category"]}"   # Document conversion category

# List supported document formats and their MIME types
formats = client.list_formats
formats["results"].each do |fmt|
  puts "#{fmt["name"]} (#{fmt["extension"]}): #{fmt["mime_type"]}"
end
```

Learn more: [Markdown to HTML Tool](https://peasyformats.com/doc/markdown-to-html/) · [YAML/JSON Converter](https://peasyformats.com/doc/yaml-json-converter/) · [File Format Conversion Guide](https://peasyformats.com/guides/file-format-conversion-guide/)

### Browse Document Format Reference

The document format glossary provides clear definitions for structured data formats, markup languages, and serialization standards. Understanding the differences between JSON and YAML syntax, when CSV is preferable to JSON for tabular data, and how Markdown flavors (CommonMark, GFM) differ helps developers choose the right format for each use case.

| Glossary Term | Description |
|---------------|-------------|
| Markdown | Lightweight markup language for creating formatted text with plain-text syntax |
| CSV | Comma-separated values format for tabular data interchange |
| JSON | JavaScript Object Notation for structured data serialization |
| YAML | Human-readable data serialization format used in configuration files |

```ruby
# Browse document format glossary terms programmatically
glossary = client.list_glossary(search: "csv")
glossary["results"].each do |term|
  puts "#{term["term"]}: #{term["definition"]}" # Document format definition
end

# Read in-depth guides on format conversion strategies
guides = client.list_guides(category: "document")
guides["results"].each do |guide|
  puts "#{guide["title"]} (#{guide["audience_level"]})" # Guide title and difficulty
end
```

Learn more: [Markdown Glossary](https://peasyformats.com/glossary/markdown/) · [JSON Glossary](https://peasyformats.com/glossary/json/) · [How to Convert Markdown to Other Formats](https://peasyformats.com/guides/how-to-convert-markdown-to-other-formats/)

### Search and Discovery

The unified search endpoint queries across all document tools, glossary terms, guides, and supported file formats simultaneously. This is useful for building scripts, documentation search, or automation that needs to discover conversion capabilities.

```ruby
# Search across all document tools, glossary, and guides
results = client.search("markdown")
puts "Found #{results["results"]["tools"].length} tools"
puts "Found #{results["results"]["glossary"].length} glossary terms"
```

Learn more: [CSV Glossary](https://peasyformats.com/glossary/csv/) · [YAML Glossary](https://peasyformats.com/glossary/yaml/) · [All Document Guides](https://peasyformats.com/guides/)

## API Client

The client wraps the [PeasyFormats REST API](https://peasyformats.com/developers/) using only Ruby standard library -- no external dependencies.

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

## Learn More About Document Formats

- **Tools**: [Markdown to HTML](https://peasyformats.com/doc/markdown-to-html/) · [YAML/JSON Converter](https://peasyformats.com/doc/yaml-json-converter/) · [Format Identifier](https://peasyformats.com/doc/format-identifier/) · [All Tools](https://peasyformats.com/)
- **Guides**: [File Format Conversion Guide](https://peasyformats.com/guides/file-format-conversion-guide/) · [How to Convert Markdown to Other Formats](https://peasyformats.com/guides/how-to-convert-markdown-to-other-formats/) · [All Guides](https://peasyformats.com/guides/)
- **Glossary**: [Markdown](https://peasyformats.com/glossary/markdown/) · [CSV](https://peasyformats.com/glossary/csv/) · [JSON](https://peasyformats.com/glossary/json/) · [YAML](https://peasyformats.com/glossary/yaml/) · [All Terms](https://peasyformats.com/glossary/)
- **Formats**: [All Formats](https://peasyformats.com/formats/)
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
| peasy-pdf | [PyPI](https://pypi.org/project/peasy-pdf/) | [npm](https://www.npmjs.com/package/peasy-pdf) | [Gem](https://rubygems.org/gems/peasy-pdf) | PDF merge, split, rotate, compress -- [peasypdf.com](https://peasypdf.com) |
| peasy-image | [PyPI](https://pypi.org/project/peasy-image/) | [npm](https://www.npmjs.com/package/peasy-image) | [Gem](https://rubygems.org/gems/peasy-image) | Image resize, crop, convert, compress -- [peasyimage.com](https://peasyimage.com) |
| peasy-audio | [PyPI](https://pypi.org/project/peasy-audio/) | [npm](https://www.npmjs.com/package/peasy-audio) | [Gem](https://rubygems.org/gems/peasy-audio) | Audio trim, merge, convert, normalize -- [peasyaudio.com](https://peasyaudio.com) |
| peasy-video | [PyPI](https://pypi.org/project/peasy-video/) | [npm](https://www.npmjs.com/package/peasy-video) | [Gem](https://rubygems.org/gems/peasy-video) | Video trim, resize, thumbnails, GIF -- [peasyvideo.com](https://peasyvideo.com) |
| peasy-css | [PyPI](https://pypi.org/project/peasy-css/) | [npm](https://www.npmjs.com/package/peasy-css) | [Gem](https://rubygems.org/gems/peasy-css) | CSS minify, format, analyze -- [peasycss.com](https://peasycss.com) |
| peasy-compress | [PyPI](https://pypi.org/project/peasy-compress/) | [npm](https://www.npmjs.com/package/peasy-compress) | [Gem](https://rubygems.org/gems/peasy-compress) | ZIP, TAR, gzip compression -- [peasytools.com](https://peasytools.com) |
| **peasy-document** | [PyPI](https://pypi.org/project/peasy-document/) | [npm](https://www.npmjs.com/package/peasy-document) | [Gem](https://rubygems.org/gems/peasy-document) | **Markdown, HTML, CSV, JSON conversion -- [peasyformats.com](https://peasyformats.com)** |
| peasytext | [PyPI](https://pypi.org/project/peasytext/) | [npm](https://www.npmjs.com/package/peasytext) | [Gem](https://rubygems.org/gems/peasytext) | Text case conversion, slugify, word count -- [peasytext.com](https://peasytext.com) |

## License

MIT
