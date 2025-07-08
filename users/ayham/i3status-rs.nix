{ config, pkgs, lib, home-manager, stylix, ... }: {
  home-manager.users.ayham = {
    programs.i3status-rust = {
      enable = true;
      bars = {
        default = {
          blocks = [{
            alert = 10.0;
            block = "disk_space";
            info_type = "available";
            interval = 60;
            path = "/";
            warning = 20.0;
          }
          {
            block = "memory";
          }
          {
            block = "cpu";
            interval = 1;
          }
          {
            block = "load";
            format = " $icon $1m ";
            interval = 1;
          }
          {
            block = "sound";
          }
          {
            block = "battery";
            format = " $percentage {$time_remaining.dur(hms:true, min_unit:m) |}";
            missing_format = "";
          }
          {
            block = "time";
            format = " $timestamp.datetime(f:'%a %d.%m.%y %R') ";
            interval = 60;
          }
        ];
      };
    };
  };

};
}
