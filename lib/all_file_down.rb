require 'mechanize'

def all_file_down(y, m, d)
  Mechanize.new.get('http://pbs.vo.llnwd.net/kip0/_pxn=0+_pxK=17082/newshour/rss/media/'+y+'\/'+m+'\/'+d).links.each do |link|
    if link.text !~ /Parent Directory/
      puts "downloading" + link.text
      open(link.text.sub(' ',''), 'w') do |f|
        f.write(Mechanize.new.click(link).body)
      end
      puts link.text + "download complete"
    end
  end
  puts "all file download complete"
end

