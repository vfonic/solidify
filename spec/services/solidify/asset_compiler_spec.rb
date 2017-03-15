module Solidify
  class AssetCompilerClass
    include Solidify::AssetCompiler
  end

  RSpec.describe AssetCompiler do
    it 'raises error on compile' do
      expect { AssetCompilerClass.new(double).compile }
        .to raise_error 'Implement in subclass'
    end
  end
end
