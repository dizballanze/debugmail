#! /usr/bin/python

import smtplib

from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText

# me == my email address
# you == recipient's email address
me = "dizballanze@gmail.com"
you = "vit@wbtech.pro"

# Create message container - the correct MIME type is multipart/alternative.
msg = MIMEMultipart('alternative')
msg['Subject'] = "HTML Stuff"
msg['From'] = me
msg['To'] = you

# Create the body of the message (a plain-text and an HTML version).
text = "Hi!\nHow are you?\nHere is the link you wanted:\nhttp://www.python.org"
html = """\
<html>
  <head></head>
  <body>
    <p>Hi!<br>
       How are you?<br>
       Here is the <a href="http://www.python.org">link</a> you wanted.
    </p>
  </body>
</html>
"""

# Record the MIME types of both parts - text/plain and text/html.
part1 = MIMEText(text, 'plain')
part2 = MIMEText(html, 'html')

# Attach parts into message container.
# According to RFC 2046, the last part of a multipart message, in this case
# the HTML message, is best and preferred.
msg.attach(part1)
msg.attach(part2)

# Send the message via local SMTP server.
smtp = smtplib.SMTP()

smtp.connect('debugmail.info', 9025)

smtp.ehlo()
smtp.starttls()
smtp.ehlo()

smtp.login('yuri@wbtech.pro', '40d72d5c19f7f542bfba52fe239e4d05')

# sendmail function takes 3 arguments: sender's address, recipient's address
# and message to send - here it is sent as one string.
smtp.sendmail(me, you, msg.as_string())
smtp.quit()