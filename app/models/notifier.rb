class Notifier < ActionMailer::Base
require 'net/smtp'
  def feedback(user)
    from "LetnaLiga.sk"
    recipients "#{user.email}"
    subject "Vitajte na LetnaLiga.sk!"
    body :user => user
    content_type 'text/html'
  end
  def self_invitation(user)
    from "LetnaLiga.sk"
    recipients "#{user.email}"
    subject "Vitajte na LetnaLiga.sk!"
    body :user => user
    content_type 'text/html'
  end
  def invitation(user)
    from "LetnaLiga.sk"
    recipients "#{user.email}"
    subject "Pozvanka na LetnaLiga.sk!"
    body :user => user
    content_type 'text/html'
  end
  def admin_info(user)
    from "LetnaLiga.sk"
    recipients "registracia@letnaliga.sk"
    subject "Novy ksicht sa regol"
    body :user => user
    content_type 'text/html'
  end
end

