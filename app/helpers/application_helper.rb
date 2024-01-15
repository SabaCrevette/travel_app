module ApplicationHelper
  def full_title(page_title = '')
    base_title = 'Travel_app'
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end

  def full_url(path)
    domain = Rails.env.development? ? ENV['DEVELOPMENT_DOMAIN'] : ENV['PRODUCTION_DOMAIN']
    "#{domain}#{path}"
  end
end
