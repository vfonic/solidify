module Spree
  RSpec.describe LineItemDrop do
    subject { render_liquid(template, assigns, strict) }

    let(:product) do
      build(:product,
            id: 9000,
            description: 'Always take your towel!',
            handle: 'a-towel')
    end
    let(:variant) do
      create(:variant,
             id: 48,
             images: [build(:image)],
             price: 2.49,
             sku: 'variant sku',
             option_values: [
               build(:option_value, presentation: 'Titanium'),
               build(:option_value, presentation: 'Green')
             ],
             product: product)
    end
    let(:line_item) do
      build(:line_item, id: 1337, quantity: 7, variant: variant)
    end

    let(:assigns) { { 'line_item' => line_item } }
    let(:strict) { true }

    it_behaves_like 'drop for nil', 'line_item', LineItemFields::METHODS

    describe 'json' do
      let(:template) { '{{ line_item | json }}' }

      it 'renders correct json attributes' do
        result_map = JSON.parse(subject)
        result_map.transform_values!(&:to_s)

        expect(result_map['id']).to eq('1337')
        expect(result_map['handle']).to eq('a-towel')
        expect(result_map['image'])
          .to eq(variant.dropify.featured_image.as_json.to_s)
        expect(result_map['key']).to eq('1337')
        expect(result_map['line_price']).to eq((249 * 7).to_s)
        expect(result_map['original_line_price']).to eq((249 * 7).to_s)
        expect(result_map['original_price']).to eq('249')
        expect(result_map['price']).to eq('249')
        expect(result_map['product_description'])
          .to eq('Always take your towel!')
        expect(result_map['product_id']).to eq('9000')
        expect(result_map['product_title'])
          .to eq('Always take your towel!')
        expect(result_map['quantity']).to eq('7')
        expect(result_map['sku']).to eq('variant sku')
        expect(result_map['title'])
          .to eq(product.dropify.title + ' - ' + variant.dropify.title)
        expect(result_map['url']).to eq(variant.dropify.url)
        expect(result_map['variant_id']).to eq('48')
        expect(result_map['variant_options']).to eq(%w(Titanium Green).to_s)
        expect(result_map['variant_title'])
          .to eq(variant.dropify.title)
      end

      it 'Not MVP: discounted_price'
      it 'Not MVP: product_type'

      it 'renders all json attributes' do
        result_map = JSON.parse(subject)

        expect(result_map.keys).to eq(LineItemFields::JSON)
      end

      it 'does not render any additional attributes' do
        result_map = JSON.parse(subject)

        expect(result_map.keys - LineItemFields::JSON).to be_empty
      end
    end

    describe 'methods' do
      it_behaves_like('drop', 'id') { let(:expected) { '1337' } }

      it 'Not MVP: discounts'
      it 'Not MVP: fulfillment'
      it 'Not MVP: fulfillment_service'
      it 'Not MVP: gift_card'
      it 'Not MVP: grams'

      it_behaves_like('drop', 'handle') { let(:expected) { 'a-towel' } }
      it_behaves_like('drop', 'image') { let(:expected) { 'ImageDrop' } }
      it_behaves_like('drop', 'key') { let(:expected) { '1337' } }
      it_behaves_like('drop', 'line_price') do
        let(:expected) { (249 * 7).to_s }
      end

      it 'Not MVP: message'

      it_behaves_like('drop', 'original_line_price') do
        let(:expected) { (249 * 7).to_s }
      end
      it_behaves_like('drop', 'original_price') do
        let(:expected) { '249' }
      end
      it_behaves_like('drop', 'price') { let(:expected) { '249' } }
      it_behaves_like('drop', 'product') { let(:expected) { 'ProductDrop' } }
      it_behaves_like('drop', 'product_id') { let(:expected) { '9000' } }

      it 'Not MVP: properties'

      it_behaves_like('drop', 'quantity') { let(:expected) { '7' } }

      it 'Not MVP: requires_shipping'

      it_behaves_like('drop', 'sku') { let(:expected) { 'variant sku' } }

      it 'Not MVP: successfully_fulfilled_quantity'

      it_behaves_like('drop', 'title') do
        let(:expected) { product.dropify.title + ' - ' + variant.dropify.title }
      end

      it 'Not MVP: taxable'
      it 'Not MVP: total_discount'
      it 'Not MVP: type'

      it_behaves_like('drop', 'url') { let(:expected) { variant.dropify.url } }

      it 'Not MVP: vendor'

      it_behaves_like('drop', 'variant') { let(:expected) { 'VariantDrop' } }
      it_behaves_like('drop', 'variant_id') { let(:expected) { '48' } }
    end
  end
end
