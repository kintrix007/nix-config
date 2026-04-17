{ ... }:

{
  services.kanata = {
    enable = true;
    keyboards = {
      builtinKeyboard = {
        configFile = ./config.kbd;
      };
    };
  };
}
