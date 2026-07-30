# AJLII Theme Features

This document lists the production features in the African Journal of Library and Information Innovations theme for OJS 3.5.0-5 LTS.

## Journal Identity

The theme is branded for the African Journal of Library and Information Innovations (AJLII), published by the Consortium of Uganda University Libraries (CUUL).

Example:

```text
African Journal of Library and Information Innovations
Published by the Consortium of Uganda University Libraries
```

The theme uses the `plugins.themes.ajlii` translation namespace and the `AfricanJournalThemePlugin` class.

## OJS 3.5.0-5 LTS Compatibility

The runtime templates use OJS 3.5 publication-level data patterns.

Examples:

```smarty
{assign var=doiObject value=$publication->getData('doiObject')}
{assign var="galleys" value=$publication->getData('galleys')}
{url router=\PKP\core\PKPApplication::ROUTE_PAGE page="issue" op="archive"}
```

The theme version is declared as `1.1.0.0` in `version.xml`.

## British English Standard

AJLII-authored English copy uses British English spelling, grammar, and punctuation.

Examples:

```text
Summarise article
decolonising libraries
heritage digitisation
Creative Commons Attribution 4.0 International Licence
```

Technical identifiers remain unchanged when required by standards.

Examples:

```json
{
  "license": "https://creativecommons.org/licenses/by/4.0/",
  "@type": "Organization"
}
```

## Header Layout

The header uses a journal-style academic layout inspired by large scholarly publishers while preserving CUUL/AJLII branding.

Features:

- CUUL publisher bar.
- AJLII journal band.
- Sky-blue primary journal colour.
- Black navigation bar for journal menu items.
- Search area.
- AI Discovery Assistant signal in the navigation region.

Example navigation areas:

```text
Issues | More Content | Submit | Alerts | About
Search this journal
AI Discovery Assistant
```

## Colour System

The default primary colour is sky blue.

Example:

```text
Default primary colour: #38BDF8
```

The theme keeps CUUL dark and gold accents for contrast and institutional identity.

## Footer

The footer provides a standard open-access journal footer.

Features:

- Journal title and scope.
- CUUL publisher details.
- Open access and CC BY 4.0 International Licence statement.
- Contact page link.
- OJS platform link.
- Optional authority/profile links.

Example:

```text
Articles are published as open access under the Creative Commons Attribution 4.0 International Licence.
```

## Accessibility Tools

The site-wide WCAG menu appears at the bottom left.

Available controls:

- Font size increase and decrease.
- Highlight titles.
- Highlight links.
- Dyslexia-friendly font.
- Letter spacing.
- Line height.
- Font weight.
- Text alignment.
- Dark contrast.
- Light contrast.
- High contrast.
- High saturation.
- Low saturation.
- Monochrome.
- Mute sounds.
- Page read aloud.
- Reading guide.
- Pause animations.
- Big cursor.
- Reset all settings.

Example:

```text
Open Accessibility Tools -> Adjust font size -> 110%
```

Settings are stored locally in the browser under `ajliiAccessibility`.

## In-Browser Galley Reader

Article and issue galley links can open in a modal reader without forcing a download.

Features:

- Opens PDF or file galleys inside an iframe where the browser supports preview.
- Offers an "Open in new tab" link.
- Works across desktop and mobile screens.
- Preserves restricted-access screen reader text.

Example link behaviour:

```text
PDF -> opens AJLII in-browser reader -> Open in new tab
```

## AI Article Assistant

The article assistant supports OpenAI, Claude/Anthropic, or a custom compatible model provider through a server-side proxy.

Available actions:

- Summarise article.
- Key points.
- Methods and evidence.
- Reading guide.
- Custom question and answer.

Example browser request sent to the configured proxy:

```json
{
  "provider": "openai",
  "model": "institution-configured-model",
  "action": "summarize",
  "question": "What are the article's main findings?",
  "article": {
    "title": "Article title",
    "abstract": "Article abstract",
    "text": "Visible article text",
    "url": "https://journal.example/article/view/1"
  }
}
```

Expected proxy response:

```json
{
  "answer": "The assistant response text."
}
```

Security note:

```text
Do not place OpenAI, Claude, or other provider API keys in browser JavaScript.
```

## Smart Discovery

Article pages include a smart-discovery panel.

Features:

- Knowledge map generated from visible article metadata.
- Research signals generated from visible article text.
- Reading-aid disclaimer.

Knowledge map data:

- Article title.
- Authors.
- Keywords.
- References.
- DOI.
- Data availability statement.

Example signals:

```text
Citation context: 24 references are available for reading-path review.
Persistent identifier: DOI detected.
Data transparency: A data availability statement is visible.
Methods signal: The page includes method or evidence language.
```

The signals do not replace peer review, editorial judgement, or author statements.

## SEO Metadata

The theme adds journal-level metadata in `headerHead.tpl`.

Features:

- Description.
- Keywords.
- Author and publisher.
- Robots, Googlebot, and Bingbot directives.
- Classification, subject, coverage, distribution, and rating.
- Dublin Core metadata.
- Citation metadata.
- Open Graph metadata.
- Twitter card metadata.

Example:

```html
<meta name="description" content="African Journal of Library and Information Innovations (AJLII) is a peer-reviewed, gold open-access publication...">
```

## GEO and AEO Optimisation

The theme supports generative engine optimisation and answer engine optimisation.

Features:

- Visible answer capsules on the journal homepage.
- FAQPage JSON-LD.
- Periodical JSON-LD.
- Article-level ScholarlyArticle JSON-LD.
- Freshness metadata.
- AI summary metadata.
- sameAs links from configured authority URLs.

Example answer capsule:

```text
What is AJLII?
AJLII is a peer-reviewed, gold open-access African library and information science journal published by CUUL.
```

Example FAQPage question:

```json
{
  "@type": "Question",
  "name": "Is AJLII open access?",
  "acceptedAnswer": {
    "@type": "Answer",
    "text": "Yes. AJLII follows a gold open-access model..."
  }
}
```

## Structured Data

The theme provides two main JSON-LD structures.

Journal-level `Periodical`:

```json
{
  "@context": "https://schema.org",
  "@type": "Periodical",
  "name": "African Journal of Library and Information Innovations",
  "alternateName": "AJLII",
  "publisher": {
    "@type": "Organization",
    "name": "Consortium of Uganda University Libraries",
    "alternateName": "CUUL"
  }
}
```

Article-level `ScholarlyArticle`:

```json
{
  "@context": "https://schema.org",
  "@type": "ScholarlyArticle",
  "headline": "Article title",
  "abstract": "Article abstract",
  "isAccessibleForFree": true,
  "publisher": {
    "@type": "Organization",
    "name": "Consortium of Uganda University Libraries"
  }
}
```

## Geographic Metadata

The theme marks AJLII as a Uganda-based journal with African continental coverage.

Example:

```html
<meta name="geo.region" content="UG">
<meta name="geo.placename" content="Kampala, Uganda">
<meta name="geo.position" content="0.3476;32.5825">
```

## Authority Links

The theme supports optional profile links configured in theme settings.

Supported links:

- Official website.
- ORCID.
- DOAJ.
- Crossref.
- Google Scholar.
- LinkedIn.
- YouTube.
- Repository or archive.

Example footer output:

```text
AJLII authority links: Website | DOAJ | Crossref | Google Scholar
```

Configured authority URLs are also added to JSON-LD `sameAs`.

## AI and Referral Citation Monitoring

The theme includes an optional citation-monitor hook.

When configured, the browser sends lightweight page visibility data to the journal-owned HTTPS endpoint.

Example payload:

```json
{
  "url": "https://journal.example/article/view/1",
  "title": "Article page title",
  "referrer": "https://example.ai/",
  "source": "example.ai",
  "userAgent": "Browser user agent",
  "timestamp": "2026-07-30T08:00:00.000Z"
}
```

This is a theme-side capability. AJLII or CUUL must provide the HTTPS endpoint that stores and analyses the events.

## Open Access and Copyright

The theme displays open-access publishing details.

Example:

```text
Unless otherwise stated, journal content is licensed under CC BY 4.0 International to support open access publishing.
```

The footer links to:

```text
https://creativecommons.org/licenses/by/4.0/
```

## Article Metadata Display

Article pages support standard OJS metadata display.

Features:

- Title.
- Issue and section.
- Published date and updated version notice.
- Authors.
- ORCID links.
- Affiliations.
- Author biographies.
- DOI.
- Keywords.
- Categories.
- Data availability statement.
- Other publication identifiers.
- Abstract.
- Galleys.
- References.
- Licence terms.
- Usage statistics chart when enabled.

Example:

```text
DOI: https://doi.org/...
Data Availability: Data are available from...
References: listed below article abstract and files.
```

## Homepage Answer Capsules

The journal homepage includes direct-answer content for AI and search engines.

Questions covered:

- What is AJLII?
- Is AJLII open access?
- What peer review model does AJLII use?
- How often is AJLII published?
- What topics does AJLII publish?

Example:

```text
AJLII is published biannually in English, with issues released in June and December.
```

## Theme Options

The theme adds configurable settings in OJS.

Options:

- Primary colour.
- Usage statistics display.
- AI assistant provider.
- AI model name.
- AI proxy endpoint URL.
- AI and referral citation monitor endpoint.
- Authority/profile URLs.

Example:

```text
AI assistant provider: Claude / Anthropic
AI model name: claude-institution-model
AI proxy endpoint URL: https://journal.example/api/ai
```

## Production Runtime Files

The production package keeps the files OJS needs to run the theme.

Runtime files:

- `AfricanJournalThemePlugin.inc.php`
- `index.php`
- `version.xml`
- `locale/`
- `templates/`
- `styles/`
- `fonts/`
- `libs/app.min.css`
- `libs/app.min.js`
- `LICENSE`
- `README.md`
- `features.md`

Development-only files such as Node dependencies, Gulp config, Cypress tests, GitHub workflows, source JavaScript, and unminified bundles are not required in production.
