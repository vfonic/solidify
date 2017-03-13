require 'rails_helper'

module SolidusLiquid
  RSpec.describe 'StringFilters', type: :helper do
    subject { render_liquid(template, assigns, strict) }

    let(:assigns) { Hash.new }
    let(:strict) { true }

    describe '#append' do
      it_behaves_like('filter', '"apple"', 'append', '" and mango"') do
        let(:expected) { 'apple and mango' }
      end
    end

    describe '#camelcase' do
      it_behaves_like('filter', '"coming-soon"', 'camelcase') do
        let(:expected) { 'ComingSoon' }
      end
    end

    describe '#capitalize' do
      it_behaves_like('filter', '"capitalize me"', 'capitalize') do
        let(:expected) { 'Capitalize me' }
      end
    end

    describe '#downcase' do
      it_behaves_like('filter', '"DOWNCASE ME"', 'downcase') do
        let(:expected) { 'downcase me' }
      end
    end

    describe '#escape' do
      it_behaves_like('filter', '"<p>test</p>"', 'escape') do
        let(:expected) { '&lt;p&gt;test&lt;/p&gt;' }
      end
    end

    describe '#first' do
      it_behaves_like 'filter', '"apple"', 'first' do
        let(:expected) { 'a' }
      end
    end

    describe '#handle' do
      it_behaves_like('filter', '"100% M & Ms!!!"', 'handle') do
        let(:expected) { '100-m-ms' }
      end
    end

    describe '#handleize' do
      it_behaves_like('filter', '"100% M & Ms!!!"', 'handleize') do
        let(:expected) { '100-m-ms' }
      end
    end

    describe '#last' do
      it_behaves_like 'filter', '"apple"', 'last' do
        let(:expected) { 'e' }
      end
    end

    describe '#md5' do
      it_behaves_like('filter', '"arthur.dent@example.com"', 'md5') do
        let(:expected) { Digest::MD5.hexdigest('arthur.dent@example.com') }
      end
    end

    describe '#sha1' do
      it_behaves_like('filter', '"arthur.dent@example.com"', 'sha1') do
        let(:expected) { Digest::SHA1.hexdigest('arthur.dent@example.com') }
      end
    end

    describe '#sha256' do
      it_behaves_like('filter', '"arthur.dent@example.com"', 'sha256') do
        let(:expected) { Digest::SHA256.hexdigest('arthur.dent@example.com') }
      end
    end

    describe '#hmac_sha1' do
      it_behaves_like('filter', '"arthur.dent@example.com"',
                      'hmac_sha1', '"secret_key"') do
                        let(:expected) do
                          OpenSSL::HMAC.hexdigest(
                            OpenSSL::Digest.new('sha1'),
                            'secret_key', 'arthur.dent@example.com'
                          )
                        end
                      end
    end

    describe '#hmac_sha256' do
      it_behaves_like('filter', '"arthur.dent@example.com"',
                      'hmac_sha256', '"secret_key"') do
                        let(:expected) do
                          OpenSSL::HMAC.hexdigest(
                            OpenSSL::Digest.new('sha256'),
                            'secret_key', 'arthur.dent@example.com'
                          )
                        end
                      end
    end

    describe '#newline_to_br' do
      it_behaves_like('filter', "'One\nTwo\nThree'", 'newline_to_br') do
        let(:expected) { "One<br />\nTwo<br />\nThree" }
      end
    end

    describe '#pluralize' do
      it_behaves_like('filter', '1', 'pluralize', "'banana', 'bananas'") do
        let(:expected) { 'banana' }
      end
      it_behaves_like('filter', '2', 'pluralize', "'banana', 'bananas'") do
        let(:expected) { 'bananas' }
      end
      context 'number as string' do
        it_behaves_like('filter', '"1"', 'pluralize', "'banana', 'bananas'") do
          let(:expected) { 'banana' }
        end
        it_behaves_like('filter', '"7"', 'pluralize', "'banana', 'bananas'") do
          let(:expected) { 'bananas' }
        end
      end
    end

    describe '#prepend' do
      it_behaves_like('filter', '"mango"', 'prepend', '"apple and "') do
        let(:expected) { 'apple and mango' }
      end
    end

    describe '#remove' do
      it_behaves_like('filter',
                      '"Hello, world. Goodbye, world."', 'remove', '"world"') do
                        let(:expected) { 'Hello, . Goodbye, .' }
                      end
    end

    describe '#remove_first' do
      it_behaves_like('filter',
                      '"Hello, world. Goodbye, world."',
                      'remove_first', '"world"') do
                        let(:expected) { 'Hello, . Goodbye, world.' }
                      end
    end

    describe '#replace' do
      it_behaves_like('filter',
                      '"Hello, world. Goodbye, world."',
                      'replace', '"world", "mundo"') do
                        let(:expected) { 'Hello, mundo. Goodbye, mundo.' }
                      end
    end

    describe '#replace_first' do
      it_behaves_like('filter',
                      '"Hello, world. Goodbye, world."',
                      'replace_first', '"world", "mundo"') do
                        let(:expected) { 'Hello, mundo. Goodbye, world.' }
                      end
    end

    describe '#size' do
      it_behaves_like('filter', '"banana"', 'size') do
        let(:expected) { '6' }
      end
    end

    describe '#slice' do
      it_behaves_like('filter', '"Hello."', 'slice', '0') do
        let(:expected) { 'H' }
      end
      it_behaves_like('filter', '"Hello."', 'slice', '1') do
        let(:expected) { 'e' }
      end
      it_behaves_like('filter', '"Hello."', 'slice', '1, 3') do
        let(:expected) { 'ell' }
      end
      it_behaves_like('filter', '"Hello."', 'slice', '-3, 2') do
        let(:expected) { 'lo' }
      end
    end

    describe '#split' do
      it_behaves_like('filter', '"H el lo"', 'split', '" " | join: ","') do
        let(:expected) { 'H,el,lo' }
      end
    end

    describe '#strip' do
      it_behaves_like('filter', '"  too many spaces   "', 'strip') do
        let(:expected) { 'too many spaces' }
      end
    end

    describe '#lstrip' do
      it_behaves_like('filter', '"  too many spaces   "', 'lstrip') do
        let(:expected) { 'too many spaces   ' }
      end
    end

    describe '#rstrip' do
      it_behaves_like('filter', '"  too many spaces   "', 'rstrip') do
        let(:expected) { '  too many spaces' }
      end
    end

    describe '#strip_html' do
      it_behaves_like('filter', '"<h1>Hello</h1> World"', 'strip_html') do
        let(:expected) { 'Hello World' }
      end
    end

    describe '#strip_newlines' do
      it_behaves_like('filter', "'Hello\n World\r\n'", 'strip_newlines') do
        let(:expected) { 'Hello World' }
      end
    end

    describe '#truncate' do
      it_behaves_like('filter',
                      '"The cat came back the very next day"',
                      'truncate', '13') do
        let(:expected) { 'The cat ca...' }
      end
      it_behaves_like('filter',
                      '"ABCDEFGHIJKLMNOPQRSTUVWXYZ"',
                      'truncate', '18, ", and so on"') do
        let(:expected) { 'ABCDEFG, and so on' }
      end
      it_behaves_like('filter',
                      '"I\'m a little teapot, short and stout."',
                      'truncate', '15, ""') do
        let(:expected) { "I'm a little te" }
      end
    end

    describe '#truncatewords' do
      it_behaves_like('filter',
                      '"The cat came back the very next day"',
                      'truncatewords', '4') do
        let(:expected) { 'The cat came back...' }
      end
      it_behaves_like('filter',
                      '"The cat came back the very next day"',
                      'truncatewords', '4, "--"') do
        let(:expected) { 'The cat came back--' }
      end
      it_behaves_like('filter',
                      '"The cat came back the very next day"',
                      'truncatewords', '4, ""') do
        let(:expected) { 'The cat came back' }
      end
    end

    describe '#upcase' do
      it_behaves_like('filter', '"upcase me"', 'upcase') do
        let(:expected) { 'UPCASE ME' }
      end
    end

    describe '#url_encode' do
      it_behaves_like('filter',
                      '"url_encode arthur.dent@example.com"', 'url_encode') do
        let(:expected) { 'url_encode+arthur.dent%40example.com' }
      end
    end

    describe '#url_escape' do
      it_behaves_like('filter', '"<hello> & <shopify>"', 'url_escape') do
        let(:expected) { '%3Chello%3E%20&%20%3Cshopify%3E' }
      end
    end

    describe '#url_param_escape' do
      it_behaves_like('filter', '"<hello> & <shopify>"', 'url_param_escape') do
        let(:expected) { '%3Chello%3E%20%26%20%3Cshopify%3E' }
      end
    end

    describe 'reversing strings' do
      it_behaves_like('filter',
                      '"Ground control to Major Tom."',
                      'split', '"" | reverse | join: ""') do
        let(:expected) { '.moT rojaM ot lortnoc dnuorG' }
      end
    end
  end
end
