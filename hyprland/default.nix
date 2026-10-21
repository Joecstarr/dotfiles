# So best window tiling manager
{
  pkgs,
  config,
  inputs,
  ...
}:
{

  #imports = [
  #  #./animations.nix
  #  #./bindings.nix
  #  #./polkitagent.nix
  #  # ./hyprspace.nix
  #];

  xdg.configFile =
    let
      mkSymlink = config.lib.file.mkOutOfStoreSymlink;
      confPath = "${config.home.homeDirectory}/server-cfg/home/system/hyprland/conf";
    in
    {
      "hypr/hyprland.lua".source = mkSymlink "${confPath}/hyprland.lua";
      "hypr/animations.lua".source = mkSymlink "${confPath}/animations.lua";
      "hypr/bindings.lua".source = mkSymlink "${confPath}/bindings.lua";
      "hypr/apps.lua".source = mkSymlink "${confPath}/apps.lua";
      "hypr/workspaces.lua".source = mkSymlink "${confPath}/workspaces.lua";
    };

  home.packages = with pkgs; [
    qt5.qtwayland
    qt6.qtwayland
    libsForQt5.qt5ct
    qt6Packages.qt6ct
    hyprshot
    wayle
    hyprpicker
    swappy
    imv
    wf-recorder
    wlr-randr
    wl-clipboard
    brightnessctl
    gnome-themes-extra
    libva
    dconf
    wayland-utils
    wayland-protocols
    glib
    direnv
    meson
    hyprpaper
  ];

  services.wayle = {
    enable = true;

    # Whether to automatically install soft dependencies used by wayle that
    # will be required based on your config.
    autoInstallDependencies = true;

    # tip: you can automatically translate your TOML config to Nix by running
    # nix-instantiate --eval --expr 'builtins.fromTOML (builtins.readFile ./config.toml)' | nixfmt
    settings = {
      bar = {
        layout = [
          # add more attribute sets with different monitors if wayle should
          # have different layouts on each
          {
            scale = .7;
            monitor = "*"; # replace "DP-1" with "*" for all monitors
            show = true;
            center = [
              "clock"
              "weather"
            ];
            left = [
              "dashboard"
              "hyprland-workspaces"
            ];
            right = [
              "volume"
              "battery"
            ];
          } # this is a 'list' of 'attribute sets', no semi-colons after the closing braces needed
        ];
      };
      modules = {
        clock = {
          format = "%H:%M:%S";
          dropdown-show-seconds = false;
        };
        weather = {
          location = "Detroit";
          units = "imperial";
        };
        hyprland-workspaces = {
          show-special = false;
        };
        hyprsunset = {
          temperature = 2500;
        };
      };

      wallpaper = {
        # this will automatically install aww
        engine-enabled = false;

        cycling-directory = "/home/horsey/Pictures/Backgrounds/1/";
        cycling-mode = "shuffle";
      };

    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    configType = "lua";
  };

  systemd.user.targets.hyprland-session.Unit.Wants = [ "xdg-desktop-autostart.target" ];
}
