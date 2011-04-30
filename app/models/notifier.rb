class Notifier < ActionMailer::Base
require 'net/smtp'
  def feedback(user)
    from "LetnaLiga.sk"
    recipients "#{user}"
    subject "Vitajte na LetnaLiga.sk!"
    body :user => user
    content_type 'text/html'
  end
  def invitation(user)
    from "LetnaLiga.sk"
    recipients "#{user}"
    subject "Pozvánka na portál LetnaLiga.sk!"
    body :user => user
    content_type 'text/html'
  end

end

