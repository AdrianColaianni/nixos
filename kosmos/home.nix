{ config, pkgs, ... }:

{
  home.username = "adrian";
  home.homeDirectory = "/home/adrian";
  home.stateVersion = "25.11";

  home.sessionVariables = {
    XCURSOR_SIZE = "24";
    HYPRCURSOR_SIZE = "24";
  };

  wayland.windowManager.hyprland = {
    enable = true;
    plugins = [
      pkgs.hyprlandPlugins.hyprsplit
    ];
    package = null;
    portalPackage = null;
    settings = {
      monitor = "eDP-1,preferred,auto,auto";
      plugin = {
        hyprsplit = {
          num_workspaces = 6;
        };
      };

      device = {
        name = "epic-mouse-v1";
        sensitivity = -0.5;
      };
      input = {
        kb_layout = "us";
        follow_mouse = 1;
        sensitivity = 0; # -1.0 - 1.0, 0 means no modification.
        touchpad = {
            natural_scroll = false;
        };
      };

      workspace = [
        "special:scratchpad, on-created-empty: kitty --class scratchpad"
        "special:bc, on-created-empty: kitty --class bc bc -lq"
      ];

      misc = {
        force_default_wallpaper = -1; # Set to 0 or 1 to disable the anime mascot wallpapers
        disable_hyprland_logo = true; # If true disables the random hyprland logo / anime girl background. :(
        enable_swallow = true;
      };

      decoration = {
        rounding = 10;
        rounding_power = 1;

        # Change transparency of focused and unfocused windows
        # active_opacity = 1.0
        # inactive_opacity = 0.9

        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
          color = "rgba(1a1a1aee)";
        };

        # https://wiki.hypr.land/Configuring/Variables/#blur
        blur = {
          enabled = true;
          size = 3;
          passes = 1;
          vibrancy = 0.1696;
        };
      };

      animations = {
        enabled = false;
        bezier = [
          "easeOutQuint,   0.23, 1,    0.32, 1"
          "easeInOutCubic, 0.65, 0.05, 0.36, 1"
          "linear,         0,    0,    1,    1"
          "almostLinear,   0.5,  0.5,  0.75, 1"
          "quick,          0.15, 0,    0.1,  1"
        ];
        animation = [
          "global,        1,     10,    default"
          "border,        1,     5.39,  easeOutQuint"
          "windows,       1,     4.79,  easeOutQuint"
          "windowsIn,     1,     4.1,   easeOutQuint, popin 87%"
          "windowsOut,    1,     1.49,  linear,       popin 87%"
          "fadeIn,        1,     1.73,  almostLinear"
          "fadeOut,       1,     1.46,  almostLinear"
          "fade,          1,     3.03,  quick"
          "layers,        1,     3.81,  easeOutQuint"
          "layersIn,      1,     4,     easeOutQuint, fade"
          "layersOut,     1,     1.5,   linear,       fade"
          "fadeLayersIn,  1,     1.79,  almostLinear"
          "fadeLayersOut, 1,     1.39,  almostLinear"
          "workspaces,    1,     1.94,  almostLinear, fade"
          "workspacesIn,  1,     1.21,  almostLinear, fade"
          "workspacesOut, 1,     1.94,  almostLinear, fade"
          "zoomFactor,    1,     7,     quick"
        ];
      };

      general = {
        gaps_in = 5;
        gaps_out = 10;

        border_size = 2;

        # https://wiki.hypr.land/Configuring/Variables/#variable-types for info about colors
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";

        # Set to true enable resizing windows by clicking and dragging on borders and gaps
        resize_on_border = true;

        # Please see https://wiki.hypr.land/Configuring/Tearing/ before you turn this on
        allow_tearing = false;

        layout = "monocle";
      };


      exec-once = [
      "swww-daemon"
      "dunst"
      "waybar"
      "hypridle"
      "sudo xremap ~/.config/xremap/config.yml"
      "xrdb -merge ~/.config/x11/xresources"
      "wlsunset -l 34.7 -L -82.8"
      "mpd"
      "mpd-mpris"
      "gnome-keyring-daemon"
      ];

      "$mainMod" = "SUPER";
      "$terminal" = "kitty";
      "$fileManager" = "dolphin";
      "$web" = "brave";
      "$menu" = "rofi -show drun";
      "$sshmenu" = "rofi -show ssh";

      gesture = "3, horizontal, workspace";

      bind = [
        #Binds
        "$mainMod, 36, exec, $terminal"
        "$mainMod, D, exec, $menu"
        "$mainMod, Q, killactive,"
        "$mainMod SHIFT, space, togglefloating,"
        "$mainMod, P, pseudo, # dwindle"
        "$mainMod SHIFT, R, exec, $terminal btop"
        # Tools
        "SHIFT, Print, exec, rofipick"
        ", Print, exec, hyprshot -m active -m output"
        "$mainMod SHIFT, D, exec, rofi-pass"
        "$mainMod, 22, exec, $terminal ~/.config/waybar/scripts/power-menu.sh"
        # Music
        "$mainMod, M, exec, $terminal ncmpcpp"
        "$mainMod, 59, exec, playerctl previous"
        "$mainMod, 60, exec, playerctl next"
        "$mainMod, up, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
        "$mainMod, down, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        "$mainMod, right, exec, playerctl play-pause"
        "$mainMod, R, exec, $fileManager"
        "$mainMod, W, exec, $web"
        "$mainMod, E, exec, evolution"
        "$mainMod SHIFT, E, exec, signal-desktop"
        "$mainMod CTRL, E, exec, vesktop"
        # Movement
        "$mainMod, J, layoutmsg, cyclenext"
        "$mainMod, K, layoutmsg, cycleprev"
        # Monitor
        # Monitor
        "$mainMod, right, focusmonitor, r"
        "$mainMod, down, focusmonitor, d"
        "$mainMod, up, focusmonitor, u"
        "$mainMod, left, movefocus, l"
        # Move windows
        "$mainMod, F, fullscreen"
        "$mainMod, U, fullscreenstate, 1 0"
        "$mainMod, S, pin"

        # Switch workspaces with mainMod + [0-9]
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        # Move active window to a workspace with mainMod + SHIFT + [0-9]
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"

        # Example special workspace (scratchpad)
        "$mainMod, I, togglespecialworkspace, magic"
        "$mainMod SHIFT, I, movetoworkspace, special:magic"

        # Pop-up term
        "$mainMod SHIFT, 36, togglespecialworkspace, scratchpad"
        # Pop-up bc
        "$mainMod, 48, togglespecialworkspace, bc"

        # Scroll through existing workspaces with mainMod + scroll
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"
        # Functions
        "$mainMod, F4, exec, $terminal pulsemixer"
      ];

      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      bindl = [
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPause, exec, playerctl play-pause"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF85AudioPrev, exec, playerctl previous"
      ];

      bindel = [
        ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ", XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+"
        ", XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-"
      ];
    };
  };
}
