{**
 * templates/frontend/components/footer.tpl
 *
 * Copyright (c) 2014-2020 Simon Fraser University
 * Copyright (c) 2003-2020 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief Common site frontend footer.
 *}
<footer class="site-footer">
	<div class="container site-footer-sidebar" role="complementary"
	     aria-label="{translate|escape key="common.navigation.sidebar"}">
		<div class="row">
			{call_hook name="Templates::Common::Sidebar"}
		</div>
	</div>
	<div class="container site-footer-content">
		<div class="row site-footer-grid">
			<div class="col-md-5">
				<h2>{translate key="plugins.themes.ajlii.journalTitle"}</h2>
				<p>{translate key="plugins.themes.ajlii.footer.publisher"}</p>
				<p>{translate key="plugins.themes.ajlii.footer.scope"}</p>
			</div>
			<div class="col-md-3">
				<h3>{translate key="plugins.themes.ajlii.footer.openAccess"}</h3>
				<p>{translate key="plugins.themes.ajlii.footer.ccby"}</p>
				<a href="https://creativecommons.org/licenses/by/4.0/" rel="license noopener" target="_blank">CC BY 4.0 International</a>
			</div>
			<div class="col-md-4">
				<h3>{translate key="plugins.themes.ajlii.footer.contact"}</h3>
				<address>
					{translate key="plugins.themes.ajlii.publisher"}<br>
					Kampala, Uganda<br>
					<a href="{url page="about" op="contact"}">{translate key="plugins.themes.ajlii.footer.contactPage"}</a>
				</address>
				{if $ajliiAuthorityLinks}
					<nav class="ajlii-authority-links" aria-label="{translate|escape key="plugins.themes.ajlii.authority.title"}">
						<h3>{translate key="plugins.themes.ajlii.authority.title"}</h3>
						<ul>
							{foreach from=$ajliiAuthorityLinks item=authorityLink}
								<li><a href="{$authorityLink.url|escape}" target="_blank" rel="me noopener">{$authorityLink.label|escape}</a></li>
							{/foreach}
						</ul>
					</nav>
				{/if}
				{if $pageFooter}
					<div class="site-footer-custom">
						{$pageFooter}
					</div>
				{/if}
			</div>
		</div>
		<div class="site-footer-bottom">
			<p>&copy; {$smarty.now|date_format:"Y"} {translate key="plugins.themes.ajlii.publisher"}. {translate key="plugins.themes.ajlii.footer.copyright"}</p>
			<p>{translate key="plugins.themes.ajlii.footer.platform"} <a href="{url page="about" op="aboutThisPublishingSystem"}">Open Journal Systems</a>.</p>
		</div>
	</div>
</footer><!-- pkp_structure_footer_wrapper -->

{if $ajliiCitationMonitorUrl}
	<div data-ajlii-citation-monitor data-monitor-url="{$ajliiCitationMonitorUrl|escape}" hidden></div>
{/if}

<div class="ajlii-wcag-widget" data-wcag-widget>
	<button class="ajlii-wcag-toggle" type="button" aria-expanded="false" aria-controls="ajliiWcagPanel">
		<span aria-hidden="true" class="ajlii-wcag-toggle-icon">Aa</span>
		<span class="visually-hidden">{translate key="plugins.themes.ajlii.wcag.open"}</span>
	</button>
	<div class="ajlii-wcag-panel" id="ajliiWcagPanel" hidden>
		<div class="ajlii-wcag-header">
			<h2>{translate key="plugins.themes.ajlii.wcag.title"}</h2>
			<button type="button" class="ajlii-wcag-close" data-wcag-close aria-label="{translate key="common.close"}">x</button>
		</div>
		<button type="button" class="ajlii-wcag-language" data-wcag-action="language">
			<span class="ajlii-wcag-icon" aria-hidden="true">EN</span>
			<span>{translate key="plugins.themes.ajlii.wcag.language"}</span>
		</button>
		<button type="button" class="ajlii-wcag-profile" data-wcag-action="profiles"><span class="ajlii-wcag-icon" aria-hidden="true">AP</span><span>{translate key="plugins.themes.ajlii.wcag.profiles"}</span></button>
		<h3>{translate key="plugins.themes.ajlii.wcag.contentAdjustments"}</h3>
		<div class="ajlii-wcag-font-control">
			<span><span class="ajlii-wcag-icon" aria-hidden="true">Tt</span>{translate key="plugins.themes.ajlii.wcag.fontSize"}</span>
			<div>
				<button type="button" data-wcag-action="fontDown" aria-label="{translate key="plugins.themes.ajlii.wcag.fontDown"}">-</button>
				<output data-wcag-font-output>100%</output>
				<button type="button" data-wcag-action="fontUp" aria-label="{translate key="plugins.themes.ajlii.wcag.fontUp"}">+</button>
			</div>
		</div>
		<div class="ajlii-wcag-grid">
			<button type="button" data-wcag-toggle="highlightTitles"><span class="ajlii-wcag-icon" aria-hidden="true">H1</span><span>{translate key="plugins.themes.ajlii.wcag.highlightTitles"}</span></button>
			<button type="button" data-wcag-toggle="highlightLinks"><span class="ajlii-wcag-icon" aria-hidden="true">Ln</span><span>{translate key="plugins.themes.ajlii.wcag.highlightLinks"}</span></button>
			<button type="button" data-wcag-toggle="dyslexiaFont"><span class="ajlii-wcag-icon" aria-hidden="true">Df</span><span>{translate key="plugins.themes.ajlii.wcag.dyslexiaFont"}</span></button>
			<button type="button" data-wcag-toggle="letterSpacing"><span class="ajlii-wcag-icon" aria-hidden="true">AV</span><span>{translate key="plugins.themes.ajlii.wcag.letterSpacing"}</span></button>
			<button type="button" data-wcag-toggle="lineHeight"><span class="ajlii-wcag-icon" aria-hidden="true">LH</span><span>{translate key="plugins.themes.ajlii.wcag.lineHeight"}</span></button>
			<button type="button" data-wcag-toggle="fontWeight"><span class="ajlii-wcag-icon" aria-hidden="true">Wt</span><span>{translate key="plugins.themes.ajlii.wcag.fontWeight"}</span></button>
			<button type="button" data-wcag-toggle="textAlign"><span class="ajlii-wcag-icon" aria-hidden="true">Al</span><span>{translate key="plugins.themes.ajlii.wcag.textAlign"}</span></button>
		</div>
		<h3>{translate key="plugins.themes.ajlii.wcag.colorAdjustments"}</h3>
		<div class="ajlii-wcag-grid">
			<button type="button" data-wcag-exclusive="contrastMode" data-wcag-value="darkContrast"><span class="ajlii-wcag-icon" aria-hidden="true">DC</span><span>{translate key="plugins.themes.ajlii.wcag.darkContrast"}</span></button>
			<button type="button" data-wcag-exclusive="contrastMode" data-wcag-value="lightContrast"><span class="ajlii-wcag-icon" aria-hidden="true">LC</span><span>{translate key="plugins.themes.ajlii.wcag.lightContrast"}</span></button>
			<button type="button" data-wcag-exclusive="contrastMode" data-wcag-value="highContrast"><span class="ajlii-wcag-icon" aria-hidden="true">HC</span><span>{translate key="plugins.themes.ajlii.wcag.highContrast"}</span></button>
			<button type="button" data-wcag-exclusive="colorMode" data-wcag-value="highSaturation"><span class="ajlii-wcag-icon" aria-hidden="true">HS</span><span>{translate key="plugins.themes.ajlii.wcag.highSaturation"}</span></button>
			<button type="button" data-wcag-exclusive="colorMode" data-wcag-value="lowSaturation"><span class="ajlii-wcag-icon" aria-hidden="true">LS</span><span>{translate key="plugins.themes.ajlii.wcag.lowSaturation"}</span></button>
			<button type="button" data-wcag-exclusive="colorMode" data-wcag-value="monochrome"><span class="ajlii-wcag-icon" aria-hidden="true">Mn</span><span>{translate key="plugins.themes.ajlii.wcag.monochrome"}</span></button>
		</div>
		<h3>{translate key="plugins.themes.ajlii.wcag.navigationAdjustments"}</h3>
		<div class="ajlii-wcag-grid">
			<button type="button" data-wcag-toggle="muteSounds"><span class="ajlii-wcag-icon" aria-hidden="true">Mt</span><span>{translate key="plugins.themes.ajlii.wcag.muteSounds"}</span></button>
			<button type="button" data-wcag-action="readPage"><span class="ajlii-wcag-icon" aria-hidden="true">Rd</span><span>{translate key="plugins.themes.ajlii.wcag.readPage"}</span></button>
			<button type="button" data-wcag-toggle="readingGuide"><span class="ajlii-wcag-icon" aria-hidden="true">Gd</span><span>{translate key="plugins.themes.ajlii.wcag.readingGuide"}</span></button>
			<button type="button" data-wcag-toggle="pauseAnimations"><span class="ajlii-wcag-icon" aria-hidden="true">Ps</span><span>{translate key="plugins.themes.ajlii.wcag.pauseAnimations"}</span></button>
			<button type="button" data-wcag-toggle="bigCursor"><span class="ajlii-wcag-icon" aria-hidden="true">Pt</span><span>{translate key="plugins.themes.ajlii.wcag.bigCursor"}</span></button>
		</div>
		<button type="button" class="ajlii-wcag-reset" data-wcag-action="reset"><span class="ajlii-wcag-icon" aria-hidden="true">R</span><span>{translate key="plugins.themes.ajlii.wcag.reset"}</span></button>
	</div>
</div>

<div class="ajlii-reader-modal" data-ajlii-reader-modal hidden>
	<div class="ajlii-reader-dialog" role="dialog" aria-modal="true" aria-labelledby="ajliiReaderTitle">
		<div class="ajlii-reader-header">
			<h2 id="ajliiReaderTitle">{translate key="plugins.themes.ajlii.reader.title"}</h2>
			<div>
				<a data-ajlii-reader-open href="#" target="_blank" rel="noopener">{translate key="plugins.themes.ajlii.reader.newTab"}</a>
				<button type="button" data-ajlii-reader-close aria-label="{translate key="common.close"}">x</button>
			</div>
		</div>
		<iframe title="{translate key="plugins.themes.ajlii.reader.title"}" data-ajlii-reader-frame></iframe>
	</div>
</div>

<div class="ajlii-ai-panel" data-ajlii-ai-panel hidden data-ai-provider="{$ajliiAiProvider|escape}" data-ai-model="{$ajliiAiModel|escape}" data-ai-proxy-url="{$ajliiAiProxyUrl|escape}">
	<div class="ajlii-ai-dialog" role="dialog" aria-modal="true" aria-labelledby="ajliiAiTitle">
		<div class="ajlii-ai-header">
			<div>
				<h2 id="ajliiAiTitle">{translate key="plugins.themes.ajlii.ai.title"}</h2>
				<p>{translate key="plugins.themes.ajlii.ai.providerLabel"}: <span data-ai-provider-label>{$ajliiAiProvider|escape}</span>{if $ajliiAiModel} / {$ajliiAiModel|escape}{/if}</p>
			</div>
			<button type="button" data-ajlii-ai-close aria-label="{translate key="common.close"}">x</button>
		</div>
		<div class="ajlii-ai-body">
			<div class="ajlii-ai-actions">
				<button type="button" data-ai-action="summarize">{translate key="plugins.themes.ajlii.ai.summarize"}</button>
				<button type="button" data-ai-action="keyPoints">{translate key="plugins.themes.ajlii.ai.keyPoints"}</button>
				<button type="button" data-ai-action="methods">{translate key="plugins.themes.ajlii.ai.methods"}</button>
				<button type="button" data-ai-action="references">{translate key="plugins.themes.ajlii.ai.references"}</button>
			</div>
			<label for="ajliiAiQuestion">{translate key="plugins.themes.ajlii.ai.askLabel"}</label>
			<textarea id="ajliiAiQuestion" data-ai-question rows="4" placeholder="{translate key="plugins.themes.ajlii.ai.askPlaceholder"}"></textarea>
			<button type="button" class="btn btn-primary" data-ai-action="ask">{translate key="plugins.themes.ajlii.ai.askButton"}</button>
			<div class="ajlii-ai-status" data-ai-status role="status"></div>
			<div class="ajlii-ai-answer" data-ai-answer tabindex="0"></div>
			<p class="ajlii-ai-note">{translate key="plugins.themes.ajlii.ai.securityNote"}</p>
		</div>
	</div>
</div>

<div class="ajlii-discovery-panel" data-ajlii-discovery-panel hidden>
	<div class="ajlii-discovery-dialog" role="dialog" aria-modal="true" aria-labelledby="ajliiDiscoveryTitle">
		<div class="ajlii-ai-header">
			<div>
				<h2 id="ajliiDiscoveryTitle">{translate key="plugins.themes.ajlii.discovery.title"}</h2>
				<p>{translate key="plugins.themes.ajlii.discovery.subtitle"}</p>
			</div>
			<button type="button" data-ajlii-discovery-close aria-label="{translate key="common.close"}">x</button>
		</div>
		<div class="ajlii-discovery-body">
			<section class="ajlii-discovery-map" aria-labelledby="ajliiDiscoveryMapTitle">
				<h3 id="ajliiDiscoveryMapTitle">{translate key="plugins.themes.ajlii.discovery.map"}</h3>
				<div data-discovery-map></div>
			</section>
			<section class="ajlii-discovery-signals" aria-labelledby="ajliiDiscoverySignalsTitle">
				<h3 id="ajliiDiscoverySignalsTitle">{translate key="plugins.themes.ajlii.discovery.signals"}</h3>
				<div data-discovery-signals></div>
				<p>{translate key="plugins.themes.ajlii.discovery.note"}</p>
			</section>
		</div>
	</div>
</div>

{* Load author biography modals if they exist *}
{if !empty($smarty.capture.authorBiographyModals|default:""|trim)}
	{$smarty.capture.authorBiographyModals}
{/if}

{* Login modal *}
<div id="loginModal" class="modal fade" tabindex="-1" role="dialog">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-body">
				<button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				{include file="frontend/components/loginForm.tpl" formType = "loginModal"}
			</div>
		</div>
	</div>
</div>

{load_script context="frontend" scripts=$scripts}

{call_hook name="Templates::Common::Footer::PageFooter"}
</body>
</html>
