{**
 * templates/frontend/pages/information.tpl
 *
 * Copyright (c) 2014-2020 Simon Fraser University
 * Copyright (c) 2003-2020 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief Display the page to view a journal's or press's description, contact
 *  details, policies and more.
 *
 * @uses $currentContext Journal|Press The current journal or press
 *}
{capture assign="pageTitleTranslated"}{translate key="plugins.themes.ajlii.information.title"}{/capture}
{include file="frontend/components/header.tpl" pageTitleTranslated=$pageTitleTranslated}

<div class="container page-information">
	<div class="page-information-header">
		<p class="ajlii-home-slide-kicker">{translate key="plugins.themes.ajlii.information.kicker"}</p>
		<h1>{translate key="plugins.themes.ajlii.information.title"}</h1>
		<p>{translate key="plugins.themes.ajlii.information.intro"}</p>
	</div>

	<section class="ajlii-information-grid" aria-label="{translate|escape key="plugins.themes.ajlii.information.title"}">
		<article class="ajlii-information-card">
			<h2><a href="{url page="about"}">{translate key="plugins.themes.ajlii.information.aboutTitle"}</a></h2>
			<ul>
				<li><a href="{url page="about"}">{translate key="plugins.themes.ajlii.information.aboutJournal"}</a></li>
				<li><a href="{url page="about" op="editorialTeam"}">{translate key="plugins.themes.ajlii.information.editorialBoard"}</a></li>
				<li><a href="{url page="about" op="contact"}">{translate key="plugins.themes.ajlii.information.contactOffice"}</a></li>
				<li><a href="{url page="about" op="privacy"}">{translate key="plugins.themes.ajlii.information.privacy"}</a></li>
				<li><a href="{url page="about" op="aboutThisPublishingSystem"}">{translate key="plugins.themes.ajlii.information.platform"}</a></li>
			</ul>
		</article>
		<article class="ajlii-information-card">
			<h2><a href="{url page="about" op="submissions"}">{translate key="plugins.themes.ajlii.information.publishTitle"}</a></h2>
			<ul>
				<li><a href="{url page="about" op="submissions"}">{translate key="plugins.themes.ajlii.information.authorGuidelines"}</a></li>
				<li><a href="{url page="about" op="submissions"}">{translate key="plugins.themes.ajlii.information.apc"}</a></li>
				<li><a href="{url page="about"}">{translate key="plugins.themes.ajlii.information.peerReview"}</a></li>
				<li><a href="{url page="about"}">{translate key="plugins.themes.ajlii.information.ethics"}</a></li>
				<li><a href="{url page="information" op="authors"}">{translate key="plugins.themes.ajlii.footer.forAuthors"}</a></li>
			</ul>
		</article>
		<article class="ajlii-information-card">
			<h2><a href="{url page="issue" op="archive"}">{translate key="plugins.themes.ajlii.information.researchTitle"}</a></h2>
			<ul>
				<li><a href="{url page="issue" op="archive"}">{translate key="journal.archives"}</a></li>
				<li><a href="{url page="search"}">{translate key="common.search"}</a></li>
				<li><a href="{url page="announcements"}">{translate key="announcement.announcements"}</a></li>
				<li><a href="{url page="information" op="readers"}">{translate key="plugins.themes.ajlii.footer.forReaders"}</a></li>
				<li><a href="{url page="information" op="librarians"}">{translate key="plugins.themes.ajlii.footer.forLibrarians"}</a></li>
			</ul>
		</article>
		<article class="ajlii-information-card">
			<h2><a href="{url page="about" op="contact"}">{translate key="plugins.themes.ajlii.information.supportTitle"}</a></h2>
			<ul>
				<li><a href="{url page="about" op="contact"}">{translate key="plugins.themes.ajlii.footer.contact"}</a></li>
				<li><a href="{url page="about" op="privacy"}">{translate key="plugins.themes.ajlii.footer.privacyPolicy"}</a></li>
				<li><button type="button" data-cookie-settings>{translate key="plugins.themes.ajlii.footer.cookiePolicy"}</button></li>
				<li><a href="{url page="about"}">{translate key="plugins.themes.ajlii.information.legalNotice"}</a></li>
				<li><a href="{url page="about"}">{translate key="plugins.themes.ajlii.information.accessibility"}</a></li>
			</ul>
		</article>
		<article class="ajlii-information-card">
			<h2><a href="{url page="about"}">{translate key="plugins.themes.ajlii.information.openResearchTitle"}</a></h2>
			<ul>
				<li><a href="{url page="about"}">{translate key="plugins.themes.ajlii.information.openAccess"}</a></li>
				<li><a href="{url page="about" op="submissions"}">{translate key="plugins.themes.ajlii.information.readPublish"}</a></li>
				<li><a href="{url page="about"}">{translate key="plugins.themes.ajlii.information.researchData"}</a></li>
				<li><a href="{url page="about"}">{translate key="plugins.themes.ajlii.information.preservation"}</a></li>
			</ul>
		</article>
		<article class="ajlii-information-card">
			<h2><a href="{url page="search"}">{translate key="plugins.themes.ajlii.information.usingContentTitle"}</a></h2>
			<ul>
				<li><a href="{url page="search"}">{translate key="common.search"}</a></li>
				<li><a href="{url page="about"}">{translate key="plugins.themes.ajlii.information.citation"}</a></li>
				<li><a href="{url page="about"}">{translate key="plugins.themes.ajlii.information.metrics"}</a></li>
				<li><button type="button" data-ajlii-ai-open>{translate key="plugins.themes.ajlii.aiDiscovery"}</button></li>
				<li><a href="{url page="about"}">{translate key="plugins.themes.ajlii.information.standards"}</a></li>
			</ul>
		</article>
		<article class="ajlii-information-card">
			<h2><a href="{url page="user" op="register"}">{translate key="plugins.themes.ajlii.information.accountsTitle"}</a></h2>
			<ul>
				<li><a href="{url page="user" op="register"}">{translate key="plugins.themes.ajlii.register.registerHere"}</a></li>
				<li><a href="{url page="login"}" data-ajlii-login-open data-bs-toggle="modal" data-bs-target="#loginModal" role="button" aria-haspopup="dialog" aria-controls="loginModal">{translate key="plugins.themes.ajlii.register.loginHere"}</a></li>
				<li><a href="{url page="login" op="lostPassword"}">{translate key="user.login.forgotPassword"}</a></li>
				<li><a href="{url page="user" op="profile" path="roles"}">{translate key="plugins.themes.ajlii.information.manageRoles"}</a></li>
			</ul>
		</article>
		<article class="ajlii-information-card">
			<h2><a href="{url page="about" op="contact"}">{translate key="plugins.themes.ajlii.information.enquiriesTitle"}</a></h2>
			<ul>
				<li><a href="{url page="about" op="contact"}">{translate key="plugins.themes.ajlii.information.editorialEnquiries"}</a></li>
				<li><a href="{url page="about" op="contact"}">{translate key="plugins.themes.ajlii.information.mediaEnquiries"}</a></li>
				<li><a href="{url page="about" op="contact"}">{translate key="plugins.themes.ajlii.information.institutionalSupport"}</a></li>
				<li><a href="{url page="about" op="contact"}">{translate key="plugins.themes.ajlii.information.contactOffice"}</a></li>
			</ul>
		</article>
	</section>

	{if $content}
		<div class="row justify-content-md-center">
			<div class="col-lg-10">
				<div class="page-content ajlii-information-managed-content">
					{$content}
					<p>
						{include file="frontend/components/editLink.tpl" page="management" op="settings" path="website" anchor="setup/information" sectionTitleKey="manager.website.information"}
					</p>
				</div>
			</div>
		</div>
	{/if}
</div>

{include file="frontend/components/footer.tpl"}
