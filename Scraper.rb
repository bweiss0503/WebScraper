require 'rubygems'
require 'Nokogiri'
require 'open-uri'

#At command line: URL of website, HTML for names, HTML for emails, HTML for phone numbers
#For carthage faculty pages: https://www.carthage.edu/department-name/faculty/ "h3 a" "a.email" "div.phone a"
#When entering HTML at command line use .class_name or #id_name

PAGE_URL = ARGV[0]
page = Nokogiri::HTML(URI.open(PAGE_URL))

names = page.css(ARGV[1]).collect(&:text)

#TODO see if this can be done in one line
all_html_emails = page.css(ARGV[2])
emails = Array.new
for obj in all_html_emails
	emails.push(obj['href'])
end

phone_nums = page.css(ARGV[3]).collect(&:text)

all_info = names.zip(emails, phone_nums)
all_info.each_index do |i|
	all_info[i].each_index do |j|
		print all_info[i][j] + " "
	end
	puts
end
#TODO write data from arrays to spreadsheet