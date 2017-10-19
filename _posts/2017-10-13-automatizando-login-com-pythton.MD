---
layout: post
title: Automatizando Login com Python
data: Outubro de 2017
img_background: img\posts\2017-07-14-automatizando-tarefas-diarias-com-python\banner.png
description: Fazendo login em uma página do Citrix, com python.
categories:
- Python
tags: [Scripts]
---

---
## Executando o Auto Login

Antes de mais nada precisamos instalar tudo que vamos utilizar para que o script funcione, eu utilizo linux, mas você pode procurar no Google como fazer a instalação dos mesmo em Windows, caso esteja utilizando um.

{% highlight bash %}
sudo yum -y install ipython python-pip python-yaml git
mkdir /root/bin 
cd /root/bin 
wget https://github.com/mozilla/geckodriver/releases/download/v0.9.0/geckodriver-v0.9.0-linux64.tar.gz 
tar -xvzf geckodriver-v0.9.0-linux64.tar.gz
rm geckodriver-v0.9.0-linux64.tar.gz 
chmod +x geckodriver 
cp geckodriver wires 
export PATH=$PATH:/root/bin/wires
export PATH=$PATH:/root/bin/geckodriver
{% endhighlight %}

Agora clone o repositório e instale as dependências do script.

{% highlight python %}
git clone https://github.com/andreyglauzer/hacktools.git
cd autologin
pip install requirements.txt
{% endhighlight %}

Feito tudo isso, basta você fazer as alterações no código de acordo da maneira que você vai utilizar.

### Secrets.yml

Nesse arquivo você precisa colocar o seu usuário e sua senha.

{% highlight python %}
password: sua senha
user: seu usuario
{% endhighlight %}

### autlogin.py

O selenium por padrão toda vez que é executado cria um perfil temporário do navegador, o problema nisso é que ele não salva as permissões e edições que você já fez no seu navegador, se você quiser, você pode definir qual perfil você deseja usar.

Para saber qual é o perfil default, ou seja aquele que sempre abre para você, basta executar

{% highlight bash %}

ls -d /home/$USER/.mozilla/firefox/*default

{% endhighlight %}

Se tudo der certo a linha deve ficar assim.

{% highlight bash %}
profile = webdriver.FirefoxProfile('/root/.mozilla/firefox/20r2dk1e.default')
{% endhighlight %}

Em seguida você precisa definir qual é o site.

{% highlight python %}
driver.get("https://citrix.censo-nso.com.br/vpn/")
{% endhighlight %}

Determinar qual é o ID do input do usuario e da senha.

{% highlight python %}
email = driver.find_element_by_id("Enter user name")
senha = driver.find_element_by_id("passwd")
{% endhighlight %}

E para finalizar, colocar o que está escrito no botão que deve ser pressionado pelo código, sou seja ele vai ter a ação de click.

{% highlight python %}
driver.find_element_by_link_text("Presenca").click()
{% endhighlight %}

Caso queria criptografar a senha, use cryptography

{% highlight python %}
>> from cryptography.fernet import Fernet
>> keypasswd = Fernet.generate_key()
>> f = Fernet(keypasswd)
>> keypasswd = f.encrypt(PASSWORD)
>> gAAAAABZKH8I3hunz1BEKoG4MX5E-SkkJ2r7cjvTw6LBYqhgK-l92fYn79uN81k-PL1MTomWXU6HJ-nT_A4Um1tlImkqWTpWnQ==

>> descryptpasswd = f.decrypt(keypasswd)
>> teste
{% endhighlight %}

Para descriptografar a mesma

{% highlight python %}
descryptpasswd = f.decrypt(keypasswd)
{% endhighlight %}

Logo nosso script ficaria da seguinte maneira

{% highlight python %}
cur_dir = os.path.dirname(os.path.realpath(__file__))
secret_path = os.path.join(cur_dir, 'secrets.yml')

with open(secret_path, 'r') as stream:
data = yaml.load(stream)
USERNAME = data.get('user','')
PASSWORD = data.get('password')

descryptpasswd = f.decrypt(PASSWORD)

profile = webdriver.FirefoxProfile('/root/.mozilla/firefox/20r2dk1e.default')
driver = webdriver.Firefox()
driver.get("https://citrix.com.br/vpn/")
    time.sleep(5)
    assert "NetScaler Gateway" in driver.title
    driver.maximize_window()
    time.sleep(5)

email = driver.find_element_by_id("Enter user name")
email.send_keys(USERNAME)
senha = driver.find_element_by_id("passwd")
senha.send_keys(descryptpasswd)
senha.send_keys(Keys.RETURN)
time.sleep(5)
driver.find_element_by_link_text("Presenca").click()

quit()
{% endhighlight %}

Caso esteja tento dificuldade para instalar algumas dependências, e esteja retornando erro `gcc: error: /usr/lib/rpm/redhat/redhat-hardened-cc1: No such file or directory`, execute os camandos abaixo.

{% highlight bash %}
sudo yum update
sudo dnf install redhat-rpm-config
{% endhighlight %}

## O projeto

Você pode encontrar o projeto em [https://github.com/andreyglauzer/autologin](https://github.com/andreyglauzer/autologin)