module Spree
  RSpec.describe ImageDrop do
    let(:image_attributes) do
      {
        id: 3,
        alt: 'Vogon Ship',
        position: 2
      }
    end

    let(:assigns) { { 'image' => image } }
    let(:strict) { true }

    subject { render_liquid(template, assigns, strict) }

    it_behaves_like 'drop for nil', 'image', ImageFields::METHODS

    describe 'json' do
      let(:image) { build(:image, image_attributes) }
      let(:template) { '{{ image | json }}' }

      it 'renders src as json' do
        expect(subject).to eq(image.attachment.url.to_json)
      end
    end

    describe 'methods' do
      let(:image) { build(:image, image_attributes) }

      it_behaves_like('drop', 'id') { let(:expected) { '3' } }
      it_behaves_like('drop', 'alt') { let(:expected) { 'Vogon Ship' } }
      it_behaves_like('drop', 'product_id') do
        let(:product) { create(:product) }

        before(:each) do
          image.viewable = build(:variant, product: product)
        end

        let(:expected) { product.id.to_s }
      end
      it_behaves_like('drop', 'position') { let(:expected) { '2' } }
      it_behaves_like('drop', 'src') { let(:expected) { image.attachment.url } }

      describe 'variants' do
        context 'without variants' do
          it_behaves_like('drop', 'attached_to_variant?') do
            let(:expected) { 'false' }
          end
          it_behaves_like('drop', 'variants') { let(:expected) { '' } }
        end

        context 'with one variant' do
          before(:each) do
            image.viewable = build(:variant)
          end

          it_behaves_like 'drop', 'attached_to_variant?' do
            let(:expected) { 'true' }
          end

          it_behaves_like('drop', 'variants') do
            let(:expected) { 'VariantDrop' }
          end
        end
      end
    end
  end
end
