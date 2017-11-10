#require 'lib/service_layer/service_layer.rb'

class SalesOrder

  attr_accessor :my_json

  def initialize(json)
    puts "--------------------------------------------------"
    puts json
    @my_json = json
  end

  def doc_num
    @my_json["DocNum"]
  end 

  def doc_entry
    @my_json["DocEntry"]
  end 

  def updated_at
    @my_json["UpdateDate"]
  end

  #with shipping cost
  def total_amount
    total = 0
    products = @my_json["DocumentLines"]
    products.each do |product|
      total += product["Quantity"] * product["PriceAfterVAT"]
    end
    total
  end

  def total_products_amount
    total = 0
    products = @my_json["DocumentLines"]
    products.each do |product|
      if product["ItemCode"] != "DESPACHO"
        total += product["Quantity"] * product["PriceAfterVAT"]
      end
    end
    total
  end

  def shipping_cost
    cost = 0
    products = @my_json["DocumentLines"]
    products.each do |product|
      if product["ItemCode"] == "DESPACHO"
        cost = product["PriceAfterVAT"]
      end
    end
    cost
  end

  #TODO
  def discount_amount
    0
  end

  def shopping_cart_id
    @my_json["U_SHOPPING_CART_ID"]
  end

  def checkout_date
    @my_json["CreationDate"]
  end

  def shipping_address 
    address = @my_json["AddressExtension"]
    if address["ShipToStreet"] != nil
      address['ShipToStreet']
    else
      nil
    end
  end 

  def shipping_city
    address = @my_json["AddressExtension"]
    if address['ShipToCity'] != nil
      address['ShipToCity']
    else
      nil
    end
  end

  def billing_address 
    address = @my_json["AddressExtension"]
    if address["BillToStreet"]
      address['BillToStreet']
    else
      nil
    end
  end

  def billing_city 
    address = @my_json["AddressExtension"]
    if address['BillToCity'] != nil
      address['BillToCity']
    else
      nil
    end
  end

  def payment_receip
    billing_address == nil ? 'ticket' : 'invoice'
  end 

  def shipping_method
    shipping_address == nil ? 'pickup' : 'dispatch'
  end 

  def products 
    @my_json["DocumentLines"]
  end

  ##########################
  ##### STATIC METHODS #####
  ##########################
  def self.find_by_docnum(docnum)
    puts "########################################"
    puts "Buscando Orden Cliente por DocNum"
    
    response = SERVICE_LAYER.get("https://10.221.127.9:50000/b1s/v1/Orders?$filter=DocNum eq #{docnum}")
    response["value"].first
  end

  def self.find_by_customer_id(customer_id)
    puts "########################################"
    puts "Buscando Orden Cliente por Customer ID"
    
    response = SERVICE_LAYER.get("https://10.221.127.9:50000/b1s/v1/Orders?$filter=U_CUSTOMER_ID eq #{customer_id} &$orderby=UpdateDate desc")
    response["value"]
  end
  
  def self.create_order(json)
    puts "########################################"
    puts "Creando Orden"

    response = SERVICE_LAYER.post("https://10.221.127.9:50000/b1s/v1/Orders", json)
    puts response
    response
  end

  def self.update_order(docentry, json)
    puts "########################################"
    puts "Actualizando Orden con DocEntry #{docentry}"

    response = SERVICE_LAYER.patch("https://10.221.127.9:50000/b1s/v1/Orders(#{docentry})", json)
    puts response
    response
  end
end