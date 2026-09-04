{pkgs, ...}: let
  skills = "${pkgs.cortex}/share/cortex/skills";
  skillNames = ["ask" "capture" "cortex-connect" "cortex-disconnect"];
in {
  home.file = builtins.listToAttrs (
    builtins.concatMap (name: [
      {
        name = ".claude/skills/${name}";
        value = {source = "${skills}/${name}";};
      }
      {
        name = ".codex/skills/${name}";
        value = {source = "${skills}/${name}";};
      }
    ])
    skillNames
  );
}
