{
  cv = {
    name = "Sam Lehman";
    location = "Reading, Pennsylvania";
    email = "sam@samlehman.dev";
    phone = "tel:+1-814-528-3891";
    website = "https://samlehman.dev";
    social_networks = [
      {
        network = "Mastodon";
        username = "@Lehmanator@fosstodon.social";
      }
      {
        network = "Matrix";
        username = "@Lehmanator:tchncs.de";
      }
      {
        network = "GitHub";
        username = "Lehmanator";
      }
      {
        network = "Pixelfed";
        username = "Lehmanator@pixelfed.social";
      }
    ];
    sections = {
      summary = ["Hi, I'm Sam!"];
      education = [
        {
          institution = "Pennsylvania State University";
          location = "University Park, Pennsylvania";
          area = "Computer Science";
          degree = "in-progress";
          start_date = "2014-08";
          end_date = "2019-05";
          highlights = ["Made friends"];
        }
      ];
      experience = [
        {
          company = "Presque Isle Wine Cellars";
          location = "North East, Pennsylvania";
          position = "System Administrator";
          start_date = "2019-08";
          end_date = "2024-12";
          highlights = ["Test"];
        }
      ];
      projects = [
        # Normal Entry
        {
          name = "Test";
          location = "Remote";
          date = "2024-05";
          #start_date = "2020"; end_date = "2024";
          highlights = ["Test"];
        }
      ];
      publications = [
        # Publication Entry
        {
          title = "Test Publication";
          authors = ["Sam Lehman"];
          date = "2024-05";
          journal = "Test Journal";
          doi = "10.1001/FAKE.2024.1337124";
        }
      ];
      additional_experience_and_awards = [
        {
          label = "Test label";
          details = "Test details";
        }
      ];
      technologies = [
        # One Line Entry
        {
          label = "DevOps";
          details = ["Git" "Terraform" "Kubernetes" "Docker" "Nix"];
        }
        {bullet = "Test bullet";}
      ];
    };
  };
  design = {
    theme = "classic"; # classic | sb2nov | moderncv | engineeringresumes
    color = "rgb(255,0,0)"; # rgb(r,g,b) | #RRGGBB | <color_name>

    font = "Source Sans 3";
    font_size = "10pt";
    header_font_size = "30pt";

    disable_page_numbering = true;
    page_numbering_style = "NAME - Page PAGE_NUMBER of TOTAL_PAGES";
    page_size = "letterpapger"; # "a4paper";

    disable_last_updated_date = true;
    last_updated_date_style = "Last updated in TODAY";

    text_alignment = "justified";
    content_scale = 0.75;
    date_width = "3.8 cm";
    disable_external_link_icons = false;

    show_timespan_in = ["Experience"];
    show_only_years = false;

    #margins = {
    #  page = {
    #    top = "2 cm";
    #    bottom = "2 cm";
    #    left = "1.24 cm";
    #    right = "1.24 cm";
    #  };
    #  section_title = {
    #    top = "0.2 cm";
    #    bottom = "0.2 cm";
    #  }; # left = "1.24 cm"; right = "1.24 cm"; ;
    #  entry_area = {
    #    date_and_location_width = "4.1 cm";
    #    left_and_right = "0.2 cm";
    #    vertical_between = "0.12 cm";
    #    education_degree_width = "1 cm";
    #  };
    #  highlights_area = {
    #    left = "0.4 cm";
    #    top = "0.10 cm";
    #    vertical_between_bullet_points = "0.10 cm";
    #  };
    #  header = {
    #    horizontal_between_connections = "1.5 cm";
    #    vertical_between_name_and_connections = "0.2 cm";
    #    bottom = "0.2 cm";
    #  };
    #};
  };
}
