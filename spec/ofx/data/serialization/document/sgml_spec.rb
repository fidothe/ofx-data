require "ofx/data/serialization/shared_examples"
require "ofx/data/serialization/document"
require "ofx/data/document"
require "ofx/data/message_sets"
require "builder"

module OFX::Data::Serialization::Document
  RSpec.describe SGML do
    it_should_behave_like "a basic serializer", [:document, nil], :document, nil

    context "serialization", :serializer do
      let(:message_sets) { OFX::Data::MessageSets.new([]) }
      let(:declaration) { OFX::Data::Declaration[:"1.0.2"] }
      let(:document) { OFX::Data::Document.new(declaration: declaration, message_sets: message_sets) }
      let(:builder) { Builder::XmlMarkup.new }

      subject { SGML.new(test_registry) }

      it "generates the correct OFX header" do
        output = subject.serialize(document, builder)

        expected_headers = %w{
          OFXHEADER:100
          DATA:OFXSGML
          VERSION:102
          SECURITY:NONE
          ENCODING:UTF-8
          CHARSET:NONE
          COMPRESSION:NONE
          OLDFILEUID:NONE
          NEWFILEUID:NONE
        }.join("\r\n")

        expect(output).to start_with(expected_headers)
      end

      context "encodings and charsets" do
        def declaration(encoding)
          OFX::Data::Declaration.new(ofxheader: "100", version: "102", encoding: encoding)
        end

        it "generates expected encoding and charset headers for a windows-1252 encoding" do
          document = OFX::Data::Document.new({
            declaration: declaration("Windows-1252"), message_sets: message_sets
          })

          output = subject.serialize(document, builder)

          expected_headers = %w{
          OFXHEADER:100
          DATA:OFXSGML
          VERSION:102
          SECURITY:NONE
          ENCODING:USASCII
          CHARSET:1252
          COMPRESSION:NONE
          OLDFILEUID:NONE
          NEWFILEUID:NONE
          }.join("\r\n")

          expect(output).to start_with(expected_headers)
        end

        it "generates expected encoding and charset headers for an iso-8859-1 encoding" do
          document = OFX::Data::Document.new({
            declaration: declaration("ISO8859-1"), message_sets: message_sets
          })

          output = subject.serialize(document, builder)

          expected_headers = %w{
          OFXHEADER:100
          DATA:OFXSGML
          VERSION:102
          SECURITY:NONE
          ENCODING:USASCII
          CHARSET:ISO-8859-1
          COMPRESSION:NONE
          OLDFILEUID:NONE
          NEWFILEUID:NONE
          }.join("\r\n")

          expect(output).to start_with(expected_headers)
        end
      end

      it "correctly hands its MessageSets on for serialization" do
        expect(subject).to receive(:serialize_object).with(message_sets, builder)

        subject.serialize(document, builder)
      end
    end
  end
end
