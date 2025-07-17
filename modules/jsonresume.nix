{
  config,
  lib,
  pkgs,
  # TODO: Create modules for NixOS, home-manager, etc.
  # osConfig,
  # homeConfig,
  # nixosConfig,
  # darwinConfig,
  ...
} @ moduleArgs:
#
# NOTE: Structure is currently:
#
#   -   jsonresume.<templateName>.{...schemaAttrs}
#   - hackmyresume.<templateName>.{...schemaAttrs}
#   -     rendercv.<templateName>.{...schemaAttrs}
#
# TODO: Change to:
#
# - resumes.<templateName>.{...schemaAttrs} // { type = "jsonresume" | "hackmyresume" | "rendercv" }
#
let
  inherit (lib) mkOption types;
in {
  imports = [];

  options.jsonresume = mkOption {
    description = "Attrset of JSON Resume data";
    type = types.attrsOf (types.submodule ({name, ...} @ documentArgs: {
      # freeformType = settings
      options = {
        "$schema" = mkOption {
          type = types.uri;
          description = "link to the version of the schema that can validate the resume";
          default = "https://github.com/jsonresume/resume-schema/blob/master/schema.json";
          example = "https://github.com/jsonresume/resume-schema/blob/master/schema.json";
        };
        meta = mkOption {
          description = "Metadata about the JSON Resume document";
          default = {};
          type = types.submodule {
            freeformType = types.attrs;
            options = {
              canonical = mkOption {
                type = types.nullOr types.url;
                description = "URL (as per RFC 3986) to latest version of this document";
                example = "https://resume.samlehman.dev/${name}/resume.json";
              };
              version = mkOption {
                type = types.nullOr types.semVer;
                description = "A version field which follows semver";
                default = "v0.0.1";
                example = "v1.0.0";
              };
              lastModified = mkOption {
                type = types.nullOr types.date.iso8601;
                description = "Using ISO 8601 with YYYY-MM-DDThh:mm:ss";
              };

              # --- Non-standard options -----------------------------
              # TODO: htmlTheme, pdfTheme
              # TODO: Allow packages to pass attrs / options to the theme
              language = mkOption {
                type = types.nullOr types.nonEmptyStr;
                description = "Two-letter shortcode of the language of the document";
                example = "en";
              };
              theme = mkOption {
                type = types.nullOr (types.either types.nonEmptyStr types.package);
                description = "Package of the theme to build the document with";
                default = "stackoverflow";
                example = "stackoverflow";
              };
            };
          };
        };

        basics = {
          name = mkOption {
            type = types.nullOr types.singleLineStr;
            description = "Name of the job seeker";
            example = "Linus Torvalds";
          };
          label = mkOption {
            type = types.nullOr types.singleLineStr;
            description = "Job title or position of the job seeker";
            example = "Web Developer";
          };
          image = mkOption {
            type = types.nullOr types.url;
            description = "URL (as per RFC 3986) to a image in JPEG or PNG format";
          };
          email = mkOption {
            type = types.nullOr types.emailAddress;
            description = "Email address";
            example = "thomas@gmail.com";
          };
          phone = mkOption {
            type = types.nullOr types.phoneNumber;
            description = "Phone numbers are stored as strings so use any format you like, e.g. 712-117-2923";
            default = null;
            example = "+1 (404) 999-0123";
          };
          url = mkOption {
            type = types.nullOr types.uri;
            description = "URL (as per RFC 3986) to your website, e.g. personal homepage";
            example = "https://resume.samlehman.dev";
          };
          summary = mkOption {
            type = types.nullOr types.str;
            description = "Write a short 2-3 sentence biography about yourself";
          };

          # location = mkOption {
          #   type = types.submodule {
          #     freeformType = types.attrsOf types.str;
          #     options = {
          location.address = mkOption {
            type = types.nullOr types.str;
            description = "To add multiple address lines, use \n.";
            default = null;
            example = "1234 Glücklichkeit Straße\nHinterhaus 5. Etage li.";
          };
          location.postalCode = mkOption {
            # TODO: Allow numbers & coerce to string?
            type = types.nullOr (types.either types.singleLineStr (types.ints.between 0 99999));
            default = null;
            example = "90210";
          };
          location.city = mkOption {
            type = types.nullOr types.singleLineStr;
            example = "Cairo";
          };
          location.countryCode = mkOption {
            type = types.nullOr types.countryCode;
            description = "code as per ISO-3166-1 ALPHA-2";
            example = "US"; # "AU" "IN";
          };
          location.region = mkOption {
            type = types.nullOr types.singleLineStr;
            description = "The general region where you live. Can be a US state, or a province, for instance.";
            example = "Pennsylvania";
          };
          #     };
          #   };
          # };

          profiles = mkOption {
            description = "Specify any number of social networks that you participate in";
            example = ''
              { network = "GitHub";
                username = "Lehmanator";
                url = "https://github.com/Lehmanator";
              }
            '';
            type = types.listOf (types.submodule {
              freeformType = types.attrs; # Follow JSON schema: `additionalProperties = true`;
              options = {
                network = mkOption {
                  type = types.nullOr types.nonEmptyStr;
                  description = "Name of the social network";
                  example = "Mastodon";
                };
                username = mkOption {
                  type = types.nullOr types.nonEmptyStr;
                  description = "Your username on this network";
                  example = "Lehmanator";
                };
                url = mkOption {
                  type = types.nullOr types.nonEmptyStr;
                  description = "URL to your profile on this network";
                  example = "https://fosstodon.org/@Lehmanator";
                };
              };
            });
          };
        };

        awards = mkOption {
          description = "Specify a list of awards you have received throughout your professional career";
          default = [];
          type = types.nullOr (types.listOf (types.submodule {
            freeformType = types.attrs;
            options = {
              awarder = mkOption {
                type = types.nullOr types.nonEmptyStr;
                description = "The awarder's name";
                example = "Time Magazine";
              };
              title = mkOption {
                type = types.nullOr types.nonEmptyStr;
                description = "Your position within the organization";
                example = "One of the 100 greatest minds of the century";
              };
              date = mkOption {
                type = types.nullOr types.date.iso8601;
                description = "The date (in ISO8601 format) you received the award";
                example = "2014-08-01";
              };
              summary = mkOption {
                type = types.nullOr types.nonEmptyStr;
                description = "Brief description of the award and/or why you won it";
                example = "Received for my work on Quantum Physics";
              };
            };
          }));
        };

        certificates = mkOption {
          description = "Specify a list of certificates you have received throughout your professional career";
          default = [];
          type = types.listOf (
            types.submodule {
              # TODO: Follow JSON schema: `additionalProperties = true`;
              freeformType = types.attrs;
              options = {
                name = mkOption {
                  type = types.nullOr types.nonEmptyStr;
                  description = "Name of the certificate";
                  example = "Certified Kubernetes Administrator";
                };
                issuer = mkOption {
                  type = types.nullOr types.nonEmptyStr;
                  description = "Name of the organization issuing the certificate";
                  example = "CNCF";
                };
                date = mkOption {
                  type = types.nullOr types.date.iso8601;
                  description = "The date (in ISO8601 format) you received the certificate";
                  example = "2014-08-01";
                };
                url = mkOption {
                  type = types.nullOr types.uri;
                  description = "URL of the certificate details or the issuer";
                  example = "https://cncf.org";
                };
              };
            }
          );
        };

        education = mkOption {
          description = "Specify a list of entries of educational studies";
          default = [];
          type = types.listOf (
            types.submodule {
              freeformType = types.attrs;
              options = {
                institution = mkOption {
                  type = types.nullOr types.nonEmptyStr;
                  description = "The educational institution";
                  default = null;
                  example = "Pennsylvania State University";
                };
                url = mkOption {
                  type = types.nullOr types.uri;
                  description = "The institution's URL";
                  default = null;
                  example = "https://psu.edu";
                };
                area = mkOption {
                  type = types.nullOr types.str;
                  description = "The field, subject, or area of study";
                  default = null;
                  example = "Computer Science";
                };
                studyType = mkOption {
                  type = types.nullOr types.str;
                  description = "The type of study, usually the type of degree";
                  default = null;
                  example = "Bachelor";
                };
                startDate = mkOption {
                  type = types.nullOr types.date.iso8601;
                  description = "The start date (in ISO8601 format) of your studies at this institution";
                  default = null;
                  example = "2014-08-01";
                };
                endDate = mkOption {
                  type = types.nullOr types.date.iso8601;
                  description = "The end date (in ISO8601 format) of your studies at this institution";
                  default = null;
                  example = "2018-05-31";
                };
                score = mkOption {
                  type = types.nullOr (types.either types.ints.u8 types.str);
                  description = "Grade point average (GPA) or other type of grading metric";
                  default = null;
                  example = 4.0;
                };
                courses = mkOption {
                  type = types.nullOr (types.listOf types.nonEmptyStr);
                  description = "List of notable courses / subjects";
                  default = null;
                  example = "MATH230 - Calculus III";
                };
              };
            }
          );
        };

        interests = mkOption {
          description = "List of entries of your interests";
          default = [];
          type = types.listOf (types.submodule {
            freeformType = types.attrs;
            options = {
              name = mkOption {
                type = types.nullOr types.nonEmptyStr;
                description = "Name of the interest";
                example = "Philosophy";
              };
              keywords = mkOption {
                type = types.nullOr (types.listOf types.nonEmptyStr);
                description = "List some keywords pertaining to this interest";
                example = ["Friedrich Nietzsche" "Plato"];
              };
            };
          });
        };

        languages = mkOption {
          description = "List of entries of languages you speak";
          default = [];
          type = types.listOf (types.submodule {
            freeformType = types.attrs;
            options = {
              language = mkOption {
                type = types.nonEmptyStr;
                description = "Name of the language";
                example = "Spanish";
              };
              fluency = mkOption {
                type = types.nullOr types.nonEmptyStr;
                description = "Classify your fluency in this language";
                example = "Fluent";
              };
            };
          });
        };

        projects = mkOption {
          description = "Specify a list of entries of projects you have worked on.";
          default = [];
          type = types.listOf (types.submodule {
            freeformType = types.attrs;
            options = {
              name = mkOption {
                type = types.nonEmptyStr;
                description = "The project name";
                example = "resume.nix";
              };
              description = mkOption {
                type = types.nullOr types.str;
                description = "Short summary of the project.";
                example = "Project to build resume artifacts using Nix.";
              };
              url = mkOption {
                type = types.nullOr types.uri;
                description = "The project's URL";
                example = "https://codeberg.org/Lehmanator/resume.nix";
              };
              entity = mkOption {
                type = types.nullOr types.str;
                default = null;
                description = "Specify the relevant company, organization, or entity this project is affiliated with";
                example = "NixOS";
              };
              type = mkOption {
                type = types.nullOr types.nonEmptyStr;
                default = null;
                description = "Broad class type of your project";
                example = "application";
              };
              startDate = mkOption {
                type = types.nullOr types.date.iso8601;
                default = null;
                description = "The start date (in ISO8601 format) of your work on this project";
                example = "2014-08-01";
              };
              endDate = mkOption {
                type = types.nullOr types.date.iso8601;
                default = null;
                description = "The end date (in ISO8601 format) of your work on this project";
                example = "2018-05-31";
              };
              roles = mkOption {
                type = types.nullOr (types.listOf types.nonEmptyStr);
                description = "Specify your role(s) on this project or within this entity";
                default = null;
                example = [
                  "Team Lead"
                  "Developer"
                ];
              };
              keywords = mkOption {
                type = types.nullOr (types.listOf types.nonEmptyStr);
                description = "Specify special elements involved";
                example = [
                  "Nix"
                  "JSON Resume"
                  "Node.js"
                ];
              };
              highlights = mkOption {
                type = types.nullOr (types.listOf types.nonEmptyStr);
                description = "Specify a list of features or accomplishments.";
                example = [
                  "Builds HTML webpage for your resume from Nix or JSON data."
                  "Builds PDF document for your resume from Nix or JSON data."
                ];
              };
            };
          });
        };

        publications = mkOption {
          description = "Specify a list of entries of publications you have made throughout your career";
          default = [];
          type = types.listOf (types.submodule {
            freeformType = types.attrs;
            options = {
              name = mkOption {
                type = types.nonEmptyStr;
                description = "Name of your publication";
                example = "How to eat beans";
              };
              publisher = mkOption {
                type = types.nullOr types.nonEmptyStr;
                description = "Name of the organization publishing your work";
                example = "WikiHow";
              };
              releaseDate = mkOption {
                type = types.nullOr types.date.iso8601;
                description = "Release date (in ISO8601 format) of your publication";
                example = "2014-08-01";
              };
              url = mkOption {
                type = types.nullOr types.uri;
                description = "URL of the certificate details or the issuer";
                example = "https://cncf.org";
              };
              summary = mkOption {
                type = types.nullOr types.nonEmptyStr;
                description = "Short summary of your publication";
                example = "Discussion of the World Wide Web";
              };
            };
          });
        };

        references = mkOption {
          description = "List of entries for professional or personal references";
          default = [];
          type = types.listOf (types.submodule {
            freeformType = types.attrs;
            options = {
              name = mkOption {
                type = types.nonEmptyStr;
                description = "Name of the person";
                example = "Tim Apple";
              };
              reference = mkOption {
                type = types.nullOr types.nonEmptyStr;
                description = "The quoted reference made by the person";
                example = "Joe blogs was a great employee, who turned up to work at least once a week. He exceeded my expectations when it came to doing nothing.";
              };
            };
          });
        };

        skills = mkOption {
          description = "List of entries for your skills";
          default = [];
          type = types.listOf (types.submodule {
            freeformType = types.attrs;
            options = {
              name = mkOption {
                type = types.nullOr types.nonEmptyStr;
                description = "Name of the skill";
                example = "Web Development";
              };
              level = mkOption {
                type = types.nullOr types.nonEmptyStr;
                description = "Classify the level of your ability in this skill";
                default = null;
                example = "Expert";
              };
              keywords = mkOption {
                type = types.nullOr (types.listOf types.nonEmptyStr);
                description = "List some keywords pertaining to this skill";
                example = ["Nix" "HTML" "Node.js"];
              };
            };
          });
        };

        volunteer = mkOption {
          description = "List of prior volunteer entries";
          default = [];
          type = types.listOf (types.submodule {
            freeformType = types.attrs;
            options = {
              organization = mkOption {
                type = types.nonEmptyStr;
                description = "The organization's name";
                example = "NixOS Foundation";
              };
              position = mkOption {
                type = types.nonEmptyStr;
                description = "Your position within the organization";
                example = "Technical Consultant";
              };
              url = mkOption {
                type = types.nullOr types.uri;
                description = "The organization's URL";
                example = "https://redhat.com";
              };
              startDate = mkOption {
                type = types.nullOr types.date.iso8601;
                description = "The start date (in ISO8601 format) of your work on this project";
                example = "2014-08-01";
              };
              endDate = mkOption {
                type = types.nullOr types.date.iso8601;
                description = "The end date (in ISO8601 format) of your work on this project";
                example = "2018-05-31";
              };
              summary = mkOption {
                type = types.nullOr types.nonEmptyStr;
                description = "Give an overview of your responsibilities within this organization";
                example = "Responsible for advising on software and infrastructure choices";
              };
              highlights = mkOption {
                type = types.nullOr (types.listOf types.nonEmptyStr);
                description = "Specify a list of achievements / accomplishments.";
                example = [
                  "Saved the world"
                  "Built a lot of cool stuff"
                ];
              };
              # keywords = mkOption {
              #   type = types.nullOr (types.listOf types.nonEmptyStr);
              #   description = "Specify special elements involved";
              #   example = [ "Nix" "Rust" ];
              # };
            };
          });
        };

        work = mkOption {
          description = "List of prior work/employment entries";
          default = [];
          type = types.listOf (types.submodule {
            freeformType = types.attrs;
            options = {
              name = mkOption {
                type = types.nonEmptyStr;
                description = "The employer's name";
                example = "RedHat";
              };
              description = mkOption {
                type = types.nullOr types.str;
                description = "Short description of the employer.";
                example = "Enterprise Linux OS developer";
              };
              url = mkOption {
                type = types.nullOr types.uri;
                description = "The employer's URL";
                example = "https://redhat.com";
              };
              position = mkOption {
                type = types.nullOr types.nonEmptyStr;
                description = "Your job position within the company or organization";
                example = "Software Engineer";
              };
              summary = mkOption {
                type = types.nullOr types.nonEmptyStr;
                description = "Give an overview of your responsibilities at this employer";
                example = "Responsible for developing software and infrastructure";
              };
              startDate = mkOption {
                type = types.nullOr types.date.iso8601;
                description = "The start date (in ISO8601 format) of your work on this project";
                example = "2014-08-01";
              };
              endDate = mkOption {
                type = types.nullOr types.date.iso8601;
                description = "The end date (in ISO8601 format) of your work on this project";
                example = "2018-05-31";
              };
              roles = mkOption {
                type = types.nullOr (types.listOf types.nonEmptyStr);
                default = null;
                description = "Specify your role(s) on this project or within this entity";
                example = ["Team Lead" "Developer"];
              };
              highlights = mkOption {
                type = types.nullOr (types.listOf types.nonEmptyStr);
                description = "Specify a list of features or accomplishments.";
                example = [
                  "Builds HTML webpage for your resume from Nix or JSON data."
                  "Builds PDF document for your resume from Nix or JSON data."
                ];
              };
              # keywords = mkOption {
              #   type = types.nullOr (types.listOf types.nonEmptyStr);
              #   description = "Specify special elements involved";
              #   default = null;
              #   example = [ "Nix" "Rust" ];
              # };
            };
          });
        };

        # Export the data in a multitude of formats & build all the documents artifacts.
        result = mkOption {
          description = "Built artifact files";
          default = {};
          readOnly = true;
          type = let
            personName = lib.toCamelCase (documentArgs.config.basics.name or "Sam Lehman");
            templateName = documentArgs.name or "default";
            filePrefix = "${templateName}.${personName}";

            # TODO: Remove null values & empty lists
            data = rec {
              jsonresume = builtins.removeAttrs documentArgs.config ["type" "result" "settings" "themeSettings" "_module"];
              rendercv = lib.jsonresume.toRenderCV jsonresume;
              hackmyresume = lib.jsonresume.toHackMyResume jsonresume;
            };
          in
            types.submodule {
              options = let
                goresume = pkgs.callPackage ../packages/jsonresume/goresume.nix {};

                # TODO: Retrieve these from `flake-parts.perSystem.packages.<format>.themes`?
                builders = {
                  # Builds HTML page for a JSON Resume using `pkgs.goresume`
                  html.goresume = theme:
                    pkgs.stdenv.mkDerivation {
                      src = documentArgs.config.assetsDirectory or moduleArgs.assetsDirectory or ../src;
                      version = data.jsonresume.meta.version or "v0.0.1";
                      pname = "resume-${name}-goresume-${theme}.html";
                      nativeBuildInputs = [pkgs.goresume or goresume];
                      buildPhase = ''
                        mkdir -p $out
                        cat ${documentArgs.config.result.jsonresume.json.outPath} > ./resume.json
                        # TODO: Copy goresume themes dir into ./themes/*.html
                        goresume export --html-output - > $out/index.html
                      '';
                      meta = {
                        homepage = "https://codeberg.org/Lehmanator/resume.nix";
                        description = "JSONResume goresume HTML output using theme: ${theme}";
                        license = lib.licenses.agpl3Plus;
                      };
                    };

                  # Builds HTML page for a JSON Resume using `pkgs.resumed`
                  html.resumed = theme: let
                    themePackage =
                      pkgs.callPackage (
                        if builtins.pathExists ../packages/jsonresume/themes/${theme}.nix
                        then ../packages/jsonresume/themes/${theme}.nix
                        else ../packages/jsonresume/themes/${theme}
                      ) {
                      };
                  in
                    pkgs.stdenv.mkDerivation {
                      src = documentArgs.config.assetsDirectory or moduleArgs.assetsDirectory or ../src;
                      version = data.jsonresume.meta.version or "v0.0.1";
                      pname = "resume-${name}-resumed-${theme}.html";
                      nativeBuildInputs = [pkgs.resumed themePackage];
                      buildPhase = ''
                        mkdir -p $out
                        basedir='lib/node_modules/jsonresume-theme-${theme}'   # TODO: Some NodeJS packages may use diff naming scheme
                        entry="$basedir/index.js"                              # Used by theme: **most**
                        [[ ! -f "$entry" ]] && entry="$basedir/dist/index.js"  # Used by theme: crewshin
                        [[ ! -f "$entry" ]] && entry="$basedir/lib/index.js"   # Used by theme: eloquent
                        resumed render ${documentArgs.config.result.jsonresume.json.outPath} \
                           --theme "$entry" \
                           --output "$out/index.html"
                      '';
                      meta = {
                        homepage = "https://codeberg.org/Lehmanator/resume.nix";
                        description = "JSONResume resumed HTML output using theme: ${theme}";
                        license = lib.licenses.agpl3Plus;
                      };
                    };

                  # Builds HTML page for a JSON Resume using `pkgs.goresume`
                  pdf.goresume = theme:
                    pkgs.stdenv.mkDerivation {
                      src = documentArgs.config.assetsDirectory or moduleArgs.assetsDirectory or ../src;
                      version = data.jsonresume.meta.version or "v0.0.1";
                      pname = "resume-${name}-goresume-${theme}.pdf";
                      nativeBuildInputs = [pkgs.goresume or goresume];
                      buildPhase = ''
                        mkdir -p $out
                        cat ${documentArgs.config.result.jsonresume.json.outPath} > ./resume.json
                        # TODO: Copy goresume themes dir into ./themes/*.html
                        goresume export --pdf-theme ${theme} --html-output - > $out/index.html
                      '';
                      meta = {
                        homepage = "https://codeberg.org/Lehmanator/resume.nix";
                        description = "JSONResume goresume HTML output using theme: ${theme}";
                        license = lib.licenses.agpl3Plus;
                      };
                    };

                  # html.resumed = theme: pkgs.callPackage ../packages/jsonresume/scripts/builder-html-resumed.nix {
                  #   inherit theme;
                  #   themeDrv = pkgs.callPackage ( if builtins.pathExists ../packages/jsonresume/themes/${theme}.nix then ../packages/jsonresume/themes/${theme}.nix else ../packages/jsonresume/themes/${theme}/default.nix ) {};
                  #   src = documentArgs.config.assetsDirectory or ../src;
                  #   version = data.jsonresume.meta.version or "v0.0.1";
                  #   json = documentArgs.config.result.jsonresume.json.outPath;
                  #   extraThemes = [];
                  # };
                  # html.goresume = theme: pkgs.callPackage ../packages/jsonresume/scripts/builder-html-goresume.nix {
                  #   inherit theme;
                  #   extraThemes = [];
                  #   src = documentArgs.config.assetsDirectory or ../src;
                  #   version = data.jsonresume.meta.version or "v0.0.1";
                  #   json = documentArgs.config.result.jsonresume.json.outPath;
                  # };
                  # pdf.goresume = theme: pkgs.callPackage ../packages/jsonresume/scripts/builder-pdf-goresume.nix {
                  #   inherit theme;
                  #   extraThemes = [];
                  #   src = documentArgs.config.assetsDirectory or ../src;
                  #   version = data.jsonresume.meta.version or "v0.0.1";
                  #   json = documentArgs.config.result.jsonresume.json.outPath;
                  # };
                };
                themes = {
                  # jsonresume = builtins.map (theme: builders.html.resumed theme) ["stackoverflow"];
                  # jsonresume = builtins.mapAttrs (theme: v: pkgs.callPackage ../packages/jsonresume/themes/${theme}.nix { inherit theme; data = data.jsonresume; };
                  resumed = rec {
                    html = ["stackoverflow"];
                    pdf = html;
                  };
                  goresume = {
                    html = ["actual" "simple" "simple-compact"];
                    pdf = ["actual"];
                  };
                  hackmyresume = {
                    html = [];
                    pdf = [];
                  };
                  rendercv = {
                    html = [""];
                    pdf = [""];
                  };
                };
              in {
                # --- Output Formats ---------------------------------
                # NOTE: Formats accepting themes should be an attrset of packages. i.e. HTML, LaTeX, Markdown?
                # NOTE: Formats derived from formats accepting themes should also be an attrset of packages. i.e. PDF, PNG
                # --- Unthemed Formats ---
                markdown = mkOption {type = types.nullOr types.package;};
                vcard = mkOption {type = types.nullOr types.package;};

                # --- Themed Formats ---
                html = mkOption {
                  description = "Resume artifacts: HTML";
                  defaultText = "Final HTML documents for resume data";
                  type = types.nullOr (types.attrsOf types.package);
                  default = let
                    resumed = builtins.listToAttrs (builtins.map (theme: {
                        name = theme;
                        value = builders.html.resumed theme;
                      })
                      themes.resumed.html);
                    goresume = builtins.listToAttrs (builtins.map (theme: {
                        name = theme;
                        value = builders.html.goresume theme;
                      })
                      themes.goresume.html);
                  in
                    resumed // goresume;
                };
                pdf = mkOption {
                  description = "Resume artifacts: PDF";
                  defaultText = "Final PDF documents for resume data";
                  type = types.nullOr (types.attrsOf types.package);
                  default = let
                    resumed = builtins.listToAttrs (builtins.map (name: {
                        inherit name;
                        value = builders.pdf.resumed name;
                      })
                      themes.resumed.pdf);
                    goresume = builtins.listToAttrs (builtins.map (name: {
                        inherit name;
                        value = builders.pdf.goresume name;
                      })
                      themes.goresume.pdf);
                  in
                    resumed // goresume;
                };
                docx = mkOption {type = types.nullOr (types.attrsOf types.package);};
                latex = mkOption {type = types.nullOr (types.attrsOf types.package);};
                png = mkOption {type = types.nullOr (types.attrsOf types.package);};
                typst = mkOption {type = types.nullOr (types.attrsOf types.package);};

                # --- Input Formats ----------------------------------
                # TODO: {jsonresume,hackmyresume,rendercv}.{nix,ini,json,toml,yaml,dhall}
                # TODO: {jsonresume,hackmyresume,rendercv}.all (pkgs.linkFarm?)
                hackmyresume = {
                  nix = mkOption {
                    description = "JSON Resume in Nix format";
                    defaultText = "Final JSON Resume input data in format: Nix";
                    default = pkgs.writeText "${filePrefix}.jsonresume.nix" (lib.generators.toPretty {} data.hackmyresume);
                    type = types.package;
                  };
                  ini = mkOption {
                    description = "JSON Resume in INI format";
                    defaultText = "Final JSON Resume input data in format: INI";
                    default = (pkgs.formats.ini {}).generate "${filePrefix}.jsonresume.ini" data.hackmyresume;
                    type = types.package;
                  };
                  json = mkOption {
                    description = "JSON Resume in JSON format";
                    defaultText = "Final JSON Resume input data in format: JSON";
                    default = (pkgs.formats.json {}).generate "${filePrefix}.jsonresume.json" data.hackmyresume;
                    type = types.package;
                  };
                  toml = mkOption {
                    description = "JSON Resume in TOML format";
                    defaultText = "Final JSON Resume input data in format: TOML";
                    default = (pkgs.formats.toml {}).generate "${filePrefix}.jsonresume.toml" data.hackmyresume;
                    type = types.package;
                  };
                  # TODO: Do we need to pretty-print the json first?
                  yaml = mkOption {
                    description = "JSON Resume in YAML format";
                    defaultText = "Final JSON Resume input data in format: YAML";
                    default = (pkgs.formats.yaml {}).generate "${filePrefix}.jsonresume.yaml" data.hackmyresume;
                    type = types.package;
                  };
                };

                jsonresume = {
                  nix = mkOption {
                    description = "JSON Resume in Nix format";
                    defaultText = "Final JSON Resume input data in format: Nix";
                    default = pkgs.writeText "${filePrefix}.jsonresume.nix" (lib.generators.toPretty {} data.jsonresume);
                    type = types.package;
                  };
                  # ini = mkOption {
                  #   description = "JSON Resume in INI format";
                  #   defaultText = "Final JSON Resume input data in format: INI";
                  #   default = (pkgs.formats.gitIni {}).generate "${filePrefix}.jsonresume.ini" data.jsonresume; #(builtins.removeAttrs data.jsonresume ["$schema" "\$schema"]);
                  #   type = types.package;
                  # };
                  json = mkOption {
                    description = "JSON Resume in JSON format";
                    defaultText = "Final JSON Resume input data in format: JSON";
                    default = (pkgs.formats.json {}).generate "${filePrefix}.jsonresume.json" data.jsonresume;
                    type = types.package;
                  };
                  toml = mkOption {
                    description = "JSON Resume in TOML format";
                    defaultText = "Final JSON Resume input data in format: TOML";
                    default = (pkgs.formats.toml {}).generate "${filePrefix}.jsonresume.toml" data.jsonresume;
                    type = types.package;
                  };
                  yaml = mkOption {
                    description = "JSON Resume in YAML format";
                    defaultText = "Final JSON Resume input data in format: YAML";
                    default = (pkgs.formats.yaml {}).generate "${filePrefix}.jsonresume.yaml" data.jsonresume;
                    type = types.package;
                  };
                };

                rendercv = {
                  nix = mkOption {
                    description = "JSON Resume in Nix format";
                    defaultText = "Final JSON Resume input data in format: Nix";
                    default = pkgs.writeText "${filePrefix}.jsonresume.nix" data.rendercv;
                    type = types.package;
                  };
                  ini = mkOption {
                    description = "JSON Resume in INI format";
                    defaultText = "Final JSON Resume input data in format: INI";
                    default = (pkgs.formats.ini {}).generate "${filePrefix}.jsonresume.ini" data.rendercv;
                    type = types.package;
                  };
                  json = mkOption {
                    description = "JSON Resume in JSON format";
                    defaultText = "Final JSON Resume input data in format: JSON";
                    default = (pkgs.formats.json {}).generate "${filePrefix}.jsonresume.json" data.rendercv;
                    type = types.package;
                  };
                  toml = mkOption {
                    description = "JSON Resume in TOML format";
                    defaultText = "Final JSON Resume input data in format: TOML";
                    default = (pkgs.formats.toml {}).generate "${filePrefix}.jsonresume.toml" data.rendercv;
                    type = types.package;
                  };
                  # TODO: Do we need to pretty-print the json first?
                  yaml = mkOption {
                    description = "JSON Resume in YAML format";
                    defaultText = "Final JSON Resume input data in format: YAML";
                    default = (pkgs.formats.yaml {}).generate "${filePrefix}.jsonresume.yaml" data.rendercv;
                    type = types.package;
                  };
                  # NOTE: XML output needs JSON output formatted according to [Badgerfish spec](http://www.sklar.com/badgerfish/) before conversion can work.
                  #       This is because json <-> xml conversion is not one-to-one.
                  # badgerfish = mkOption {
                  #   type = types.package;
                  #   description = "JSON Resume in JSON intermediate format: Badgerfish";
                  #   defaultText = "Final JSON Resume input data in format: JSON (Badgerfish schema)";
                  #   default = {
                  #     root = cfg;
                  #   };
                  # };
                  # xml = mkOption {
                  #   type = types.package;
                  #   description = "JSON Resume in XML format";
                  #   defaultText = "Final JSON Resume input data in format: XML";
                  #   default = (pkgs.formats.xml {format = "badgerfish";}).generate "${filePrefix}.jsonresume.xml" resumeData;
                  # };
                };
              };
            };
        };
      };
    }));
  };

  # TODO: How to handle settings controlling outputs or rendering, but dont actually belong in the data?
  config = {
    # _module.args = {
    #   # inherit pkgs;
    # };
  };
}
