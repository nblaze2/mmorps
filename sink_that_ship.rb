require "uri"
require "openssl"

def decode_session(str)
  Marshal.load(URI.decode_www_form_component(str).unpack("m").first)
end


def generate_hmac(data, secret)
  OpenSSL::HMAC.hexdigest(OpenSSL::Digest::SHA1.new, secret, data)
end
