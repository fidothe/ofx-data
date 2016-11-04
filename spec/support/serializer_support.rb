require "nokogiri"
require "builder"

class CatchAllEntry
  attr_reader :serializer

  def initialize(serializer)
    @serializer = serializer
  end

  def match?(*args)
    true
  end
end

class NullSerializer
  def serialize(object, builder)
    builder.null object.ofx_type.to_s
  end
end

module SerializerHelpers
  def strict_parse(xml)
    opts = Nokogiri::XML::ParseOptions.new.strict.norecover
    Nokogiri.XML(xml, nil, nil, opts)
  end

  def test_registry
    OFX::Data::Serialization::Registry.build { |r|
      yield(r) if block_given?
      r.register(CatchAllEntry.new(NullSerializer.new))
    }
  end

  def empty_registry
    OFX::Data::Serialization::Registry.new
  end
end

RSpec.configure do |c|
  c.include SerializerHelpers, serializer: true
end

