# resume.nix

Reproducible personal résumé built & deployed using [Nix](https://nixos.org/) &
[jsonresume](https://jsonresume.org/).
Supports a broad number of themes.

## Getting started

Initialize your own resume repository from one of the templates here by running:

  `nix flake init -t github:Lehmanator/resume.nix`

Template will come with a `builder` package, and a selection of theme packages that are passed to the builder.
To build your résumé, first edit the data inside `src/resume.nix`, then select one of the packages to build.

Each theme will have one of the following packages:

- Theme Package: `jsonresume-theme-<THEMENAME>`
- HTML Builder: `jsonresume-html-<THEMENAME>`
- PDF Builder: `jsonresume-pdf-<THEMENAME>`

For example, to build a PDF document of your résumé, run:

  `nix build .#jsonresume-pdf-<THEMENAME>`

Or to build the HTML static site, run:

  `nix build .#jsonresume-html-<THEMENAME>`

You will then find either `resume.pdf` or `index.html` inside `./result` directory.

Provided is a default package using a pre-selected theme. This makes building as simple as running: `nix build` with no extra arguments. To change which theme is used, edit the default package in `flake.nix` to point to some other `config.packages.jsonresume-theme-<THEMENAME>` package.

Included are package definitions for other utils, themes, etc.
These may not all be complete or functioning for the time-being.

To list all available packages, run:

  `nix flake show github:Lehmanator/resume.nix`

## Additional Themes

Check NPM for other themes. Most should be fairly trivial to include,
and can mostly be copy-and-pasted from other theme package files in
`packages/jsonresume-themes/<THEMENAME>`

[Search NPM packages for jsonresume themes](https://www.npmjs.com/search?q=jsonresume-theme)

## Planned Features

Features I plan on implementing at some point.
**Contributions welcome!**

See:

- To-Do document: [`./docs/todo.md`](./docs/todo.md)
- [GitHub Issues](https://github.com/Lehmanator/resume.nix/issues)

## Thanks

- [TaserudConsulting](https://github.com/TaserudConsulting): Developer who created the [flake repo I originally forked this one from](https://github.com/TaserudConsulting/jsonresume-nix). Consider using that project if it better fits your needs. My repo has diverged substantially.
- [rbardini](https://github.com/rbardini): Developer of the [`resumed` util](https://github.com/rbardini/resumed) that builds `index.html` artifacts.
- [JarvusInnovations](https://github.com/JarvusInnovations): Developer of the [`puppeteer-cli` util](https://github.com/JarvusInnovations/puppeteer-cli) that builds the `resume.pdf` artifacts from a `index.html` file.
- Maintainers of the `jsonresume` & `RenderCV` projects
- Developers of various `jsonresume` & `RenderCV` themes used here.
- The entire `jsonresume` community.
