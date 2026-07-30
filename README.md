# African Journal of Library and Information Innovations Theme

OJS theme for the **African Journal of Library and Information Innovations** by the **Consortium of Uganda University Libraries**.

The plugin identity, translation namespace, asset paths, and visible journal branding are aligned for AJLII.

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

## Journal Theme Standards

The theme uses a restrained scholarly layout:

- clean white reading surfaces;
- high-contrast body text;
- teal primary branding with modest gold and red accents;
- serif article typography and sans-serif interface text;
- simple cards, alerts, buttons, and navigation treatment;
- accessible link and focus states.

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

## License

This plugin is licensed under the GNU General Public License. See `LICENSE` for complete terms.

The PT Serif and Fira Sans fonts are distributed under the Open Font License.
