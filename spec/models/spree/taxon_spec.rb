module Spree
  RSpec.describe Taxon do
    it_behaves_like 'handle'

    describe '.find_or_create_collections_all' do
      context 'collection does not exist' do
        it 'creates the collection' do
          expect { Spree::Taxon.find_or_create_collections_all }
            .to change(Spree::Taxon, :count).by(1)
        end

        it 'creates the collection with correct attributes' do
          collection = Spree::Taxon.find_or_create_collections_all

          expect(collection.title).to eq('Products')
          expect(collection.handle).to eq('all')
        end

        it "contains all store's products" do
          create_list(:base_product, 2)

          expect(Spree::Taxon.find_or_create_collections_all.products.size)
            .to eq(2)
        end
      end

      context 'collection exists' do
        it 'fetches existing collection' do
          taxon = create(:taxon, handle: 'all')

          expect(Spree::Taxon.find_or_create_collections_all).to eq(taxon)
        end

        it "contains only manually selected collections' products" do
          product = create(:base_product)
          create(:taxon, handle: 'all', products: [product])
          create(:base_product)

          collections_all = Spree::Taxon.find_or_create_collections_all

          expect(collections_all.products).to eq([product])
        end
      end
    end
  end
end
