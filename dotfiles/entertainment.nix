{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    steam
    multimc
    xboxdrv
    mpv
  ];
  hardware.opengl.driSupport32Bit = true;
  hardware.pulseaudio.support32Bit = true;

  services.xserver.videoDrivers = [ "nvidia" ];

  services.xserver.screenSection = '' 
   Option         "metamodes" "nvidia-auto-select +0+0 {ForceCompositionPipeline=On, ForceFullCompositionPipeline=On}"
    '';

  systemd.services.xboxdrv = {
     wantedBy = [ "multi-user.target" ];
     after = [ "network.target" ];
     serviceConfig = {
       Type = "forking";
       User = "root";
       ExecStart = ''${pkgs.xboxdrv}/bin/xboxdrv --daemon --detach --pid-file /var/run/xboxdrv.pid --dbus disabled --silent --deadzone 4000 --deadzone-trigger 10% --mimic-xpad-wireless'';
     };
   };

  services.xserver.config = ''
   Section "InputClass"
        Identifier "joystick catchall"
        MatchIsJoystick "on"
        MatchDevicePath "/dev/input/event*"
    Driver "evdev"
        Option "StartKeysEnabled" "False"
        Option "StartMouseEnabled" "False"
   EndSection
  '';
}


