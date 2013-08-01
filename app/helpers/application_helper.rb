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
    params[:teacher].delete( :bill_name )
    params[:teacher].delete( :bill_last_name )
  end

  def sanitize_from_bill_address
    params[:teacher].delete( :bill_street )
    params[:teacher].delete( :bill_cap )
    params[:teacher].delete( :bill_country )
    params[:teacher].delete( :bill_number )
    params[:teacher].delete( :bill_city )
    params[:teacher].delete( :bill_province )
  end

  def sanitize_from_subjects
    params[:teacher].delete( :sub1 )
    params[:teacher].delete( :sub2 )
    params[:teacher].delete( :sub3 )
  end

end
