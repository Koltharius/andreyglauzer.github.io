---
layout: default
title: Sistemas Linux
permalink: /colecoes/linux
description: Administração e configurações de Servidores/Desktops Linux, e sistuações que já enfrentei mediante ao mesmo.
---

{% for linux in site.linux %}
   <div class="grid__column">
      <article  class="article__posts">
         <header class="article__header">
            <h2 class="article__title">
            	<a class="" title="{{ linux.title }}" href="{% if site.baseurl == "/" %}{{ linux.url }}{% else %}{{ linux.url | prepend: site.baseurl }}{% endif %}">{{ linux.title }}</a>
            </h2>
            <div class="article__meta">
            	<span  itemprop="datePublished" content="2017-01-01">Publicado em {{ linux.date | date_to_string }} </span><span>por <span itemprop="author">Andrey Glauzer</span></span>
            </div>
         </header>
         <p itemprop="description" class="article__description">
         	<a href="{% if site.baseurl == "/" %}{{ linux.url }}{% else %}{{ linux.url | prepend: site.baseurl }}{% endif %}" class="" title="{{ linux.title }}">{{ linux.content | strip_html | truncatewords:50 }}</a>
         </p>
         <div class="article__button">
         	<a  href="{% if site.baseurl == "/" %}{{ linux.url }}{% else %}{{ linux.url | prepend: site.baseurl }}{% endif %}" class="nuxt-link-button nuxt-link-button--ghost" title="{{ linux.title }}">Continue lendo</a>
         </div>
         <!---->
         <figure class="article__image" data-v-7cb2a31e=""><img src="\{{ linux.img_background }}"></figure>
      </article>
   </div>
{% endfor %}