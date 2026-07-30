{**
 * templates/frontend/components/header.tpl
 *
 * Copyright (c) 2014-2020 Simon Fraser University
 * Copyright (c) 2003-2020 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief Common frontend site header.
 *}

{* Determine whether a logo or title string is being displayed *}
{assign var="showingLogo" value=true}
{if !$displayPageHeaderLogo}
	{assign var="showingLogo" value=false}
{/if}

{capture assign="homeUrl"}{url page="index" router=\PKP\core\PKPApplication::ROUTE_PAGE}{/capture}
{assign var="homeUrl" value=$homeUrl|strip}

{* Logo or site title. Only use <h1> heading on the homepage.
	 Otherwise that should go to the page title. *}
{if $requestedOp == 'index'}
	{assign var="siteNameTag" value="h1"}
{else}
	{assign var="siteNameTag" value="div"}
{/if}

{* Determine whether to show a logo of site title *}
{capture assign="brand"}{strip}
	{if $displayPageHeaderLogo}
		<img src="{$publicFilesDir}/{$displayPageHeaderLogo.uploadName|escape:"url"}"
		     {if $displayPageHeaderLogo.altText != ''}alt="{$displayPageHeaderLogo.altText|escape}"
		     {else}alt="{translate key="common.pageHeaderLogo.altText"}"{/if}
				 class="img-fluid">
	{elseif $displayPageHeaderTitle}
		<span class="navbar-logo-text">{$displayPageHeaderTitle|escape}</span>
	{else}
		<img src="{$baseUrl}/templates/images/structure/logo.png" alt="{$applicationName|escape}" class="img-fluid">
	{/if}
{/strip}{/capture}

<!DOCTYPE html>
<html lang="{$currentLocale|replace:"_":"-"}" xml:lang="{$currentLocale|replace:"_":"-"}">
{if !$pageTitleTranslated}{capture assign="pageTitleTranslated"}{translate key=$pageTitle}{/capture}{/if}
{include file="frontend/components/headerHead.tpl"}
<body dir="{$currentLocaleLangDir|escape|default:"ltr"}">

{* Header *}
<header class="main-header">
	<div class="ajlii-publisher-bar">
		<div class="container ajlii-publisher-inner">
			<a class="ajlii-publisher-mark" href="{$homeUrl|escape}" aria-label="{translate key="plugins.themes.ajlii.publisher"}">
				<span class="ajlii-publisher-name">CUUL</span>
				<span class="ajlii-publisher-subtitle">{translate key="plugins.themes.ajlii.publisher"}</span>
			</a>
			<div class="ajlii-header-tools" aria-label="{translate key="common.navigation.user"}">
				<a class="ajlii-tool-link" href="{url page="about"}" aria-label="{translate key="plugins.themes.ajlii.header.aboutJournal"}">i</a>
				<a class="ajlii-tool-link ajlii-tool-user" href="{url page="login"}" aria-label="{translate key="user.login"}"><span>{translate key="user.login"}</span></a>
			</div>
		</div>
	</div>

	<div class="ajlii-journal-band">
		<div class="container ajlii-journal-inner">
			<{$siteNameTag} class="ajlii-journal-title">
				<a href="{$homeUrl|escape}">{translate key="plugins.themes.ajlii.journalTitle"}</a>
			</{$siteNameTag}>
			<div class="ajlii-cuul-badge" aria-label="{translate key="plugins.themes.ajlii.publisher"}">
				<span>CUUL</span>
				<small>Open Access<br>Knowledge</small>
			</div>
		</div>
	</div>

	<div class="container ajlii-nav-container">
		<div class="visually-hidden">{$pageTitleTranslated|escape}</div>

	{* Main navigation *}
	<nav class="navbar navbar-expand-lg navbar-light">
		<span class="ajlii-mobile-menu-label">{translate key="plugins.themes.ajlii.nav.menu"}</span>
		<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#main-navbar"
		        aria-controls="main-navbar" aria-expanded="false"
		        aria-label="{translate key="plugins.themes.ajlii.nav.toggle"}">
			<span class="navbar-toggler-icon"></span>
		</button>

		<div class="collapse navbar-collapse justify-content-md-center" id="main-navbar">
			{* primary menu *}
			{capture assign="primaryMenu"}
				{load_menu name="primary" id="primaryNav" ulClass="navbar-nav" liClass="nav-item"}
			{/capture}
			{if !empty(trim($primaryMenu)) || $currentContext}
				{$primaryMenu}
			{/if}
			{* user menu *}
			{load_menu name="user" id="primaryNav-userNav" ulClass="navbar-nav" liClass="nav-item"}
			{include file="frontend/components/languageSwitcher.tpl" id="languageSmallNav"}
		</div>
		<form class="ajlii-header-search" action="{url page="search" op="search"}" method="get" role="search">
			<label class="visually-hidden" for="ajliiHeaderSearch">{translate key="common.search"}</label>
			<input id="ajliiHeaderSearch" name="query" type="search" placeholder="{translate key="common.search"}">
			<button type="submit" aria-label="{translate key="common.search"}"></button>
		</form>
		<div class="ajlii-ai-discovery" aria-label="{translate key="plugins.themes.ajlii.aiDiscovery"}">
			<span aria-hidden="true">AI</span>
			<strong>{translate key="plugins.themes.ajlii.aiDiscovery"}</strong>
		</div>
	</nav>

	{* Repeat the userNav for positioning on large screens *}
	{load_menu name="user" id="userNav" ulClass="navbar-nav" liClass="nav-item"}

	{* Language switcher *}
	{include file="frontend/components/languageSwitcher.tpl" id="languageLargeNav"}

	</div>
</header>
