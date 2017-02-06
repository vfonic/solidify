module SolidusLiquid
  class Configuration
    attr_accessor :cart_class

    def initialize
      @cart_class = ::Cart if defined? ::Cart
    end
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configuration=(config)
    @configuration = config
  end

  def self.configure
    yield configuration
  end
end
