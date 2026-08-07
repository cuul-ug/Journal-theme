{**
 * templates/frontend/pages/search.tpl
 *
 * Copyright (c) 2014-2020 Simon Fraser University
 * Copyright (c) 2003-2020 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief Display the page to search and view search results.
 *
 * @uses $query Value of the primary search query
 * @uses $authors Value of the authors search filter
 * @uses $dateFrom Value of the date from search filter (published after).
 * @uses $dateTo Value of the date to search filter (published before).
 * @uses $yearStart Earliest year that can be used in from/to filters
 * @uses $yearEnd Latest year that can be used in from/to filters
 *}
{include file="frontend/components/header.tpl" pageTitle="common.search"}

<div class="container page-search">
	<header class="page-header page-search-header">
		<p class="ajlii-page-kicker">{translate key="plugins.themes.ajlii.search.kicker"}</p>
		<h1>
			{if $query}
				{translate key="plugins.themes.ajlii.search.resultsFor" query=$query|escape}
			{elseif $authors}
				{translate key="plugins.themes.ajlii.search.resultsFor" query=$authors|escape}
			{elseif $title}
				{translate key="plugins.themes.ajlii.search.resultsFor" query=$title|escape}
			{elseif $subject}
				{translate key="plugins.themes.ajlii.search.resultsFor" query=$subject|escape}
			{else}
				{translate key="common.search"}
			{/if}
		</h1>
		<p>{translate key="plugins.themes.ajlii.search.intro"}</p>
	</header>

	<div class="row page-search-layout">
		<div class="col-lg-8 search-col-results">
			<section class="search-results" id="results" aria-labelledby="ajliiSearchResultsTitle">
				<h2 id="ajliiSearchResultsTitle" class="visually-hidden">{translate key="search.searchResults"}</h2>

				{if $results->wasEmpty()}
					{if $error}
						<div class="alert alert-danger" role="alert">{$error|escape}</div>
					{else}
						<div class="alert alert-primary" role="alert">{translate key="search.noResults"}</div>
					{/if}
				{else}
					<div class="search-results-list">
						{iterate from=results item=result}
							{include file="frontend/objects/article_summary.tpl" article=$result.publishedSubmission journal=$result.journal showDatePublished=true hideGalleys=true}
						{/iterate}
					</div>
					<nav class="pagination search-pagination" aria-label="{translate|escape key="plugins.themes.ajlii.search.pagination"}">
						{page_info iterator=$results}
						{page_links anchor="results" iterator=$results name="search" query=$query searchJournal=$searchJournal authors=$authors title=$title abstract=$abstract galleyFullText=$galleyFullText discipline=$discipline subject=$subject type=$type coverage=$coverage indexTerms=$indexTerms dateFromMonth=$dateFromMonth dateFromDay=$dateFromDay dateFromYear=$dateFromYear dateToMonth=$dateToMonth dateToDay=$dateToDay dateToYear=$dateToYear orderBy=$orderBy orderDir=$orderDir}
					</nav>
				{/if}
			</section>
		</div>

		<div class="col-lg-4 search-col-filters">
			<aside class="search-filters" aria-labelledby="ajliiSearchFiltersTitle">
				<h2 id="ajliiSearchFiltersTitle">{translate key="plugins.themes.ajlii.search.params"}</h2>

				{capture name="searchFormUrl"}{url escape=false}{/capture}
				{assign var=formUrlParameters value=[]}{* Prevent Smarty warning *}
				{$smarty.capture.searchFormUrl|parse_url:$smarty.const.PHP_URL_QUERY|parse_str:$formUrlParameters}
				<form class="form-search" method="get" action="{$smarty.capture.searchFormUrl|strtok:"?"|escape}">
					{foreach from=$formUrlParameters key=paramKey item=paramValue}
						<input type="hidden" name="{$paramKey|escape}" value="{$paramValue|escape}"/>
					{/foreach}

					<div class="form-group form-group-query">
						<label for="query">{translate key="common.searchQuery"}</label>
						<input type="search" class="form-control" id="query" name="query" value="{$query|escape}" placeholder="{translate|escape key="plugins.themes.ajlii.search.placeholder"}">
					</div>

					<div class="form-group form-group-authors">
						<label for="authors">{translate key="search.author"}</label>
						<input type="text" class="form-control" id="authors" name="authors" value="{$authors|escape}">
					</div>

					<div class="form-group form-group-title">
						<label for="title">{translate key="plugins.themes.ajlii.search.titleLabel"}</label>
						<input type="text" class="form-control" id="title" name="title" value="{$title|escape}">
					</div>

					<div class="form-group form-group-subject">
						<label for="subject">{translate key="plugins.themes.ajlii.search.subjectLabel"}</label>
						<input type="text" class="form-control" id="subject" name="subject" value="{$subject|escape}">
					</div>

					<div class="form-group form-group-date-from">
						<label for="dateFromYear">{translate key="search.dateFrom"}</label>
						<div class="form-control-date">
							{html_select_date class="form-control" prefix="dateFrom" time=$dateFrom start_year=$yearStart end_year=$yearEnd year_empty="" month_empty="" day_empty="" field_order="YMD"}
						</div>
					</div>

					<div class="form-group form-group-date-to">
						<label for="dateToYear">{translate key="search.dateTo"}</label>
						<div class="form-control-date">
							{html_select_date class="form-control" prefix="dateTo" time=$dateTo start_year=$yearStart end_year=$yearEnd year_empty="" month_empty="" day_empty="" field_order="YMD"}
						</div>
					</div>

					<div class="form-group form-group-buttons">
						<button class="btn btn-primary" type="submit">{translate key="common.search"}</button>
						<a class="btn btn-outline-primary" href="{url page="search"}">{translate key="plugins.themes.ajlii.search.clear"}</a>
					</div>
				</form>
			</aside>
		</div>
	</div>
</div>

{include file="frontend/components/footer.tpl"}
