require 'mail'
require 'pry'

Mail.defaults do
  retriever_method :imap, { :address    => 'mail.promedicalinc.com',
                            :port       => 993,
                            :user_name  => ARGV[0],
                            :password   => ARGV[1],
                            :enable_ssl => true }
end

# the mail gem had the read_only flag inverted for all versions through 2.4.4
read_only_flag = Mail::VERSION.version.gsub('.','').to_i <= 244 ? true : false

Mail.find(:mailbox => 'inbox/Lists/adhearsion', :read_only => read_only_flag) do |message, imap, message_id|
  puts "From: #{message.from}"
  puts "To: #{message.to}"
  puts "Subject: #{message.subject}"

  destination_mailbox = 'inbox/Lists/viewed_adhearsion'

  imap.uid_copy(message_id, destination_mailbox)
  imap.uid_store(message_id, "+FLAGS", [Net::IMAP::DELETED])
  imap.expunge
end