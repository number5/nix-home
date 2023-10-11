{
  unstable,
  self,
  ...
}: {
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (config.lib) dag;
  cfg = config.mutable;

  cloneIfNotExists = target: repo: branch: ''
    if [ ! -e "${target}" ]; then
      GIT_SSH_COMMAND=${pkgs.openssh}/bin/ssh $DRY_RUN_CMD ${pkgs.git}/bin/git clone \
        --branch "${branch}" \
        --recursive \
        -- \
        "${repo}" \
        "${target}"
    fi
  '';

  cloneScripts =
    lib.attrsets.mapAttrsToList
    (_name: attrs: cloneIfNotExists attrs.target attrs.repo attrs.branch)
    cfg.repos;

  types = lib.types;
  inherit (lib) mkIf mkOption mkEnableOption;

in {
  options.mutable.enable = mkEnableOption "Stateful Data";

  options.mutable.repos = mkOption {
    type = types.attrsOf (types.submodule {
      options = {
        branch = mkOption {type = types.str;};
        repo = mkOption {type = types.str;};
        target = mkOption {type = types.path;};
      };
    });
  };

  config = mkIf cfg.enable {
    programs.git.enable = true;

    home.activation.cloneStatefulRepos =
      dag.entryAfter ["installPackages"]
      (builtins.concatStringsSep "\n" cloneScripts);
  };
}
