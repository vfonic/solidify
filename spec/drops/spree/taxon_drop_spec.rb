module Spree
  RSpec.describe TaxonDrop do
    subject { render_liquid(template, assigns, strict) }

    let(:created_at) { 2.hours.ago }
    let(:taxon) do
      build(:taxon,
            id: 314,
            title: 'Best products',
            handle: 'best-of',
            description: '<h1>Best products on the planet and galaxy</h1>',
            created_at: created_at,
            image: build(:image),
            products: [build(:product), build(:product)])
    end

    let(:assigns) { { 'collection' => taxon } }
    let(:strict) { true }

    it_behaves_like 'drop for nil', 'collection', TaxonFields::METHODS

    describe 'json' do
      let(:template) { '{{ collection | json }}' }

      it 'renders correct json attributes' do
        # save to create created_at that we use for published_at
        taxon.save

        result_map = JSON.parse(subject)
        result_map.transform_values!(&:to_s)

        expect(result_map['id']).to eq('314')
        expect(result_map['body_html'])
          .to eq('<h1>Best products on the planet and galaxy</h1>')
        expect(result_map['handle']).to eq('best-of')
        expect(Time.zone.parse(result_map['published_at']).to_s)
          .to eq(created_at.to_s)
        expect(result_map['published_scope']).to eq('global')
        expect(result_map['sort_order']).to eq('alpha-asc')
        expect(result_map['title']).to eq('Best products')
      end

      it 'Not MVP: template_suffix'

      it 'renders all json attributes' do
        result_map = JSON.parse(subject)

        expect(result_map.keys).to eq(TaxonFields::JSON)
      end

      it 'does not render any additional attributes' do
        result_map = JSON.parse(subject)

        expect(result_map.keys - TaxonFields::JSON).to be_empty
      end
    end

    describe 'methods' do
      it_behaves_like('drop', 'id', 'collection') { let(:expected) { '314' } }
      it 'Not MVP: all_tags'
      it 'Not MVP: all_types'
      it_behaves_like('drop', 'all_products_count', 'collection') do
        let(:expected) { '2' }
      end
      it 'Not MVP: all_vendors'
      it 'Not MVP: current_type'
      it 'Not MVP: current_vendor'
      it 'Not MVP: default_sort_by'
      it_behaves_like('drop', 'description', 'collection') do
        let(:expected) { '<h1>Best products on the planet and galaxy</h1>' }
      end
      it_behaves_like('drop', 'handle', 'collection') do
        let(:expected) { 'best-of' }
      end
      it 'Not MVP: current_type'
      it 'Not MVP: current_vendor'
      it 'Not MVP: default_sort_by'
      it_behaves_like('drop', 'image', 'collection') do
        let(:expected) { 'ImageDrop' }
      end
      it 'Not MVP: next_product'
      it 'Not MVP: previous_product'
      it_behaves_like('drop', 'products', 'collection') do
        let(:expected) { 'ProductDrop' * 2 }
      end
      it_behaves_like('drop', 'products_count', 'collection') do
        let(:expected) { '2' }
      end
      it 'Not MVP: published_at'
      it 'Not MVP: template_suffix'
      it_behaves_like('drop', 'title', 'collection') do
        let(:expected) { 'Best products' }
      end
      it 'Not MVP: tags'
      it_behaves_like('drop', 'url', 'collection') do
        let(:taxon) { create(:taxon) }

        let(:expected) { "/collections/#{taxon.handle}" }
      end
    end
  end
end
