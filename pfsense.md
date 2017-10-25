---
layout: default
title: pfSense
permalink: /colecoes/pfsense
description: Configurações e procedimentos referente ao pfSense, e soluções que já apresentei em algumas empresas.
---
<div  class="alert">Olá, se você precisa de auditoria e/ou implantação de Firewall pfSense entre em contato.</div>

{% for pfsense in site.pfsense %}
   <div class="grid__column">
      <article  class="article__posts">
         <header class="article__header">
            <h2 class="article__title">
            	<a class="" title="{{ pfsense.title }}" href="{% if site.baseurl == "/" %}{{ pfsense.url }}{% else %}{{ pfsense.url | prepend: site.baseurl }}{% endif %}">{{ pfsense.title }}</a>
            </h2>
            <div class="article__meta">
            	<span  itemprop="datePublished" content="2017-01-01">Publicado em {{ pfsense.date | date_to_string }} </span><span>por <span itemprop="author">Andrey Glauzer</span></span>
            </div>
         </header>
         <p itemprop="description" class="article__description">
         	<a href="{% if site.baseurl == "/" %}{{ pfsense.url }}{% else %}{{ pfsense.url | prepend: site.baseurl }}{% endif %}" class="" title="{{ pfsense.title }}">{{ pfsense.content | strip_html | truncatewords:50 }}</a>
         </p>
         <div class="article__button">
         	<a  href="{% if site.baseurl == "/" %}{{ pfsense.url }}{% else %}{{ pfsense.url | prepend: site.baseurl }}{% endif %}" class="nuxt-link-button nuxt-link-button--ghost" title="{{ pfsense.title }}">Continue lendo</a>
         </div>
         <!---->
         <figure class="article__image" data-v-7cb2a31e=""><img src="\{{ pfsense.img_background }}"></figure>
      </article>
   </div>
{% endfor %}