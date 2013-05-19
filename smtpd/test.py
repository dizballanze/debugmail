from smtplib import SMTP
import datetime

debuglevel = 2

smtp = SMTP()
smtp.set_debuglevel(debuglevel)

smtp.connect('localhost', 9025)

smtp.ehlo()
smtp.starttls()
smtp.ehlo()

smtp.login('yuri@wbtech.pro', '3dabb1d84a5613f30216d1cf053163fb')

from_addr = "Yuri Shikanov <dizballanze@gmail.com>"
to_addr = "lion.programmer@gmail.com"

subj = "Hack The Planet"
date = datetime.datetime.now().strftime( "%d/%m/%Y %H:%M" )

message_text = "Hello\nThis is a mail from your server\n\nBye\n"

msg = "From: %s\nTo: %s\nSubject: %s\nDate: %s\n\n%s" \
        % ( from_addr, to_addr, subj, date, message_text )

try:
	smtp.sendmail(from_addr, to_addr, msg)
finally:
	smtp.close()