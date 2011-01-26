require 'mechanize'

def all_file_down(page)
  Mechanize.new.get(page).links.each do |link|
    if link.text !~ /Parent Directory/
      puts "downloading" + link.text
      open(link.text.sub(' ',''), 'wb') do |f|
        f.write(Mechanize.new.click(link).body)
      end
      puts link.text + "download complete"
    end
  end
  puts "all file download complete"
end

all_file_down("http://www.pbs.org/newshour/rss/media/2011/01/24")