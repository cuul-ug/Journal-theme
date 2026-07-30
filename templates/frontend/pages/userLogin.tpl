{**
 * templates/frontend/pages/userLogin.tpl
 *
 * Copyright (c) 2014-2020 Simon Fraser University
 * Copyright (c) 2000-2017 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * User login form.
 *
 *}
{include file="frontend/components/header.tpl" pageTitle="user.login"}

<div class="container page-login page-user-login">
	<header class="page-header ajlii-login-hero">
		<p class="ajlii-page-kicker">{translate key="plugins.themes.ajlii.login.kicker"}</p>
		<h1>{translate key="plugins.themes.ajlii.login.title"}</h1>
		<p>{translate key="plugins.themes.ajlii.login.intro"}</p>
	</header>

	<div class="ajlii-login-layout">
		<main class="page-content ajlii-login-card" aria-labelledby="ajliiLoginFormTitle">
			<h2 id="ajliiLoginFormTitle">{translate key="user.login"}</h2>

				{* A login message may be displayed if the user was redireceted to the
				   login page from another request. Examples include if login is required
				   before dowloading a file. *}
				{if $loginMessage}
					<p>
						{translate key=$loginMessage}
					</p>
				{/if}

				{if $error}
					<div class="alert alert-danger" role="alert">
						{translate key=$error reason=$reason}
					</div>
				{/if}

				{include file="frontend/components/loginForm.tpl" formType = "loginPage"}

		</main>
		<aside class="ajlii-login-support" aria-label="{translate|escape key="plugins.themes.ajlii.login.supportTitle"}">
			<section>
				<h2>{translate key="plugins.themes.ajlii.login.supportTitle"}</h2>
				<ul>
					<li>{translate key="plugins.themes.ajlii.login.readerSupport"}</li>
					<li>{translate key="plugins.themes.ajlii.login.authorSupport"}</li>
					<li>{translate key="plugins.themes.ajlii.login.editorSupport"}</li>
				</ul>
			</section>
			<nav aria-label="{translate|escape key="plugins.themes.ajlii.login.accountLinks"}">
				<h2>{translate key="plugins.themes.ajlii.login.accountLinks"}</h2>
				{if !$disableUserReg}
					<a href="{url page="user" op="register" source=$source}">{translate key="plugins.themes.ajlii.register.registerHere"}</a>
				{/if}
				<a href="{url page="login" op="lostPassword"}">{translate key="user.login.forgotPassword"}</a>
				<a href="{url page="about" op="contact"}">{translate key="plugins.themes.ajlii.footer.contact"}</a>
			</nav>
		</aside>
	</div>
</div>
{include file="frontend/components/footer.tpl"}
