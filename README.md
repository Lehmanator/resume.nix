# resume.nix

Reproducible personal résumé built & deployed using [Nix](https://nixos.org/) and
[jsonresume](https://jsonresume.org/). Supports a broad number of themes.

## Getting started

- [ ] **TODO: Create template**

Create your own `resume` repository and run

    nix flake init -t github:Lehmanator/resume.nix

to clone the template to use this flake.

Template will come with a `builder` package, and a selection of theme packages that are passed to the builder.
To build your résumé, first edit the data inside `src/resume.nix`, then select one of the packages to build.

Each theme will have one of the following packages:

- Theme Package: `jsonresume-theme-THEMENAME`
- HTML Builder: `jsonresume-html-THEMENAME`
- PDF Builder: `jsonresume-pdf-THEMENAME`

For example, to build a PDF document of your résumé, run:

    `nix build .#jsonresume-pdf-THEMENAME`

Or to build the HTML static site, run:

    `nix build .#jsonresume-html-THEMENAME`

You will then find either `resume.pdf` or `index.html` inside `./result` directory.

Provided is a default package using a pre-selected theme. This makes building as simple as running: `nix build` with no extra arguments. To change which theme is used, edit the default package in `flake.nix` to point to some other `config.packages.jsonresume-theme-THEMENAME` package.

Included are package definitions for other utils, themes, etc.
These may not all be complete or functioning for the time-being.

To list all available packages, run:

    nix flake show github:Lehmanator/resume.nix

## More Themes

Check NPM for other themes. Most should be fairly trivial to include,
and can mostly be copy-and-pasted from other theme package files in
`packages/jsonresume-themes/THEMENAME`

<https://www.npmjs.com/search?q=jsonresume-theme>

## To-Do

List of features I'd like to implement at some point.
Plz help me. Contributions welcome!

- [ ] GitHub/GitLab Pages deployment
- [ ] GitHub/GitLab Releases deployment
- [ ] Formatters via `treefmt-nix`
- [ ] QR code links to your HTML deployments or PDF release artifacts.
- [ ] Co-existing theme deployments.
- [ ] Markdown conversion
- [ ] LaTeX support
- [ ] flake checks
- [ ] PDF signing
- [ ] More themes!

### Nix Environments

- [ ] `devShell` for building, hacking on themes, etc.
- [ ] `hmModules.jsonresume` implementing [home-manager](https://github.com/nix-community/home-manager) options to allow setting your data as a part of your `homeConfigurations`
- [ ] `nixosModules.jsonresume` implementing [NixOS](https://github.com/NixOS/nixpkgs) options to allow deploying your static site & hosting your assets on your machine's `networking.domain` via a webserver running as a systemd service by declaring what to deploy in your `nixosConfigurations`.
  - [ ] TLS certificate generation for self-hosting your static site resume.
  - [ ] DNS configuration to point your domain at GitHub Pages.

### Personal Info

- [ ] Actually make the data accurate.

### Links for later

- <https://github.com/jsonresume/jsonresume-gpt3>
- <https://github.com/jsonresume/jsonresume.org>
- <https://github.com/DrakeAxelrod/json-resume-service>
- <https://github.com/marketplace/actions/jsonresume-export>
- <https://github.com/jsonresume/resume-cli>

## Thanks

- [TaserudConsulting/jsonresume-nix](https://github.com/TaserudConsulting/jsonresume-nix) - Flake repo I originally forked this one from. Consider using that project if it better fits your needs. My repo has diverged substantially.
- [rbardini/resumed](https://github.com/rbardini/resumed) - Util that builds the `index.html` artifacts.
- [JarvusInnovations/puppeteer-cli](https://github.com/JarvusInnovations/puppeteer-cli) - Util that builds the `resume.pdf` artifacts from `index.html`
- All the `jsonresume` maintainers, theme developers, and community.
