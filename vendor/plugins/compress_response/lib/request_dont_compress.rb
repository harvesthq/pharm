module ActionController
  class AbstractRequest
    attr_writer :dont_compress
    def skip_compression?
      @dont_compress
    end
  end
end
