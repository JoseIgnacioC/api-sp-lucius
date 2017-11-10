class DocumentLine

  attr_accessor :my_json

  def initialize(json)
    puts "--------------------------------------------------"
    puts json
    @my_json = json
  end

  ##########################
  ##### STATIC METHODS #####
  ##########################
  def self.find_by_condition(condition)
    puts "########################################"
    puts "Buscando Lineas de Marketing por condicion"
    
    response = SERVICE_LAYER.get("https://10.221.127.9:50000/b1s/v1/DocumentLines?$filter=#{condition}")
    response["value"]
  end
end