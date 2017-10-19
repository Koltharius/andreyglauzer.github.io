---
layout: post
title: Automatizando tarefas diarias com python
data: Julho de 2017
img_background: img\posts\2017-07-14-automatizando-tarefas-diarias-com-python\banner.png
description: Script bem simples que eu desenvolvi, para bater o ponto no meu trabalho.
categories:
- Python
tags: [Scripts, Python]
---


### Como usar o ponto.py

Esse script eu criei pensando em um ambiente Windows, já que no meu trabalho eu uso windows como sistema operacional padrão, e eu sempre acabo me esquecendo, ou as vezes eu tenho preguiça de bater o ponto, então resolvi criar um script para facilitar as coisas.

![Banner](img/posts/2017-07-14-automatizando-tarefas-diarias-com-python/banner.png)

Primeiro você vai precisar instalar o Python em seu computador e também o Pip, a baixo tem o link de como você pode fazer download e as instruções de instalação.

Python - [https://www.python.org/downloads/](https://www.python.org/downloads/){:class='link-exteno'}

Pip - [https://pip.pypa.io/en/stable/installing/](https://pip.pypa.io/en/stable/installing/){:class='link-exteno'}

Com os dois instalados na sua máquina, vamos para a ação. Tentei deixar o mais simples possível, fazendo um screenshot simples da tela e me enviando por e-mail o comprovante do ponto, só para ter guardado comigo.

Dentro da pasta `includes` é possível localizar um arquivo chamado `requirements.txt`

{% highlight python %}
pyscreenshot==0.4
selenium==2.49.0
PyYAML==3.11
time
yaml
image
{% endhighlight %}

Você precisa instalar todos os requerimentos para o script funcionar, então você pode fazer o seguinte.

{% highlight python %}

cd includes
pip install -r requirements.txt

{% endhighlight %}

Após instalação dos requerimentos, vamos ao script. Aqui eu faço a importação de tudo que eu vou usar nele, como email, printscreen etc..

{% highlight python %}
from datetime import date
from email import encoders
from selenium import webdriver
import os, time, smtplib, yaml
import pyscreenshot as ImageGrab
from email.MIMEText import MIMEText
from email.MIMEBase import MIMEBase
from email.MIMEMultipart import MIMEMultipart
{% endhighlight %}

Aqui eu tenho um HELP, onde eu explico como utilizar o script, então se você executar o script sem argumentos você será direcionado para ele, ou se você usar `python3 ponto.py -h`, deve aparecer o help.

{% highlight python %}
MEAJUDA = ("""

Ponto v 2.0 ( Andrey Glauzer - https://andreyglauzer.com )

Use: python ponto.py [Entrada/Saída] <Usuário> <Senha>
Ex: python ponto.py -e andrey 123456

-e  : Especifica que você quer bater a sua entrada no ponto.
-s  : Especifica que você quer bater a sua sáida no ponto.

""")
{% endhighlight %}

Dentro da pasta `includes` também existe um arquivo chamado `config.yml`, que é onde você vai colocar as informações necessárias para o script funcionar, então aqui eu estou chamando o `config.yml` e pegando as informações das variáveis que estão lá.

{% highlight python %}
cur_dir = os.path.dirname(os.path.realpath(__file__))
config_path = os.path.join(cur_dir, 'includes/config.yml')
with open(config_path, 'r') as stream:
data = yaml.load(stream)
PATHDRIVER = data.get('chomedriver','')
SENHAMAIL = data.get('senhadoemail')
EMAIL = data.get('meuemail')
DESTINATARIO = data.get('quemrecebe')
SMTP = data.get('smtpserver')
{% endhighlight %}

Nessa parte do script estou definindo os meus argumentos, para que eu possa armazenar eles em uma variável, e poder utiliza-los ao decorrer co script.

{% highlight python %}
def get_argumentos():
if len(sys.argv) is 4:
return {
'tipo': sys.argv[1],
'user_info': sys.argv[2],
'user_passwd': sys.argv[3],
}
else:
print(MEAJUDA)
sys.exit()
{% endhighlight %}

No site para barter o ponto existe um select, que é necessário selecionar se vou bater a entrada/saida, então para isso que eu uso os argumentos -e = Entrada e -s = Saída, que é justamente aqui, que vamos selecionar o que vamos fazer.

{% highlight python %}
def faztudo(argumento):

print ("[+] - Selecionando a opção desejada...")
if ('{0}'.format(argumento['tipo'])) == '-e':
xpathselect = '//*[@id="form1"]/table/tbody/tr[7]/td[2]/font/select/option[2]'
elif ('{0}'.format(argumento['tipo'])) == '-s':
xpathselect = '//*[@id="form1"]/table/tbody/tr[7]/td[2]/font/select/option[3]'
elif ('{0}'.format(argumento['tipo'])) == '-h':
print (MEAJUDA)
else:
print (MEAJUDA)
{% endhighlight %}

Já aqui entra toda a parte de navegação do browser que no caso eu estou usando o Chrome, então ele entra no site, coloca meu usuário e minha senha, nos campos que eu indiquei de acordo com o nome do input, clica na opção `continuar`, seleciona Entrada/Saída de acordo com a opção que eu selecionei no menu, e depois clica em `confirmar`.

{% highlight python %}
print ("[+] - Abrindo o Chrome...")
options = webdriver.ChromeOptions()
localdochromedriver = PATHDRIVER
options.add_argument("user-data-dir=etc\perfil_chrome")
driver = webdriver.Chrome(executable_path=localdochromedriver, chrome_options=options)
driver.get("http://sac.bind.com.br/ponto/")
#driver.maximize_window()
print ("[+] - Aplicando o seu usuário e senha...")
email = driver.find_element_by_name("nome")
email.send_keys('{0}'.format(argumento['user_info']))
senha = driver.find_element_by_name("id")
senha.send_keys('{0}'.format(argumento['user_passwd']))
driver.find_element_by_name('continuar').click()
print ("[+] - Batendo o seu ponto...")
driver.find_element_by_xpath(xpathselect).click()
driver.find_element_by_name('confirmar').click()
{% endhighlight %}


Aqui eu solicito que ele aguarde um tempo para que a página carregue e o printscreen seje feito no momento exato.

{% highlight python %}
time.sleep(2)
{% endhighlight %}

E então já nessa parte do script eu tiro o screenshot da tela e a salvo em `includes/screenshots/`

{% highlight python %}
print ("[+] - Tirando uma screenshot do seu ponto...")
date = (time.strftime("%Y-%m-%d"))
img = ImageGrab.grab()
img.save("includes/screenshots/{0}_meuponto_{1}.jpg".format(date, USERNAME))
envemail(driver)
{% endhighlight %}

E por fim, entra toda a parte do script que envia o email, de acordo com as informações que você colocou no `config.yml`, anexando o printscreen, que é o nosso comprovante de ponto.

{% highlight python %}
def envemail(driver):
print ("[+] - Localizando o seu print...")
imgpatch = ("includes/screenshots/{0}_meuponto_{1}.jpg".format(date, USERNAME))
print ("[+] - Organizando o email p/ ser enviado...")
msg = MIMEMultipart()
msg['From'] = (EMAIL)
msg['To'] = (DESTINATARIO)
msg['Subject'] = 'Meu ponto do dia %s' % date
body = '''
=================================================================

NOME DA IMAGEM DO PONTO :%s

PONTO DO DIA:%s

=================================================================
''' % (imgpatch, date)

msg.attach(MIMEText(body, 'plain'))
filename = (imgpatch)
attachment = open(imgpatch, "rb")
part = MIMEBase('application', 'octet-stream')
part.set_payload((attachment).read())
encoders.encode_base64(part)
part.add_header('Content-Disposition', "attachment; filename= %s" % filename)
msg.attach(part)
server = smtplib.SMTP(SMTP, 587)
server.starttls()
print ("[+] - Enviando o seu email...")
server.login(EMAIL, SENHAMAIL)
text = msg.as_string()
server.sendmail(EMAIL, DESTINATARIO, text)
print ("[+] - E-mail enviado com sucesso!")
{% endhighlight %}

Enquanto o scritp é executado você consegue ver o que está sendo feito, como o log à baixo:

{% highlight python %}
PS C:\Users\andrey\Documents\GitHub\ponto> python .\ponto.py -e usuarioteste senhateste
[+] - Selecionando a opção desejada...
[+] - Abrindo o Chrome...
[+] - Aplicando o seu usuário e senha...
[+] - Batendo o seu ponto...
[+] - Localizando o seu print...
[+] - Organizando o email p/ ser enviado...
[+] - Enviando o seu email...
[+] - E-mail enviado com sucesso!
{% endhighlight %}

Por fim é isso, não tive problema usando ele no Windows 10!
