module ApplicationHelper

  def sanitize_params( hash )
    params[hash].delete( :street )
    params[hash].delete( :cap )
    params[hash].delete( :country )
    params[hash].delete( :number )
    params[hash].delete( :city )
    params[hash].delete( :province )
  end

  def sanitize_from_bill
    params[:teacher].delete( :business_name )
    params[:teacher].delete( :cf )
    params[:teacher].delete( :iva )
    params[:teacher].delete( :name )
    params[:teacher].delete( :last_name )
  end

  def sanitize_from_bill_address
    params[hash].delete( :bill_street )
    params[hash].delete( :bill_cap )
    params[hash].delete( :bill_country )
    params[hash].delete( :bill_number )
    params[hash].delete( :bill_city )
    params[hash].delete( :bill_province )
  end

end
