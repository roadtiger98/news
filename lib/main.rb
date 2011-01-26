require 'mechanize'

def date
  Time.new.strftime('%d')
end
def month
  Time.new.strftime('%m')
end

def all_script_down(m, d)
  agent = Mechanize.new
  agent.get('http://www.pbs.org/newshour/newshour_index.html').links.each do |link|						#첫 페이지의 모든 링크를 차례대로 스캔
    if link.to_s != 'Intel' && link.uri.to_s =~ /#{m}-#{d}.html/								#링크이름이 인텔제외, 링크 url이 날짜+html인거
      puts 'downloading' + link.uri.to_s.gsub(/[\\\/\:\*\?\"\<\>\|]/, '').gsub(/http.*june11/,'')				#현재 상황 리포트
      open(link.uri.to_s.gsub(/[\\\/\:\*\?\"\<\>\|]/, '').gsub(/http.*june11/,'').gsub(/.html/,'')+'.txt', 'w') do |f|		#링크에서 파일이름 추출
        agent.get(link.uri.to_s).search('//div[@class="copy"]/p').map(&:inner_html).each do |contents|				#스크립트 읽어오기
          f.write(contents.gsub('<strong>','\n').gsub('</strong>',''))								#스크립트 파일에 쓰기
        end
      end
      a = 1															#첫번째 링크가 mp3링크이므로
      agent.get(link.uri.to_s).links.each do |link2|										#현재 열린 뉴스의 모든 링크 스캔
        if link2.to_s != 'Intel' && link2.uri.to_s =~ /.mp3/ && a == 1								#인텔X, mp3파일, 첫번째 링크
          open(link.uri.to_s.gsub(/[\\\/\:\*\?\"\<\>\|]/, '').gsub(/http.*june11/,'').gsub(/.html/,'')+'.mp3', 'wb') do |f|	#파일이름 지정
            f.write(Mechanize.new.click(link2).body)										#mp3다운
            a = 2														#더이상 이 뉴스에서 파일다운 없음
          end
        end
      end
    end
  end
end

all_script_down(date().to_s, month().to_s)