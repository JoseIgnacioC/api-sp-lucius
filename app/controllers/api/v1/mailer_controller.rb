class Api::V1::MailerController < ApplicationController

  def to_proof
  	puts params

  	@message = {report: "OK"}

  	render json: @message, status: 200
  end

  #Action for send email about the entered order (Only web)
  def to_entered
    @message = ""
    begin

      data_user = params_send_email[:mailer][:user]
      data_order = params_send_email[:mailer][:order]

      #Web Order
      unless data_user.nil? || data_order.nil?
        unless data_order[:order_id].nil?
          
          #send email
          unless data_user[:user_email].nil?
            name_template = "order_entered"
            status = "Ingresada"
            subject = "[SP Digital] Su orden ha sido ingresada" 
            CustomerMailer.send_email_order(data_user, data_order, name_template, status, subject ).deliver
                      
            @message = {report: "OK"}.to_json
          else
            @message = {report: "ERROR: Email no encontrado"}.to_json
          end
        #Isnt web order, then ERROR
        else
          @message = {report: "ERROR: ShoppingCart no encontrado"}.to_json
        end
      else
        @message = {report: "ERROR: Datos no recibidos"}.to_json
      end

    rescue => e
      @message = {report: "ERROR" + e.to_s[0..100]}.to_json
    end
    render json: @message, status: 200
  end

  def to_be_confirmed
    @message = ""
    begin

      data_user = params_send_email[:mailer][:user]
      data_order = params_send_email[:mailer][:order]

      #Web Order
      unless data_order[:order_id].nil?
        
        #send email
        unless data_user[:user_email].nil?
          name_template = "order_be_confirmed"
          status = "Por confirmar pago"
          subject = "[SP Digital] Hemos recibido su comprobante de pago" 
          CustomerMailer.send_email_order(data_user, data_order, name_template, status, subject ).deliver
                    
          @message = {report: "OK"}.to_json
        else
          @message = {report: "ERROR: Email no encontrado"}.to_json
        end
      #Isnt web order, then ERROR
      else
        @message = {report: "ERROR: ShoppingCart no encontrado"}.to_json
      end

    rescue => e
      @message = {report: "ERROR" + e.to_s[0..100]}.to_json
    end
    render json: @message, status: 200
  end

  #Preparate information for notify about checkout order (Only web order)
  def to_paidout
    @message = ""
    begin

      data_user = params_send_email[:mailer][:user]
      data_order = params_send_email[:mailer][:order]

      #Web Order
      unless data_order[:order_id].nil?
        
        #send email
        unless data_user[:user_email].nil?

          subject = "[SP Digital] Pago confirmado" 
          
          if data_order[:order_only_local]
            name_template = "order_checkout_local"
            status = "Pagada"
          else
            name_template = "order_checkout_external"
            status = "Pagada"
          end
          CustomerMailer.send_email_order(data_user, data_order, name_template, status, subject ).deliver
          @message = {report: "OK"}.to_json
        else
          @message = {report: "ERROR: Email no encontrado"}.to_json
        end
      #Isnt web order, then ERROR
      else
        @message = {report: "ERROR: ShoppingCart no encontrado"}.to_json
      end
    rescue => e
      @message = {report: "ERROR" + e.to_s[0..100]}.to_json
    end
    render json: @message, status: 200
  end

  #Preparate information for send email about the availability order for invoice/dispatch
  def to_availability
    @message = ""

    begin
      data_user = params_send_email[:mailer][:user]
      data_order = params_send_email[:mailer][:order]

      #Isn't Web Order
      if data_order[:order_id].nil?
        #data_user[:order_email]

      #If is web order
      else
        #customer = Customer.where(id: data_user[:user_id] ).first
        #customer_email = customer.email
        #data_user[:user_email] = customer_email
      end

      #send email
      unless data_user[:user_email].nil?

        subject = "[SP Digital] Orden disponible para retiro/despacho" 
        name_template = "order_availability"
        status = "Disponible"

        CustomerMailer.send_email_order(data_user, data_order, name_template, status, subject ).deliver
        @message = {report: "OK"}.to_json
      else
        @message = {report: "ERROR: Email no encontrado"}.to_json
      end
    rescue => e
      @message = {report: "ERROR" + e.to_s[0..100]}.to_json
    end
    render json: @message, status: 200
  end

  #Preparate information for send email about the availability order for invoice/dispatch
  def to_sended
      @message = ""

    begin
      data_user = params_send_email[:mailer][:user]
      data_order = params_send_email[:mailer][:order]

      #Isn't Web Order
      if data_order[:order_id].nil?
        #data_user[:order_email]

      #If is web order
      else
        #customer = Customer.where(id: data_user[:user_id] ).first
        #customer_email = customer.email
        #data_user[:user_email] = customer_email
      end

      #send email
      unless data_user[:user_email].nil?

        subject = "[SP Digital] Orden enviada a destino" 
        name_template = "order_sended"
        status = "Enviada"

        CustomerMailer.send_email_order(data_user, data_order, name_template, status, subject ).deliver
        @message = {report: "OK"}.to_json
      else
        @message = {report: "ERROR: Email no encontrado"}.to_json
      end
    rescue => e
      @message = {report: "ERROR" + e.to_s[0..100]}.to_json
    end
    render json: @message, status: 200
  end

  private
    def params_send_email
      params.permit(mailer: 
        [
          user: [:user_id, :user_email, :user_rut, :user_name, ],
          order:[ :order_id, :order_status, :order_status_transition, 
                  :order_modified_at, :order_created_at, :order_cart_link, 
                  :order_payment_method, :order_payment_receipt, 
                  :order_billing_address_address, :order_billing_address_business_name,
                  :order_billing_address_city, :order_billing_address_contact_name, 
                  :order_billing_address_email, :order_billing_address_line_of_business,
                  :order_billing_address_number, :order_billing_address_phone, 
                  :order_billing_address_rut, :order_delivery_time, 
                  :order_shipping_address_address, :order_shipping_address_city, 
                  :order_shipping_address_complement, :order_shipping_address_contact_name, 
                  :order_shipping_address_number, :order_shipping_address_phone, 
                  :order_shipping_cost, :order_shipping_method, :order_shipping_service, 
                  :order_shipping_courier, :order_tracking_number, :order_tracking_state, 
                  :order_products, :order_cost_total, :order_only_local, :order_doc_num
            ] 
        ])
    end
end