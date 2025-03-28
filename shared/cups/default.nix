{ pkgs, config, ... }:

{
  # Enable CUPS to print documents.
  services.printing = {
    enable = true;
    browsing = true;
    browsed.enable = true;

    drivers = with pkgs; [
      gutenprint
      foomatic-filters
      foomatic-db
      foomatic-db-nonfree
      foomatic-db-ppds
      foomatic-db-engine
    ];
  };
}
