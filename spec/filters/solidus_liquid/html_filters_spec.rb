module SolidusLiquid
  RSpec.describe HtmlFilters, type: :helper do
    subject { render_liquid(template, assigns, strict) }

    let(:assigns) { { 'url' => 'https://example.com' } }
    let(:strict) { true }

    describe '#img_tag' do
      it 'renders img tag' do
        expect(helper.img_tag('https://example.com'))
          .to eq('<img src="https://example.com" alt="" />')
      end

      context 'with alt' do
        it 'renders img tag' do
          expect(helper.img_tag('https://example.com', 'ALT'))
            .to eq('<img src="https://example.com" alt="ALT" />')
        end
      end
    end

    describe '#script_tag' do
      it 'renders script tag' do
        expect(helper.script_tag('https://example.com'))
          .to eq(
            '<script src="https://example.com" type="text/javascript"></script>'
          )
      end
    end

    describe '#stylesheet_tag' do
      it 'renders stylesheet tag' do
        expect(helper.stylesheet_tag('https://example.com'))
          .to eq(%w(<link href="https://example.com" rel="stylesheet"
                    type="text/css" media="all" />).join(' '))
      end

      context 'with media' do
        it 'render stylesheet tag' do
          expect(helper.stylesheet_tag('https://example.com', 'MEDIA'))
            .to eq(%w(<link href="https://example.com" rel="stylesheet"
                      type="text/css" media="MEDIA" />).join(' '))
        end
      end
    end
  end
end
