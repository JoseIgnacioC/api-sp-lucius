require 'net/http'
require 'json'

class ServiceLayer
  attr_accessor :http
  attr_accessor :cookie_b1session
  attr_accessor :cookie_routeid
  attr_accessor :cookies
  
  def initialize
    uri = URI("https://10.221.127.9:50000/b1s/v1/Orders")
    @http = Net::HTTP.new(uri.host, uri.port)
    @http.use_ssl = true
    @http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    @cookies = ""
  end
  
  def connect
    uri = URI("https://10.221.127.9:50000/b1s/v1/Login")
    connectionData = {
      "CompanyDB" => "SP_PRUEBAS",
      "Password" => "1234",
      "UserName" => "FMONROY"
    }
    resp, data = @http.post(uri.path, connectionData.to_json, { 'Content-Type' => 'application/json' })
    cookies = resp.response['set-cookie'].split(';HttpOnly;, ')
    @cookies = resp.response['set-cookie']
    resp
  end
  
  def post(url, json)
    puts "####################################"
    puts "Sending request to Service Layer"
    uri = URI(url)
    headers = {
      'Cookie' => @cookies
    }
    puts headers
    resp, data = @http.post(uri, json, headers)
    puts uri.path
    puts "resp"
    puts resp
    response = JSON.parse resp.body
    puts response
    # Check if everything went good
    if !response["error"].nil? && !response["error"]["code"].nil? && response["error"]["code"] == -1001
      puts "ERROR: No logueados"
      puts self.connect
      self.post(url, json)
    else
      return response
    end
  end

  def patch(url, json)
    puts "####################################"
    puts "Sending request to Service Layer"
    uri = URI(url)
    headers = {
      'Cookie' => @cookies,
      'X-HTTP-Method-Override' => "PATCH"
    }
    puts headers
    resp, data = @http.post(uri, json, headers)
    puts uri.path
    puts "RESPUESTA SERVICE LAYER"
    puts resp
    puts resp.code

    if resp.body != nil
      response = JSON.parse resp.body
      puts response
      # Check if everything went good
      if !response["error"].nil? && !response["error"]["code"].nil? && response["error"]["code"] == -1001
        puts "ERROR: No logueados"
        puts self.connect
        self.patch(url, json)
      else
        return response
      end
    else
      return resp
    end
  end
  
  def get(url)
    puts "####################################"
    puts "Sending request to Service Layer"
    uri = URI(url)
    headers = {
      'Cookie' => @cookies
    }
    puts headers
    resp, data = @http.get(uri, headers)
    puts uri.path
    response = JSON.parse resp.body
    # Check if everything went good
    if !response["error"].nil? && !response["error"]["code"].nil? && response["error"]["code"] == -1001
      puts "ERROR: No logueados"
      puts self.connect
      self.get(url)
    else
      return response
    end
  end
end