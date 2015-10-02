require_relative 'telegram_bot'
require_relative 'mailer'

class Notifyer
	def self.notify!(message = 'Hurry Up!')
    th1 = Thread.new { TelegramNotifier.new(message).notify }
    th2 = Thread.new { NotificationMailer.new(EMAIL, PASSWORD).notify }
    [th1, th2].each(&:join)
	end
end
