(function () {
	'use strict';

	const ready = function (callback) {
		if (document.readyState === 'loading') {
			document.addEventListener('DOMContentLoaded', callback, { once: true });
		} else {
			callback();
		}
	};

	const textFrom = function (selector, root) {
		const element = (root || document).querySelector(selector);
		return element ? element.textContent.replace(/\s+/g, ' ').trim() : '';
	};

	const pageContext = function () {
		const article = document.querySelector('[data-ajlii-article]');
		const main = article || document.querySelector('main, .page-content, .page, .page-about, .page-contact, .page-privacy, .page-masthead, .page-article, body');
		return {
			title: article ? article.getAttribute('data-article-title') || textFrom('.article-details-fulltitle', article) : document.title,
			abstract: article ? article.getAttribute('data-article-abstract') || textFrom('.article-details-abstract', article) : '',
			text: main ? main.textContent.replace(/\s+/g, ' ').trim().slice(0, 18000) : '',
			url: window.location.href,
			isArticle: Boolean(article)
		};
	};

	const initLoginGuidelines = function () {
		document.addEventListener('click', function (event) {
			document.querySelectorAll('.ajlii-login-guidelines[open]').forEach(function (details) {
				if (!details.contains(event.target)) {
					details.removeAttribute('open');
				}
			});
		});
	};

	const initLoginModal = function () {
		const modalElement = document.getElementById('loginModal');
		const modalApi = window.bootstrap && window.bootstrap.Modal;
		if (!modalElement || !modalApi) return;

		const openers = document.querySelectorAll('[data-ajlii-login-open], .nmi_type_user_login > a, .nmi_type_user_login a');
		const open = function (event) {
			event.preventDefault();
			event.stopImmediatePropagation();
			const modal = modalApi.getOrCreateInstance ? modalApi.getOrCreateInstance(modalElement) : new modalApi(modalElement);
			modal.show();
			const username = modalElement.querySelector('input[name="username"], input[type="text"], input[type="email"]');
			if (username) {
				window.setTimeout(function () {
					username.focus();
				}, 200);
			}
		};

		openers.forEach(function (opener) {
			if (opener.dataset.productionLoginModal === 'true') return;
			opener.dataset.productionLoginModal = 'true';
			opener.setAttribute('aria-haspopup', 'dialog');
			opener.setAttribute('aria-controls', 'loginModal');
			opener.addEventListener('click', open, true);
		});
	};

	const initHeaderSearch = function () {
		document.querySelectorAll('[data-ajlii-header-search]').forEach(function (form) {
			if (form.dataset.productionSearch === 'true') return;
			form.dataset.productionSearch = 'true';
			const scope = form.querySelector('[data-ajlii-search-scope]');
			const query = form.querySelector('[data-ajlii-search-query]');
			if (!scope || !query) return;

			form.addEventListener('submit', function () {
				form.querySelectorAll('[data-ajlii-generated-search-field]').forEach(function (input) {
					input.remove();
				});
				const field = scope.value || 'query';
				query.name = field === 'authors' || field === 'discipline' || field === 'subject' || field === 'indexTerms' ? field : 'query';
				if (field === 'issues') {
					const issueHint = document.createElement('input');
					issueHint.type = 'hidden';
					issueHint.name = 'title';
					issueHint.value = query.value;
					issueHint.setAttribute('data-ajlii-generated-search-field', 'true');
					form.appendChild(issueHint);
				}
			});
		});
	};

	const initCookieConsent = function () {
		const widget = document.querySelector('[data-ajlii-cookie-consent]');
		const settingsButtons = document.querySelectorAll('[data-cookie-settings]');
		const storageKey = 'ajliiCookieConsent.v1';
		const defaults = { necessary: true, performance: false, functional: false, targeting: false, updatedAt: null };
		if (!widget) return;
		const banner = widget.querySelector('.ajlii-cookie-banner');
		const modal = widget.querySelector('[data-cookie-modal]');

		const storedValue = function () {
			try {
				return localStorage.getItem(storageKey);
			} catch (error) {
				return null;
			}
		};

		const read = function () {
			try {
				return Object.assign({}, defaults, JSON.parse(storedValue()) || {});
			} catch (error) {
				return Object.assign({}, defaults);
			}
		};

		let state = read();

		const syncInputs = function () {
			widget.querySelectorAll('[data-cookie-category]').forEach(function (input) {
				input.checked = Boolean(state[input.getAttribute('data-cookie-category')]);
			});
		};

		const publish = function () {
			document.documentElement.dataset.ajliiPerformanceCookies = state.performance ? 'accepted' : 'declined';
			document.documentElement.dataset.ajliiFunctionalCookies = state.functional ? 'accepted' : 'declined';
			document.documentElement.dataset.ajliiTargetingCookies = state.targeting ? 'accepted' : 'declined';
			window.dispatchEvent(new CustomEvent('ajlii:cookieConsent', { detail: Object.assign({}, state) }));
		};

		const save = function (nextState) {
			state = Object.assign({}, defaults, nextState, { necessary: true, updatedAt: new Date().toISOString() });
			try {
				localStorage.setItem(storageKey, JSON.stringify(state));
			} catch (error) {}
			syncInputs();
			publish();
			if (banner) banner.hidden = true;
			if (modal) modal.hidden = true;
			widget.hidden = true;
		};

		const openBanner = function () {
			syncInputs();
			widget.hidden = false;
			if (banner) banner.hidden = false;
			if (modal) modal.hidden = true;
		};

		const openSettings = function () {
			syncInputs();
			widget.hidden = false;
			if (banner && !storedValue()) banner.hidden = false;
			if (modal) modal.hidden = false;
			const firstInput = widget.querySelector('[data-cookie-category]');
			if (firstInput) firstInput.focus();
		};

		const closeSettings = function () {
			if (modal) modal.hidden = true;
			if (storedValue() && banner) {
				banner.hidden = true;
				widget.hidden = true;
			}
		};

		widget.querySelectorAll('[data-cookie-action]').forEach(function (button) {
			button.addEventListener('click', function () {
				const action = button.getAttribute('data-cookie-action');
				if (action === 'accept') {
					save({ performance: true, functional: true, targeting: true });
					return;
				}
				if (action === 'reject') {
					save({ performance: false, functional: false, targeting: false });
					return;
				}
				if (action === 'close') {
					if (banner) banner.hidden = true;
					if (modal) modal.hidden = true;
					widget.hidden = true;
					return;
				}
				const choices = {};
				widget.querySelectorAll('[data-cookie-category]').forEach(function (input) {
					choices[input.getAttribute('data-cookie-category')] = input.checked;
				});
				save(choices);
			});
		});

		settingsButtons.forEach(function (button) {
			button.addEventListener('click', openSettings);
		});

		widget.querySelectorAll('[data-cookie-settings-close]').forEach(function (button) {
			button.addEventListener('click', closeSettings);
		});

		window.ajliiCookieConsent = {
			get: function () {
				return Object.assign({}, state);
			},
			open: openSettings,
			save: save
		};

		if (!storedValue()) {
			openBanner();
		} else {
			widget.hidden = true;
			if (banner) banner.hidden = true;
			if (modal) modal.hidden = true;
			syncInputs();
			publish();
		}
	};

	const initWcag = function () {
		const widget = document.querySelector('[data-wcag-widget]');
		if (!widget || widget.dataset.productionReady === 'true') return;
		widget.dataset.productionReady = 'true';

		const toggle = widget.querySelector('.ajlii-wcag-toggle');
		const panel = widget.querySelector('.ajlii-wcag-panel');
		const close = widget.querySelector('[data-wcag-close]');
		const fontOutput = widget.querySelector('[data-wcag-font-output]');
		const storageKey = 'ajliiAccessibility';
		const toggleNames = ['highlightTitles', 'highlightLinks', 'dyslexiaFont', 'letterSpacing', 'lineHeight', 'fontWeight', 'textAlign', 'muteSounds', 'readingGuide', 'pauseAnimations', 'bigCursor'];
		const exclusiveNames = ['darkContrast', 'lightContrast', 'highContrast', 'highSaturation', 'lowSaturation', 'monochrome'];
		let guide = document.querySelector('.ajlii-reading-guide');

		const defaultState = { fontScale: 100, contrastMode: null, colorMode: null };
		const readState = function () {
			try {
				return Object.assign({}, defaultState, JSON.parse(localStorage.getItem(storageKey)) || {});
			} catch (error) {
				return Object.assign({}, defaultState);
			}
		};
		let state = readState();

		const save = function () {
			localStorage.setItem(storageKey, JSON.stringify(state));
		};

		const updateMedia = function () {
			document.querySelectorAll('audio, video').forEach(function (media) {
				media.muted = Boolean(state.muteSounds);
			});
		};

		const updateGuide = function () {
			if (state.readingGuide && !guide) {
				guide = document.createElement('div');
				guide.className = 'ajlii-reading-guide';
				document.body.appendChild(guide);
			}
			if (guide) {
				guide.hidden = !state.readingGuide;
			}
		};

		const apply = function () {
			toggleNames.concat(exclusiveNames).forEach(function (name) {
				document.body.classList.remove('ajlii-wcag-' + name);
			});
			toggleNames.forEach(function (name) {
				document.body.classList.toggle('ajlii-wcag-' + name, Boolean(state[name]));
			});
			if (state.contrastMode) document.body.classList.add('ajlii-wcag-' + state.contrastMode);
			if (state.colorMode) document.body.classList.add('ajlii-wcag-' + state.colorMode);
			document.documentElement.style.setProperty('--ajlii-wcag-font-scale', (state.fontScale || 100) + '%');
			if (fontOutput) fontOutput.textContent = (state.fontScale || 100) + '%';
			widget.querySelectorAll('[data-wcag-toggle]').forEach(function (button) {
				const name = button.getAttribute('data-wcag-toggle');
				button.classList.toggle('is-active', Boolean(state[name]));
				button.setAttribute('aria-pressed', String(Boolean(state[name])));
			});
			widget.querySelectorAll('[data-wcag-exclusive]').forEach(function (button) {
				const group = button.getAttribute('data-wcag-exclusive');
				const value = button.getAttribute('data-wcag-value');
				const active = state[group] === value;
				button.classList.toggle('is-active', active);
				button.setAttribute('aria-pressed', String(active));
			});
			updateMedia();
			updateGuide();
		};

		const speakPage = function () {
			if (!('speechSynthesis' in window)) return;
			if (window.speechSynthesis.speaking) {
				window.speechSynthesis.cancel();
				return;
			}
			const context = pageContext();
			const utterance = new SpeechSynthesisUtterance((context.title + '. ' + context.abstract + '. ' + context.text).slice(0, 5000));
			utterance.lang = 'en-GB';
			window.speechSynthesis.speak(utterance);
		};

		apply();

		if (toggle && panel) {
			toggle.addEventListener('click', function (event) {
				event.stopImmediatePropagation();
				const nextHidden = !panel.hidden;
				panel.hidden = nextHidden;
				toggle.setAttribute('aria-expanded', String(!nextHidden));
			}, true);
		}
		if (close && panel && toggle) {
			close.addEventListener('click', function (event) {
				event.stopImmediatePropagation();
				panel.hidden = true;
				toggle.setAttribute('aria-expanded', 'false');
			}, true);
		}
		widget.querySelectorAll('[data-wcag-toggle]').forEach(function (button) {
			button.addEventListener('click', function (event) {
				event.stopImmediatePropagation();
				const name = button.getAttribute('data-wcag-toggle');
				state[name] = !state[name];
				save();
				apply();
			}, true);
		});
		widget.querySelectorAll('[data-wcag-exclusive]').forEach(function (button) {
			button.addEventListener('click', function (event) {
				event.stopImmediatePropagation();
				const group = button.getAttribute('data-wcag-exclusive');
				const value = button.getAttribute('data-wcag-value');
				state[group] = state[group] === value ? null : value;
				save();
				apply();
			}, true);
		});
		widget.querySelectorAll('[data-wcag-action]').forEach(function (button) {
			button.addEventListener('click', function (event) {
				event.stopImmediatePropagation();
				const action = button.getAttribute('data-wcag-action');
				if (action === 'fontUp') state.fontScale = Math.min(160, (state.fontScale || 100) + 10);
				if (action === 'fontDown') state.fontScale = Math.max(80, (state.fontScale || 100) - 10);
				if (action === 'profiles') {
					state.dyslexiaFont = true;
					state.lineHeight = true;
					state.highlightLinks = true;
				}
				if (action === 'language') document.documentElement.lang = 'en-GB';
				if (action === 'readPage') speakPage();
				if (action === 'reset') {
					if ('speechSynthesis' in window) window.speechSynthesis.cancel();
					state = Object.assign({}, defaultState);
				}
				save();
				apply();
			}, true);
		});
		document.addEventListener('mousemove', function (event) {
			if (guide && state.readingGuide) {
				guide.style.top = event.clientY + 'px';
			}
		});
	};

	const initReader = function () {
		const modal = document.querySelector('[data-ajlii-reader-modal]');
		if (!modal) return;
		const frame = modal.querySelector('[data-ajlii-reader-frame]');
		const title = modal.querySelector('#ajliiReaderTitle');
		const openLink = modal.querySelector('[data-ajlii-reader-open]');
		const close = function () {
			modal.hidden = true;
			if (frame) frame.removeAttribute('src');
			document.body.classList.remove('ajlii-modal-open');
		};
		document.querySelectorAll('[data-ajlii-reader]').forEach(function (link) {
			if (link.dataset.productionReader === 'true') return;
			link.dataset.productionReader = 'true';
			link.addEventListener('click', function (event) {
				event.preventDefault();
				const href = link.getAttribute('href');
				const readerSrc = link.getAttribute('data-reader-src') || href;
				const downloadHref = link.getAttribute('data-reader-download') || href;
				if (!readerSrc) return;
				if (title) title.textContent = link.getAttribute('data-reader-label') || link.textContent.trim();
				if (frame) frame.setAttribute('src', readerSrc);
				if (openLink) openLink.setAttribute('href', downloadHref || readerSrc);
				modal.hidden = false;
				document.body.classList.add('ajlii-modal-open');
			}, true);
		});
		modal.querySelectorAll('[data-ajlii-reader-close]').forEach(function (button) {
			button.addEventListener('click', close);
		});
		modal.addEventListener('click', function (event) {
			if (event.target === modal) close();
		});
	};

	const initAi = function () {
		const panel = document.querySelector('[data-ajlii-ai-panel]');
		if (!panel) return;
		const answer = panel.querySelector('[data-ai-answer]');
		const status = panel.querySelector('[data-ai-status]');
		const question = panel.querySelector('[data-ai-question]');
		const close = panel.querySelector('[data-ajlii-ai-close]');
		const proxy = panel.getAttribute('data-ai-proxy-url');
		const provider = panel.getAttribute('data-ai-provider') || 'openai';
		const model = panel.getAttribute('data-ai-model') || '';

		const open = function () {
			panel.hidden = false;
			document.body.classList.add('ajlii-modal-open');
			if (question) question.focus();
		};
		const hide = function () {
			panel.hidden = true;
			document.body.classList.remove('ajlii-modal-open');
		};
		const localAnswer = function (action) {
			const context = pageContext();
			const body = context.text || 'No readable page text was detected.';
			if (action === 'keyPoints') return body.replace(/([.!?])\s+/g, '$1|').split('|').slice(0, 5).join('\n\n');
			if (action === 'methods') return /method|survey|interview|case study|sample|data|analysis/i.test(body) ? 'Method or evidence language is visible on this page. Review the highlighted sections in the article text for the full context.' : 'No clear method section was detected in the visible page text.';
			if (action === 'references') return context.isArticle ? 'Use the article references, DOI, keywords, and abstract as your reading path. The Smart Discovery panel can extract visible citation and metadata signals.' : 'This is a journal information page. Use the main navigation, search, and footer links for the relevant AJLII reading path.';
			return (context.abstract || body).slice(0, 900);
		};
		const run = async function (action) {
			const context = pageContext();
			if (status) status.textContent = proxy ? 'Reading page context...' : 'AI proxy is not configured; showing local reading aid.';
			if (answer) answer.textContent = '';
			if (!proxy) {
				if (answer) answer.textContent = localAnswer(action);
				return;
			}
			try {
				const response = await fetch(proxy, {
					method: 'POST',
					headers: { 'Content-Type': 'application/json' },
					credentials: 'same-origin',
					body: JSON.stringify({ provider: provider, model: model, action: action, question: question ? question.value : '', article: context })
				});
				if (!response.ok) throw new Error('The AI service returned HTTP ' + response.status);
				const data = await response.json();
				if (answer) answer.textContent = data.answer || data.text || data.output || 'No answer returned.';
				if (status) status.textContent = 'Done';
			} catch (error) {
				if (status) status.textContent = error.message + ' Showing local reading aid instead.';
				if (answer) answer.textContent = localAnswer(action);
			}
		};

		document.querySelectorAll('[data-ajlii-ai-open], .ajlii-ai-discovery').forEach(function (button) {
			if (button.dataset.productionAi === 'true') return;
			button.dataset.productionAi = 'true';
			button.addEventListener('click', function (event) {
				event.preventDefault();
				open();
			}, true);
		});
		panel.querySelectorAll('[data-ai-action]').forEach(function (button) {
			button.addEventListener('click', function (event) {
				event.stopImmediatePropagation();
				run(button.getAttribute('data-ai-action'));
			}, true);
		});
		if (close) close.addEventListener('click', hide);
		panel.addEventListener('click', function (event) {
			if (event.target === panel) hide();
		});
	};

	const initHomepageSlider = function () {
		document.querySelectorAll('[data-ajlii-home-slider]').forEach(function (slider) {
			if (slider.dataset.productionSlider === 'true') return;
			slider.dataset.productionSlider = 'true';

			const slides = Array.from(slider.querySelectorAll('[data-slider-slide]'));
			const prev = slider.querySelector('[data-slider-prev]');
			const next = slider.querySelector('[data-slider-next]');
			const dots = slider.querySelector('[data-slider-dots]');
			const autoplay = slider.getAttribute('data-autoplay') === 'true' && !window.matchMedia('(prefers-reduced-motion: reduce)').matches;
			let index = Math.max(0, slides.findIndex(function (slide) {
				return slide.classList.contains('is-active');
			}));
			let timer = null;

			if (!slides.length) return;

			const show = function (nextIndex) {
				index = (nextIndex + slides.length) % slides.length;
				slides.forEach(function (slide, slideIndex) {
					const active = slideIndex === index;
					slide.classList.toggle('is-active', active);
					slide.setAttribute('aria-hidden', String(!active));
				});
				if (dots) {
					Array.from(dots.querySelectorAll('button')).forEach(function (dot, dotIndex) {
						const active = dotIndex === index;
						dot.classList.toggle('is-active', active);
						dot.setAttribute('aria-current', active ? 'true' : 'false');
					});
				}
			};

			const stop = function () {
				if (timer) {
					window.clearInterval(timer);
					timer = null;
				}
			};

			const start = function () {
				stop();
				if (autoplay && slides.length > 1) {
					timer = window.setInterval(function () {
						show(index + 1);
					}, 6500);
				}
			};

			if (dots) {
				dots.innerHTML = '';
				slides.forEach(function (slide, slideIndex) {
					const dot = document.createElement('button');
					dot.type = 'button';
					dot.setAttribute('aria-label', 'Show slide ' + (slideIndex + 1));
					dot.addEventListener('click', function () {
						show(slideIndex);
						start();
					});
					dots.appendChild(dot);
				});
			}
			if (prev) {
				prev.addEventListener('click', function () {
					show(index - 1);
					start();
				});
			}
			if (next) {
				next.addEventListener('click', function () {
					show(index + 1);
					start();
				});
			}

			slider.addEventListener('mouseenter', stop);
			slider.addEventListener('mouseleave', start);
			slider.addEventListener('focusin', stop);
			slider.addEventListener('focusout', start);
			show(index);
			start();
		});
	};

	ready(function () {
		initHomepageSlider();
		initLoginGuidelines();
		initLoginModal();
		initHeaderSearch();
		initCookieConsent();
		initWcag();
		initReader();
		initAi();
	});
})();
