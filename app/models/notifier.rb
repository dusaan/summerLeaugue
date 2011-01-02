class Notifier < ActionMailer::Base
require 'net/smtp'
  def feedback(user)
    from "dusaan@gmail.com"
    recipients "#{user}"
    subject "Vitajte na portali Aliga!"
    body :foo => 'bar'
    content_type 'text/html'
  end
end
