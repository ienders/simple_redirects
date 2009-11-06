class Redirection < ActiveRecord::Base

  before_save :cleanse_url_from

  def self.url_to_redirect_to(request_url)
    if result = find_by_cleansed_url(request_url)
      result.url_to
    else
      nil
    end
  end

  def self.is_legacy_url_for_redirect?(request_url)
    !!find_by_cleansed_url(request_url)
  end

  protected

  def self.find_by_cleansed_url(request_url)
    self.find_by_url_from(cleanse_url(request_url))
  end

  def self.cleanse_url(url)
    return url.to_s.downcase
  end

  def cleanse_url(url); self.class.cleanse_url(url); end

  def cleanse_url_from
    self.url_from = cleanse_url(self.url_from)
  end

end
