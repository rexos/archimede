module ApplicationHelper

  def sanitize_params( hash )
    params[hash].delete( :street )
    params[hash].delete( :cap )
    params[hash].delete( :country )
    params[hash].delete( :number )
    params[hash].delete( :city )
    params[hash].delete( :province )
  end

end
