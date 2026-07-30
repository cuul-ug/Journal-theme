{**
 * templates/frontend/components/headerHead.tpl
 *
 * Common site header <head> tag and AJLII SEO/GEO metadata.
 *}
<head>
	<meta http-equiv="Content-Type" content="text/html; charset={$defaultCharset|escape}">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>
		{$pageTitleTranslated|strip_tags}
		{if $requestedPage|escape|default:"index" != 'index' && $currentContext && $currentContext->getLocalizedName()}
			| {$currentContext->getLocalizedName()|escape}
		{/if}
	</title>
	{capture assign="ajliiJournalTitle"}{translate key="plugins.themes.ajlii.journalTitle"}{/capture}
	{capture assign="ajliiPublisher"}{translate key="plugins.themes.ajlii.publisher"}{/capture}
	{capture assign="ajliiSeoDescription"}{translate key="plugins.themes.ajlii.seo.description"}{/capture}
	{capture assign="ajliiSeoKeywords"}{translate key="plugins.themes.ajlii.seo.keywords"}{/capture}
	{capture assign="ajliiSeoVision"}{translate key="plugins.themes.ajlii.seo.vision"}{/capture}
	{capture assign="ajliiSeoMission"}{translate key="plugins.themes.ajlii.seo.mission"}{/capture}
	{capture assign="ajliiSeoPublicationModel"}{translate key="plugins.themes.ajlii.seo.publicationModel"}{/capture}
	{capture assign="ajliiSeoReview"}{translate key="plugins.themes.ajlii.seo.review"}{/capture}
	{capture assign="ajliiSeoFocus"}{translate key="plugins.themes.ajlii.seo.focus"}{/capture}
	{capture assign="ajliiSeoResearcherSupport"}{translate key="plugins.themes.ajlii.seo.researcherSupport"}{/capture}
	{capture assign="ajliiSeoEthics"}{translate key="plugins.themes.ajlii.seo.ethics"}{/capture}
	{capture assign="ajliiAeoWhatQuestion"}{translate key="plugins.themes.ajlii.aeo.whatQuestion"}{/capture}
	{capture assign="ajliiAeoWhatAnswer"}{translate key="plugins.themes.ajlii.aeo.whatAnswer"}{/capture}
	{capture assign="ajliiAeoOpenAccessQuestion"}{translate key="plugins.themes.ajlii.aeo.openAccessQuestion"}{/capture}
	{capture assign="ajliiAeoOpenAccessAnswer"}{translate key="plugins.themes.ajlii.aeo.openAccessAnswer"}{/capture}
	{capture assign="ajliiAeoPeerReviewQuestion"}{translate key="plugins.themes.ajlii.aeo.peerReviewQuestion"}{/capture}
	{capture assign="ajliiAeoPeerReviewAnswer"}{translate key="plugins.themes.ajlii.aeo.peerReviewAnswer"}{/capture}
	{capture assign="ajliiAeoFrequencyQuestion"}{translate key="plugins.themes.ajlii.aeo.frequencyQuestion"}{/capture}
	{capture assign="ajliiAeoFrequencyAnswer"}{translate key="plugins.themes.ajlii.aeo.frequencyAnswer"}{/capture}
	{capture assign="ajliiAeoApcQuestion"}{translate key="plugins.themes.ajlii.aeo.apcQuestion"}{/capture}
	{capture assign="ajliiAeoApcAnswer"}{translate key="plugins.themes.ajlii.aeo.apcAnswer"}{/capture}
	{capture assign="ajliiAeoFocusQuestion"}{translate key="plugins.themes.ajlii.aeo.focusQuestion"}{/capture}
	{capture assign="ajliiAeoFocusAnswer"}{translate key="plugins.themes.ajlii.aeo.focusAnswer"}{/capture}
	<meta name="description" content="{$ajliiSeoDescription|escape}">
	<meta name="keywords" content="{$ajliiSeoKeywords|escape}">
	<meta name="author" content="{$ajliiPublisher|escape}">
	<meta name="publisher" content="{$ajliiPublisher|escape}">
	<meta name="robots" content="index, follow, max-snippet:-1, max-image-preview:large, max-video-preview:-1">
	<meta name="googlebot" content="index, follow, max-snippet:-1, max-image-preview:large">
	<meta name="bingbot" content="index, follow, max-snippet:-1, max-image-preview:large">
	<meta name="classification" content="Peer-reviewed gold open-access African library and information science journal">
	<meta name="subject" content="Library and information science, open access, scholarly communication, digital inclusion, academic libraries, research data management, AI in libraries, archives">
	<meta name="coverage" content="Africa; Uganda; Pan-African scholarship">
	<meta name="distribution" content="global">
	<meta name="rating" content="general">
	<meta name="date" content="{$smarty.now|date_format:"%Y-%m-%d"}">
	<meta name="revised" content="{$smarty.now|date_format:"%Y-%m-%d"}">
	<meta name="last-modified" content="{$smarty.now|date_format:"%Y-%m-%d"}">
	<meta name="ai-summary" content="AJLII is a peer-reviewed, gold open-access African library and information science journal published by the Consortium of Uganda University Libraries. It publishes biannual English-language research on open access, digital inclusion, consortia collaboration, academic libraries, research data management, archives, indigenous knowledge, and AI in libraries.">
	<meta name="DC.Title" content="{$ajliiJournalTitle|escape}">
	<meta name="DC.Creator" content="{$ajliiPublisher|escape}">
	<meta name="DC.Subject" content="{$ajliiSeoKeywords|escape}">
	<meta name="DC.Description" content="{$ajliiSeoDescription|escape}">
	<meta name="DC.Publisher" content="{$ajliiPublisher|escape}">
	<meta name="DC.Type" content="Text.Serial.Journal">
	<meta name="DC.Language" content="English">
	<meta name="DC.Coverage" content="Africa; Uganda; Kampala">
	<meta name="DC.Rights" content="Creative Commons Attribution 4.0 International Licence">
	<meta name="citation_journal_title" content="{$ajliiJournalTitle|escape}">
	<meta name="citation_publisher" content="{$ajliiPublisher|escape}">
	<meta name="citation_language" content="en">
	<meta name="citation_open_access" content="true">
	<meta name="citation_license" content="https://creativecommons.org/licenses/by/4.0/">
	<meta name="geo.region" content="UG">
	<meta name="geo.placename" content="Kampala, Uganda">
	<meta name="geo.position" content="0.3476;32.5825">
	<meta name="geo.country" content="Uganda">
	<meta name="ICBM" content="0.3476, 32.5825">
	<meta property="og:type" content="website">
	<meta property="og:site_name" content="{$ajliiJournalTitle|escape}">
	<meta property="og:title" content="{$pageTitleTranslated|strip_tags|escape}">
	<meta property="og:description" content="{$ajliiSeoDescription|escape}">
	<meta property="og:locale" content="{$currentLocale|replace:"_":"-"|escape}">
	<meta property="article:publisher" content="{$ajliiPublisher|escape}">
	<meta name="twitter:card" content="summary_large_image">
	<meta name="twitter:title" content="{$pageTitleTranslated|strip_tags|escape}">
	<meta name="twitter:description" content="{$ajliiSeoDescription|escape}">
	<script type="application/ld+json">
	{ldelim}
		"@context": "https://schema.org",
		"@type": "Periodical",
		"name": "{$ajliiJournalTitle|escape:"javascript"}",
		"alternateName": "AJLII",
		"description": "{$ajliiSeoDescription|escape:"javascript"}",
		"abstract": "{$ajliiSeoMission|escape:"javascript"}",
		"publisher": {ldelim}
			"@type": "Organization",
			"name": "{$ajliiPublisher|escape:"javascript"}",
			"alternateName": "CUUL",
			"address": {ldelim}
				"@type": "PostalAddress",
				"addressCountry": "UG",
				"addressLocality": "Kampala"
			{rdelim}
		{rdelim},
		"license": "https://creativecommons.org/licenses/by/4.0/",
		"isAccessibleForFree": true,
		"conditionsOfAccess": "Gold Open Access",
		"inLanguage": "{$currentLocale|replace:"_":"-"|escape}",
		"keywords": "{$ajliiSeoKeywords|escape:"javascript"}",
		"dateModified": "{$smarty.now|date_format:"%Y-%m-%d"}",
		{if $ajliiAuthorityLinks}
		"sameAs": [
			{foreach from=$ajliiAuthorityLinks item=authorityLink name=authoritySameAs}
				"{$authorityLink.url|escape:"javascript"}"{if !$smarty.foreach.authoritySameAs.last},{/if}
			{/foreach}
		],
		{/if}
		"audience": {ldelim}
			"@type": "Audience",
			"audienceType": "Library and information science researchers, academic librarians, information professionals, archivists, research data managers, policy makers, and higher education institutions"
		{rdelim},
		"about": [
			{ldelim}"@type": "Thing", "name": "Open Access and Scholarly Communication in Africa"{rdelim},
			{ldelim}"@type": "Thing", "name": "Digital Transformation in African Universities"{rdelim},
			{ldelim}"@type": "Thing", "name": "Consortia Collaboration and Best Practices"{rdelim},
			{ldelim}"@type": "Thing", "name": "Indigenous Knowledge and Decolonising Libraries"{rdelim},
			{ldelim}"@type": "Thing", "name": "Research Data Management"{rdelim},
			{ldelim}"@type": "Thing", "name": "Artificial Intelligence and Automation in Libraries"{rdelim},
			{ldelim}"@type": "Thing", "name": "Records and Archival Management"{rdelim}
		],
		"additionalProperty": [
			{ldelim}"@type": "PropertyValue", "name": "Vision", "value": "{$ajliiSeoVision|escape:"javascript"}"{rdelim},
			{ldelim}"@type": "PropertyValue", "name": "Mission", "value": "{$ajliiSeoMission|escape:"javascript"}"{rdelim},
			{ldelim}"@type": "PropertyValue", "name": "Publication model", "value": "{$ajliiSeoPublicationModel|escape:"javascript"}"{rdelim},
			{ldelim}"@type": "PropertyValue", "name": "Editorial process", "value": "{$ajliiSeoReview|escape:"javascript"}"{rdelim},
			{ldelim}"@type": "PropertyValue", "name": "Focus areas", "value": "{$ajliiSeoFocus|escape:"javascript"}"{rdelim},
			{ldelim}"@type": "PropertyValue", "name": "Emerging researcher support", "value": "{$ajliiSeoResearcherSupport|escape:"javascript"}"{rdelim},
			{ldelim}"@type": "PropertyValue", "name": "Ethics and integrity", "value": "{$ajliiSeoEthics|escape:"javascript"}"{rdelim}
		]
	{rdelim}
	</script>
	<script type="application/ld+json">
	{ldelim}
		"@context": "https://schema.org",
		"@type": "FAQPage",
		"mainEntity": [
			{ldelim}
				"@type": "Question",
				"name": "{$ajliiAeoWhatQuestion|escape:"javascript"}",
				"acceptedAnswer": {ldelim}
					"@type": "Answer",
					"text": "{$ajliiAeoWhatAnswer|escape:"javascript"}"
				{rdelim}
			{rdelim},
			{ldelim}
				"@type": "Question",
				"name": "{$ajliiAeoOpenAccessQuestion|escape:"javascript"}",
				"acceptedAnswer": {ldelim}
					"@type": "Answer",
					"text": "{$ajliiAeoOpenAccessAnswer|escape:"javascript"}"
				{rdelim}
			{rdelim},
			{ldelim}
				"@type": "Question",
				"name": "{$ajliiAeoPeerReviewQuestion|escape:"javascript"}",
				"acceptedAnswer": {ldelim}
					"@type": "Answer",
					"text": "{$ajliiAeoPeerReviewAnswer|escape:"javascript"}"
				{rdelim}
			{rdelim},
			{ldelim}
				"@type": "Question",
				"name": "{$ajliiAeoFrequencyQuestion|escape:"javascript"}",
				"acceptedAnswer": {ldelim}
					"@type": "Answer",
					"text": "{$ajliiAeoFrequencyAnswer|escape:"javascript"}"
				{rdelim}
			{rdelim},
			{ldelim}
				"@type": "Question",
				"name": "{$ajliiAeoApcQuestion|escape:"javascript"}",
				"acceptedAnswer": {ldelim}
					"@type": "Answer",
					"text": "{$ajliiAeoApcAnswer|escape:"javascript"}"
				{rdelim}
			{rdelim},
			{ldelim}
				"@type": "Question",
				"name": "{$ajliiAeoFocusQuestion|escape:"javascript"}",
				"acceptedAnswer": {ldelim}
					"@type": "Answer",
					"text": "{$ajliiAeoFocusAnswer|escape:"javascript"}"
				{rdelim}
			{rdelim}
		]
	{rdelim}
	</script>
	{load_header context="frontend"}
	{load_stylesheet context="frontend"}
</head>
