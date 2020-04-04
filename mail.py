import smtplib
import subprocess

subprocess.run('ls')
subprocess.call(['/root/Desktop/narzedzie_1.sh']) #sciezka do skryptu sprawdzajacego waznosc cert.


EMAIL_ADDRESS = "stefan.mos33@gmail.com"
PASSWORD = "123456789xsw2!QAZ"

from email.message import EmailMessage

msg = EmailMessage()

mylines = []
mydata = []
with open ('raport.txt', 'rt') as myfile:
    for myline in myfile:
        mylines.append(myline)



######Generator ostrzezen ->wartosc certyfikatu konczy sie za <30dni
#a=len(mylines)
#d=0
#petla sprawdzajaca czy waznosc ktoregos z certyfikatu konczy sie za mniej niz 30 dni ->>
#for x in range (3, a, 5):
#    b=int(mylines[x])
#    if b < 30:
#        d=d+1
#gdy chociaz waznosc 1 certyfikatu <30dni, generujemy odpowiednie ostrzezenie



#def gen_email():

#   if d > 0:
#        t = '***WAZNE*** Raport - waznosc certyfikatow.'
#        m = '***WAZNE*** Koniecznie sprawdz waznosc certyfikatow!!!'
#    else:
#        t = 'Raport - waznosc certyfikatow.'
#        m = 'Prosze o zapozanie sie z raportem dot. certyfikatow'




#Generowanie wiadomosci email

msg['From'] = EMAIL_ADDRESS
msg['To'] = EMAIL_ADDRESS
msg['Subject'] = '***WAZNE*** Raport - waznosc certyfikatow.'
msg.set_content('Wiadomosc wygenerowana automatycznie - raport')



with open('raport.txt', 'rb') as content_file:
    content = content_file.read()
    msg.add_attachment(content, maintype='application/txt', subtype='txt',  filename='raport.txt')


#wysylanie raportu za pomoca smtplib
def send_email(msg):
    try:
        with smtplib.SMTP_SSL('smtp.gmail.com', 465) as smtp:
            smtp.login(EMAIL_ADDRESS, PASSWORD)

            smtp.send_message(msg)
            print("Success Email sent!")

    except:
        print("Email failed to send.")

send_email(msg)







