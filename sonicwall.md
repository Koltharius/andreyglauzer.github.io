---
layout: default
title: SonicWall
permalink: /colecoes/sonicwall
description: Um pouco mais sobre novas coisas que estou aprendendo sobre o SonicWall, e sistuações que venho enfrentando.
---
<div  class="alert">Olá, se você precisa de auditoria e/ou implantação de Firewall SonicWall entre em contato.</div>

{% for sonicwall in site.sonicwall %}
   <div class="grid__column">
      <article  class="article__posts">
         <header class="article__header">
            <h2 class="article__title">
            	<a class="" title="{{ sonicwall.title }}" href="{% if site.baseurl == "/" %}{{ sonicwall.url }}{% else %}{{ sonicwall.url | prepend: site.baseurl }}{% endif %}">{{ sonicwall.title }}</a>
            </h2>
            <div class="article__meta">
            	<span  itemprop="datePublished" content="2017-01-01">Publicado em {{ sonicwall.date | date_to_string }} </span><span>por <span itemprop="author">Andrey Glauzer</span></span>
            </div>
         </header>
         <p itemprop="description" class="article__description">
         	<a href="{% if site.baseurl == "/" %}{{ sonicwall.url }}{% else %}{{ sonicwall.url | prepend: site.baseurl }}{% endif %}" class="" title="{{ sonicwall.title }}">{{ sonicwall.content | strip_html | truncatewords:50 }}</a>
         </p>
         <div class="article__button">
         	<a  href="{% if site.baseurl == "/" %}{{ sonicwall.url }}{% else %}{{ sonicwall.url | prepend: site.baseurl }}{% endif %}" class="nuxt-link-button nuxt-link-button--ghost" title="{{ sonicwall.title }}">Continue lendo</a>
         </div>
         <!---->
         <figure class="article__image" data-v-7cb2a31e=""><img src="\{{ sonicwall.img_background }}"></figure>
      </article>
   </div>
{% endfor %}