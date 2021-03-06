# Data scraped from
# https://www.visahq.com/citizens/United-States/

require 'open-uri'

class Visa
  SOURCE_URL = 'https://www.visahq.com/citizens/United-States/'
  DEFAULT_VISA_COST = 100.00
  
  def initialize
  end

  def cost_for_country(country)
    begin
      doc = country_data(country)
      doc.css('table tr.odd .price_hide').first.text
    rescue => e
      nil
    end
  end

  def country_url(country)
    Visa.country_url(country)
  end

  def self.country_url(country)
    "https://#{country}.visahq.com/"
  end
  
  private

  def visa_countries
    return @visa_countries if @visa_countries
    doc = Nokogiri::HTML(open(SOURCE_URL))
    @visa_countries = doc.css('a').map { |link| link['href'] }
  end
  
  def country_data(country)
    doc = Nokogiri::HTML(open(country_url(country)))
  end
  
end
