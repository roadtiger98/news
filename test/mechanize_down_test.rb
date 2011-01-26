require 'rubygems'
require 'mechanize'

agent = Mechanize.new
page = agent.get('http://www.pbs.org/newshour/rss/media/2011/01/24')

page.links.each do |link|
  line = link.text
  if line =~ /mp3/
    puts "downloading" + link.text
    open(link.text, 'w') do |f|
      f.write(agent.click(link).body)
    end
  end
end