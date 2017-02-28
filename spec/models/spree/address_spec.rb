require 'rails_helper'

module Spree
  RSpec.describe Address do
    it_behaves_like 'address'
    it_behaves_like 'full_name'
  end
end
