# Vagrant LEMP Paketi

----------

## Katkıda bulunmak

### Sorunlar, hata raporları

Hata raporlarınızı [Vagrant-LEMP-Stack-setter](https://github.com/juy/Vagrant-LEMP-Stack-setter/issues) deposunun hata raporları sayfasına gönderebilirsiniz. Provisyon işlemleri o depoda gerçekleştiği için o deponun hata bildirim sayfasını kullanmaktayız.

## Vagrant LEMP Paketi nedir

PHP web sayfaları ve laravel projeleri geliştirmek için gereken her şeyi içeren hazır bir geliştirme platformudur.

## Bağımlılıklar

* [Vagrant](http://www.vagrantup.com/downloads.html) `1.5.0`+ (Sürüm kontrolü için `vagrant version` komutunu kullanabilirsiniz)
* [Virtualbox](https://www.virtualbox.org/wiki/Downloads)

## Kurulum

Vagrant LEMP Paketi için tavsiye edilen Vagrant sürümüne sahip olduğunuza emin olunuz.

```shell
vagrant version
```

### 1. Vagrant LEMP Paketi GitHub deposunu klonlayın veya indirin

**Klonlama**
```shell
git clone https://github.com/juy/Vagrant-LEMP-Stack.git new-project
```

**İndirme**
https://github.com/juy/Vagrant-LEMP-Stack/archive/master.zip

### 2. Vagrant kutumuzu ekleyin

Vagrant LEMP Paketi için hazırladığımız ubuntu kutusunu Vagrant sistemine ekleyin.

```shell
vagrant box add juysoft/vagrant-lemp-stack
```

Bu işlem internet hızınıza bağlı olarak biraz zaman alabilir, bu yüzden yanınıza bir kahve veya sandviç almak isteyebilirsiniz. 

### 3. vagrant-cachier eklentisi kurulumu (isteğe bağlı)

[vagrant-cachier](https://github.com/fgrehm/vagrant-cachier/) eklentisi provizyon sırasında kullanılan genel paketler için ön-bellek özelliği sunar. İsteğe bağlı olarak kurabilirsiniz. Ancak Vagrant LEMP Paketi kurulum sırasında provizyon yapmaz, zaten hazırdır.

```shell
vagrant plugin install vagrant-cachier
```

### 4. Vagrant LEMP Paket ayarlarınızı yapın

`vagrant/config.example.yml` dosyasını `config.yml` olarak yeniden adlandırın. Bu dosya ayar dosyasıdır, içeriğini kontrol edip gereken değişiklikleri yapabilirsiniz.

### 5. Sanal makineyi çalıştırın

Vagrant LEMP Paketi dizininde iken aşağıdaki komutu komut istemciniz ile çalıştırın. Bu komut ile sanal sunucu çalışacak ve sizi sanal sunucu içindeki shell komut satırına bağlayacaktır.

```shell
vagrant up && vagrant ssh
```

## Web ve proje kullanımı

#### *Vagrant paylaşımlı dizin hakkında küçük bir not*

> Projelerimiz için vagrant paylaşımlı dizin kullanmıyoruz, şimdilik Vagrantfile dosyası üzerine de bununla ilgili bir kod koymadık. PhpStorm IDE üzerinden SFTP ile uzaktan bağlantı yapıyoruz. Artisan, composer, npm, bower, gulp gibi tüm komutları sunucu üzerinden çalıştırıyoruz.

### Proje dosyaları nereye konulmalı

Proje dosyalarınızı sanal sunucu içindeki `~/www`  dizini içerisine projenize göre bir adı olan bir dizin içine koyabilirsiniz. Örneğin `~/www/mylaravel`.

### Projeleri web tarayıcıdan nasıl açacağız

Önceki örnek proje dizin adına göre `http://mylaravel.app:8800` veya `http://mylaravel.site:8800` ile erişebiliriz, bu özel joker erişim türünü bir sonraki başlık altında açıklayacağız. Web portunu 8000 numarasından özellikle farklı tuttuk ve `8800` olarak kullandık, çünkü sanal makine dışından `php artisan serve` komutu 8000 numarı portu kullanır, olası bir çakışma yaşanmasını istemedik.

### Joker sistemi, projelerin web erişimi için

Vagrant LEMP Paketi, hiç web sunucu ayarı yapmadan sınırsız proje oluşturabilmek için Nginx joker sistemini kullanır. Bu sayede hiçbir Nginx dosyasını değiştirmeniz, virtualhost oluşturmanız gerekmez, proje oluşturduktan sonra web sunucuyu yeniden başlatmanız gerekmez.

Joker sisteminde iki adet alan adı uzantısı bulunur, `.app` ve `.site`. `.app` uzantısı laravel projeleri için kullanılır, bu uzantı proje dizini içinde bir `public` dizini arar ve onun içindeki index.php dosyasını çalıştırır. `.site` uzansı ise normal php web projelerinde kullanılabilir (örneğin wordpress), bir `public` dizini aramaz, direk proje dizi içindeki index.php dosyasını çalıştırır.

Alan adı proje dizin ismi ile aynıdır, önceki örneğimizde proje dizin adı olan `mylaravel` projesini çalıştırmak için; projemiz public dizini içeren bir laravel ise `http://mylaravel.app:8800` adresini, normal bir web projesi ise `http://mylaravel.site:8800` adresini kullanabiliriz.

**Önemli:**

Windows bilgisayarlarda kullanacağımız her bir projenin alan adını `C:\Windows\System32\drivers\etc\hosts` dosyasına eklemek zorundayız.

Örneğin:

```
127.0.0.1    mylaravel.app   # http://mylaravel.app:8800
127.0.0.1    testlaravel.app # http://testlaravel.app:8800
127.0.0.1    wordpress.site  # http://wordpress.site:8800
```

**Joker sisteminin temsili bir şeması**
```
*.app:8800 -> www/*/public
*.site:8800 -> www/*
```

## Erişim ve Portlar

**Basit gösterge paneli**
```
http://127.0.0.1:8800
```

**MailCatcher**
```
http://127.0.0.1:1080
http://machine-ip:1080
```

**Beanstalkd console**
```
http://127.0.0.1:8501
http://machine-ip:8501
```

**Redis commander**
```
http://127.0.0.1:8502
http://machine-ip:8081
```

**MySQL, uzaktan erişim için bilgiler**
```
IP          127.0.0.1
Port        33060
Database    homestead
User        root        homestead
Password    secret
```

**PostgreSQL, uzaktan erişim için bilgiler**
```
IP          127.0.0.1
Port        54320
Database    homestead
User        root
Password    secret
```

**Shell-SSH**
```
IP          127.0.0.1
Port        2222
User        vagrant
Password    vagrant
```

## Vagrant box/kutu güncelleme komutları

**Zamanı geçen kutuların kontrolü**
```shell
vagrant box outdated
```

**Kutu güncelleme**
```shell
vagrant box update
```

## Sanal makine güncelleme komutları

Bu komutlar sanal ubuntu sistemi içindir, `vagrant ssh` ile bağlanılmalıdır.

### Ubuntu güncelleme

```shell
apt-get update
apt-get upgrade
apt-get dist-upgrade
```

### Composer kendisini ve genel paketleri güncelleme

```shell
composer self-update
composer global update
```

### Npm genel paketleri güncelleme

```shell
npm update -g 
```

----------

## Sağlanan İçerik

- **OS**
	- [x] Ubuntu Server 15.04 Vivid Vervet (64-bit) - [boxcutter/ubuntu1504](https://atlas.hashicorp.com/boxcutter/boxes/ubuntu1504)
- **Temel/Çekirdek paketler**
	- [x] Ansible
	- [x] Nginx
	- [x] PHP 5.6.* (php-fpm)
	- [x] Git, git-flow, git-extras
	- [x] Composer
	- [x] Ruby
	- [x] HHVM ("composerh" komutu ile composer'i hhvm ile kullanmak için)
	- [x] VirtualBox Guest Additions
- **Veritabanları**
	- [x] MySQL 5.6.*
	- [x] PostgreSQL 9.4.*
	- [x] SQLite
- **Hafızada veri tutma**
	- [x] Redis
	- [x] Memcached
- **Araçlar**
	- [x] Mailcatcher
	- [x] Beanstalkd
	- [x] Supervisord
	- [x] Blackfire profiler
	- [x] Ngrok
- **Varlık araçları**
	- [x] node.js 5.5.*, npm
	- [x] bower
	- [x] gulp
- **Composer genel paketleri**
    - [x] Laravel installer
	- [x] Lumen installer
	- [x] Spark installer
	- [x] Laravel envoy
- **SSH araçları**
	- [x] htop
	- [x] mytop
	- [x] pgtop
	- [x] ngxtop
	- [x] autojump
	- [x] screen
- **Web arayüz araçları**
	- [x] Beanstalkd console - https://github.com/ptrofimov/beanstalk_console
	- [x] Redis Commander - https://github.com/joeferner/redis-commander

### Lisans

Açık kaynaklı olan bu proje [MIT license][mit-url] ile lisanslanmıştır.



[mit-url]: http://opensource.org/licenses/MIT