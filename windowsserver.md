---
layout: default
title: Windows Server
permalink: /colecoes/windowsserver
description: Administração, configuração e gerencimando de Servidores Windows, o melhor para trabalhar com client.
---
<div  class="alert">Olá, se você precisa de auditoria e/ou implantação de servidor Windows entre em contato.</div>

{% for windowsserver in site.windowsserver %}
   <div class="grid__column">
      <article  class="article__posts">
         <header class="article__header">
            <h2 class="article__title">
            	<a class="" title="{{ windowsserver.title }}" href="{% if site.baseurl == "/" %}{{ windowsserver.url }}{% else %}{{ windowsserver.url | prepend: site.baseurl }}{% endif %}">{{ windowsserver.title }}</a>
            </h2>
            <div class="article__meta">
            	<span  itemprop="datePublished" content="2017-01-01">Publicado em {{ windowsserver.date | date_to_string }} </span><span>por <span itemprop="author">Andrey Glauzer</span></span>
            </div>
         </header>
         <p itemprop="description" class="article__description">
         	<a href="{% if site.baseurl == "/" %}{{ windowsserver.url }}{% else %}{{ windowsserver.url | prepend: site.baseurl }}{% endif %}" class="" title="{{ windowsserver.title }}">{{ windowsserver.content | strip_html | truncatewords:50 }}</a>
         </p>
         <div class="article__button">
         	<a  href="{% if site.baseurl == "/" %}{{ windowsserver.url }}{% else %}{{ windowsserver.url | prepend: site.baseurl }}{% endif %}" class="nuxt-link-button nuxt-link-button--ghost" title="{{ windowsserver.title }}">Continue lendo</a>
         </div>
         <!---->
         <figure class="article__image" data-v-7cb2a31e=""><img src="{{ windowsserver.img_background }}"></figure>
      </article>
   </div>
{% endfor %}