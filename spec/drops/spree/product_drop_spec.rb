module Spree
  RSpec.describe ProductDrop do
    let(:created_at) { 1.hour.ago }
    let(:product_attributes) do
      {
        id: 42,
        created_at: created_at,
        description: 'Once upon a time...',
        handle: 'bar',
        price: 69.96,
        title: 'A book'
      }
    end

    let(:assigns) { { 'product' => product } }
    let(:strict) { true }

    subject { render_liquid(template, assigns, strict) }

    it_behaves_like 'drop for nil', 'product', ProductFields::METHODS

    describe 'json' do
      let(:option_type_material) do
        build(:option_type, presentation: 'Material')
      end
      let(:option_type_eyes_color) do
        build(:option_type, presentation: 'Eyes color')
      end
      let(:product) do
        build(:product,
              product_attributes.merge(
                option_types: [option_type_material, option_type_eyes_color],
                variants: [build(:variant,
                                 images: [build(:image)],
                                 option_values: [
                                   build(:option_value,
                                         option_type: option_type_material,
                                         presentation: 'Titanium'),
                                   build(:option_value,
                                         option_type: option_type_eyes_color,
                                         presentation: 'Green')
                                 ])]
              ))
      end
      let(:template) { '{{ product | json }}' }

      it 'renders correct json attributes' do
        result_map = JSON.parse(subject)
        result_map.transform_values!(&:to_s)

        expect(result_map['id']).to eq('42')
        expect(result_map['available']).to eq('true')
        expect(result_map['compare_at_price']).to eq('')
        expect(result_map['compare_at_price_max']).to eq('0')
        expect(result_map['compare_at_price_min']).to eq('0')
        expect(result_map['compare_at_price_varies']).to eq('false')
        expect(result_map['content']).to eq('Once upon a time...')
        expect(Time.zone.parse(result_map['created_at']).to_s)
          .to eq(created_at.to_s)
        expect(result_map['description']).to eq('Once upon a time...')
        expect(result_map['featured_image'])
          .to eq(Spree::ProductDrop.new(product).featured_image.as_json.to_s)
        expect(result_map['handle']).to eq('bar')
        expect(result_map['images']).to eq('[]')
        expect(result_map['options']).to eq(['Material', 'Eyes color'].to_s)
        expect(result_map['price']).to eq('6996')
        expect(result_map['price_max']).to eq('6996')
        expect(result_map['price_min']).to eq('6996')
        expect(result_map['price_varies']).to eq('false')
        expect(Time.zone.parse(result_map['published_at']).to_s)
          .to eq(created_at.to_s)
        expect(result_map['tags']).to eq('[]')
        expect(result_map['title']).to eq('A book')
        expect(result_map['type']).to eq('')
        expect(result_map['vendor']).to eq('')
      end

      it 'renders all json attributes' do
        result_map = JSON.parse(subject)

        expect(result_map.keys).to eq(ProductFields::JSON)
      end

      it 'does not render any additional attributes' do
        result_map = JSON.parse(subject)

        expect(result_map.keys - ProductFields::JSON).to be_empty
      end
    end

    describe 'methods' do
      let(:product) { build(:product, product_attributes) }

      it_behaves_like('drop', 'id') { let(:expected) { '42' } }

      describe 'available' do
        context 'has no variants' do
          context 'master variant is available' do
            it 'is available'
          end
          context 'master variant is not available' do
            it 'is not available'
          end
        end
        context 'has variants' do
          context 'no variant is available' do
            it 'is not available'
          end
          context 'one variant is available' do
            it 'is available'
          end
          context 'master variant has no effect'
        end
      end

      it_behaves_like('drop', 'content') do
        let(:expected) { 'Once upon a time...' }
      end

      it_behaves_like('drop', 'description') do
        let(:expected) { 'Once upon a time...' }
      end

      it_behaves_like('drop', 'handle') { let(:expected) { product.handle } }

      it_behaves_like('drop', 'options') do
        let(:product) do
          build(:product,
                option_types: [
                  build(:option_type, presentation: 'Material'),
                  build(:option_type, presentation: 'Eyes color')
                ])
        end

        let(:expected) { 'Material' + 'Eyes color' }
      end

      it_behaves_like('drop', 'title') { let(:expected) { 'A book' } }

      it_behaves_like('drop', 'url') do
        let(:product) { create(:product) }
        let(:expected) { "/products/#{product.handle}" }
      end
    end
  end
end
