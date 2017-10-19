---
layout: post
title: Fazendo Backup de OST/PST do Outlook
data: Outubro de 2017
img_background: img/posts/2017-10-12-fazendo-backup-de-ost-pst-do-outlook/outlook.jpg
description: Script em python, para fazer backup de arquivos do Outlook tanto como contatos e até OST, convertendo eles para PST
categories:
- Scripts
tags: [Python]
---


### Utilizando

Para fazer Backup dos Contatos/Grupos de contatos do Outlook, caso quando você fizer a troca de perfil e reconfigurar e não ter voltados os contatos, existe uma pequena solução.
Para isso volte à máquina onde está o perfil antigo do Outlook, e faça os procedimentos à baixo.

### Python

Antes de tudo é necessário fazer a instalação do Python, faça download dele (https://www.python.org/downloads/) - Versão 3.6.1.  Não esqueça de marcar a opção (Add python Patch)

### PIP

Após instalar o python é necessário instalar o PIP, para isso vá ao site (https://bootstrap.pypa.io/get-pip.py) e faça download do mesmo, e em seguida vá ao diretório do donwload pelo CMD e execute

{% highlight bash %}
Python get-pip.py
{% endhighlight %}

Após fazer a instalação do PIP é necessário instalar os requerimentos, nesse scrip temos apenas um, o restante é padrão. Então pelo CMD em qualquer diretório execute.

{% highlight bash %}
Pip install pypiwin32
{% endhighlight %}

### Executando

Com tudo instalado, basta acessar o diretório onde está o script e execute.

{% highlight bash %}
python backup-outlook.py
{% endhighlight %}

Deve abrir uma janela do Outlook, onde você deve selecionar o que deseja fazer backup, você pode selecionar todos os e-mails ou somente a caixa o objeto que deseja fazer backup.

![01](https://user-images.githubusercontent.com/4019334/27830268-090bd58a-609c-11e7-820b-8a863816a776.PNG)

Após selecionar o que deseja, basta clicar em OK e em seguida ele já deve iniciar o Backup.
No Outlook:

![02](https://user-images.githubusercontent.com/4019334/27830269-090bdd46-609c-11e7-8721-d59786f6f853.PNG)
 
No CMD:

![03](https://user-images.githubusercontent.com/4019334/27830270-090dcd36-609c-11e7-98fb-500d7ac30faa.PNG)

Basta aguardar o processo de backup. Após acabar basta fazer a importação pelo próprio Outlook, selecionando a opção de pst.

Você pode fazer download do script aqui [https://github.com/andreyglauzer/backup-group-outlook](https://github.com/andreyglauzer/backup-group-outlook)



