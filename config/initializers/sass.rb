# rubocop:disable all
module Sass
  module Selector
    class SimpleSequence < AbstractSequence
      def check_directives_match!(extend, parent_directives)
        dirs1 = extend.directives.map {|d| d.resolved_value}
        dirs2 = parent_directives.map {|d| d.resolved_value}
        return if Sass::Util.subsequence?(dirs1, dirs2)
        line = extend.node.line
        filename = extend.node.filename
      end
    end
  end
end
# rubocop:enable all
