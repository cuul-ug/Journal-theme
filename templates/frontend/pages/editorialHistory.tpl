{**
 * templates/frontend/pages/editorialHistory.tpl
 *
 * Copyright (c) 2024 Simon Fraser University
 * Copyright (c) 2024 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief Display context's editorial history page.
 *
 *}
{include file="frontend/components/header.tpl" pageTitle="common.editorialHistory"}

<div class="container page page-masthead page-editorial-history">
	<header class="page-header ajlii-editorial-hero">
		<p class="ajlii-page-kicker">{translate key="plugins.themes.ajlii.editorial.kicker"}</p>
		<h1>{translate key="common.editorialHistory.page"}</h1>
		<p>{translate key="plugins.themes.ajlii.editorial.historyIntro"}</p>
	</header>

	<div class="ajlii-editorial-layout">
		<main class="page-content ajlii-editorial-main" aria-labelledby="ajliiEditorialHistoryTitle">
			<h2 id="ajliiEditorialHistoryTitle">{translate key="plugins.themes.ajlii.editorial.serviceTitle"}</h2>
			<p>{translate key="common.editorialHistory.page.description"}</p>

			{foreach from=$mastheadRoles item="mastheadRole"}
				{if array_key_exists($mastheadRole->id, $mastheadUsers)}
					<section class="ajlii-masthead-role" aria-labelledby="historyRole{$mastheadRole->id|escape}">
						<h3 id="historyRole{$mastheadRole->id|escape}">{$mastheadRole->getLocalizedData('name')|escape}</h3>
						<ul class="user_listing" role="list">
							{foreach from=$mastheadUsers[$mastheadRole->id] item="mastheadUser"}
								<li>
									{strip}
									<span class="date_start">
										{foreach name="services" from=$mastheadUser['services'] item="service"}
											{translate key="common.fromUntil" from=$service['dateStart'] until=$service['dateEnd']}
											{if !$smarty.foreach.services.last}{translate key="common.commaListSeparator"}{/if}
										{/foreach}
									</span>
									<span class="name">
										{$mastheadUser['user']->getFullName()|escape}
										{if $mastheadUser['user']->getData('orcid') && $mastheadUser['user']->hasVerifiedOrcid()}
											<span class="orcid">
												<a href="{$mastheadUser['user']->getData('orcid')|escape}" target="_blank" aria-label="{translate key="common.editorialHistory.page.orcidLink" name=$mastheadUser['user']->getFullName()|escape}">
													{$orcidIcon}
												</a>
											</span>
										{/if}
									</span>
									{if !empty($mastheadUser['user']->getLocalizedData('affiliation'))}
										<span class="affiliation">{$mastheadUser['user']->getLocalizedData('affiliation')|escape}</span>
									{/if}
									{/strip}
								</li>
							{/foreach}
						</ul>
					</section>
				{/if}
			{/foreach}

			{if $currentContext->getLocalizedData('editorialHistory')}
				<section class="ajlii-editorial-managed-history">
					<h2>{translate key="plugins.themes.ajlii.editorial.contextHistoryTitle"}</h2>
					{$currentContext->getLocalizedData('editorialHistory')}
				</section>
			{/if}
			{include file="frontend/components/editLink.tpl" page="management" op="settings" path="context" anchor="masthead" sectionTitleKey="common.editorialHistory"}
		</main>

		<aside class="ajlii-editorial-aside" aria-label="{translate|escape key="plugins.themes.ajlii.editorial.sideTitle"}">
			<section>
				<h2>{translate key="plugins.themes.ajlii.editorial.sideTitle"}</h2>
				<p>{translate key="plugins.themes.ajlii.editorial.historySideText"}</p>
			</section>
			<nav aria-label="{translate|escape key="plugins.themes.ajlii.editorial.relatedLinks"}">
				<h2>{translate key="plugins.themes.ajlii.editorial.relatedLinks"}</h2>
				<a href="{url page="about" op="editorialMasthead" router=\PKP\core\PKPApplication::ROUTE_PAGE}">{translate key="common.editorialMasthead"}</a>
				<a href="{url page="about" op="submissions"}">{translate key="plugins.themes.ajlii.footer.authorGuidelines"}</a>
				<a href="{url page="about" op="contact"}">{translate key="plugins.themes.ajlii.footer.contact"}</a>
			</nav>
		</aside>
	</div>
</div>

{include file="frontend/components/footer.tpl"}
