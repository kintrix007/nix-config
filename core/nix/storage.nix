{ ... }:

{
  nix.gc = {
    automatic = true;
    dates = "weekly";
    # options = "--delete-older-than +5"; # Keep last 5 generations
    # NOTE: The above is not actually supported even though the
    # documentation says it is. Bruh.
    options = "--delete-older-than 30d";
  };

  nix.optimise = {
    automatic = true;
    dates = [ "weekly" ];
  };
}
