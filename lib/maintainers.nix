{...}: {
  Lehmanator = {
    name = "Sam Lehman";
    handle = "Lehmanator";

    email = "lehmanator@noreply.codeberg.org";
    matrix = "@Lehmanator:tchncs.de";

    # https://api.github.com/users/${github}
    githubId = 134539022;
    github = "Lehmanator";

    keys = [
      # GPG - RSA-4096: Sign, Certify
      {fingerprint = "5222 833B 7C18 B486 CB71  46F5 2D0F BE02 03AE 5181";}

      # GPG - RSA-4096: Encrypt
      {fingerprint = "7242 794B 51C8 C739 7977  4A09 85A2 FAE1 50CC CB8C";}
    ];
  };
}
