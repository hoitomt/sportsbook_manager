require 'watir'
require 'watir-webdriver'

module SportsbookApi
	class Sportsbook

		URL = 'http://www.sportsbook.ag/livesports/login.php'
		WAGERS_URL = 'https://www.sportsbook.ag/sbk/sportsbook4/www.sportsbook.ag/wagers.cgi?betState=0&searchByDateType=1&searchButton=Search'

		def initialize(config)
			@config = config
		end

		def get_tickets(date_range)
			browser = login
			raw_ticket_array = get_sb_data(browser, date_range)
			browser.close
			[].tap do |a|
				raw_ticket_array.each do |raw_ticket|
					a << ParseTickets.new(raw_ticket).extract
				end
			end.flatten
		end

		def login
			browser = Watir::Browser.new
			browser.goto URL
			browser.text_field(name: 'username').set @config.username
			browser.text_field(name: 'password').set @config.password
			browser.button(name: 'submit').click
			browser
		end

		def get_sb_data(browser, date_range)
			data = [polish(watir_script(browser, date_range, nil))]
			data << polish(watir_script(browser, date_range, 1))
			data
		end

		def watir_script(browser, date_range, page)
			browser.goto wager_url(date_range, page)
			# browser.select_list(name: 'betState').select 'Pending and Processed'
			# browser.select_list(id: 'priorDaysId').select date_range
			# browser.button(name: 'searchButton').click
			browser.html
		end

		def polish(doc)
			doc.gsub!(/\\r|\\t|\\n|\\/, '')
			doc.gsub!(/\s{2,}/, ' ')
			Nokogiri::HTML(doc)
		end

		def wager_url(date_range, page)
			url = "#{WAGERS_URL}&dateRangeMode=#{date_range}"
			url += "&page=#{page}" if page
			p "******** Sportsbook URL #{url}"
			url
		end

	end
end