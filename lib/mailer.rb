module NotificationMailer
  def self.notify(message)
    Gmail.connect(G_LOGIN, G_PASSWORD) do |gmail|
      gmail.deliver do
        to EMAIL_TO
        subject message
        text_part { body 'Having fun in Puerto Rico!' }
      end
    end
    puts "Email was sent at #{time}"
  end
end
