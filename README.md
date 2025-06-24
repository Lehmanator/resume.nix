# resume.nix

Reproducible personal résumé built & deployed using [Nix](https://nixos.org/) and
[jsonresume](https://jsonresume.org/).
Supports a broad number of themes.

## Getting started

- [ ] **TODO: Create template**

Create your own `resume` repository and run:

```bash
    nix flake init -t git+https://codeberg.org/Lehmanator/resume.nix
```

to clone the template to use this flake.

To build your résumé,

1. Edit the data inside `src/jsonresume/default.nix`
2. Change the `meta.theme` attribute to select which theme package the document will be built with. The available names should match the names of the files in `packages/jsonresume/themes/`

For example, to build a PDF document of your résumé, run:

    `nix run .#pdf`

Or to build the HTML static site, run:

    `nix run .#html`

You will then find either `resume.pdf` or `index.html` inside `./result` directory.

Provided is a default package using a pre-selected (`stackoverflow`) theme.
This makes building as simple as running: `nix run` with no extra arguments.

## More Themes

Included are package definitions for other utils, themes, etc.
To list all available packages, run:

```bash
    nix flake show git+https://codeberg.org/Lehmanator/resume.nix
```

[Search NPM packages for jsonresume themes](https://www.npmjs.com/search?q=jsonresume-theme)

Most should be fairly trivial to include,
and can mostly be copy-and-pasted from other theme package files in
`packages/jsonresume/themes/`

## To-Do

Features I'd like to implement at some point.
Contributions welcome!

- [x] Deployment: GitHub Pages / Codeberg Pages
- [ ] Deployment: GitHub Actions / Forgejo Actions Releases
- [ ] Format: QR code images linking to your HTML deployment or PDF release artifacts.
- [ ] Format: Markdown
- [ ] Format: `.vcard`
- [ ] Format: LaTeX
- [ ] HTML: Co-existing theme deployments.
- [ ] HTML: 'Download as...' button
- [ ] HTML: More themes!
- [ ] PDF: Signing documents
- [ ] Nix: flake checks

### Nix Environments

- [ ] `devShell` for building, hacking on themes, etc.
- [ ] `hmModules.jsonresume` implementing [home-manager](https://github.com/nix-community/home-manager) options to allow setting your data as a part of your `homeConfigurations`
- [ ] `nixosModules.jsonresume` implementing [NixOS](https://github.com/NixOS/nixpkgs) options to allow deploying your static site & hosting your assets on your machine's `networking.domain` via a webserver running as a systemd service by declaring what to deploy in your `nixosConfigurations`.
  - [ ] TLS certificate generation for self-hosting your static site resume.
  - [ ] DNS configuration to point your domain at GitHub Pages.

## Thanks

- [TaserudConsulting/jsonresume-nix](https://github.com/TaserudConsulting/jsonresume-nix) - Flake repo I originally forked this one from. Consider using that project if it better fits your needs. My repo has diverged substantially.
- [rbardini/resumed](https://github.com/rbardini/resumed) - Util that builds the `index.html` artifacts.
- [JarvusInnovations/puppeteer-cli](https://github.com/JarvusInnovations/puppeteer-cli) - Util that builds the `resume.pdf` artifacts from `index.html`
- All the `jsonresume` maintainers, theme developers, and community.
