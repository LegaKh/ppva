module Notifyer
	def self.notify(message = 'Hurry Up!')
    [Thread.new { TelegramNotifier.notify(message) }, Thread.new { NotificationMailer.notify(message) }].each(&:join)
	end
end
