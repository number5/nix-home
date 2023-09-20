{pkgs, ...}: let 
 user = "bruce";
 in 
{
  # required by virt-manager (Gnome)
  programs.dconf.enable = true;

# 1password 
    programs._1password-gui.enable = true;
    programs._1password-gui.polkitPolicyOwners = [ user ];

    programs._1password.enable = true;

}
