module Notifyer
	def self.notify(message = 'Hurry Up!')
    threads = []
    threads << Thread.new { TelegramNotifier.notify(message) } if TELEGRAM_TOKEN.length > 0
    threads << Thread.new { NotificationMailer.notify(message) } if G_LOGIN.length > 0
    threads.each(&:join)
	end
end
