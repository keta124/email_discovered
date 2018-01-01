class CheckEmailController < ApplicationController
  layout false

  def index
  end

  def create
    permit_param = email_params
    result = CheckEmailDiscovered.execute permit_param["your_email"]
    if result.any?
      password = result.first["password"]
      #render json:{"password" => password}.to_json
      redirect_to :controller => 'check_email',password: password.to_s.gsub(" ",""), 
        email: permit_param["your_email"]
    else 
      redirect_to :controller => 'check_email',email: permit_param["your_email"], password: "Email an toàn"
    end
    #status ='hello'
    #redirect_to :controller => 'check_email',notice: status
  end
  def email_params
    params.permit :your_email
  end
end
