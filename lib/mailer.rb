module NotificationMailer
  def self.notify(message)
    Gmail.connect(EMAIL, PASSWORD) do |gmail|
      gmail.deliver do
        to EMAIL_TO
        subject message
        text_part { body 'Having fun in Puerto Rico!' }
      end
    end
    puts "Email was sent at #{time}"
  end
end
