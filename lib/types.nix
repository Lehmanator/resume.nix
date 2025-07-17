{lib, ...}: rec {
  # https://github.com/nix-community/nixvim/blob/main/flake/flake-modules/nixvimConfigurations.nix
  configuration = lib.mkOptionType {
    name = "configuration";
    description = "configuration";
    descriptionClass = "noun";
    merge = lib.options.mergeOneOption;
    check = x: x._type or null == "configuration";
  };

  # --- Datetime -----------------------
  # Similar to the standard date type, but each section after the year is optional. e.g. 2014-06-29 or 2023-04
  #   ^(?![+-]?\d{4,5}-?(?:\d{2}|W\d{2})T)(?:|(\d{4}|[+-]\d{5})-?(?:|(0\d|1[0-2])(?:|-?([0-2]\d|3[0-1]))|([0-2]\d{2}|3[0-5]\d|36[0-6])|W([0-4]\d|5[0-3])(?:|-?([1-7])))(?:(?!\d)|T(?=\d)))(?:|([01]\d|2[0-4])(?:|:?([0-5]\d)(?:|:?([0-5]\d)(?:|\.(\d{3})))(?:|[zZ]|([+-](?:[01]\d|2[0-4]))(?:|:?([0-5]\d)))))$
  date.iso8601 = lib.types.strMatching "([1-2][0-9]{3}-[0-1][0-9]-[0-3][0-9]|[1-2][0-9]{3}-[0-1][0-9]|[1-2][0-9]{3})(T[0-2][0-9]:[0-5][0-9]:[0-5][0-9])?";

  # --- URI Components -----------------
  # TODO: URI (RFC 3986 URL)
  # TODO: URL
  # url = lib.types.strMatching "((https?|ftps?|s?ftp|file|git|ipfs|ssh):\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?";

  # TODO: Handle parameter queries
  url = lib.types.strMatching "((https?|ftps?|s?ftp|file|git|ipfs|ssh):\/\/)?([[:alnum:]\.-]+)\.([[:alpha:]]{2,})(\/[[:alnum:]\.\+\%_-]+)*";
  uri = url;
  urlSlug = lib.types.strMatching "[[:alnum:]-]+";

  # TODO: domainName
  # TODO: subdomain
  # TODO: protocolPrefix
  # TODO: urlPath
  # TODO: urlQueryParam, urlQueryParams
  tld = lib.types.enum ["com" "net" "org" "dev"];
  httpURL = lib.types.strMatching "https?:\/\/[[:alnum:]\.\/\-?=&%,]+";
  ipv4Address = lib.types.strMatching "(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)";

  # --- Contact Info -------------------
  # TODO: Email address
  emailAddress = lib.types.strMatching ".+@.+";

  # TODO: Phone number
  phoneNumber = lib.types.strMatching "(\+[[:digit:]]{0,3})\(?([[:digit:]]{3}\))[[:space:]-]?([[:digit:]]{3})-?([[:digit:]]{4})";

  username = lib.types.strMatching "[[:alnum:]-_]{3,16}";

  # --- Locale -------------------------
  # TODO: Country code (ISO-3166-1 ALPHA-2)
  # TODO: lib.types.enum [...];
  countryCode = lib.types.strMatching "[a-z|A-Z]{2}";
  # TODO: Is this just the United States? Complete regex.
  postalCode = lib.types.strMatching "[1-9][0-9]{4}(-[0-9]{4})?";
  postalCodeUSCanada = lib.types.strMatching "(^\d{5}(-\d{4})?$)|(^[ABCEGHJKLMNPRSTVXY]{1}\d{1}[A-Z]{1} *\d{1}[A-Z]{1}\d{1}$)";
  postalCodeBrazil = lib.types.strMatching "[[:digit]]{5}-[[:digit:]]{3}";

  # --- Versioning ---------------------
  semVer = lib.types.strMatching "v?([[:digit:]]+)\.([[:digit:]]+)\.([[:digit:]]+)";
}
