
Note: docker-compose doesn't work well yet, use the scripts below instead

```bash
sudo yum install epel-release
sudo yum install certbot
# substitute the correct subdomain(s).domain(s)
sudo certbot certonly --standalone -d azure1.tradle.io
# run nginx proxy
./start.sh

# setup auto-renew
sudo nano /etc/crontab
# paste:
# @monthly /path/to/renew.sh
```
