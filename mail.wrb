# -*- coding: utf-8 -*-
if __FILE__ == $0
  require 'net/pop'
  require 'Win32OLE'
  require 'kconv'

  # メッセージだすよ！
  def show(msg, title)
    wsh = WIN32OLE.new('WScript.Shell')
    ret = wsh.Popup(msg, 0, title, 0 + 4 + 256 + 0x40000)
    # メーラーを起動してもいいのよ
    if ret == 6
      exec '"C:\\Program Files (x86)\\Mozilla Thunderbird\\thunderbird.exe"'
      #WIN32OLE.new("Outlook.Application").GetNamespace("MAPI").GetDefaultFolder(6).Display
    end
  end

begin
  # POP3接続
  Net::POP3.enable_ssl(OpenSSL::SSL::VERIFY_NONE)
  pop = Net::POP3.new('pop3.live.com', 995) # hotmail
  pop.start('accountname@piyo.piyo', 'passphrase')

  mailCount = pop.mails.size
  if mailCount != 0
    receivedSubjects = Array.new
  
    # タイトルをデコードして一覧にしようそうしよう
    pop.mails.each do |m|
      receivedSubjects << m.header.split(/\r\n/).grep(/(Subject: |=\?(ISO|iso)-2022-(JP|jp)\?)/){ |grepped|
        grepped.gsub(/Subject: | /,"")
      }.join().tolocale.toutf8
    end
    pop.finish
  
    # メッセージボックスを表示しちゃう
    title = "めーるだよーーー！ (" << mailCount.to_s << ")"
    msg = receivedSubjects.join("\n-----------------------------------------------------------------------\n")
    show(msg, title)
  end

rescue => e
  show(e.to_s,"!ERROR!")
end

end
