#require 'lib/service_layer/service_layer.rb'

class IncomingPayment

  attr_accessor :json_response

  def initialize(json)
    puts "--------------------------------------------------"
    puts json
    @json_response = json
  end

  def doc_num
    @json_response["DocNum"]
  end 

  def doc_entry
    @json_response["DocEntry"]
  end 

  ##########################
  ##### STATIC METHODS #####
  ##########################
  def self.find_by_doc_num(doc_num)
    puts "########################################"
    puts "Buscando Pago por DocNum"
    
    response = SERVICE_LAYER.get("https://10.221.127.9:50000/b1s/v1/IncomingPayments?$filter=DocNum eq #{doc_num}")
    response["value"]
  end

  def self.create_payment(json)
    puts "########################################"
    puts "Creando Pago"

  	response = SERVICE_LAYER.post("https://10.221.127.9:50000/b1s/v1/IncomingPayments", json)
    puts response
    response
  end

end