{**
 * templates/frontend/pages/userRegister.tpl
 *
 * Copyright (c) 2014-2020 Simon Fraser University
 * Copyright (c) 2003-2020 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * User registration form.
 *
 * @uses $primaryLocale string The primary locale for this journal/press
 *}
{capture assign="pageTitleTranslated"}{translate key="plugins.themes.ajlii.register.pageTitle"}{/capture}
{include file="frontend/components/header.tpl" pageTitleTranslated=$pageTitleTranslated}

<div class="container page-register">
	<div class="page-register-hero">
		<div>
			<p class="ajlii-home-slide-kicker">{translate key="plugins.themes.ajlii.register.kicker"}</p>
			<h1>{translate key="plugins.themes.ajlii.register.pageTitle"}</h1>
			<p>{translate key="plugins.themes.ajlii.register.intro"}</p>
		</div>
		<aside class="page-register-support" aria-label="{translate|escape key="plugins.themes.ajlii.register.supportTitle"}">
			<h2>{translate key="plugins.themes.ajlii.register.supportTitle"}</h2>
			<ul>
				<li>{translate key="plugins.themes.ajlii.register.supportAuthor"}</li>
				<li>{translate key="plugins.themes.ajlii.register.supportReviewer"}</li>
				<li>{translate key="plugins.themes.ajlii.register.supportReader"}</li>
			</ul>
		</aside>
	</div>
	<div class="row justify-content-md-center page-register-body">
		<div class="col-lg-10">
			<div class="page-register-note" role="note">
				<strong>{translate key="plugins.themes.ajlii.register.beforeStartTitle"}</strong>
				<span>{translate key="plugins.themes.ajlii.register.beforeStartText"}</span>
			</div>
			<div class="page-register-orcid">
				<div>
					<h2>{translate key="plugins.themes.ajlii.register.orcidTitle"}</h2>
					<p>{translate key="plugins.themes.ajlii.register.orcidText"}</p>
					{if !$ajliiOrcidAuthUrl}
						<p class="page-register-orcid-note">{translate key="plugins.themes.ajlii.register.orcidSetupNote"}</p>
					{/if}
				</div>
				<div class="page-register-orcid-actions">
					{if $ajliiOrcidAuthUrl}
						<a class="ajlii-orcid-button" id="connect-orcid-button" href="{$ajliiOrcidAuthUrl|escape}" rel="nofollow">
							<span aria-hidden="true">iD</span>
							{translate key="plugins.themes.ajlii.register.orcidButton"}
						</a>
					{/if}
					<a class="page-register-orcid-about" href="{$ajliiOrcidAboutUrl|escape}">
						{translate key="plugins.themes.ajlii.register.orcidAbout"}
					</a>
				</div>
			</div>
		</div>
	</div>
	<div class="row justify-content-md-center">
		<div class="col-lg-10">
			<div class="page-content">

				<form class="form-register" id="register" method="post" action="{url op="register"}">
					{csrf}
					<input type="hidden" name="source" value="{$source|default:""|escape}" />

					{include file="common/formErrors.tpl"}

					{include file="frontend/components/registrationForm.tpl"}

					{include file="frontend/components/registrationFormContexts.tpl"}

					{* recaptcha spam blocker *}
					{if $recaptchaPublicKey}
						<fieldset class="recaptcha_wrapper">
							<div class="fields">
								<div class="recaptcha">
									<div class="g-recaptcha" data-sitekey="{$recaptchaPublicKey|escape}">
									</div><label for="g-recaptcha-response" style="display:none;" hidden>Recaptcha response</label>
								</div>
							</div>
						</fieldset>
					{/if}

					{* altcha spam blocker *}
					{if $altchaEnabled}
						<fieldset class="altcha_wrapper">
							<div class="fields">
								<altcha-widget challengejson='{$altchaChallenge|@json_encode}' floating></altcha-widget>
							</div>
						</fieldset>
					{/if}

					<div class="form-group form-group-buttons">
						<button class="btn btn-primary" type="submit">
							{translate key="user.register"}
						</button>
					</div>
					<div class="form-group form-group-login">
						{translate key="plugins.themes.ajlii.register.haveAccount"}
						{capture assign="rolesProfileUrl"}{url page="user" op="profile" path="roles"}{/capture}
						<a href="{url page="login" source=$rolesProfileUrl}" class="login" data-ajlii-login-open data-bs-toggle="modal" data-bs-target="#loginModal" role="button" aria-haspopup="dialog" aria-controls="loginModal">
							{translate key="plugins.themes.ajlii.register.loginHere"}
						</a>
					</div>
				</form>
			</div>
		</div>
	</div>
</div><!-- .page -->

{include file="frontend/components/footer.tpl"}
