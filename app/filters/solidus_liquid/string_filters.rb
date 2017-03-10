module SolidusLiquid
  module StringFilters
    def camelcase(string)
      string.underscore.camelize
    end

    def handle(string)
      string.try(:parameterize)
    end

    alias handleize handle

    def md5(string)
      Digest::MD5.hexdigest(string)
    end

    def sha1(string)
      Digest::SHA1.hexdigest(string)
    end

    def sha256(string)
      Digest::SHA256.hexdigest(string)
    end

    def hmac_sha1(data, secret)
      OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha1'),
                              secret.encode('ASCII'), data.encode('ASCII'))
    end

    def hmac_sha256(data, secret)
      OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha256'),
                              secret.encode('ASCII'), data.encode('ASCII'))
    end

    def pluralize(input, singular, plural)
      input == 1 ? singular : plural
    end
  end
end
