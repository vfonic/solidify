require 'rails_helper'

module Spree
  RSpec.describe Address do
    it_behaves_like 'address'
    it_behaves_like 'full_name'

    it 'does not call postal_code_validate' do
      expect { create(:address, country: 'Bananaland') }.to_not raise_error
    end

    it 'does not validate presence of country_id' do
      expect(build(:address, country_id: nil)).to be_valid
    end
  end
end
