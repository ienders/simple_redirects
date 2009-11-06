module RedirectHelper

  def rescue_404
    # wont work in dev mode until you enable "consider_all_requests_local"  in  development.rb
    if new_destination = Redirection.url_to_redirect_to(request.request_uri)
      redirect_to new_destination, :status => "301"
    else
      render :file => "#{RAILS_ROOT}/public/404.html",  :status => "404"
    end
  end

end