/**
 * @file /js/main.js
 *
 * Copyright (c) 2014-2023 Simon Fraser University
 * Copyright (c) 2000-2023 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief Handle JavaScript functionality unique to this theme.
 */
(function () {

	// Open login modal when nav menu links clicked
	document.querySelectorAll('.nmi_type_user_login').forEach((userLogin) => {
		userLogin.addEventListener('click', function (event) {
			event.preventDefault();
			const loginModal = new bootstrap.Modal('#loginModal');
			loginModal.show();
		});
	});
})();

(function () {
	const monitor = document.querySelector('[data-ajlii-citation-monitor]');
	if (!monitor) {
		return;
	}

	const endpoint = monitor.getAttribute('data-monitor-url');
	if (!endpoint || !/^https?:\/\//i.test(endpoint)) {
		return;
	}

	const payload = JSON.stringify({
		url: window.location.href,
		title: document.title,
		referrer: document.referrer,
		source: document.referrer ? new URL(document.referrer).hostname : 'direct-or-private',
		userAgent: navigator.userAgent,
		timestamp: new Date().toISOString()
	});

	if (navigator.sendBeacon) {
		navigator.sendBeacon(endpoint, new Blob([payload], { type: 'application/json' }));
		return;
	}

	fetch(endpoint, {
		method: 'POST',
		headers: {
			'Content-Type': 'application/json'
		},
		body: payload,
		keepalive: true,
		credentials: 'omit'
	}).catch(function () {});
})();

(function () {
	const widget = document.querySelector('[data-wcag-widget]');
	if (!widget) {
		return;
	}

	const toggle = widget.querySelector('.ajlii-wcag-toggle');
	const panel = widget.querySelector('.ajlii-wcag-panel');
	const close = widget.querySelector('[data-wcag-close]');
	const fontOutput = widget.querySelector('[data-wcag-font-output]');
	const storageKey = 'ajliiAccessibility';
	const toggleClasses = [
		'highlightTitles',
		'highlightLinks',
		'dyslexiaFont',
		'letterSpacing',
		'lineHeight',
		'fontWeight',
		'textAlign',
		'muteSounds',
		'readingGuide',
		'pauseAnimations',
		'bigCursor'
	];
	const exclusiveClasses = ['darkContrast', 'lightContrast', 'highContrast', 'highSaturation', 'lowSaturation', 'monochrome'];

	function getSettings() {
		try {
			return Object.assign({ fontScale: 100 }, JSON.parse(localStorage.getItem(storageKey)) || {});
		} catch (error) {
			return { fontScale: 100 };
		}
	}

	function saveSettings(settings) {
		localStorage.setItem(storageKey, JSON.stringify(settings));
	}

	function applySettings(settings) {
		toggleClasses.concat(exclusiveClasses).forEach((key) => {
			document.body.classList.remove('ajlii-wcag-' + key);
		});
		toggleClasses.forEach((key) => {
			document.body.classList.toggle('ajlii-wcag-' + key, Boolean(settings[key]));
		});
		if (settings.contrastMode) {
			document.body.classList.add('ajlii-wcag-' + settings.contrastMode);
		}
		if (settings.colorMode) {
			document.body.classList.add('ajlii-wcag-' + settings.colorMode);
		}
		document.documentElement.style.setProperty('--ajlii-wcag-font-scale', (settings.fontScale || 100) + '%');
		if (fontOutput) {
			fontOutput.textContent = (settings.fontScale || 100) + '%';
		}
	}

	let settings = getSettings();
	applySettings(settings);

	toggle.addEventListener('click', function () {
		const isOpen = !panel.hidden;
		panel.hidden = isOpen;
		toggle.setAttribute('aria-expanded', String(!isOpen));
	});

	if (close) {
		close.addEventListener('click', function () {
			panel.hidden = true;
			toggle.setAttribute('aria-expanded', 'false');
		});
	}

	widget.querySelectorAll('[data-wcag-toggle]').forEach((button) => {
		button.addEventListener('click', function () {
			const key = this.getAttribute('data-wcag-toggle');
			settings[key] = !settings[key];
			saveSettings(settings);
			applySettings(settings);
		});
	});

	widget.querySelectorAll('[data-wcag-exclusive]').forEach((button) => {
		button.addEventListener('click', function () {
			const key = this.getAttribute('data-wcag-exclusive');
			const value = this.getAttribute('data-wcag-value');
			settings[key] = settings[key] === value ? null : value;
			saveSettings(settings);
			applySettings(settings);
		});
	});

	widget.querySelectorAll('[data-wcag-action]').forEach((button) => {
		button.addEventListener('click', function () {
			const action = this.getAttribute('data-wcag-action');
			if (action === 'fontUp') {
				settings.fontScale = Math.min(150, (settings.fontScale || 100) + 10);
			}
			if (action === 'fontDown') {
				settings.fontScale = Math.max(80, (settings.fontScale || 100) - 10);
			}
			if (action === 'readPage') {
				if ('speechSynthesis' in window) {
					window.speechSynthesis.cancel();
					const text = document.querySelector('main, .page-content, .article-details, body').innerText;
					window.speechSynthesis.speak(new SpeechSynthesisUtterance(text.slice(0, 4000)));
				}
			}
			if (action === 'reset') {
				settings = { fontScale: 100 };
			}
			saveSettings(settings);
			applySettings(settings);
		});
	});
})();

(function () {
	const modal = document.querySelector('[data-ajlii-reader-modal]');
	if (!modal) {
		return;
	}

	const frame = modal.querySelector('[data-ajlii-reader-frame]');
	const openLink = modal.querySelector('[data-ajlii-reader-open]');
	const title = modal.querySelector('#ajliiReaderTitle');
	const closeButtons = modal.querySelectorAll('[data-ajlii-reader-close]');

	function closeReader() {
		modal.hidden = true;
		frame.removeAttribute('src');
		document.body.classList.remove('ajlii-modal-open');
	}

	document.querySelectorAll('[data-ajlii-reader]').forEach((link) => {
		link.addEventListener('click', function (event) {
			event.preventDefault();
			const url = this.getAttribute('href');
			const label = this.getAttribute('data-reader-label') || this.textContent.trim();
			title.textContent = label;
			frame.setAttribute('src', url);
			openLink.setAttribute('href', url);
			modal.hidden = false;
			document.body.classList.add('ajlii-modal-open');
		});
	});

	closeButtons.forEach((button) => button.addEventListener('click', closeReader));
	modal.addEventListener('click', function (event) {
		if (event.target === modal) {
			closeReader();
		}
	});
})();

(function () {
	const panel = document.querySelector('[data-ajlii-ai-panel]');
	const article = document.querySelector('[data-ajlii-article]');
	if (!panel || !article) {
		return;
	}

	const answer = panel.querySelector('[data-ai-answer]');
	const status = panel.querySelector('[data-ai-status]');
	const question = panel.querySelector('[data-ai-question]');
	const proxyUrl = panel.getAttribute('data-ai-proxy-url');
	const provider = panel.getAttribute('data-ai-provider') || 'openai';
	const model = panel.getAttribute('data-ai-model') || '';

	function getArticleContext() {
		const text = article.innerText.replace(/\s+/g, ' ').trim();
		return {
			title: article.getAttribute('data-article-title') || '',
			abstract: article.getAttribute('data-article-abstract') || '',
			text: text.slice(0, 18000),
			url: window.location.href
		};
	}

	function openAssistant() {
		panel.hidden = false;
		document.body.classList.add('ajlii-modal-open');
		question.focus();
	}

	function closeAssistant() {
		panel.hidden = true;
		document.body.classList.remove('ajlii-modal-open');
	}

	async function runAssistant(action) {
		if (!proxyUrl) {
			status.textContent = 'AI proxy endpoint is not configured in the AJLII theme settings.';
			answer.textContent = '';
			return;
		}

		status.textContent = 'Reading article context...';
		answer.textContent = '';

		try {
			const response = await fetch(proxyUrl, {
				method: 'POST',
				headers: {
					'Content-Type': 'application/json'
				},
				credentials: 'same-origin',
				body: JSON.stringify({
					provider: provider,
					model: model,
					action: action,
					question: question.value,
					article: getArticleContext()
				})
			});
			if (!response.ok) {
				throw new Error('The AI service returned HTTP ' + response.status);
			}
			const data = await response.json();
			answer.textContent = data.answer || data.text || data.output || 'No answer returned.';
			status.textContent = 'Done';
		} catch (error) {
			status.textContent = error.message;
		}
	}

	document.querySelectorAll('[data-ajlii-ai-open]').forEach((button) => {
		button.addEventListener('click', openAssistant);
	});
	panel.querySelector('[data-ajlii-ai-close]').addEventListener('click', closeAssistant);
	panel.querySelectorAll('[data-ai-action]').forEach((button) => {
		button.addEventListener('click', function () {
			runAssistant(this.getAttribute('data-ai-action'));
		});
	});
	panel.addEventListener('click', function (event) {
		if (event.target === panel) {
			closeAssistant();
		}
	});
})();

(function () {
	const panel = document.querySelector('[data-ajlii-discovery-panel]');
	const article = document.querySelector('[data-ajlii-article]');
	if (!panel || !article) {
		return;
	}

	const mapTarget = panel.querySelector('[data-discovery-map]');
	const signalsTarget = panel.querySelector('[data-discovery-signals]');

	function textFrom(selector, root) {
		const node = (root || document).querySelector(selector);
		return node ? node.textContent.replace(/\s+/g, ' ').trim() : '';
	}

	function listFrom(selector, root) {
		return Array.from((root || document).querySelectorAll(selector))
			.map((node) => node.textContent.replace(/\s+/g, ' ').trim())
			.filter(Boolean);
	}

	function createNode(label, value, modifier) {
		const node = document.createElement('div');
		node.className = 'ajlii-knowledge-node' + (modifier ? ' ' + modifier : '');
		const labelElement = document.createElement('span');
		labelElement.textContent = label;
		const valueElement = document.createElement('strong');
		valueElement.textContent = value;
		node.append(labelElement, valueElement);
		return node;
	}

	function createSignal(label, value, isStrong) {
		const item = document.createElement('li');
		item.className = isStrong ? 'is-strong' : 'is-watch';
		const labelElement = document.createElement('strong');
		labelElement.textContent = label;
		const valueElement = document.createElement('span');
		valueElement.textContent = value;
		item.append(labelElement, valueElement);
		return item;
	}

	function getDiscoveryData() {
		const text = article.innerText.replace(/\s+/g, ' ').trim();
		const referenceNodes = document.querySelectorAll('.article-details-references-value p');
		const rawReferences = referenceNodes.length ? listFrom('.article-details-references-value p') : textFrom('.article-details-references-value').split(/\n+/);
		const references = rawReferences.map((reference) => reference.trim()).filter(Boolean);
		const doi = textFrom('.article-details-doi a');
		const dataAvailability = textFrom('.article-details-dataAvailability p');
		const abstract = article.getAttribute('data-article-abstract') || textFrom('.article-details-abstract');

		return {
			title: article.getAttribute('data-article-title') || textFrom('.article-details-fulltitle') || document.title,
			authors: listFrom('.authors-string li span').slice(0, 8),
			keywords: listFrom('.article-details-keywords-value span').slice(0, 10),
			references: references,
			doi: doi,
			dataAvailability: dataAvailability,
			abstract: abstract,
			text: text
		};
	}

	function renderMap(data) {
		mapTarget.innerHTML = '';
		const map = document.createElement('div');
		map.className = 'ajlii-knowledge-map';
		map.setAttribute('role', 'list');
		map.appendChild(createNode('Article', data.title, 'is-main'));
		map.appendChild(createNode('Authors', data.authors.length ? data.authors.join(', ') : 'Not listed on page'));
		map.appendChild(createNode('Keywords', data.keywords.length ? data.keywords.join(', ') : 'No keywords detected'));
		map.appendChild(createNode('References', data.references.length ? data.references.length + ' cited sources detected' : 'No references detected'));
		map.appendChild(createNode('Identifier', data.doi || 'No DOI detected'));
		map.appendChild(createNode('Data', data.dataAvailability ? 'Data availability statement present' : 'No data availability statement detected'));
		mapTarget.appendChild(map);
	}

	function renderSignals(data) {
		signalsTarget.innerHTML = '';
		const signals = document.createElement('ul');
		signals.className = 'ajlii-signal-list';
		const text = (data.abstract + ' ' + data.text).toLowerCase();
		const mentionsMethods = /method|survey|interview|case stud|dataset|sample|analysis|experiment/.test(text);
		const mentionsLimitations = /limitation|constraint|future research|further research|bias|validity|reliability/.test(text);
		const mentionsReplication = /replicat|reproduc|open data|available data|supplementary/.test(text);

		signals.appendChild(createSignal('Citation context', data.references.length ? data.references.length + ' references are available for reading-path review.' : 'References were not detected on this page.', Boolean(data.references.length)));
		signals.appendChild(createSignal('Persistent identifier', data.doi ? 'DOI detected: ' + data.doi : 'No DOI was detected in the visible metadata.', Boolean(data.doi)));
		signals.appendChild(createSignal('Discovery metadata', data.keywords.length ? data.keywords.length + ' keywords support topic discovery and indexing.' : 'No keywords were detected for semantic discovery.', Boolean(data.keywords.length)));
		signals.appendChild(createSignal('Data transparency', data.dataAvailability ? 'A data availability statement is visible.' : 'No data availability statement was detected.', Boolean(data.dataAvailability)));
		signals.appendChild(createSignal('Methods signal', mentionsMethods ? 'The page includes method or evidence language.' : 'Method language is limited in the visible text.', mentionsMethods));
		signals.appendChild(createSignal('Limitations signal', mentionsLimitations ? 'Limitation or future-research language is visible.' : 'No explicit limitation language was detected.', mentionsLimitations));
		signals.appendChild(createSignal('Replication signal', mentionsReplication ? 'Replication, reproducibility, or supporting-data language is visible.' : 'No replication or reproducibility language was detected.', mentionsReplication));
		signalsTarget.appendChild(signals);
	}

	function openDiscovery() {
		const data = getDiscoveryData();
		renderMap(data);
		renderSignals(data);
		panel.hidden = false;
		document.body.classList.add('ajlii-modal-open');
	}

	function closeDiscovery() {
		panel.hidden = true;
		document.body.classList.remove('ajlii-modal-open');
	}

	document.querySelectorAll('[data-ajlii-discovery-open]').forEach((button) => {
		button.addEventListener('click', openDiscovery);
	});
	panel.querySelector('[data-ajlii-discovery-close]').addEventListener('click', closeDiscovery);
	panel.addEventListener('click', function (event) {
		if (event.target === panel) {
			closeDiscovery();
		}
	});
})();

(function () {
	const pageArticle = document.querySelector('.page-article');
	if (!pageArticle) {
		return;
	}

	// Show author affiliation under authors list (for large screen only)
	const authorLinks = document.querySelectorAll('.author-string-href');
	authorLinks.forEach(function (authorLink) {
		authorLink.addEventListener('click', function (event) {
			event.preventDefault();
			const elementId = this.getAttribute('href').replace('#', '');
			document.querySelectorAll('.article-details-author').forEach((details) => {

				// Show only targeted author's affiliation on click
				if (details.getAttribute('id') === elementId && details.classList.contains('hideAuthor')) {
					details.classList.remove('hideAuthor');
				} else {
					details.classList.add('hideAuthor');
				}
			});

			// Add specifiers to the clicked author's link
			authorLinks.forEach((sibling) => {
				if (authorLink === sibling && !sibling.classList.contains('active')) {
					sibling.classList.add('active');
					sibling.querySelector('.author-plus').classList.add('hidden');
					sibling.querySelector('.author-minus').classList.remove('hidden');
				} else {
					sibling.classList.remove('active');
					sibling.querySelector('.author-plus').classList.remove('hidden');
					sibling.querySelector('.author-minus').classList.add('hidden');
				}
			});
		});
	});
})();

(function() {
	if (!document.querySelector('.page-register')) {
		return;
	}

	const checkboxReviewerInterests = document.querySelector('#reviewerOptinGroup input[type="checkbox"]');
	if (!checkboxReviewerInterests) {
		return;
	}

	/**
	 * Reveal the reviewer interests field on the registration form when a
	 * user has opted to register as a reviewer
	 *
	 * @see: /templates/frontend/pages/userRegister.tpl
	 */
	function reviewerInterestsToggle() {
		if (checkboxReviewerInterests.checked) {
			document.getElementById('reviewerInterests').classList.remove('hidden');
		} else {
			document.getElementById('reviewerInterests').classList.add('hidden');
		}
	}

	// Update interests on page load and when the toggled is toggled
	reviewerInterestsToggle();
	checkboxReviewerInterests.addEventListener('click', reviewerInterestsToggle);
})();

// change article's blocks logic for small screens

(function () {

	const mainArticleContent = document.getElementById('mainArticleContent');
	if (!mainArticleContent) {
		return;
	}

	const articleDetailsWrapper = document.getElementById('articleDetailsWrapper');
	const articleDetails = document.getElementById('articleDetails');
	let articleDetailsChildren = articleDetails.children;

	const articleMainWrapper = document.getElementById('articleMainWrapper');
	const articleMain = document.getElementById('articleMain');
	let articleMainChildren = articleMain.children;

	const dataForMobilesMark = "data-for-mobiles";

	function reorganizeArticleBlocks() {
		if (mainArticleContent && !mainArticleContent.classList.contains(dataForMobilesMark) && window.innerWidth < 992) {
			const detailsClone = [].concat(...articleDetailsChildren);
			const mainClone = [].concat(...articleMainChildren);
			const articleBlockMobile = document.createElement('div');
			articleBlockMobile.classList.add('col-lg', 'article-blocks-mobile');
			articleBlockMobile.append(...articleDetailsChildren, ...articleMainChildren);

			while (mainArticleContent.lastElementChild) {
				mainArticleContent.removeChild(mainArticleContent.lastElementChild);
			}
			mainArticleContent.appendChild(articleBlockMobile);

			articleDetailsChildren = detailsClone;
			articleMainChildren = mainClone;
			mainArticleContent.classList.add(dataForMobilesMark);
		} else if (mainArticleContent && mainArticleContent.classList.contains(dataForMobilesMark) && window.innerWidth >= 992) {
			while (mainArticleContent.lastElementChild) {
				mainArticleContent.removeChild(mainArticleContent.lastElementChild);
			}

			mainArticleContent.appendChild(articleDetailsWrapper);
			articleDetailsWrapper.appendChild(articleDetails);
			articleDetails.append(...articleDetailsChildren);

			mainArticleContent.appendChild(articleMainWrapper);
			articleMainWrapper.appendChild(articleMain);
			articleMain.append(...articleMainChildren);

			mainArticleContent.classList.remove(dataForMobilesMark);
		}
	}

	reorganizeArticleBlocks();

	window.addEventListener("resize", function () {
		reorganizeArticleBlocks();
	});
})();

// Functionality of more/less buttons for the journal description (index journal page)

(function () {
	var journalDescription = document.getElementById('homepageDescription');

	if (!journalDescription) return false;

	var moreButton = document.getElementById('homepageDescriptionMore');
	var lessButton = document.getElementById('homepageDescriptionLess');
	var descriptionButtons = document.getElementById('homepageDescriptionButtons');

	if (journalDescription.offsetHeight < journalDescription.scrollHeight) {
		moreButton.classList.remove('hidden');
		descriptionButtons.classList.remove('hidden');
	}

	moreButton.onclick = function () {
		journalDescription.classList.remove('long-text');
		this.classList.add('hidden');
		lessButton.classList.remove('hidden');
	};

	lessButton.onclick = function () {
		journalDescription.classList.add('long-text');
		this.classList.add('hidden');
		moreButton.classList.remove('hidden');
	};
})();

// Toggle display of consent checkboxes in site-wide registration
(function () {
	const contextOptinGroup = document.getElementById('contextOptinGroup');
	if (!contextOptinGroup) {
		return;
	}

	const privacyVisible = 'context_privacy_visible';

	contextOptinGroup.querySelectorAll(':scope .list-group-item').forEach((context) => {
		const roleInputs = context.querySelectorAll(':scope .roles input[type=checkbox]');
		roleInputs.forEach((roleInput) => {
			roleInput.addEventListener('change', function () {
				const contextPrivacy = context.querySelector('.context_privacy');
				if (!contextPrivacy) {
					return;
				}

				if (this.checked) {
					if (!contextPrivacy.classList.contains(privacyVisible)) {
						contextPrivacy.classList.add(privacyVisible);
						return;
					}
				}

				for (let i = 0; i < roleInputs.length; i++) {
					const sibling = roleInputs[i];
					if (sibling === roleInput) {
						continue;
					}
					if (sibling.checked) {
						return;
					}
				}

				contextPrivacy.classList.remove(privacyVisible);
			});
		});
	});
})();
