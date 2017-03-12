module SolidusLiquid
  RSpec.describe HtmlFilters, type: :helper do
    subject { render_liquid(template, assigns, strict) }

    let(:assigns) { { 'url' => 'https://example.com' } }
    let(:strict) { true }

    describe '#img_tag' do
      let(:expected) { '<img src="https://example.com" alt="" />' }
      it_behaves_like 'filter', 'url', 'img_tag'

      context 'with alt' do
        let(:expected) { '<img src="https://example.com" alt="ALT" />' }
        it_behaves_like 'filter', 'url', 'img_tag', '"ALT"'
      end
    end

    describe '#script_tag' do
      let(:expected) do
        '<script src="https://example.com" type="text/javascript"></script>'
      end
      it_behaves_like 'filter', 'url', 'script_tag'
    end

    describe '#stylesheet_tag' do
      let(:expected) do
        %w(<link href="https://example.com" rel="stylesheet"
           type="text/css" media="all" />).join(' ')
      end
      it_behaves_like 'filter', 'url', 'stylesheet_tag'
    end
  end
end
