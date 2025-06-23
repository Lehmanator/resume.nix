{
  extraHighlights ? [],
  hide ? [],
  overrides ? {},
  ...
} @ args: let
  base = builtins.removeAttrs args ["extraHighlights" "hide" "overrides"];
  merge = a: builtins.removeAttrs (base // a // {highlights = a.highlights or [] ++ extraHighlights;} // overrides) hide;
in
  merge
  {
    name = "Presque Isle Wine Cellars";
    location = "North East, PA";
    description = "Winery & Wine Supplies Sales";
    position = "System Administrator";
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
      "Created Group Policy Objects (GPOs) to push configuration updates to remote Windows workstations."
    ];
  }
