# Pandoc

- [ ] TODO: Figure out best input format for Pandoc conversion.

See: [jgm/pandoc - Formats](https://github.com/jgm/pandoc#the-universal-markup-converter)

## Input Formats

From: `-f <FORMAT>`

- [ ] `csljson`
- [ ] `csv`
- [ ] `tsv`
- [ ] `docbook`
- [ ] `endnotexml`
- [ ] `epub`
- [ ] `gfm`
- [ ] `html`
- [ ] `ipynb`
- [ ] `json`
- [ ] `latex`
- [ ] `markdown`
- [ ] `markdown_mmd`
- [ ] `markdown_phpextra`
- [ ] `markdown_strict`
- [ ] `man`
- [ ] `mdoc`
- [ ] `native`
- [ ] `odt`
- [ ] `opml`
- [ ] `org`
- [ ] `pod` (Perl's Plain Old Documentation)
- [ ] `rtf`
- [ ] `rst`
- [ ] `t2t`
- [ ] `tikiwiki` (TikiWiki markup)
- [ ] `twiki` (TWiki markup)
- [ ] `typst`
- [ ] `vimwiki`
- [ ] Path to custom Lua reader

## Output Formats

To: `-t <FORMAT>`

- [ ] `ansi` (text with ANSI escape codes for terminal viewing)
- [ ] `asciidoc` | `asciidoctor` (modern AsciiDoc as interpretted by AsciiDoctor)
- [ ] `beamer` (LaTeX beamer slideshow)
- [ ] `biblatex`
- [ ] `bibtex`
- [ ] `commonmark`
- [ ] `commonmark_x`
- [ ] `context` (ConTeXt)
- [ ] `csljson` (CSL JSON bibliography)
- [ ] `djot`
- [ ] `docbook` (DocBook 4)
- [ ] `docbook5` (DocBook 5)
- [ ] `docx`
- [ ] `docuwiki`
- [ ] `epub` | `epub3` (EPUB v3 book)
- [ ] `epub2` (EPUB v2 book)
- [ ] `fb2` (FictionBook2 e-book)
- [ ] `gfm` (GitHub-Flavored Markdown) or deprecated & less-accurate `markdown_github`; use only if you need extensions unsupported by `gfm`.
- [ ] `haddock`
- [ ] `html` | `html5` (HTML, i.e. HTML5/XHTML polyglot markup)
- [ ] `html4` (XHTML 1.0 Transitional)
- [ ] `icml` (InDesign ICML)
- [ ] `ipynb` (Jupyter notebook, <https://pandoc.org/MANUAL.html#jupyter-notebooks>)
- [ ] `jats_archiving` | `jats` (JATS XML, Archiving & Interchange Tag Set)
- [ ] `jats_articleauthoring` (JATS XML, Article Authoring Tag Set)
- [ ] `jats_publishing` (JATS XML, Journal Publishing Tag Set)
- [ ] `jira`
- [ ] `json` (JSON version of native AST)
- [ ] `latex`
- [ ] `man`
- [ ] `markdown` (Pandoc's Markdown)
- [ ] `markdown_mmd` (MultiMarkdown)
- [ ] `markdown_phpextra` (PHP Markdown Extra)
- [ ] `markdown_strict` (original unextended Markdown)
- [ ] `markua`
- [ ] `mediawiki`
- [ ] `ms` (roff ms)
- [ ] `muse` (Muse)
- [ ] `native` (native Haskell)
- [ ] `odt` (OpenDocument text document)
- [ ] `opml` (OPML)
- [ ] `opendocument` (OpenDocument XML)
- [ ] `org` (Emacs Org mode)
- [ ] `pdf` (PDF document) - `--pdf-engine=weasyprint --pdf-engine-opt=--pdf-variant=pdf/ua-1`
- [ ] `plain` (plaintext)
- [ ] `pptx` (PowerPoint slideshow)
- [ ] `rst` (reStructuredText)
- [ ] `rtf` (Rich Text Format)
- [ ] `texinfo` (GNU Texinfo)
- [ ] `textile` (Textile)
- [ ] `slideous` (Slideous HTML & JavaScript slideshow)
- [ ] `slidy` (Slidy HTML & JavaScript slideshow)
- [ ] `dzslides` (DZSlides HTML5 & JavaScript slideshow)
- [ ] `revealjs` (reveal.js HTML5 & JavaScript slideshow)
- [ ] `s5` (S5 HTML & JavaScript slideshow)
- [ ] `tei` (TEI Simple)
- [ ] `typst` (Typst)
- [ ] `xwiki` (XWiki markup)
- [ ] `zimwiki` (ZimWiki markup)

- [ ] Path to custom Lua writer (see: [Custom readers & writers](https://pandoc.org/MANUAL.html#custom-readers-and-writers))

See: [Pandoc Manual - Extensions](https://pandoc.org/MANUAL.html#extension--tagging)

## Documentation & Tutorials

- <https://flyx.org/nix-flakes-latex/> - Nix & LaTeX tutorial
- <https://jngb.lt/posts/overengineering-thesis-template/>
- <https://github.com/pascalj/thesis-template>
- <https://github.com/serokell/nix-pandoc>
  ```nix
      { inputs.nix-pandoc = {url="github:serokell/nix-pandoc"; inputs.nixpkgs.follows="nixpkgs";};
        outputs = { self, ... }: {
          packages.default = builtins.mapAttrs (system: pkgs: inputs.nix-pandoc.mkDoc.${system} {
            name = "your-document-name";
            src = ./.;
            phases = [ "unpackPhase" "buildPhase" "installPhase" ];
            buildPhase = "pandoc --pdf-engine=xelatex -o $name.pdf ./your-document.md";
            installPhase = "mkdir -p $out; cp $name.pdf $out";
          }) inputs.nixpkgs.legacyPackages;
        };
      }
  ```

