require 'mechanize'
a = Mechanize.new
r = a.get 'http://www.pbs.org/newshour/bb/world/jan-june11/moscowitn_01-24.html'
r.search('//div[@class="copy"]/p').map(&:inner_html).each do |contents|
  puts contents.gsub('<strong>','').gsub('</strong>','')
end