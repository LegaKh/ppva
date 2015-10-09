module TelegramNotifier
  def self.notify message
    Telegram::Bot::Client.run TELEGRAM_TOKEN do |bot|
      bot.api.sendMessage chat_id: TELEGRAM_CHAT_ID, text: message
      sleep 2
    end
    puts "Messages to Telegram were sent at #{time}"
  end
end
