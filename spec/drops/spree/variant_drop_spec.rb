module Spree
  RSpec.describe VariantDrop do
    subject { render_liquid(template, assigns, strict) }

    let(:variant_attributes) do
      {
        id: 4,
        price: 7.69,
        sku: 'SKU-15'
      }
    end

    let(:variant) do
      build(:variant,
            variant_attributes.merge(
              images: [build(:image)],
              option_values: [
                build(:option_value, presentation: 'Depressed'),
                build(:option_value, presentation: 'Green eyes'),
                build(:option_value, presentation: 'With emotions')
              ],
              product: build(:product, name: 'Marvin Jersey')
            ))
    end
    let(:assigns) { { 'variant' => variant } }
    let(:strict) { true }

    it_behaves_like 'drop for nil', 'variant', VariantFields::METHODS

    describe 'json' do
      let(:template) { '{{ variant | json }}' }

      it 'renders correct json attributes' do
        result_map = JSON.parse(subject)
        result_map.transform_values!(&:to_s)

        expect(result_map['id']).to eq('4')
        expect(result_map['available']).to eq('true')
        expect(result_map['barcode']).to eq('')
        expect(result_map['compare_at_price']).to eq('')
        expect(result_map['featured_image'])
          .to eq(variant.images.first.attachment.url)
        expect(result_map['inventory_management']).to eq('shopify')
        expect(result_map['inventory_policy']).to eq(
          Solidify::InventoryPolicy::INVENTORY_POLICY_DENY
        )
        expect(result_map['inventory_quantity']).to eq('0')
        expect(result_map['name'])
          .to eq('Marvin Jersey - Depressed / Green eyes / With emotions')
        expect(result_map['option1']).to eq('Depressed')
        expect(result_map['option2']).to eq('Green eyes')
        expect(result_map['option3']).to eq('With emotions')
        expect(result_map['options'])
          .to eq(['Depressed', 'Green eyes', 'With emotions'].to_s)
        expect(result_map['price']).to eq('769')
        expect(result_map['public_title'])
          .to eq('Depressed / Green eyes / With emotions')
        expect(result_map['requires_shipping']).to eq('true')
        expect(result_map['sku']).to eq('SKU-15')
        expect(result_map['taxable']).to eq('true')
        expect(result_map['title'])
          .to eq('Depressed / Green eyes / With emotions')
        expect(result_map['weight']).to eq('0')
      end

      it 'Implemented partially: available'
      it 'Not MVP: taxable'
      it 'Not MVP: weight'

      it 'renders all json attributes' do
        result_map = JSON.parse(subject)

        expect(result_map.keys).to eq(VariantFields::JSON)
      end
    end

    describe 'methods' do
      it_behaves_like('drop', 'id') { let(:expected) { '4' } }
      describe 'available' do
        # variant.inventory_quantity > 0
        # or variant.inventory_policy == 'continue'
        # or variant.inventory_management == nil
        context 'inventory_management is nil' do
          context 'inventory_quantity > 0' do
            context 'inventory_policy == "continue"' do
              it 'is available'
            end
            context 'inventory_policy == "deny"' do
              it 'is available'
            end
          end
          context 'inventory_quantity = 0' do
            context 'inventory_policy == "continue"' do
              it 'is available'
            end
            context 'inventory_policy == "deny"' do
              it 'is available'
            end
          end
        end
        context 'inventory_management is set' do
          context 'inventory_quantity > 0' do
            context 'inventory_policy == "continue"' do
              it 'is available'
            end
            context 'inventory_policy == "deny"' do
              it 'is available'
            end
          end
          context 'inventory_quantity = 0' do
            context 'inventory_policy == "continue"' do
              it 'is available'
            end
            context 'inventory_policy == "deny"' do
              it 'is not available'
            end
          end
        end
      end

      it_behaves_like('drop', 'barcode') { let(:expected) { '' } }
      it 'Not MVP: barcode'
      it 'Not MVP: compare_at_price'
      it_behaves_like('drop', 'image') do
        before(:each) do
          variant.images << build(:image)
        end

        let(:expected) { 'ImageDrop' }
      end
      it_behaves_like('drop', 'incoming') { let(:expected) { 'false' } }
      it 'Not MVP: incoming'
      it_behaves_like('drop', 'inventory_management') do
        let(:expected) { 'shopify' }
      end
      it_behaves_like('drop', 'inventory_policy') do
        let(:expected) { 'deny' }
      end
      xit 'behaves like drop for inventory_quantity' do
        it_behaves_like('drop', 'inventory_quantity') do
          before(:each) do
            stock_item = build(:stock_item)
            stock_item.set_count_on_hand(505)
            variant.stock_items << stock_item
            variant.save
          end

          let(:expected) { '505' }
        end
      end
      it 'Not MVP: inventory_management'
      it 'Not MVP: inventory_policy'
      it 'Not MVP: inventory_quantity'
      it_behaves_like('drop', 'next_incoming_date') { let(:expected) { '' } }
      it 'Not MVP: next_incoming_date'
      it_behaves_like('drop', 'option1') { let(:expected) { 'Depressed' } }
      it_behaves_like('drop', 'option2') { let(:expected) { 'Green eyes' } }
      it_behaves_like('drop', 'option3') { let(:expected) { 'With emotions' } }
      it_behaves_like('drop', 'price') { let(:expected) { '769' } }
      it_behaves_like('drop', 'requires_shipping') { let(:expected) { 'true' } }

      it 'Not MVP: requires_shipping'

      describe '#selected' do
        context 'when selected' do
          before(:each) do
            variant.product.selected_variant = variant
          end

          it_behaves_like('drop', 'selected') { let(:expected) { 'true' } }
        end

        context 'not selected' do
          it_behaves_like('drop', 'selected') { let(:expected) { 'false' } }
        end
      end
      it_behaves_like('drop', 'sku') { let(:expected) { 'SKU-15' } }
      it_behaves_like('drop', 'taxable') { let(:expected) { 'true' } }
      it 'Not MVP: taxable'
      it_behaves_like('drop', 'title') do
        let(:expected) { 'Depressed / Green eyes / With emotions' }
      end
      it_behaves_like('drop', 'url') do
        before(:each) do
          variant.save
        end

        let(:expected) do
          "/products/#{variant.product.handle}?variant=#{variant.id}"
        end
      end
      it_behaves_like('drop', 'weight') { let(:expected) { '0' } }
      it_behaves_like('drop', 'weight_unit') { let(:expected) { 'kg' } }
      it_behaves_like('drop', 'weight_in_unit') { let(:expected) { '0' } }
      it 'Not MVP: weight'
      it 'Not MVP: weight_unit'
      it 'Not MVP: weight_in_unit'
    end
  end
end
