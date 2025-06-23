{
  overrides ? {},
  hide ? {},
  extraKeywords ? [],
  ...
} @ args: let
  base = builtins.removeAttrs args ["extraKeywords" "hide" "overrides"];
  merge = a: builtins.removeAttrs (base // a // {keywords = a.keywords or [] ++ extraKeywords;} // overrides) hide;
in
  merge
  {
    name = "Remote Management";
    level = "Master";
    keywords = [
      "SSH"
      "RDP"
      "VNC"
      "journald"
      "Group Policy Objects"
      "Wireguard tunnels"
      "Tailscale"
    ];
  }
