Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

	namespace :api, defaults: { format: "json" } do
  	namespace :v1 do
  		scope '/mailer' do
  			post '/to_proof' => 'mailer#to_proof'
    		post '/to_entered' => 'mailer#to_entered'
	        post '/to_be_confirmed' => 'mailer#to_be_confirmed'
	        post '/to_paidout' => 'mailer#to_paidout'
	        post '/to_availability' => 'mailer#to_availability'
	        post '/to_sended' => 'mailer#to_sended'
  		end

      namespace :service_layer do
        scope  '/orders' do
          get '/list' => 'orders#list'
          post '/update_order_status/:doc_entry' => 'orders#update_order_status'
          patch '/update_line_order_status/:doc_entry' => 'orders#update_line_order_status', as: "update_line_order_status" 
        end
      end
      
	  end
	end
end
