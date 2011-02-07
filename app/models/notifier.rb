class Notifier < ActionMailer::Base
#require 'net/smtp'
  def feedback(user)
    from "dusaan@gmail.com"
    recipients "#{user}"
    subject "Vitajte na portáli aLiga.sk!"
    body :user => user
    content_type 'text/html'
  end
  def invitation(user)
    from "dusaan@gmail.com"
    recipients "#{user}"
    subject "Pozvánka na portál aLiga.sk!"
    body :user => user
    content_type 'text/html'
  end

end

