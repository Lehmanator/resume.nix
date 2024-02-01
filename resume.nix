{
  "$schema" = "https://raw.githubusercontent.com/jsonresume/resume-schema/v1.0.0/schema.json";

  basics = {
    name = "Sam Lehman";
    #label = "Programmer";
    label = "Software Developer";
    image = "photo.png";
    email = "sam@samlehman.dev";
    phone = "+1 (814) 528-3891";
    url = "https://samlehman.dev";
    summary = "Sam hails from Erie, Pennsylvania. He has earned degrees from Penn State University. Before starting Pied Piper, he worked for Hooli as a part time software developer. While his work focuses on applied information theory, mostly optimizing lossless compression schema of both the length-limited and adaptive variants, his non-work interests range widely, everything from quantum computing to chaos theory. He could tell you about it, but THAT would NOT be a “length-limited” conversation!";
    location = {
      address = "617 Hardscrabble Blvd";
      postalCode = "PA 16505";
      city = "Erie";
      countryCode = "US";
      region = "Pennsylvania";
    };
    profiles = [
      {
        network = "Mastodon";
        username = "@sam@lehman.run";
        url = "https://lehman.run/sam";
      }
      {
        network = "Twitter";
        username = "publicSam";
        url = "https://twitter.com/publicSam";
      }
      {
        network = "SoundCloud";
        username = "dandymusicnl";
        url = "https://soundcloud.example.com/dandymusicnl";
      }
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
      summary = "Pied Piper is a multi-platform technology based on a proprietary universal compression algorithm that has consistently fielded high Weisman Scores™ that are not merely competitive, but approach the theoretical limit of lossless compression.";
      highlights = [
        "Build an algorithm for artist to detect if their music was violating copy right infringement laws"
        "Successfully won Techcrunch Disrupt"
        "Optimized an algorithm that holds the current world record for Weisman Scores"
      ];
    }
    {
      name = "General Electric: Transportation";
      location = "Lawrence Park, PA";
      description = "Locomotive manufacturer";
      position = "Software Engineering Intern";
      url = "https://ge.com";
      startDate = "2018-06-01";
      endDate = "2018-09-01";
      summary = "INSERT SUMMARY HERE";
      highlights = [
        "Successfully won Techcrunch Disrupt"
        "Optimized an algorithm that holds the current world record for Weisman Scores"
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
      summary = "Global movement of free coding clubs for young people.";
      highlights = ["Awarded 'Teacher of the Month'"];
    }
  ];

  education = [
    {
      institution = "Penn State University";
      url = "https://psu.edu";
      area = "Computer Science";
      studyType = "Bachelor";
      startDate = "2011-06-01";
      endDate = "2014-01-01";
      score = "4.0";
      courses = ["DB1101 - Basic SQL" "CS2011 - Java Introduction"];
    }
  ];

  awards = [
    {
      title = "Digital Compression Pioneer Award";
      date = "2014-11-01";
      awarder = "Techcrunch";
      summary = "There is no spoon.";
    }
  ];

  publications = [
    {
      name = "Video compression for 3d media";
      publisher = "Hooli";
      releaseDate = "2014-10-01";
      url = "http://en.wikipedia.org/wiki/Silicon_Valley_(TV_series)";
      summary = "Innovative middle-out compression algorithm that changes the way we store data.";
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
      ];
    }
    {
      name = "Nix";
      level = "Master";
      keywords = ["Nix" "NixOS" "reproducible" "builds" "DevOps" "functional"];
    }
    {
      name = "Kubernetes";
      level = "Beginner";
      keywords = ["containers" "infrastructure" "orchestration"];
    }
    {
      name = "Rust";
      level = "Beginner";
      keywords = ["Rust" "memory-safe" "systems"];
    }
    {
      name = "Microsoft Azure";
      level = "Intermediate";
      keywords = ["Cloud"];
    }
  ];

  languages = [
    {
      language = "English";
      fluency = "Native speaker";
    }
    {
      language = "Spanish";
      fluency = "Basic";
    }
  ];

  interests = [
    {
      name = "Wildlife";
      keywords = ["Ferrets" "Unicorns"];
    }
  ];

  references = [
    {
      name = "Erlich Bachman";
      reference = "It is my pleasure to recommend Richard, his performance working as a consultant for Main St. Company proved that he will be a valuable addition to any company.";
    }
  ];

  projects = [
    {
      name = "Meehive";
      description = "Personal Nix configurations for personal computing devices & cluster infrastructure.";
      highlights = ["Running many self-hosted server applications in Kubernetes"];
      keywords = [
        "Kubernetes"
        "Helm"
        "Nix"
        "NixOS"
        "Deployment"
        "DevOps"
        "CI"
        "CD"
        "infrastructure-as-code"
      ];
    }
    {
      name = "Miss Direction";
      description = "A mapping engine that misguides you";
      highlights = [
        "Won award at AIHacks 2016"
        "Built by all women team of newbie programmers"
        "Using modern technologies such as GoogleMaps, Chrome Extension and Javascript"
      ];
      keywords = ["GoogleMaps" "Chrome Extension" "Javascript"];
      startDate = "2016-08-24";
      endDate = "2016-08-24";
      url = "missdirection.example.com";
      roles = ["Team lead" "Designer"];
      entity = "Smoogle";
      type = "application";
    }
  ];

  meta = {
    canonical = "https://raw.githubusercontent.com/jsonresume/resume-schema/master/schema.json";
    version = "v1.0.0";
    lastModified = "2017-12-24T15:53:00";

    # Set default theme when fetching through
    # https://registry.jsonresume.org/<github-user-name>, see themes
    # here: https://jsonresume.org/themes/
    theme = "papirus";
  };
}
