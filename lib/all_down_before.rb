require 'mechanize'

def all_script_down(m, d)
  agent = Mechanize.new
  agent.get('http://www.pbs.org/newshour/newshour_index.html').links.each do |link|						//첫 페이지 내부 모든 링크를 차례대로 스캔
    if link.to_s != 'Intel' && link.uri.to_s =~ /#{m}-#{d}.html/								//오늘 날짜 스크립트 링크인지 확인
      open(link.uri.to_s.gsub(/[\\\/\:\*\?\"\<\>\|]/, '').gsub(/http.*june11/,'').gsub(/.html/,'')+'.txt', 'w') do |f|		//파일명 지정하기
        agent.get(link.uri.to_s).search('//div[@class="copy"]/p').map(&:inner_html).each do |contents|				//script 읽어오기
          f.write(contents.gsub('<strong>','').gsub('</strong>',''))								//파일에 script쓰기
        end
      end
      a = 1															//첫번째 링크가 현재페이지 mp3파일
      agent.get(link).links.each do |link2|											//현재페이지의 모든 링크를 차례대로 스캔
        if link2.uri.to_s =~ /.mp3/ && a == 1											//mp3파일에 대한 링크이고 첫번째인지 확인
          open(link2.uri.to_s.gsub(/[\\\/\:\*\?\"\<\>\|]/, '').gsub(/http.*media/,''), 'wb') do |f|				//파일명지정하기
            f.write(Mechanize.new.click(link2).body)										//mp3파일 쓰기
            a = 2														//이다음부터 mp3파일 받지 말기
          end
        end
      end
    end
  end
end