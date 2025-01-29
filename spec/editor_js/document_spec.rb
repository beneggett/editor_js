# frozen_string_literal: true

RSpec.describe EditorJs::Document do
  let(:document_1_json) { File.read(File.expand_path('../data/document_1.json', __dir__)) }
  let(:document_1_html) { File.read(File.expand_path('../data/document_1.html', __dir__)).strip }
  let(:document_1_txt) { File.read(File.expand_path('../data/document_1.txt', __dir__)).strip }
  let(:document_1_output) { JSON.parse(File.read(File.expand_path('../data/document_1.output', __dir__))) }
  let(:document_2_json) { File.read(File.expand_path('../data/document_2.json', __dir__)) }
  let(:document_3_json) { File.read(File.expand_path('../data/document_3.json', __dir__)) }
  let(:document_with_invalid_block_json) do
    File.read(File.expand_path('../data/document_with_invalid_block.json', __dir__))
  end
  let(:document_with_invalid_block_html) do
    File.read(File.expand_path('../data/document_with_invalid_block.html', __dir__)).strip
  end
  let(:document_with_invalid_block_render_html) do
    File.read(File.expand_path('../data/document_with_invalid_block_render.html', __dir__)).strip
  end

  let(:document_1) { described_class.new(document_1_json) }
  let(:document_2) { described_class.new(document_2_json) }
  let(:document_3) { described_class.new(document_3_json) }

  it('should be valid') { expect(document_1).to be_valid }
  it('should be invalid') { expect(document_2).not_to be_valid }
  it('should be invalid') { expect(document_3).not_to be_valid }

  it('should render html as expectd') { expect(document_1.render).to eq document_1_html }

  it('should render text as expected') { expect(document_1.plain).to eq document_1_txt }
  it { expect(document_1.output).to match(document_1_output) }

  describe 'with invalid block' do
    it('one invalid block without renderer') do
      doc = described_class.new(document_with_invalid_block_json)
      expect(doc.render).to eq document_with_invalid_block_html
    end
    it('one invalid block with renderer') do
      render = Class.new do
        def initialize(raw)
          @raw = raw
        end

        def valid?
          false
        end

        def render
          '<div>invalid block</div>'
        end

        def plain; end

        def output
          {}
        end
      end
      doc = described_class.new(document_with_invalid_block_json, invalid_block_renderer: render)
      expect(doc.render).to eq document_with_invalid_block_render_html
    end
  end
end
