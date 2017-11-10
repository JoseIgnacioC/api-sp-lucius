# encoding: utf-8
class Api::V1::ServiceLayer::OrdersController < ApplicationController

  def update_order_status

    status_response = ""
    report_response = ""

    doc_entry = params_order[:doc_entry]
    status = params_order[:order][:status]

    MyLog.debug "params_order"
    MyLog.debug params_order

    MyLog.debug "status"
    MyLog.debug status
    
    MyLog.debug "doc_entry"
    MyLog.debug doc_entry


    if status != nil

      if is_status_valid(status)

        begin

          MyLog.debug "STATUS VALIDO"

          #prepare status as json
          json_status = {
            "U_ORDER_STATUS" => status
          }
          
          response = SalesOrder.update_order(doc_entry, json_status.to_json)

          MyLog.debug "response"
          MyLog.debug response

          code = response.code.to_i

          MyLog.debug "code"
          MyLog.debug code

          case code
          when 200 || 201 || 204
            #Success
            status_response = 200
            report_response = "OK"
          when (400..499)
            #Bad request
            status_response = 400
            report_response = "ERROR: Problemas en la petición hecha a Servicer Layer"
          when (500..599)
            #Server Problems
            status_response = 500
            report_response = "ERROR: Problemas en el servidor de Service Layer"
          end


        rescue Exception => e
          MyLog.debug "Exception OrdersController"
          MyLog.debug e
          status_response = 500
          report_response = "Exception: #{e}"
        end      

      else
        #El estado enviado no es valido
        status_response = 400
        report_response = "ERROR: El estado de la orden es invalido"
      end

    else

      #No hay status ingresado
      status_response = 400
      report_response = "ERROR: La peticion no posee el estado de la orden"
    end

    render json: {report: report_response }, status: status_response 
  end

  def update_line_order_status
    MyLog.debug "OrdersController"

    #data response
    status_response = nil
    @report_response = nil

    MyLog.debug "params_line_order"
    MyLog.debug params_line_order

    #data params
    doc_entry = params_line_order[:doc_entry]
    line_num = params_line_order[:line_num]
    status = params_line_order[:status]
    item_code = params_line_order[:item_code]


    if line_num != nil and status != nil and item_code != nil
      if is_line_status_valid(status)

        MyLog.debug "LINE STATUS VALIDO"

        begin
        
          json_line_status = {
            "DocumentLines" => [
              { 
                "LineNum" => line_num.to_i,
                "ItemCode" => item_code,
                "U_REQUEST_STATUS" => status,
                "U_REQUEST_UPDATED" => Time.new.strftime("%d/%m/%y")
              },
            ]
          }

          response = SalesOrder.update_order(doc_entry, json_line_status.to_json)

          MyLog.debug "response"
          MyLog.debug response

          code = response.code.to_i

          MyLog.debug "code"
          MyLog.debug code

          case code
          when 200 || 201 || 204
            #Success
            status_response = 200
            @report_response = {report: "OK"}
          when (400..499)
            #Bad request
            status_response = 400
            @report_response = {report: "ERROR: Problemas en la petición hecha a Servicer Layer"}
          when (500..599)
            #Server Problems
            status_response = 500
            @report_response = {report: "ERROR: Problemas en el servidor de Service Layer"}
          end


        rescue Exception => e
          MyLog.debug "Exception OrdersController"
          MyLog.debug e
          status_response = 500
          @report_response = {report: "Exception: #{e}"}
        end
      else
        #El estado es invalido
        status_response = 400
        @report_response = {report: "ERROR: El estado de la línea de la orden es inválido"}
      end 
    else
      #Error en los parametros enviados
      status_response = 400
      @report_response = {report: "ERROR: Faltan parametros en la petición"}
    end 
    render json: @report_response.to_json, status: status_response
  end

  def list
    @json_sales_order = SalesOrder.find_by_customer_id(9)


    render json: @json_sales_order, status: 200
  end


  private 

  def params_order
    params_permit = params.permit(:doc_entry, order: :status)
  end

  def params_line_order
    params_permit = params.permit(:doc_entry, :line_num, :status, :item_code)
  end

  #TODO: lista de todos los estados de la orden 
  def is_status_valid(status)
    ["DISPONIBLE_RET_DESP" ,"PAGADO", "ENVIADO", "ENTREGADO"].include?(status)
  end

  def is_line_status_valid(status)
    ["PENDIENTE", "PEDIDO", "ARRIBADO", "ERROR"].include?(status)
  end
end