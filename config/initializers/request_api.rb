module ActionController
  class AbstractRequest
    def api?
      format.xml? || format.json?
    end
  end
end
