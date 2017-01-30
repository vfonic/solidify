module Liquor
  class AssetCompilerClass
    include Liquor::AssetCompiler
  end

  RSpec.describe AssetCompiler do
    it 'raises error on compile' do
      expect { AssetCompilerClass.new(double).compile }
        .to raise_error 'Implement in subclass'
    end
  end
end
