{**
 * templates/frontend/pages/indexJournal.tpl
 *
 * Copyright (c) 2014-2020 Simon Fraser University
 * Copyright (c) 2003-2020 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief Display the index page for a journal
 *
 * @uses $currentJournal Journal This journal
 * @uses $journalDescription string Journal description from HTML text editor
 * @uses $homepageImage object Image to be displayed on the homepage
 * @uses $additionalHomeContent string Arbitrary input from HTML text editor
 * @uses $announcements array List of announcements
 * @uses $numAnnouncementsHomepage int Number of announcements to display on the
 *       homepage
 * @uses $issue Issue Current issue
 *}
{include file="frontend/components/header.tpl" pageTitleTranslated=$currentJournal->getLocalizedName()}

{if $ajliiHomepageSliderEnabled}
	<section class="ajlii-home-slider" data-ajlii-home-slider data-autoplay="{if $ajliiHomepageSliderAutoplay}true{else}false{/if}" aria-labelledby="ajliiHomeSliderTitle">
		<div class="container ajlii-home-slider-inner">
			<h2 id="ajliiHomeSliderTitle" class="visually-hidden">{translate key="plugins.themes.ajlii.slider.title"}</h2>
			<div class="ajlii-home-slider-track" data-slider-track>
				{foreach from=$ajliiHomepageSliderSlides item=slide name=managedSlides}
					<article class="ajlii-home-slide{if !$slide.imageUrl} ajlii-home-slide-no-image{/if}{if $smarty.foreach.managedSlides.first} is-active{/if}" data-slider-slide>
						{if $slide.imageUrl}
							<img src="{$slide.imageUrl|escape}" alt="{$slide.title|escape}">
						{/if}
						<div class="ajlii-home-slide-content">
							<p class="ajlii-home-slide-kicker">{$slide.type|escape}</p>
							{if $slide.title}<h3>{$slide.title|escape}</h3>{/if}
							{if $slide.description}<p>{$slide.description|escape}</p>{/if}
							{if $slide.url}<a class="btn btn-primary" href="{$slide.url|escape}">{$slide.label|escape}</a>{/if}
						</div>
					</article>
				{/foreach}
				{if $homepageImage}
					<article class="ajlii-home-slide{if empty($ajliiHomepageSliderSlides)} is-active{/if}" data-slider-slide>
						<img src="{$publicFilesDir}/{$homepageImage.uploadName|escape:"url"}" alt="{$homepageImageAltText|escape}">
						<div class="ajlii-home-slide-content">
							<p class="ajlii-home-slide-kicker">{translate key="plugins.themes.ajlii.slider.featured"}</p>
							<h3>{translate key="plugins.themes.ajlii.journalTitle"}</h3>
							<p>{translate key="plugins.themes.ajlii.seo.description"}</p>
							<a class="btn btn-primary" href="{url page="about"}">{translate key="plugins.themes.ajlii.slider.about"}</a>
						</div>
					</article>
				{/if}
				{if $issue}
					<article class="ajlii-home-slide{if empty($ajliiHomepageSliderSlides) && !$homepageImage} is-active{/if}" data-slider-slide>
						{if $issue->getLocalizedCoverImageUrl()}
							<img src="{$issue->getLocalizedCoverImageUrl()|escape}"{if $issue->getLocalizedCoverImageAltText() != ''} alt="{$issue->getLocalizedCoverImageAltText()|escape}"{else} alt="{$issue->getIssueSeries()|escape}"{/if}>
						{/if}
						<div class="ajlii-home-slide-content">
							<p class="ajlii-home-slide-kicker">{translate key="journal.currentIssue"}</p>
							<h3>{$issue->getIssueSeries()|escape}</h3>
							{if $issue->getLocalizedTitle()}<p>{$issue->getLocalizedTitle()|escape}</p>{/if}
							<a class="btn btn-primary" href="{url op="view" page="issue" path=$issue->getBestIssueId()}">{translate key="plugins.themes.ajlii.slider.viewIssue"}</a>
						</div>
					</article>
				{/if}
				{if $numAnnouncementsHomepage && $announcements|@count}
					{foreach from=$announcements item=announcement name=sliderAnnouncements}
						{if $smarty.foreach.sliderAnnouncements.iteration <= 3}
							<article class="ajlii-home-slide ajlii-home-slide-no-image{if empty($ajliiHomepageSliderSlides) && !$homepageImage && !$issue && $smarty.foreach.sliderAnnouncements.first} is-active{/if}" data-slider-slide>
								<div class="ajlii-home-slide-content">
									<p class="ajlii-home-slide-kicker">{translate key="announcement.announcements"}</p>
									<h3>{$announcement->getLocalizedData('title')|escape}</h3>
									<p>{$announcement->getLocalizedData('descriptionShort')|strip_tags|escape}</p>
									<a class="btn btn-primary" href="{url router=\PKP\core\PKPApplication::ROUTE_PAGE page="announcement" op="view" path=$announcement->id}">{translate key="plugins.themes.ajlii.slider.readMore"}</a>
								</div>
							</article>
						{/if}
					{/foreach}
				{/if}
				{if empty($ajliiHomepageSliderSlides) && !$homepageImage && !$issue && !($numAnnouncementsHomepage && $announcements|@count)}
					<article class="ajlii-home-slide ajlii-home-slide-no-image is-active" data-slider-slide>
						<div class="ajlii-home-slide-content">
							<p class="ajlii-home-slide-kicker">{translate key="plugins.themes.ajlii.slider.featured"}</p>
							<h3>{translate key="plugins.themes.ajlii.journalTitle"}</h3>
							<p>{translate key="plugins.themes.ajlii.seo.description"}</p>
							<a class="btn btn-primary" href="{url page="about"}">{translate key="plugins.themes.ajlii.slider.about"}</a>
						</div>
					</article>
				{/if}
			</div>
			<div class="ajlii-home-slider-controls">
				<button type="button" data-slider-prev aria-label="{translate key="plugins.themes.ajlii.slider.previous"}">&lsaquo;</button>
				<div class="ajlii-home-slider-dots" data-slider-dots></div>
				<button type="button" data-slider-next aria-label="{translate key="plugins.themes.ajlii.slider.next"}">&rsaquo;</button>
			</div>
		</div>
	</section>
{elseif $homepageImage}
	<div class="homepage-image{if $issue} homepage-image-behind-issue{/if}">
		<img src="{$publicFilesDir}/{$homepageImage.uploadName|escape:"url"}" alt="{$homepageImageAltText|escape}">
	</div>
{/if}

<div class="container container-homepage-issue page-content">
	<section class="ajlii-answer-capsules" aria-labelledby="ajliiAnswerCapsulesTitle">
		<h2 id="ajliiAnswerCapsulesTitle">{translate key="plugins.themes.ajlii.aeo.title"}</h2>
		<div class="ajlii-answer-capsule is-primary">
			<h3>{translate key="plugins.themes.ajlii.aeo.whatQuestion"}</h3>
			<p>{translate key="plugins.themes.ajlii.aeo.whatAnswer"}</p>
		</div>
		<div class="ajlii-answer-grid">
			<article class="ajlii-answer-capsule">
				<h3>{translate key="plugins.themes.ajlii.aeo.openAccessQuestion"}</h3>
				<p>{translate key="plugins.themes.ajlii.aeo.openAccessAnswer"}</p>
			</article>
			<article class="ajlii-answer-capsule">
				<h3>{translate key="plugins.themes.ajlii.aeo.peerReviewQuestion"}</h3>
				<p>{translate key="plugins.themes.ajlii.aeo.peerReviewAnswer"}</p>
			</article>
			<article class="ajlii-answer-capsule">
				<h3>{translate key="plugins.themes.ajlii.aeo.frequencyQuestion"}</h3>
				<p>{translate key="plugins.themes.ajlii.aeo.frequencyAnswer"}</p>
			</article>
			<article class="ajlii-answer-capsule">
				<h3>{translate key="plugins.themes.ajlii.aeo.focusQuestion"}</h3>
				<p>{translate key="plugins.themes.ajlii.aeo.focusAnswer"}</p>
			</article>
		</div>
		<p class="ajlii-freshness-signal">
			{translate key="plugins.themes.ajlii.aeo.updated"} {$smarty.now|date_format:"Y-m-d"}.
		</p>
	</section>

	{if $issue}
		<h2 class="h5 homepage-issue-current">
			{translate key="journal.currentIssue"}
		</h2>
		<div class="h1 homepage-issue-identifier">
			{$issue->getIssueSeries()|escape}
		</div>
		<div class="h6 homepage-issue-published">
			{translate key="plugins.themes.ajlii.currentIssuePublished" date=$issue->getDatePublished()|date_format:$dateFormatLong}
		</div>

		{* make the entire block conditional if there aren't any additional issue data *}
		{if $issue->getLocalizedCoverImageUrl() || $issue->hasDescription() || $issueGalleys}
			<div class="row justify-content-center homepage-issue-header">
				{if $issue->getLocalizedCoverImageUrl()}
					<div class="col-lg-3">
						<a href="{url op="view" page="issue" path=$issue->getBestIssueId()}">
							<img class="img-fluid homepage-issue-cover" src="{$issue->getLocalizedCoverImageUrl()|escape}"{if $issue->getLocalizedCoverImageAltText() != ''} alt="{$issue->getLocalizedCoverImageAltText()|escape}"{/if}>
						</a>
					</div>
				{/if}
				{if $issue->hasDescription() || $journalDescription || $issueGalleys}
					<div class="col-lg-9">
						<div class="homepage-issue-description-wrapper">
							{if $issue->hasDescription()}
								<div class="homepage-issue-description">
									<div class="h2">
										{if $issue->getLocalizedTitle()}
											{$issue->getLocalizedTitle()|escape}
										{else}
											{translate key="plugins.themes.ajlii.issueDescription"}
										{/if}
									</div>
									{$issue->getLocalizedDescription()|strip_unsafe_html}
									<div class="homepage-issue-description-more">
										<a href="{url op="view" page="issue" path=$issue->getBestIssueId()}">{translate key="common.more"}</a>
									</div>
								</div>
							{elseif $journalDescription}
								<div class="homepage-journal-description long-text" id="homepageDescription">
									{$journalDescription|strip_unsafe_html}
								</div>
								<div class="homepage-description-buttons hidden" id="homepageDescriptionButtons">
									<a class="homepage-journal-description-more hidden" id="homepageDescriptionMore">{translate key="common.more"}</a>
									<a class="homepage-journal-description-less hidden" id="homepageDescriptionLess">{translate key="common.less"}</a>
								</div>
							{/if}
							{if $issueGalleys}
								<div class="homepage-issue-galleys">
									<div class="h3">
										{translate key="issue.fullIssue"}
									</div>
									{foreach from=$issueGalleys item=galley}
										{include file="frontend/objects/galley_link.tpl" parent=$issue purchaseFee=$currentJournal->getSetting('purchaseIssueFee') purchaseCurrency=$currentJournal->getSetting('currency')}
									{/foreach}
								</div>
							{/if}
						</div>
					</div>
				{/if}
			</div>
		{/if}

	{/if}

	{* display announcements before full issue *}
	{if $numAnnouncementsHomepage && $announcements|@count}
	<section class="row homepage-announcements">
		<h2 class="visually-hidden">{translate key="announcement.announcementsHome"}</h2>
		{foreach from=$announcements item=announcement}
			<article class="col-md-4 homepage-announcement">
				<h3 class="homepage-announcement-title">{$announcement->getLocalizedData('title')|escape}</h3>
				<p>{$announcement->getLocalizedData('descriptionShort')|strip_unsafe_html}
					<br>
					<a href="{url router=\PKP\core\PKPApplication::ROUTE_PAGE page="announcement" op="view" path=$announcement->id}">
						{capture name="more" assign="more"}{translate key="common.more"}{/capture}
						{translate key="plugins.themes.ajlii.more" text=$more}
					</a>
				</p>
				<footer>
					<small class="homepage-announcement-date">{$announcement->datePosted|date_format:$dateFormatLong}</small>
				</footer>
			</article>
		{/foreach}
	</section>
	{/if}

	{if $issue}
		<div class="row issue-wrapper{if $homepageImage && $issue->hasDescription()} issue-full-data{elseif $homepageImage && $issue->getLocalizedCoverImageUrl()} issue-image-cover{elseif $homepageImage} issue-only-image{/if}">
			<div class="col-12 col-lg-9">
				{include file="frontend/objects/issue_toc.tpl" sectionHeading="h3"}
			</div>
		</div>

		<div class="text-center">
			<a class="btn" href="{url router=\PKP\core\PKPApplication::ROUTE_PAGE page="issue" op="archive"}">
				{translate key="journal.viewAllIssues"}
			</a>
		</div>
	{/if}

	{* Additional Homepage Content *}
	{if $additionalHomeContent}
		<div class="row justify-content-center homepage-additional-content">
			<div class="col-lg-9">{$additionalHomeContent}</div>
		</div>
	{/if}
</div><!-- .container -->

{include file="frontend/components/footer.tpl"}
