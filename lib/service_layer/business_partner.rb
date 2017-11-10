#require 'lib/service_layer/service_layer.rb'

class BusinessPartner

	attr_accessor :json_response

	def initialize(json)
    @json_response = json
  end

  def card_code
  	@json_response["CardCode"]
  end

  def rut
  	@json_response["FederalTaxID"]
  end

  def self.find_by_rut(rut)
    puts "########################################"
    puts "Buscando Cliente por RUT"
    
    response = SERVICE_LAYER.get("https://10.221.127.9:50000/b1s/v1/BusinessPartners?$filter=FederalTaxID eq '#{rut}' and CardType eq 'C' &$top=1")
    response["value"].first
  end

  def self.find_by_card_code(card_code)
    puts "########################################"
    puts "Buscando Cliente por Card Code"
    
    response = SERVICE_LAYER.get("https://10.221.127.9:50000/b1s/v1/BusinessPartners?$filter=CardCode eq '#{card_code}' and CardType eq 'C' &$top=1")
    puts response["value"].first 
    response["value"].first
  end

end