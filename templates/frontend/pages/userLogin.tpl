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
		<h1>{translate key="plugins.themes.ajlii.login.title"}</h1>
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
	</div>
</div>
{include file="frontend/components/footer.tpl"}
