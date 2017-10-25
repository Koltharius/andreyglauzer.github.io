---
layout: post
title: 'Como criar regras no SonicWall'
data: Julho de 2017
img_background: img/posts/2017-07-11-criando-regras-de-redirecionamento-no-sonicwall/banner.jpg
description: 'Passo-a-passo de como criar regras de redireicionamento de portas em um SonicWall SOHO'
categories:
- SonicWall
tags: [SonicWall, Firewall]
---


## O SonicWall

A minha ideia é fazer uma série de posts falando um pouco sobre o SonicWall da dell, que eu utilizo bastante no ambiente do meu trabalho e, para começar vou explicar como fazer um redirecionamento de portas.

O ambiente que temos é o seguinte, o SonicWall modelo SOHO com o IP 192.168.0.1 de LAN, WAN 10.0.0.10 e um servidor com o endereço IP 192.168.0.20, que vamos fazer acesso via TS (Terminal Service) externo, utilizando a porta 4041 para chegar no servidor na porta 3389 que é padrão da Microsoft.

![Fluxograma do ambiênte](/img/posts/2017-07-11-criando-regras-de-redirecionamento-no-sonicwall/17.png)

 
Então para começar, antes de mais nada você precisa acessar o painel administrativo do SonicWall, para isso acesse ele usando o endereço de LAN ou WAN caso esteja externo, como estou na rede, vou acessar pela LAN.

![Página de Login](/img/posts/2017-07-11-criando-regras-de-redirecionamento-no-sonicwall/01.PNG)

Após fazer o login e entrar na área administrativa, precisamos criar um Objeto para o servidor. O SonicWall funciona quase como um LEGO, é necessário você ter todas as peças para fazer qualquer coisa, dessa maneira vamos ter que criar o Objeto do servidor e o Objeto das portas.
Começando pelo o servidor vamos em Network > Addres Objects e clique em Add...

![Página Inicial Sonic - Criando Objeto](/img/posts/2017-07-11-criando-regras-de-redirecionamento-no-sonicwall/02.PNG)
 
Ao clicar em Add.. deve abrir uma janela pequena, onde você deve preencher as informações do servidor, lembrando que para fazer uma regra de redirecionando só é possível utilizando o IP não vai funcionar colocando o MAC da placa de rede.
Então coloque um nome, defina (Zone Assignment) como LAN e o (Type) como Host já em (IP Address) coloque o IP do nosso servidor.
 
![Página Inicial Sonic - Criando Objeto](/img/posts/2017-07-11-criando-regras-de-redirecionamento-no-sonicwall/03.PNG)

Após preencher deve ficar conforme a imagem à baixo:
 
![Página Inicial Sonic - Criando Objeto](/img/posts/2017-07-11-criando-regras-de-redirecionamento-no-sonicwall/04.PNG)

Após criar o Objeto do servidor precisamos agora criar os Objetos das portas que vamos utilizar, por padrão o SonicWall vem com todas as portas bloqueadas e então precisamos especificar qual vamos utilizar, criando os seus objetos e criando uma regra para liberar essas portas.
Então para criar os Objetos das portas vamos em Network > Services > Add..
 
![Página Inicial Sonic - Criando Objeto](/img/posts/2017-07-11-criando-regras-de-redirecionamento-no-sonicwall/05.PNG)

Após clicar em Add.. vai abrir uma janela, e nela você precisa preencher as informações, como o nome para identificação, a porta ou range que vai ser utilizado e o protocolo que será usado.
 
![Página Inicial Sonic - Criando Objeto](/img/posts/2017-07-11-criando-regras-de-redirecionamento-no-sonicwall/06.PNG)

![Página Inicial Sonic - Criando Objeto](/img/posts/2017-07-11-criando-regras-de-redirecionamento-no-sonicwall/07.PNG)
 
Com os Objetos das portas criados, agora vamos à parte em que será criada a regra especificando que, ao tentar acessar pelo IP 10.0.0.10 na porta 4041 utilizando TS (Terminal Service) ele me redirecione para o IP de LAN 192.168.0.20 na porta 3389.

Para isso vamos em Network > NAT Polices > Add..


![Página Inicial Sonic - Criando Objeto](/img/posts/2017-07-11-criando-regras-de-redirecionamento-no-sonicwall/08.PNG)

E configurando da seguinte maneira utilizando todos os Objetos que já criamos, que é o _TESTE, _PORTA_4041 e _PORTA_3389.

Então em (Original Source) deixamos como Any, aqui estou especificando que qualquer IP pode fazer essa solicitação, (Translated Source) deixamos como Original, que vamos utilizar o método de redirecionamento padrão, em (Original Destination) deixamos como ALL WAN IP, especificando que qualquer IP de WAN pode fazer a solicitação, em (Translated Destination) colocamos _TESTE que é o objeto do servidor, no caso 193.168.0.20, em (Original Service) deixamos como _PORT_4041 que é a nossa porta 4041 já em (Translated Service) deve ser selecionado _PORT_3389 que é a nossa porta 3389 de LAN, feito tudo isso precisamos apenas salva nossas configurações.
 
![Página Inicial Sonic - Criando Objeto](/img/posts/2017-07-11-criando-regras-de-redirecionamento-no-sonicwall/09.PNG)

Após feito tudo isso, precisamos “Liberar” as portas que vamos utilizar. Para isso vá em Firewall > Access Rules > Matrix > WAN para LAN.

![Página Inicial Sonic - Criando Objeto](/img/posts/2017-07-11-criando-regras-de-redirecionamento-no-sonicwall/13.PNG)
  
Na próxima página clique em Add..

![Página Inicial Sonic - Criando Objeto](/img/posts/2017-07-11-criando-regras-de-redirecionamento-no-sonicwall/14.PNG)
 
Ao clicar em Add.. vamos especificar as portas pelas quais vamos fazer acesso de WAN para LAN, especificando em (Service) a porta, como vamos utilizar duas portas então precisamos criar para as duas.
 
![Página Inicial Sonic - Criando Objeto](/img/posts/2017-07-11-criando-regras-de-redirecionamento-no-sonicwall/15.PNG)

![Página Inicial Sonic - Criando Objeto](/img/posts/2017-07-11-criando-regras-de-redirecionamento-no-sonicwall/16.PNG)
 

Agora está tudo configurado, precisamos apenas testar para nos certificarmos que está tudo funcionando.

![Página Inicial Sonic - Criando Objeto](/img/posts/2017-07-11-criando-regras-de-redirecionamento-no-sonicwall/10.PNG)

![Página Inicial Sonic - Criando Objeto](/img/posts/2017-07-11-criando-regras-de-redirecionamento-no-sonicwall/11.PNG)
 
Pronto, aparecendo a tela para fazer Login já significa que temos acesso.
