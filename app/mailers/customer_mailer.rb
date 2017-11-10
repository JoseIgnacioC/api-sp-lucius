class CustomerMailer < ActionMailer::Base
  
  layout 'email'
  default from: "ventas@spdigital.cl"
  
  #API

  def send_email_order(data_user, data_order, name_template, status, subject)
    
    puts "send_email_order"
    begin
      
      template = Template.where(:key_name => name_template).first.content
      @content = replace_content_api(template, { 
          :data_user => data_user, 
          :data_order => data_order,
          :order_status => status,
        }).html_safe
      
      mail(to: "#{data_user[:user_email]}", subject: subject) do |format|
        format.html { render layout: 'email', template: '/customer_mailer/pop' }
      end

    rescue Exception => e
      puts "ERROR"
      puts e
    end
  end

  # Replaces special phrases in the form %the_variable% written in the templates
  # with the corresponding values
  # The list of allowed phrases should be on the view of new and edit for templates
  def replace_content_api(template, vars)

    data_order = vars[:data_order]
    data_user = vars[:data_user]
    status = vars[:order_status]

    html_products = products_detail_to_html(data_order[:order_products])
    hash_products = {order_products: html_products }

    data_order.merge!(hash_products)

    #Generals
    template.gsub!('%order_status%', vars[:order_status] )
    template.gsub!('%order_deposit_accounts%', deposit_accounts(vars[:shopping_cart]))

    #ShoppingCart
    unless data_order[:order_id].nil?

      data_order.each do |key, value|
        if value.nil?
          template.gsub!('%'+key.to_s+'%', "")
        else
          template.gsub!('%'+key.to_s+'%', value.to_s)
        end
      end
    end

    #User
    unless data_user[:user_id].nil?
      data_user.each do |key, value|
        if value.nil?
          template.gsub!('%'+key.to_s+'%', "")
        else
          template.gsub!('%'+key.to_s+'%', value.to_s)
        end
      end
      template
    end
  end

  def deposit_accounts(shopping_cart)
    "<h2>¿A DONDE DEPOSITAR/TRANSFERIR?</h2>" \
    "<table style='width: 100%; color: #666; border-collapse: collapse; border: 0'>" \
      "<tr>" \
        "<td style='width: 33%'>" \
          "<b>Banco Santander</b><br>" \
          "Cuenta corriente<br>" \
          "SP Digital Limitada<br>" \
          "RUT: 76.799.430-3<br>" \
          "Cuenta: 61799540" \
        "</td>" \
        "<td style='width: 33%'>" \
          "<b>Banco Estado</b><br>" \
          "Cuenta corriente<br>" \
          "SP Digital Limitada<br>" \
          "RUT: 76.799.430-3<br>" \
          "Cuenta: 1733851" \
        "</td>" \
        "<td style='width: 33%'>" \
          "<b>Banco BCI</b><br>" \
          "Cuenta corriente<br>" \
          "SP Digital Limitada<br>" \
          "RUT: 76.799.430-3<br>" \
          "Cuenta: 86066854" \
        "</td>" \
      "</tr>" \
    "</table>"
  end

  def products_detail_to_html(products)
    table = "<table style='width: 100%; border-collapse: collapse; border: 0; color: black; margin-bottom: 10px'>" \
      "<tr style='background-color: white; color: black'>" \
        "<td style='padding: 5px'>ITEM</td>" \
        "<td style='padding: 5px; width: 30%'>NOMBRE</td>" \
        "<td style='padding: 5px'>CÓD. SP</td>" \
        "<td style='padding: 5px; text-align: right; white-spice: nowrap'>VALOR C.IVA</td>" \
        "<td style='padding: 5px; text-align: right'>CANT.</td>" \
        "<td style='padding: 5px; text-align: right'>SUBTOTAL</td>" \
      "</tr>"
      total_products = 0
      shipping_cost = 0
      products.each do |product|
        if product[:name] != "DESPACHO"
          table += "<tr>" \
            "<td style='padding: 5px; width: 40%'>#{product[:name]}</td>" \
            "<td style='padding: 5px'>#{product[:code]}</td>" \
            "<td style='padding: 5px; text-align: right'>#{ product[:price]}</td>" \
            "<td style='padding: 5px; text-align: right'>#{product[:quantity]}</td>" \
            "<td style='padding: 5px; text-align: right'>#{ product[:quantity].to_i * product[:price].to_i}</td>" \
          "</tr>"
          total_products += product[:price].to_i * product[:quantity].to_i
        else
          shipping_cost += product[:price] 
        end   
      end
      table += "<tr style='border-top: 1px solid #DDD'>" \
        "<td colspan='3'></td>" \
        "<td style='padding: 5px; text-align: right' colspan='2'>Subtotal C.IVA</td>" \
        "<td style='padding: 5px; text-align: right'><b>#{ total_products }</b></td>" \
        "</tr>" \
        "<tr>" \
          "<td colspan='3'></td>" \
          "<td style='padding: 5px; text-align: right' colspan='2'>Despacho</td>" \
          "<td style='padding: 5px; text-align: right'><b>#{ shipping_cost}</b></td>" \
        "</tr>"

      #TODO: discount
      discount = 0
      if false 
        table += "<tr>" \
          "<td style='padding: 5px' colspan=3>CUPÓN DE DESCUENTO: #{self.discount_code}</td>" \
          "<td style='padding: 5px; text-align: right'>#{ -self.discount_amount_coupon}</td>" \
          "<td style='padding: 5px; text-align: right'>1</td>" \
          "<td style='padding: 5px; text-align: right'>#{ -self.discount_amount_coupon}</td>" \
        "</tr>"
      end
      total = total_products + discount + shipping_cost
      table +=  "<tr>" \
        "<td colspan='3'></td>" \
        "<td style='padding: 5px; text-align: right' colspan='2'>Total</td>" \
        "<td style='padding: 5px; text-align: right'><b>#{ total}</b></td>" \
      "</tr>" \
    "</table>"
  end
end