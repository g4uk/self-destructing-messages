helpers do
  def base_url
    @base_url ||= "#{request.env['rack.url_scheme']}://#{request.env['HTTP_HOST']}"
  end

  def partial(template, opts={})
    parts = template.split('/')
    last = "_#{parts.pop}"

    erb([parts, last].flatten.join('/').to_sym, {layout: false}.merge(opts))
  end

  def error_messages
    @error_messages ||= session[:error_messages]
    session[:error_messages] = nil

    Array.wrap(@error_messages).compact
  end

  def success_messages
    @success_messages ||= session[:success_messages]
    session[:success_messages] = nil

    Array.wrap(@success_messages).compact
  end
end