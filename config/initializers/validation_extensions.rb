require 'rfc822'

# Technique from: http://www.marklunds.com/articles/one/312
module ValidationExtensions

  def validate_email(*attributes)
    error_message = 'must be a valid address'
    attributes.each do |attribute|
      self.errors.add(attribute, error_message) unless valid_email?(self.send(attribute.to_s))
    end
  end

  def valid_email?(email)
    return true if email.blank?
    # the first fails on ' and other oddities, while the second is slow and
    # overly strict disallowing vovels with accents ä é etc (some users get
    # away with this)
    # the first will fail on things like basil@fawlty while the second will
    # let it through
    email.match(/^[\w\-\+]+(?:\.[\w\-\+]+)*@(?:[\w-]+\.)+[a-zA-Z]{2,7}$/) || email.match(RFC822::EmailAddress)
  end

end

class ActiveRecord::Base
  include ValidationExtensions
end
