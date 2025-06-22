{lib, ...} @ args: {
  meta = {
    canonical = "https://raw.githubusercontent.com/Lehmanator/resume.nix/main/src/sysadm.nix";
    version = "v1.0.3";
    lastModified = "2025-06-20T10:53:00";
    theme = args.theme or "slickoverflow";
    language = "en";
  };

  basics = rec {
    name = "Sam Lehman";
    label = "System Administrator";
    image = "https://raw.githubusercontent.com/Lehmanator/Lehmanator/main/assets/images/profile.png";
    email = "hire@samlehman.dev";
    url = "https://samlehman.dev";
    summary = "Sam is a ${lib.toLower label} that deploys & manages workstations & infrastructure running a wide array of operating systems and software services. Sam has a depth & breadth of experience using programming languages, shell scripting, & declarative code for managing, running, and deploying servers & workstations.";
    location = {
      city = "Reading";
      countryCode = "US";
      region = "Pennsylvania";
    };
    profiles = [
      (import ./socials/github.nix {})
      (import ./socials/mastodon.nix {})
      # (import ./socials/matrix.nix {})
      # (import ./socials/codeberg.nix {})
      # (import ./socials/forgejo-clan.nix {})
      # (import ./socials/forgejo-lix.nix {})
      # (import ./socials/gitlab.nix {})
      # (import ./socials/gitlab-gnome.nix {})
      # (import ./socials/gitlab-pmos.nix {})
    ];
  };

  work = [
    (import ./work/piwc.nix {})
    (import ./work/brazen.nix {})
    (import ./work/ge-transportation-2018.nix {})
    (import ./work/ge-transportation-2017.nix {})
  ];

  volunteer = [
    (import ./volunteer/thon.nix {})
  ];

  education = [
    (import ./education/pennstate.nix {})
  ];

  skills = [
    (import ./skills/operating-systems.nix {hide = ["level"];})
    (import ./skills/scripting.nix {hide = ["level"];})
    (import ./skills/deployment.nix {hide = ["level"];})
    (import ./skills/nix.nix {hide = ["level"];})
    (import ./skills/kubernetes.nix {hide = ["level"];})
    (import ./skills/containers.nix {hide = ["level"];})
    (import ./skills/terraform.nix {hide = ["level"];})
    (import ./skills/microsoft-azure.nix {hide = ["level"];})
    (import ./skills/cicd.nix {hide = ["level"];})
    (import ./skills/webdev.nix {hide = ["level"];})
  ];

  languages = [
    (import ./languages/english.nix {})
    (import ./languages/spanish.nix {})
  ];

  interests = [
    (import ./interests/home-automation.nix {})
    (import ./interests/wrestling.nix {})
    (import ./interests/lifting.nix {})
  ];

  references = [
    (import ./references/lauri.nix {})
  ];
  projects = [
    (import ./projects/nix-configs.nix {})
    (import ./projects/resume.nix {})
    (import ./projects/heyimhungry.nix {})
  ];
}
