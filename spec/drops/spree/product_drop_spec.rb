module Spree
  RSpec.describe ProductDrop do
    subject { render_liquid(template, assigns, strict) }

    let(:assigns) { { 'product' => product } }
    let(:strict) { true }

    let(:created_at) { 1.hour.ago }

    let(:option_type_material) do
      build(:option_type, presentation: 'Material')
    end
    let(:option_type_eyes_color) do
      build(:option_type, presentation: 'Eyes color')
    end
    let(:image1) { build(:image) }
    let(:image2) { build(:image) }
    let(:image3) { build(:image) }
    let(:variant) do
      build(:variant,
            images: [build(:image)],
            option_values: [
              build(:option_value,
                    option_type: option_type_material,
                    presentation: 'Titanium'),
              build(:option_value,
                    option_type: option_type_eyes_color,
                    presentation: 'Green')
            ])
    end
    let(:master) do
      build(:variant,
            is_master: true,
            images: [image1, image2, image3],
            price: 69.96)
    end
    let(:product) do
      build(:product,
            id: 42,
            created_at: created_at,
            description: 'Once upon a time...',
            handle: 'bar',
            title: 'A book',
            option_types: [option_type_material, option_type_eyes_color],
            master: master,
            variants: [variant],
            variants_including_master: [master, variant])
    end

    it_behaves_like 'drop for nil', 'product', ProductFields::METHODS

    describe 'json' do
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
          .to eq(product.dropify.featured_image.as_json.to_s)
        expect(result_map['handle']).to eq('bar')
        expect(result_map['images'])
          .to eq([image1, image2, image3].map(&:as_json).to_s)
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
        expect(result_map['variants'])
          .to eq([variant.dropify.as_json].to_s)
        expect(result_map['vendor']).to eq('')
      end
      it 'Not MVP: published_at'

      it 'renders all json attributes' do
        result_map = JSON.parse(subject)

        expect(result_map.keys).to eq(ProductFields::JSON)
      end
    end

    describe 'methods' do
      it_behaves_like('drop', 'id') { let(:expected) { '42' } }

      # describe 'available' do
      #   context 'has no variants' do
      #     context 'master variant is available' do
      #       it 'is available'
      #     end
      #     context 'master variant is not available' do
      #       it 'is not available'
      #     end
      #   end
      #   context 'has variants' do
      #     context 'no variant is available' do
      #       it 'is not available'
      #     end
      #     context 'one variant is available' do
      #       it 'is available'
      #     end
      #     context 'master variant has no effect'
      #   end
      # end
      it 'Not MVP: available'
      it 'Not MVP: collections'

      it_behaves_like('drop', 'content') do
        let(:expected) { 'Once upon a time...' }
      end
      it_behaves_like('drop', 'description') do
        let(:expected) { 'Once upon a time...' }
      end

      it 'Not MVP: compare_at_price_max'
      it 'Not MVP: compare_at_price_min'
      it 'Not MVP: compare_at_price_varies'

      it_behaves_like('drop', 'featured_image') do
        let(:expected) { 'ImageDrop' }
      end
      it_behaves_like('drop', 'first_available_variant') do
        let(:expected) { 'VariantDrop' }
      end
      it_behaves_like('drop', 'handle') { let(:expected) { 'bar' } }
      it_behaves_like('drop', 'images') do
        let(:expected) { 'ImageDrop' * 3 }
      end
      it_behaves_like('drop', 'options') do
        let(:expected) { 'Material' + 'Eyes color' }
      end

      it 'Not MVP: options_with_values'

      it_behaves_like('drop', 'price') { let(:expected) { '6996' } }

      it 'Not MVP: price_max'
      it 'Not MVP: price_min'
      it 'Not MVP: price_varies'

      describe '#selected_variant' do
        context 'variant selected' do
          before(:each) do
            product.selected_variant = variant
          end

          it_behaves_like('drop', 'selected_variant') do
            let(:expected) { 'VariantDrop' }
          end
        end

        context 'no variant selected' do
          it_behaves_like('drop', 'selected_variant') do
            let(:expected) { '' }
          end
        end
      end

      describe '#selected_or_first_available_variant' do
        context 'variant selected' do
          before(:each) do
            product.selected_variant = variant
          end

          it_behaves_like('drop', 'selected_or_first_available_variant') do
            let(:expected) { 'VariantDrop' }
          end
        end

        context 'no variant selected' do
          it_behaves_like('drop', 'selected_or_first_available_variant') do
            # selects first available variant
            let(:expected) { 'VariantDrop' }
          end
        end

        context 'no available variants' do
          before(:each) do
            product.variants = []
          end

          it_behaves_like('drop', 'selected_or_first_available_variant') do
            # selects master
            let(:expected) { 'VariantDrop' }
          end
        end
      end

      it 'Not MVP: tags'
      it 'Not MVP: template_suffix'

      it_behaves_like('drop', 'title') { let(:expected) { 'A book' } }

      it 'Not MVP: type'

      it_behaves_like('drop', 'url') do
        let(:product) { create(:product) }
        let(:expected) { "/products/#{product.handle}" }
      end

      it 'Not MVP: vendor'

      it_behaves_like('drop', 'variants') { let(:expected) { 'VariantDrop' } }
    end
  end
end
