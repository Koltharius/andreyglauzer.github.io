---
layout: post
title: Analisando diretórios de sites, http e https
data: Outubro de 2017
img_background: img/posts/2017-10-25-webls-analisando-enderecos-de-sites/01.PNG
description: 'Script para analisar diretorios que um edenreço web possui'
tags: [Segurança, Python]
categories: 
  - Python
---

## WebLS

As vezes para fazer um pentest é necessário analisar o quanto um site está acessível e quais diretórios estão públicos, para ter certeza que dados sensíveis não estejam de fácil acesso.

Então para isso resolvi criar um script em Python, bem simples que varre possíveis diretórios de qualquer site, com base em um wordlist, esse script pode ser um pouco barulhento se caso o domínio possua firewall IPS/IDS.

A sua utilização é bem simples, nada avançado e qualquer um pode instalar e utilizar, para fazer isso basta seguir os passos à baixo:

Faça clone do script.

{% highlight bash %}
git clone https://github.com/andreyglauzer/webls.git
{% endhighlight %}

Acesse o diretório

{% highlight bash %}
cd webls
{% endhighlight %}

Instale as dependências

{% highlight bash %}
Pip install -r requeriments.txt
{% endhighlight %}

Para executar

{% highlight bash %}
webls.py -L wordlist/fast.txt -S testphp.vulnweb.com
{% endhighlight %}

O seu HELP

{% highlight bash %}
[!] Usage: ./webls.py -L [WORDLIST] -S [SITE]

[!] Usage: ./webls.py -L wordlist/wordlist.txt -S google.com

[+] Wordlist: Com mais de 25mil diretórios. Costuma demorar mais.

[+] Fast: Com apenas os diretórios mais conhecidos, resultado rápido.
{% endhighlight %}

Como podem ver, o scritp não tem segredo nenhum é bem fácil de executar, caso queira ver o código fonte, é possível  ver no meu github [https://github.com/andreyglauzer/webls](https://github.com/andreyglauzer/webls).

/end
