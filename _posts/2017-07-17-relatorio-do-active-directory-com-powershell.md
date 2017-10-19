---
layout: post
title: Relatório do Active Directory com Powershell
data: Julho de 2017
img_background: img/posts/2017-07-17-relatorio-do-active-directory-com-powershell/banner.jpg
description: Como fazer auditória de Active Directory usando o powershell.
categories:
- Powershell
tags: [Powershell, Scripts]
---

## Active Directory

É sempre bom fazer auditoria dos servidores que você gerencia, para ter tudo documentado, e sempre que necessário já ter tudo pronto, e organizado.
Para facilitar um pouco essa questão eu criei alguns scripts em Powershell para facilitar essa minha tarefa de auditoria, aos poucos vou colocando todos os que eu já criei.
Esse primeiro é um bem simples que é justamente para ter controle dos usuários do `Active Directory`, coletando informações de senha nome, departamento entre outras coisas.

## Ao script

Primeiro antes de mais nada, é preciso definir algumas vaiáveis, então aqui eu estou colocando as variáveis que eu vou utilizar ao decorrer do script.

{% highlight powershell %}
$relatorio = $null
$tabela = $null
$data = Get-Date -format "dd/MM/yyyy"
$arquivo = "user-ad-list.html"
$total = (Get-ADUser -filter *).count # Total de usuários que existem do AD
$dominio = (Get-ADDomain).Forest # Domínio
$analista = "Andrey Glauzer" # Analista
$empresa = "ECOFRESH" # Empresa
{% endhighlight %}

### Importando módulos do powershell

Para poder coletar todas as informações do `AD` vamos utilizar o módulo do powershell, para isso usamos.

{% highlight powershell %}
Import-Module ActiveDirectory
{% endhighlight %}

### Coletando e filtrando resultados

Aqui vamos coletar tudo, filtrando apenas os objetos que eu desejo.

{% highlight powershell %}
$usuarios = @(Get-ADUser -filter * -Properties Company, SamAccountName, Name, Mail, Department, Title, PasswordNeverExpires, Enabled, Created)
{% endhighlight %}

E aqui eu vou selecionar os objetos que eu filtrei.

{% highlight powershell %}
$resultado = @($usuarios | Select-Object Company, SamAccountName, Name, Mail, Department, Title, PasswordNeverExpires, Enabled, Created)
{% endhighlight %}

Vou ordenar o meu resultado pela company.

{% highlight powershell %}
$resultado = $resultado | Sort "Company"
{% endhighlight %}

### Convertendo o resultado para HTML

E converter tudo para HTML.
$tabela += $resultado | ConvertTo-Html -Fragment
Aqui eu vou adicionar a minha personalização, da tabela e o formato que vou utilizar ela.

{% highlight powershell %}
$formatacao=
		"
		<html>
		<body>
		<style>
		BODY{font-family: Calibri; font-size: 12pt;margin: 0;border: 0;color:#2d3643;}
		TABLE{border-collapse: collapse; font-size: 12pt; text-align:center;margin-left:auto;margin-right:auto; width='1000px';}
		TH{border: 1px solid #c1c1c1;background: #0c59a0;padding: 5px;color: white;}
		TD{border: 1px solid rgba(210, 210, 210, 0.95);padding: 5px;}
		.total{padding: 0;font-weight: 300;color: #888;}
		.titulo{border:0 !important;}
		#header h3 {padding: 0;font-weight: 300;color: #888;}
		#header h1 {font-weight: 100 !important;color: #0c59a0;}
		#header a {text-decoration: none;color: #343434;display: inline-block;}
		#header span {font-weight: 700;}
		#header i{color: #0c59a0;font-size:1.5em;}
		footer .fa-heart{color:red;}
		figure {margin: 0;}
		#header a {margin: 0em;text-align: center;vertical-align: middle;}
		.animate {animation-name: LogoAnimate;animation-duration: .9s;}
		@keyframes LogoAnimate {from {transform: scale(0);opacity: 0;  }
		  50% {transform: scale(0);opacity: 0;  }
		  82.5% {transform: scale(1.03);animation-timing-function: ease-out;opacity: 1;}
		  to {transform: scale(1);}}
		   footer {background-color: #0c59a0;color: #FDFDFD;text-align: center;padding: 0.6667em 0;margin-top: 1em;}
		footer a {color:white;}
		</style> 
		"
$titulo=
		"
		<table width='100%' border='0' cellpadding='0' cellspacing='0'>
		<tr>
		<td class='titulo'>
		<header id='header'>
			<a class='teste' href='#'><h1 class='animate'><span>Active Directory - Lista de Usu&aacute;rios</span></h1></a>
			<h3>Empresa: $empresa - Dominio: $dominio - Relatorio: $data - Responsavel: $analista</h3>
		</header>
		</td>
		</tr>
		</table>
		</body>
		</html>
		"
$footer="<footer><span>Feito com muito cafe - Andrey Glauzer @2017</footer>"
{% endhighlight %}

### Formatando o resultado

Agora tenho que juntar tudo o que eu fiz, na ordem que eu desejo.

{% highlight powershell %}
$relatorio = $formatacao + $titulo + $tabela + $footer
{% endhighlight %}

Novamente vou converter tudo para o HTML.

{% highlight powershell %}
$relatorio | Out-File $arquivo -Encoding Utf8
{% endhighlight %}

E também vou salvar o resultado em CSV.

{% highlight powershell %}
$resultado | Sort Company | Export-Csv ad-lista.csv -NoTypeInformation -Encoding Utf8
{% endhighlight %}

---

## Resultado

Com todo o scrip montado, vamos à parte que nos intereça, a execução dele. Para executar é possivel que você precisa habilitar a execução de scripts do powershell, para fazer isso, abra ele em modo de administrador e execute o comando à baixo:

{% highlight powershell %}
Set-ExecutionPolicy RemoteSigned
{% endhighlight %}

Feito isso, partimos para a ação. Ao executar o script ele vai gerar dois arquivos no mesmo diretório onde ele está, um HTML e o outro CSV. Se tudo der certo, devemos receber o seguinte resultado.

![Fluxograma do ambiênte](img/posts/2017-07-17-relatorio-do-active-directory-com-powershell/01.PNG)

---

É possivel ver o script completo no meu github [Andrey Glauzer](https://github.com/andreyglauzer/reletorio-ad){:class='link-exteno'}