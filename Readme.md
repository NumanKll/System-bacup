## Linux Yedekleme Scripti

### Kullanım

Herhangi bir yetki problemine takılmamak için scripti root kullannıcısı altında çalıştırınız. Yedeğinin alınmasını istediğiniz dizinleri aynı dizinde oluşturulan `bacupDirectory.txt` dosyasına ekleyebilirsiniz. Uzak sunucu yedeği alabilmek için `ssh-key` oluşturmanız gerekmektedir. Scripti ssh key dosyası oluşturulduktan sonra parametresiz çalıştırıldığında belirtmiş olduğunuz dizinlerin yedeğini `/var/back` dizini altına yedekler. `./bacup.sh <kullanıcı> <host> <yedek-dizini>` şeklinde parametrelerle çalıştırıldığında ise local yedekleri sunucuya aktarır.

## SSH-Keygen oluşturma

Öncelikle scripti root kullanıcısı ile çalıştıracağımızdan `sudo su` komutu ile `root` kullanıcısına geçiyoruz. 

`ssh-keygen` ile ssh keyimizi oluşturuyoruz.

`scp .ssh/<id--->.pub root@ip :/root/.ssh/authorized_keys` komutu ile ssh keyimizi yedekleme alacağımız sunucuya aktarıyoruz.

`ssh root@ip` şeklinde bağlantıyı test ediyoruz. Herhangi bir şifre istemeden sunucuya ait kabuk oturumu açılmış olması gerekli.  

## Cron Ayarlama

Kullanım amacına göre iki farklı yöntem mevcuttur ilki günlük, haftalık ya da aylık olarak yedek almak isterseniz script dosyamızı;
* __Günlük__ :/etc/cron.daily
* __Haftalık__ : /etc/cron.weekly
* __Aylık__ : /etc/cron.monthly

klasörlerine atarak yedek alınabilir yada `crontab -e` komutu ile zamanlamayı kendiniz ayarlayabilirsiniz.



