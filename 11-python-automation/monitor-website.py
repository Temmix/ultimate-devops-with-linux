import os
import time
import smtplib
import schedule
import paramiko
import requests
import linode_api4


# Note these environment variable in my pycharm IDE environment setups
EMAIL_ADDRESS = os.environ.get('EMAIL_ADDRESS')
EMAIL_PASSWORD = os.environ.get('EMAIL_PASSWORD')
LINODE_TOKEN = os.environ.get('LINODE_TOKEN')


def send_email_notification(message):
    print('Sending an email notification........')
    with smtplib.SMTP('smtp.gmail.com', 587) as smtp:
        smtp.starttls()
        smtp.ehlo()
        smtp.login(EMAIL_ADDRESS, EMAIL_PASSWORD)
        smtp.sendmail(EMAIL_ADDRESS, EMAIL_ADDRESS, message)


def restart_container():
    print('Restarting the container.........')
    ssh = paramiko.SSHClient()
    ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    ssh.connect(hostname='139.162.212.150', username='root', key_filename="/Users/temmi/.ssh/id_rsa.pub")
    container_id = '8a59745d64cd'
    stdin, stdout, stderr = ssh.exec_command(f'docker start {container_id}')
    print(stdout.readlines())
    ssh.close()


def reboot_server_and_application():
    # restart linode server (specific to linode )
    print('Restarting the linode server........')
    client = linode_api4.LinodeClient(LINODE_TOKEN)
    server_id = 44762601  # check the server id on linode GUI
    nginx_server = client.load(linode_api4.Instance, server_id)
    nginx_server.reboot()

    # restart the application
    while True:
        nginx_server = client.load(linode_api4.Instance, server_id)
        if nginx_server.status == 'running':
            time.sleep(5)
            restart_container()
            break


def monitor_application():
    # this application is a simple linode server with docker container running nginx
    try:
        response = requests.get('http://139-162-212-150.ip.linodeusercontent.com:8080/')
        if response.status_code == 200:
            print('Application is up and running!')
        else:
            print('Application is down, fix it!')
            msg = "Subject: SITE DOWN\n Fix the issue"
            send_email_notification(msg)
            restart_container()
    except Exception as ex:
        print(f'Connection error occurred {ex}')
        oro = f"Subject: SITE DOWN\n Server issue {ex}"
        send_email_notification(oro)
        reboot_server_and_application()


schedule.every(5).minutes.do(monitor_application)
while True:
    schedule.run_pending()
