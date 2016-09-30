class JsonWebToken
  def self.encode(payload)
    JWT.encode(payload, Rails.application.secrets.secret_key_base)
  end

  def self.valid?(token)
    begin
      JWT.decode(token,Rails.application.secrets.secret_key_base)
    rescue
      false
    end
  end
end