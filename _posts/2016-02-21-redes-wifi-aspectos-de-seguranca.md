---
layout: post
title: "Redes Wi-Fi e seus aspectos de segurança"
date: 2016-02-27 17:50:55
image:
   url: img/posts/2016-02-21-redes-wifi-aspectos-de-seguranca/Essential-Guide.png
description: 'Alguns aspectos de segurança em redes Wireless'
tags:
- Dicas
categories:
- Segurança
---


O mundo da tecnologia está cada vez mais exigente e solicitando novos recursos ou métodos para se conectar. E cada vez mais necessitamos de informações de forma dinâmica e rápida, para que possamos acessá-la de maneira eficiente em qualquer lugar ou qualquer hora, por esse motivo, foram criadas redes sem fio, que facilitam o acesso e simplifica muitas atividades.

![Fonte da imagem: gadgetmeetsguy.com](/img/posts/2016-02-21-redes-wifi-aspectos-de-seguranca/redes01.jpg)

Como se trata de uma tecnologia mais complexa a ser montada ou estruturada dentro de uma rede LAN, ou até mesmo em redes MAN, exigem mais cuidado e atenção para ser montadas, que se caso não forem bem configuradas podem deixar vulnerabilidades, dando a liberdade para pessoas que não tenham acesso a essa rede, o direito de ir e vim quando quiser, colocando dados e informações importantes para você e para demais usuários dessa rede em risco. Então vamos conhecer um pouco mais sobre segurança e seus aspectos da rede wireless.


### Tipos de Criptografia SSID


Quando se adquiri um novo roteador, e o liga pela primeira vez, pouco importa como será configurada a segurança dessa rede, você simplesmente coloca uma senha e acha que está seguro. Criptografia em redes sem fio é extramamente essencial, para que todas as informações que trafegam pelo ar não seja interceptadas ou acessadas facilmente por usuários não permitidos. Em redes Wi-Fi, sem uma segurança devida, é possivel que outros usuários tenha acesso direto a informoções que trafegam nessa rede, podendo assim capturar informações, inclusive senhas. Quando alguém seguestrar a sua rede para poder fazer seus hijinks ilegais, será na sua porta que a policia irá bater. Entender as diferenças entre protocolos de criptografia e implementar isso em seu roteador, pode te deixar mais seguro.

###  WEP – Wireless Encripted Protection


WEP (802.11b WEP/802.1x) é o algoritmo de segurança Wi-Fi mais utilizado no mundo. Pelo simples fato da compatibilidade com versões anteriores e, de que ele é a primeira opção que aparece para você, quanto está configurando o seu roteador.

WEP foi ratificado como um padrão de segurança Wi-Fi em setembro de 1999. As primeiras versões do WEP não foram particularmente fortes, mesmo para a época em que foram lançados, porque a restrição norte-americana sobre a exportação de vários tipos tecnologia criptográfica levou a fabricantes restringindo seus dispositivos para apenas encriptação de 64 bits. Quando as restrições foram levantadas, foi aumentada para 128 bits. Apesar da introdução de criptografia WEP de 256 bits, 128 bits continua sendo uma das implementações mais comuns.

Apesar de revisões do algoritmo e um aumento do tamanho da chave, com o tempo numerosas falhas de segurança foram descobertas no padrão WEP e, como o poder de computação aumentou, tornou-se mais fácil para explorá-los. Já em 2001 foi a prova que esse tipo de criptografia é facilmente ‘burlada’, quando o FBI fez uma pequena demonstração pública, onde eles quebraram senhas WEP em minutos usando o software disponível gratuitamente.

Apesar de várias melhorias, como contorná-las, e outras tentativas para escorar o sistema WEP, permanece altamente vulnerável e sistemas que dependem de WEP deve ser atualizado ou, se atualizações de segurança não são uma opção, substituído. A Wi-Fi Alliance se aposentou oficialmente WEP em 2004.

### WPA – Wi-Fi Protected Access

WPA (802.11a/g WEP/802.1x/WPA) foi uma resposta rápida a demonstração feita pelo FBI em 2001, quanto ás vulnerabilidades cada vez mais aparentes do padrão WEP. Ela foi formalmente adaptada em 2003, um ano antes da WEP ser oficialmente descontinuada. Hoje a configuração mais comum utilizando WPA é WPA-PSK (Pre-Shared Key). Com a utilização de 256bits é um aumento significativo em comparação do WPA que possuía apenas 64bis e 128bits.

Aconteceram mudanças significativas implementadas em WPA, como a verificação da integridade da mensagem, para poder determinar se um intruso tinha capturada ou alterados algum dos pacotes passados entre o ponto de acesso e o cliente e Temporal Key Integrity Protocol (TKIP) emprega um sistema de chaves por pacote que foi radicalmente mais seguro do que a tecla fixa utilizada no sistema WEP. TKIP foi mais tarde substituído pelo Advanced Encryption Standard (AES).

### WPA2 – Wi-Fi Protected Access II

WPA em 2006, foi oficialmente substituída pela WPA2 (802.11i WEP/WPA/RSN AES,Ad-Hoc, etc). Uma das mudanças mais significativas entre WPA e WPA2 foi o uso obrigatório de algoritmos AES e a introdução de CCMP (Counter Cipher Mode with Block Chaining Message Authentication Code Protocol), como um substituto para TKIP que ainda foi preservada em WPA2 como um sistema de contingência e para interoperabilidade com WPA).

Atualmente, com a utilização de WPA2 requer que o invasor já tem acesso à rede Wi-Fi garantido a fim de ter acesso a certas informações e, em seguida, podendo assim fazer alguns ataques a outros usuários da mesma rede. Como tal, as implicações das vulnerabilidades de segurança WPA2 conhecidas são bem poucas, e difícil mente são utilizadas em redes domésticas seus principais alvos são redes empresarias.


### Problemas de instação utilizando configurações padrão


A utilização de roteadores em redes domésticas está cada vez mais comum. Hoje quase todo mundo tem um ponto de internet em sua residência com uma rede sem fio wireless. Apesar do crescimento continuo desse tipo de tecnologia, ainda existem pessoas que não tem um conhecimento profundo sobre o assunto, e acaba optando pelas configurações padrões do roteador ou que a sua operadora de internet propõe.

![Fonte da imagem: windows.microsoft.com](/img/posts/2016-02-21-redes-wifi-aspectos-de-seguranca/redes02.png)

E com isso, sem o devido conhecimento sobre o seu próprio aparelho, muitas vezes o usuário acaba que impondo certos problemas que podem se ocasionar em sua rede na operadora. Problemas pequenos como alteração do SSID ou senha, que está sendo utilizada na rede.  

### Problemas de Instalação


Quando não se conhece o tipo de equipamento que está sendo utilizado, você pode encontra dificuldade com a instalação ou configurações do seu roteador, assim podendo deixar um seu equipamento e sua rede mais vulnerável a possíveis ataques, que podem ocorrer. Como por exemplo:

- O comutador do seu adaptador de rede sem fio não está habilitado.

- Chaves de segurança ou senhas WEP, WPA e WPA2, que podem trazer problemas.

- Cabos que não estão conectados corretamente.

- Drivers do adaptador ou placa wireless, ou até mesmo driver da placa NIC.

- Mal configuração da rede.

- Problemas com seus hardwares.

Você pode se deparar com diversos problemas de instalação, e para todos é possível encontra uma solução clara e objetiva, que podem variar dependendo do sistema operacional que está sendo utilizado ou o equipamento que está tentando configurar, podendo pôr a sua rede em total funcionamento.


### Problemas associados a falta de planejamento e organização


Quando uma rede ela é mal estruturada ou pouco planejada pode causar muitos efeitos colaterais com o desenvolver da infraestrutura e, no meio do caminho você pode encontrar problemas que podem ocasionar ou dificultar a comunicação com demais hardwares dessa mesma rede.

Assim fica evidente que é necessário estudar bem toda a instalação dessa rede mesmo antes de que seja feito qualquer tipo de mudança no local ou a compra de hardwares, é fundamental você conhecer o seu ambiente de trabalho, antes que seja aplicada tais mudanças.

Você pode encontrar diversos problemas, de operadora de internet, que oferece um serviço que não sai como esperado, ou que a operadora em questão não era a qual você planejava utilizar, a interferências de sinais, que são ocasionadas por obstáculos existentes entre as suas redes de comunicação.

Então antes de qualquer mudança em sua instalação, é necessário um estudo, do ambiente, assim com uma estrutura estudada e bem organizada, dificilmente você encontrará problemas com essa rede ou até mesmo lentidão, e assim não terá que se preocupar por um bom tempo com a sua rede interna.

### Conclusão

Redes sem fio são alternativas interessantes em diversos tipos de aplicações, já que dependendo das circunstâncias ou local, a rede sem fio não é um meio de comunicação viável. Porem como qualquer outro tipo de conexão requer um estudo, para ser bem estruturada e para que seja segura tanto para seus usuários ou seus visitantes.  

Apesar de ser um tipo de conexão muito utilizado em redes domesticas ou corporativas, ainda é muito utilizado criptografias tipo WAP, que não traz  segurança para qualquer tipo de ambiente, sendo capaz de ser burlada facilmente com softwares distribuídos na internet, uma criptografia ótima para ser utilizada seria WPA2.

Além da implementação do WPA2 é necessário conhecer bem as configurações do seu roteador, podendo assim contar com outras medidas de segurança, como deixar o seu SSID invisível, desativar broadcast, entre outros. Porque foi possível ver que uma rede wireless é muito boa mesmo utilizando em outros tipos de topologia, podendo assim agradar demais usuários da mesma rede.  

A tecnologia hoje é focada em redes sem fio, usada entre as pessoas para obterem notícias a todo momento ou informações de última hora, enquanto vai para sua residência, utilizando celulares ou tablets, existindo muitos meios de sofrer ataques dentro dessas redes podendo ter perda de dados, por isso deve-se ter muito cuidado com a maneira que você configura a sua rede e quem tem acesso a ela.

### Referências

[Computer Networking: A Top-Down Approach (6th Edition)](http://www.amazon.com/Computer-Networks-Edition-Andrew-Tanenbaum/dp/0132126958)
[Mecanismos de Segurança de Redes IEEE 802.11: WEP, WPA, WPA2 e IEEE](http://homes.dcc.ufba.br/~joaotj/OUTROS/Pdf_italo/UFPEAGL.pdf)

-----
Viu algum erro ou gostaria de adicionar alguma sugestão a essa matéria? Comente.
