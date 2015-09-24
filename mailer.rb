require 'gmail'

class NotificationMailer
  attr_reader :gmail

  def initialize(username, password)
    @gmail   = Gmail.connect(username, password)
  end

  def notify
    gmail.deliver do
      to "legakh@gmail.com"
      subject "Having fun in Puerto Rico!"
      text_part do
        body 'Hurry Up!'
      end
    end
    gmail.logout
  end
end
