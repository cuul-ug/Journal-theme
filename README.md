# African Journal of Library and Information Innovations Theme

OJS theme for the **African Journal of Library and Information Innovations** by the **Consortium of Uganda University Libraries**.

AJLII is a peer-reviewed, gold open-access publication that provides a continental platform for library and information science research advancing innovation, collaboration, equity, and knowledge access across Africa.

The plugin identity, translation namespace, asset paths, visible journal branding, SEO metadata, GEO metadata, and machine-readable structured data are aligned for AJLII.

## Journal Profile

- Vision: to be the leading platform for transformative library and information science research across Africa.
- Mission: to advance Pan-African scholarship in academic libraries, digital inclusion, consortia partnerships, and emerging areas while amplifying underrepresented voices.
- Publication model: gold open access, USD 25 Article Processing Charge, biannual publication in June and December, English language.
- Editorial process: double-blind peer review by subject specialists and methodological experts, with African scholars and global partners including EIFL and COAR.
- Focus areas: open access, scholarly communication, digital transformation, consortia collaboration, indigenous knowledge, decolonising libraries, higher education impact, policy, advocacy, research data management, user services, heritage digitisation, AI and automation in libraries, records, and archival management.
- Researcher support: mentorship, pre-submission consultations, writing workshops, and fee waivers for CUUL conference presenters.
- Ethics: transparency in funding, AI-assisted tool use, and ethics approval for human or community-based research.

## GEO and AEO Optimisation

The theme supports generative and answer engine discovery through:

- visible 40-60 word answer capsules on the journal homepage;
- FAQPage JSON-LD for common AI/search questions about AJLII;
- journal-level Periodical JSON-LD with mission, focus areas, ethics, access model, publisher, audience, and sameAs authority links;
- article-level ScholarlyArticle JSON-LD with title, abstract, authors, ORCID links, DOI, publication date, keywords, references, licence, and publisher;
- freshness signals through visible update text and dateModified metadata;
- configurable official profile links for website, ORCID, DOAJ, Crossref, Google Scholar, LinkedIn, YouTube, and repository/archive pages;
- an optional AI and referral citation monitor endpoint that receives lightweight page, referrer, source, timestamp, and user-agent events.

Configure authority URLs and the citation monitor endpoint in the theme settings. The monitor endpoint must be an HTTPS URL owned by the journal or institution.

## Plugin Identity

- Plugin folder/application: `ajlii`
- Theme class: `AfricanJournalThemePlugin`
- Translation namespace: `plugins.themes.ajlii`
- Display name: `African Journal of Library and Information Innovations by Consortium of Uganda University Libraries`

## Installation

1. Copy this directory to your OJS installation at `plugins/themes/ajlii`.
2. In OJS, go to `Settings` > `Website` > `Plugins`.
3. Enable the **African Journal of Library and Information Innovations** theme.
4. Go to `Settings` > `Website` > `Appearance`.
5. Select `ajlii` as the active theme and save.

## Compatibility

This release is prepared for OJS 3.5.0-5 LTS and PHP 8.2+ environments. It uses OJS 3.5 publication DOI objects, publication-level galleys, Bootstrap 5 data attributes/classes, and `PKPApplication::ROUTE_PAGE` route constants.

## Journal Theme Standards

The theme uses a restrained scholarly layout:

- clean white reading surfaces;
- high-contrast body text;
- sky-blue primary branding with CUUL dark and gold accents;
- serif article typography and sans-serif interface text;
- simple cards, alerts, buttons, and navigation treatment;
- accessible link and focus states.

## English Standard

All AJLII-authored English interface text, documentation, SEO copy, GEO copy, AEO answer capsules, and structured-data prose should use British English spelling, grammar, and punctuation. Preserve technical identifiers, schema.org property names, file names, code symbols, and official licence URLs exactly as required by OJS, JSON-LD, Creative Commons, and related standards.

## AI Assistant

The article assistant is designed to work with OpenAI, Claude/Anthropic, or a custom compatible model provider through a server-side proxy endpoint configured in the theme settings.

Do not place provider API keys in browser JavaScript. Store keys on the server, then expose an HTTPS endpoint that accepts article context and returns a JSON response such as:

```json
{
  "answer": "Assistant response text"
}
```

The browser sends `provider`, `model`, `action`, `question`, and `article` fields to the configured proxy.

## Smart Discovery

The selected futuristic feature for AJLII is an AI and smart-discovery reading layer. Article pages include:

- an article assistant for natural-language questions through the configured model proxy;
- an in-browser galley reader so files can be opened without forced downloads;
- a smart-discovery panel that builds a visible knowledge map from article title, authors, keywords, DOI, references, and data availability metadata;
- automated research signals that highlight citation context, persistent identifiers, data transparency, methods language, limitation language, and replication/reproducibility clues.

These signals are reading aids generated from visible page content. They do not replace peer review, editorial assessment, or author-provided research statements.

## Development

Install dependencies:

```bash
npm install
```

Build the bundled assets:

```bash
npm run build
```

The source LESS styles live in `styles/`. The compiled vendor bundle lives in `libs/`.

## Licence

This plugin is licensed under the GNU General Public Licence. See `LICENSE` for complete terms.

The PT Serif and Fira Sans fonts are distributed under the Open Font Licence.
