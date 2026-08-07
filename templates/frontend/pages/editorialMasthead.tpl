{**
 * templates/frontend/pages/editorialMasthead.tpl
 *
 * Copyright (c) 2024 Simon Fraser University
 * Copyright (c) 2024 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief Display context's editorial masthead page.
 *
 *}
{include file="frontend/components/header.tpl" pageTitle="common.editorialMasthead"}

<div class="container page page-masthead page-editorial-masthead">
	<header class="page-header ajlii-editorial-hero">
		<h1>{translate key="common.editorialMasthead"}</h1>
	</header>

	<div class="ajlii-editorial-layout">
		<main class="page-content ajlii-editorial-main" aria-labelledby="ajliiEditorialRolesTitle">
			<h2 id="ajliiEditorialRolesTitle">{translate key="plugins.themes.ajlii.editorial.rolesTitle"}</h2>
			{foreach from=$mastheadRoles item="mastheadRole"}
				{if array_key_exists($mastheadRole->id, $mastheadUsers)}
					<section class="ajlii-masthead-role" aria-labelledby="mastheadRole{$mastheadRole->id|escape}">
						<h3 id="mastheadRole{$mastheadRole->id|escape}">{$mastheadRole->getLocalizedData('name')|escape}</h3>
						<ul class="user_listing" role="list">
						{foreach from=$mastheadUsers[$mastheadRole->id] item="mastheadUser"}
							<li>
								{strip}
									<span class="date_start">{translate key="common.fromUntil" from=$mastheadUser['dateStart'] until=""}</span>
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

			{if !empty($reviewers)}
				<section class="ajlii-masthead-role">
					<h2>{translate key="common.editorialMasthead.peerReviewers"}</h2>
					<p>{translate key="common.editorialMasthead.peerReviewers.description" year=$previousYear}</p>
					<ul class="user_listing" role="list">
					{foreach from=$reviewers item="reviewer"}
						<li>
							{strip}
								<span class="name">
									{$reviewer->getFullName()|escape}
									{if $reviewer->getData('orcid') && $reviewer->hasVerifiedOrcid()}
										<span class="orcid">
											<a href="{$reviewer->getData('orcid')|escape}" target="_blank" aria-label="{translate key="common.editorialHistory.page.orcidLink" name=$reviewer->getFullName()|escape}">
												{$orcidIcon}
											</a>
										</span>
									{/if}
								</span>
								{if !empty($reviewer->getLocalizedData('affiliation'))}
									<span class="affiliation">{$reviewer->getLocalizedData('affiliation')|escape}</span>
								{/if}
							{/strip}
						</li>
					{/foreach}
					</ul>
				</section>
			{/if}
		</main>
	</div>
</div>

{include file="frontend/components/footer.tpl"}
