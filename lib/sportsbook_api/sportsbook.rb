require 'watir'
require 'watir-webdriver'

module SportsbookApi
	class Sportsbook

		URL = 'http://www.sportsbook.ag/livesports/login.php'
		WAGERS_URL = 'https://www.sportsbook.ag/sbk/sportsbook4/www.sportsbook.ag/wagers.cgi'

		def initialize(config)
			@config = config
		end

		def get_tickets(date_range)
			data = get_sb_data(date_range)
			ParseTickets.new(data).extract
		end

		def get_sb_data(date_range)
			polish watir_script
		end

		def watir_script
			browser = Watir::Browser.new
			browser.goto URL
			browser.text_field(name: 'username').set @config.username
			browser.text_field(name: 'password').set @config.password
			browser.button(name: 'submit').click
			browser.goto WAGERS_URL
			browser.select_list(name: 'betState').select 'Pending and Processed'
			browser.radio(value: '2').set
			browser.select_list(id: 'priorDaysId').select 'Last 31 days'
			browser.button(name: 'searchButton').click
			result = browser.html
			browser.close
			result
		end

		def polish(doc)
			doc.gsub!(/\\r|\\t|\\n|\\/, '')
			doc.gsub!(/\s{2,}/, ' ')
			Nokogiri::HTML(doc)
		end

	end
end