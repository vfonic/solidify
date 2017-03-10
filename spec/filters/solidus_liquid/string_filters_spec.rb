require 'rails_helper'

module SolidusLiquid
  RSpec.describe 'StringFilters', type: :helper do
    subject { render_liquid(template, assigns, strict) }

    let(:assigns) { Hash.new }
    let(:strict) { true }

    describe '#append' do
      let(:expected) { 'apple and mango' }
      it_behaves_like 'filter', '"apple"', 'append', '" and mango"'
    end

    describe '#camelcase' do
      let(:expected) { 'ComingSoon' }
      it_behaves_like 'filter', '"coming-soon"', 'camelcase'
    end

    describe '#capitalize' do
      let(:expected) { 'Capitalize me' }
      it_behaves_like 'filter', '"capitalize me"', 'capitalize'
    end

    describe '#downcase' do
      let(:expected) { 'downcase me' }
      it_behaves_like 'filter', '"DOWNCASE ME"', 'downcase'
    end

    describe '#escape' do
      let(:expected) { '&lt;p&gt;test&lt;/p&gt;' }
      it_behaves_like 'filter', '"<p>test</p>"', 'escape'
    end

    describe '#handle' do
      let(:expected) { '100-m-ms' }
      it_behaves_like 'filter', '"100% M & Ms!!!"', 'handle'
    end

    describe '#handleize' do
      let(:expected) { '100-m-ms' }
      it_behaves_like 'filter', '"100% M & Ms!!!"', 'handleize'
    end

    describe '#md5' do
      let(:expected) { Digest::MD5.hexdigest('arthur.dent@example.com') }
      it_behaves_like 'filter', '"arthur.dent@example.com"', 'md5'
    end

    describe '#sha1' do
      let(:expected) { Digest::SHA1.hexdigest('arthur.dent@example.com') }
      it_behaves_like 'filter', '"arthur.dent@example.com"', 'sha1'
    end

    describe '#sha256' do
      let(:expected) { Digest::SHA256.hexdigest('arthur.dent@example.com') }
      it_behaves_like 'filter', '"arthur.dent@example.com"', 'sha256'
    end

    describe '#hmac_sha1' do
      let(:expected) do
        OpenSSL::HMAC.hexdigest(OpenSSL::Digest::Digest.new('sha1'),
                                'secret_key', 'arthur.dent@example.com')
      end
      it_behaves_like('filter', '"arthur.dent@example.com"',
                      'hmac_sha1', '"secret_key"')
    end

    describe '#hmac_sha256' do
      let(:expected) do
        OpenSSL::HMAC.hexdigest(OpenSSL::Digest::Digest.new('sha256'),
                                'secret_key', 'arthur.dent@example.com')
      end
      it_behaves_like('filter', '"arthur.dent@example.com"',
                      'hmac_sha256', '"secret_key"')
    end

    describe '#size' do
      let(:expected) { '6' }
      it_behaves_like 'filter', '"banana"', 'size'
    end
  end
end
