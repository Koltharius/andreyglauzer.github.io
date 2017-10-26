---
layout: post
title: Monitorando SonicWall com Zabbix
data: Outubro de 2017
img_background: /img/posts/2017-10-10-monitorando-sonicwall-com-zabbix/Zabbix-Banner.jpg
description: É isso ai, vou mostrar como podemos monitorar o SonicWall via SNMP utilizando o Zabbix.
categories:
- Zabbix
tags: [SonicWall, Zabbix, SNMP]
---


## SonicWall & Zabbix

Se você trabalha com gerenciamento de Redes, o monitoramento se torna algo essencial na sua vida, para que você possa prevenir e acompanhar erros/problemas que venha acontecer na sua rede.

Hoje eu vou mostrar para você como monitorar o SonicWall via SNMP no Zabbix. Para quem não sabe SNMP é um protocolo para gerenciar equipamentos e tem como finalidade disponibilizar um caminho simples e rápido para monitorar ativos, usando suas OIDs. Se você ficou curioso, recomendo que pesquise mais sobre SNMP.

No SonicWall é possível monitorar várias informações via SNMP, como CPU, RAM, taxa de transferências das portas de internet entre outras coisas.

## SonicWall
### Ativando SNMP
Na Interface de gerenciamento do SonicWall vá em Sytem>SNMP e marque como Enable o SNMP. 

![SonicWall](/img/posts/2017-10-10-monitorando-sonicwall-com-zabbix/01.PNG)

Logo após fazer isso, clique no botão configure, e defina os valores como à baixo, no caso o “Get Community name” eu deixei como public que é mais usado, mas você pode por uma senha qualquer, que depois você vai precisar estabelecer no template do Zabbix.

![SonicWall](/img/posts/2017-10-10-monitorando-sonicwall-com-zabbix/02.PNG)

### Liberando SNMP na interface
Após ativar o SNMP, você precisa verificar se o SNMP está liberado na interface que deseja usar, como aqui eu vou monitorar somente a rede interna, não se faz a necessidade de liberar nas interfaces de WAN, então eu vou liberar somente na X0.

![SonicWall](/img/posts/2017-10-10-monitorando-sonicwall-com-zabbix/03.PNG)

Para verificar se está liberado ou não, vai em NetWorking  > Interfaces e clique em editar na interface que deseja liberar, no meu caso é a X0.

![SonicWall](/img/posts/2017-10-10-monitorando-sonicwall-com-zabbix/04.PNG)

## Zabbix
Agora já no Zabbix, precisamos importar um template que eu fiz download na comunidade do Zabbix, mas que você também pode baixar ele aqui.

### Importando Template
Para fazer a importação, você precisa ir em Configuração > Templates.

![SonicWall](/img/posts/2017-10-10-monitorando-sonicwall-com-zabbix/05.PNG)

Logo após clique em importar.

![SonicWall](/img/posts/2017-10-10-monitorando-sonicwall-com-zabbix/06.PNG)

Selecione o template que você fez download e clique em importar.

### Criando Host do SonicWall

Com o template já importado, será necessário configurar o Host, para isso você deve ir em Configurações > Hosts e clique em Criar.
Defina um nome, coloque em um grupo que deseja, e em SNMP coloque o IP do seu SonicWall, conforme a imagem à baixo.

![SonicWall](/img/posts/2017-10-10-monitorando-sonicwall-com-zabbix/07.PNG)

### Selecionando Template no host
Depois clique em Template, e adicione o “SonicWall SNMP – Standart”, feito isso será necessário salvar as informações e acompanhar o seu monitoramento.

![SonicWall](/img/posts/2017-10-10-monitorando-sonicwall-com-zabbix/08.PNG)

## Gráfico de conexões


![SonicWall](/img/posts/2017-10-10-monitorando-sonicwall-com-zabbix/09.PNG)

## Gráfico de CPU


![SonicWall](/img/posts/2017-10-10-monitorando-sonicwall-com-zabbix/11.PNG)

## Gráfico de entrada e saída WAN


![SonicWall](/img/posts/2017-10-10-monitorando-sonicwall-com-zabbix/12.PNG)

## Alerta de monitoramento.


![SonicWall](/img/posts/2017-10-10-monitorando-sonicwall-com-zabbix/13.PNG)