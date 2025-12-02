require 'net/http'
require 'uri'
require 'json'

class SupabaseService
  SUPABASE_URL = ENV["SUPABASE_URL"]
  SUPABASE_KEY = ENV["SUPABASE_SERVICE_ROLE_KEY"]

  def self.get_user_from_access_token(access_token)
    url = URI.parse("#{SUPABASE_URL}/auth/v1/user")

    req = Net::HTTP::Get.new(url)
    req['Authorization'] = "Bearer #{access_token}"
    req['apikey'] = SUPABASE_KEY

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    res = http.request(req)

    raise "Supabase Auth error: #{res.body}" unless res.is_a?(Net::HTTPSuccess)

    json = JSON.parse(res.body)
    {
      email: json["email"]
    }
  end
end
