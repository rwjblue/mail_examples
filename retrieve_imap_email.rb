require 'mail'

Mail.defaults do
  retriever_method :imap, { :address    => 'mail.promedicalinc.com',
                            :port       => 993,
                            :user_name  => ARGV[0],
                            :password   => ARGV[1],
                            :enable_ssl => true }
end

Mail.all do |message|
  puts "From: #{message.from}"
  puts "To: #{message.to}"
  puts "Subject: #{message.subject}"
  puts "Body (text/plain): #{message.text_part.body.to_s.split("\n").join("\n    ")}\n"

  message.attachments.each do |attachment|
    puts "Attachment: #{attachment.filename} (#{attachment.content_type})"
    File.open(attachment.filename, "w+b", 0644) { |f| f.write attachment.body.decoded }
    #`open #{attachment.filename}`
  end

  puts "\n\n"
end