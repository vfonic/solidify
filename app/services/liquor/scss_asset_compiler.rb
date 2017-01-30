module Liquor
  class ScssAssetCompiler
    include AssetCompiler

    def compile
      options = {
        style: :compressed,
        syntax: :scss,
        cache: false,
        full_exception: true
      }
      Sass::Engine.new(@template, options).render
    end
  end
end
