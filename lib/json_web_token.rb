class JsonWebToken
  class << self
    def encode payload, exp = 24.hours.from_now
      payload[:exp] = exp.to_i
      JWT.encode payload, Rails.application.secrets.secret_key_base
    end

    def decode token
      JWT.decode token, Rails.application.secrets.secret_key_base
    end
  end
end
