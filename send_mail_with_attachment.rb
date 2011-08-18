require 'mail'

options = { :address              => "mail.promedicalinc.com",
            :port                 => 25,
            :domain               => 'promedview.com',
            :user_name            => ARGV[0],
            :password             => ARGV[1],
            :enable_starttls_auto => true  }

Mail.defaults do
  delivery_method :smtp, options
end

message = Mail.new do
  from      'tracker@promedview.com'
  to        ['robertj@promedicalinc.com', 'jonj@promedicalinc.com']
  subject   'Hello from the mail gem!!'
  body      'This is a body of text.'
  add_file  'test_file_attachment.txt'
end

message.deliver!