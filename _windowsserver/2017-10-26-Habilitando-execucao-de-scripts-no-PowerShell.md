---
layout: post
title: Habilitando execução de scripts no PowerShell
data: Outubro de 2017
img_background: /img/posts/2017-10-26-habilitando-execucao-de-scripts-no-powershell/banner.png
description: 'Mesmo o powershell não deixando você executar os seus scripts, podemos da uma força para que ele aceite todos os scripts.'
tags: [Powershell]
categories: 
  - Scripts
---

Já faz um tempo que estou com um problema para executar scripts em Powershell em Windows Server, mesmo alterando as permissões de script no console, e estando logado como `Administrador`, ele insistia em não me deixar executar scripts, sempre me dando o seguinte erro.

![Fonte da imagem: andreyglauzer.com](/img/posts/2017-10-26-habilitando-execucao-de-scripts-no-powershell/001.PNG)

Quebrei muita a cabeça achando que era um possível problema com os meus scripts, foi então que eu percebi que era um problema do Windows em não deixar executar todos os scripts no modo `Unrestricted`, indiferente da política que foi aplicada para o usuário, o que vai prevalecer é a `Local Group Policy`.

## Alterando a Política de Execução do Grupo Local

Para fazermos isso será necessário abrir o `Local Group Policy Editor`, siga os passo à baixo:

1 – Pressione `Windows + R`

![Fonte da imagem: andreyglauzer.com](/img/posts/2017-10-26-habilitando-execucao-de-scripts-no-powershell/01.PNG)

2 – Vá em `File -> Add Remove Snap In..`

![Fonte da imagem: andreyglauzer.com](/img/posts/2017-10-26-habilitando-execucao-de-scripts-no-powershell/02.PNG)

3 – No Painel esquerdo, encontre `Group Policy Object Editor` e adicione.

![Fonte da imagem: andreyglauzer.com](/img/posts/2017-10-26-habilitando-execucao-de-scripts-no-powershell/03.PNG)

4 – Ele vai pedir uma confirmação, aceite.

![Fonte da imagem: andreyglauzer.com](/img/posts/2017-10-26-habilitando-execucao-de-scripts-no-powershell/04.PNG)

Então, no painel esquerdo, o editor de grupo pode ser expandido. Expanda e navegue até `Computer Configuration -> Administrative Templates -> Windows Components`

![Fonte da imagem: andreyglauzer.com](/img/posts/2017-10-26-habilitando-execucao-de-scripts-no-powershell/05.PNG)

E então vá em `Windows PowerShell`.

![Fonte da imagem: andreyglauzer.com](/img/posts/2017-10-26-habilitando-execucao-de-scripts-no-powershell/06.PNG)

Então selecione `Turn on Script Execution`. Altere a configuração `Enabled`e especifique `Allow all scripts` em `Execution Policy`.

![Fonte da imagem: andreyglauzer.com](/img/posts/2017-10-26-habilitando-execucao-de-scripts-no-powershell/07.PNG)

Confirme clicando `Ok` e feche o Console de Gerenciamento.


Após realizar esses passos, você vai conseguir executar os seus scripts no Powershell normalmente.

/end
