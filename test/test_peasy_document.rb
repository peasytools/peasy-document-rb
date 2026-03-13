# frozen_string_literal: true

require "minitest/autorun"
require "peasy_document"

class TestPeasyDocument < Minitest::Test
  def test_version
    refute_nil PeasyDocument::VERSION
    assert_equal "0.1.1", PeasyDocument::VERSION
  end
end
