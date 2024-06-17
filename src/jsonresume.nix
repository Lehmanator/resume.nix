{
  basics = {
    name = "Sam Lehman";
    label = "Software Developer";
    image = "https://raw.githubusercontent.com/Lehmanator/Lehmanator/main/assets/images/profile.png";
    email = "dev@samlehman.dev";
    url = "https://samlehman.dev";
    summary = "Sam is a full-stack software developer that creates web applications, backend services, and the infrastructure used to run them. Sam has both a depth and breadth of experience using programming languages, frameworks, and development utilities to build everything necessary to build software and deploy it to end users.";
    location = {
      city = "Erie";
      countryCode = "US";
      region = "Pennsylvania";
    };
    profiles = [
      {
        network = "Mastodon";
        username = "@Lehmanator@fosstodon.org";
        url = "https://fosstodon.org/@Lehmanator";
      }
      {
        network = "Twitter";
        username = "publicSam";
        url = "https://twitter.com/publicSam";
      }
      # TODO: matrix:// or https:// to matrix.to profile link
      {
        network = "Matrix";
        username = "@lehmanator:tchncs.de";
        url = "https://matrix.to/#/@Lehmanator:tchncs.de";
      }
      {
        network = "GitHub";
        username = "Lehmanator";
        url = "https://github.com/Lehmanator";
      }
      # { network = "Mastodon";
      #   username = "@sam@lehman.run";
      #   url = "https://mastodon.lehman.run/@Lehmanator";
      # }
      # { network = "Matrix";
      #   username = "@sam:lehman.run";
      #   url = "https://matrix.to/#/@sam@lehman.run";
      # }
      # { network = "Forgejo";
      #   username = "sam";
      #   url = "https://github.com/Lehmanator";
      # }
    ];
  };

  work = [
    {
      name = "Presque Isle Wine Cellars";
      location = "North East, PA";
      description = "Winery & Wine Supplies Sales";
      position = "Systems Administrator";
      url = "https://piwine.com";
      startDate = "2021-08-01";
      endDate = "2023-11-01";
      summary = "Responsible for administration of servers and all user workstations for the entire company.";
      highlights = [
        "Migrated local domain controller to Azure cloud."
        "Migrated local servers to container-based infrastructure."
        "Migrated local databases to cloud-based PostgreSQL instance."
        "Managed virtual machines running company infrastructure."
        "Managed DNS server & configured records to improve security, routing behavior, and standards compliance"
        "Deployed internal company mesh VPN to secure company infrastructure in remote & hybrid work environments."
        "Enhanced mail server security by configuring DMARC, DKIM, & SPF DNS records."
      ];
    }
    {
      name = "Brazen";
      location = "Arlington, VA";
      position = "Software Engineering Intern";
      description = "Brazen is a company developing software for hosting video conferencing.";
      url = "https://brazenconnect.com";
      startDate = "2020-02-01";
      endDate = "2020-05-01";
      summary = "Developed features for video conferencing platform & chatbots for automated candidate onboarding.";
      highlights = [
        "Wrote Java code with Tensorflow API to integrate chatbot NLP agents with custom business logic."
        "Wrote frontend & backend code in Java for video conferencing web platform."
      ];
    }
    {
      name = "General Electric: Transportation";
      location = "Lawrence Park, PA";
      description = "Locomotive manufacturer";
      position = "Electrical Integration - Software Engineering Intern";
      url = "https://ge.com";
      startDate = "2018-06-01";
      endDate = "2018-09-01";
      summary = "GE Transportation (now Wabtec) is a global leader in locomotive manufacturing.";
      highlights = [
        "Wrote C program to validate configurations to control locomotive hardware."
        "Wrote Python program to analyze locomotive schematics for possible points of failure."
        "Wrote Visual Basic for Applications (VBA) code to integrate Python & C programs with Excel spreadsheets used by engineers."
      ];
    }
    {
      name = "General Electric: Transportation";
      location = "Lawrence Park, PA";
      description = "Locomotive manufacturer";
      position = "Electrical Integration - Software Engineering Intern";
      url = "https://ge.com";
      startDate = "2017-06-01";
      endDate = "2017-09-01";
      summary = "GE Transportation (now Wabtec) is a global leader in locomotive manufacturing.";
      highlights = [
        "Wrote C program to validate configurations to control locomotive hardware."
        "Wrote Python program to analyze locomotive schematics for possible points of failure."
        "Wrote Visual Basic for Applications (VBA) code to integrate Python & C programs with Excel spreadsheets used by engineers."
      ];
    }
  ];

  volunteer = [
    {
      organization = "THON Technology";
      position = "Captain";
      url = "https://think.thon.org";
      startDate = "2018-09-01";
      endDate = "2019-04-01";
      summary = "THON is a student-run non-profit organization raising money for pediatric cancer research and the children affected by it. The THON Technology committee develops software to facilitate volunteer work and manage the annual dance marathon event.";
      highlights = [
        "Containerized developer environment to speed up onboarding new volunteer developers."
        "Containerized production webserver to make production environment reproducible."
        "Used Python & Django to create informational webpages to update volunteers on latest events & news."
        "Used Python & Django to create forms to collect and process information from volunteers."
      ];
    }
  ];

  education = [
    {
      institution = "Penn State University";
      url = "https://psu.edu";
      area = "Computer Science";
      startDate = "2014-08-20";
      endDate = "2019-05-31";
      # studyType = "Bachelor";
      # score = "3.2";
      # courses = [
      #   "CMPSC121 - "
      #   "CMPSC122 - "
      #   "CMPSC221 - "
      #   "CMPSC360 - Discrete Mathematics"
      #   "CMPSC461 - "
      #   "CMPSC465 - Algorithms & Data Scriptures"
      # ];
    }
  ];
  publications = [
    {
      name = "Hello World - Blog";
      publisher = "Sam Lehman - Blog";
      releaseDate = "2024-02-10";
      url = "https://blog.samlehman.dev/posts/hello_world.html";
      summary = "First post to my self-hosted blog!";
    }
  ];

  skills = [
    {
      name = "Web Development";
      level = "Master";
      keywords = [
        "HTML"
        "CSS"
        "Javascript"
        "Typescript"
        "Node.js"
        "React.js"
        "Webpack.js"
        "Babel.js"
        "Django"
        "Python"
      ];
    }
    {
      name = "Nix";
      level = "Master";
      keywords = ["Nix" "NixOS" "DevOps" "reproducible builds" "functional programming"];
    }
    {
      name = "Kubernetes";
      level = "Beginner";
      keywords = ["DevOps" "containers" "infrastructure" "orchestration"];
    }
    {
      name = "Containers";
      level = "Master";
      keywords = ["DevOps" "Docker" "Podman" "containers" "infrastructure" "orchestration" "deployment"];
    }
    {
      name = "Rust";
      level = "Beginner";
      keywords = ["Rust" "memory-safe" "systems"];
    }
    {
      name = "Python";
      level = "Intermediate";
      keywords = ["Python" "Django" "data science"];
    }
    {
      name = "Terraform";
      level = "Beginner";
      keywords = ["Terraform" "DevOps" "infrastructure" "infrastructure-as-code"];
    }
    {
      name = "Microsoft Azure";
      level = "Intermediate";
      keywords = ["DevOps" "cloud computing" "OAuth2" "directory server"];
    }
  ];

  languages = [
    {
      language = "English";
      fluency = "Native speaker";
    }
    {
      language = "Spanish";
      fluency = "Intermediate";
    }
    {
      language = "Mandarin";
      fluency = "Beginner";
    }
  ];

  interests = [
    {
      name = "Home Automation";
      keywords = [
        "Home Assistant"
        "ESPHome"
        "Self-Hosting"
        "Raspberry Pi"
        "ESP32"
        "Microcontrollers"
        "Circuitry"
      ];
    }
    {
      name = "Wrestling";
      keywords = ["Sports" "Martial Arts" "Fitness" "Athletics" "Competition"];
    }
    {
      name = "Weight Lifting";
      keywords = ["Fitness" "Athletics" "Health"];
    }
  ];

  references = [
    {
      name = "Lauri Lewis";
      reference = "It's my pleasure to recommend Sam. He single-handedly moved our business IT into the 21st century. Any company would be lucky to have him.";
    }
  ];

  projects = [
    {
      name = "nix-configs";
      description = "Personal Nix configurations for personal computing devices & cluster infrastructure.";
      highlights = [
        "Declarative configurations representing both personal workstations and server infrastructure."
        "Encrypted secret management with sops."
        "Deployment of configurations via SSH."
        "Running many self-hosted server applications in Kubernetes"
      ];
      url = "https://github.com/Lehmanator/nix-configs";
      keywords = [
        "Kubernetes"
        "Helm"
        "Nix"
        "NixOS"
        "DevOps"
        "CI / CD"
        "deployment"
        "infrastructure-as-code"
      ];
    }
    {
      name = "resume.nix";
      description = "Nix flake project to build & deploy my personal resume using jsonresume.";
      highlights = [
        "Reproducible environment that pulls locked dependencies to build artifacts for my resume."
        "Builds an static webpage and PDF of my resume."
        "Automatically deploys successfully built artifacts to GitHub Pages using GitHub Actions."
        "Development shell with automatic installations of dependencies needed to hack on, build, and deploy my resume."
      ];
      keywords = [
        "Nix"
        "GitHub"
        "GitHub Pages"
        "GitHub Actions"
        "DevOps"
        "Node.js"
        "static site"
        "reproducible builds"
        "declarative"
        "CI / CD"
      ];
      startDate = "2024-01-24";
      url = "https://resume.samlehman.dev";
      roles = ["Team lead" "Designer"];
      entity = "Sam Lehman";
      type = "application";
    }
    {
      name = "HeyImHungry";
      description = "Service to connect those with excess or soon-to-expire food with those in need.";
      url = "https://github.com/Lehmanator/HeyImHungry";
      keywords = ["React" "Javascript" "Google Assistant" "Google Cloud" "Firebase"];
      highlights = [
        "React & React Native frontend."
        "Google Assistant interface to query and add listings."
      ];
    }
  ];

  #awards = [
  #  { title = "Digital Compression Pioneer Award";
  #    date = "2014-11-01";
  #    awarder = "Techcrunch";
  #    summary = "There is no spoon.";
  #  }
  #];

  meta = {
    canonical = "https://raw.githubusercontent.com/Lehmanator/resume-nix/main/src/jsonresume.nix";
    version = "v1.0.1";
    lastModified = "2024-06-11T15:53:00";

    # Set default theme when fetching through
    # https://registry.jsonresume.org/<github-user-name>, see themes
    # here: https://jsonresume.org/themes/
    # theme = "stackoverflow"; # "papirus";
    theme = "minyma";
  };
}
