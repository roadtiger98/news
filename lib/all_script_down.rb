require 'mechanize'

def all_script_down(m, d)
  agent = Mechanize.new
  agent.get('http://www.pbs.org/newshour/newshour_index.html').links.each do |link|
    if link.to_s != 'Intel' && link.uri.to_s =~ /#{m}-#{d}.html/
      agent.get(link.uri.to_s).search('//div[@class="copy"]/p').map(&:inner_html).each do |contents|
        open(link.to_s, 'w') do |f|
          f.write(contents.gsub('<strong>','').gsub('</strong>',''))
        end
      end
    end
  end
end