{
  description = ''Fast mpmc queue with sympathetic memory behavior'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-loony-0_1_9.flake = false;
  inputs.src-loony-0_1_9.ref   = "refs/tags/0.1.9";
  inputs.src-loony-0_1_9.owner = "shayanhabibi";
  inputs.src-loony-0_1_9.repo  = "loony";
  inputs.src-loony-0_1_9.type  = "github";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-loony-0_1_9"];
  in lib.mkRefOutput {
    inherit self nixpkgs ;
    src  = deps."src-loony-0_1_9";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  };
}