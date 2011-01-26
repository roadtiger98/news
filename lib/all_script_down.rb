require 'mechanize'

def all_script_down(y, m, d)
  agent = Mechanize.new
  agent.get('http://www.pbs.org/newshour/newshour_index.html').links.each do |link|
    if link.to_s != 'Intel' && link.uri.to_s =~ /#{m}-#{d}.html/
      open(link.uri.to_s.gsub(/[\\\/\:\*\?\"\<\>\|]/, '').gsub(/http.*june11/,'').gsub(/.html/,'')+'.txt', 'w') do |f|
        agent.get(link.uri.to_s).search('//div[@class="copy"]/p').map(&:inner_html).each do |contents|
          f.write(contents.gsub('<strong>','').gsub('</strong>',''))
        end
      end
    end
  end
end