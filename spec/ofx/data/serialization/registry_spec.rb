require "ofx/data/serialization/registry"

module OFX::Data::Serialization
  RSpec.describe Registry do
    it "can return the serialization class for a registered data class" do
      s_class = Class.new
      d_class = Class.new {
        def ofx_type
          :example
        end
      }

      subject.register(s_class, :example)

      expect(subject.serializer_for(d_class.new)).to be(s_class)
    end
  end
end
