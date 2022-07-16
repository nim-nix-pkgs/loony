{
  description = ''fast mpmc queue with sympathetic memory behavior'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-loony-0_1_0.flake = false;
  inputs.src-loony-0_1_0.ref   = "refs/tags/0.1.0";
  inputs.src-loony-0_1_0.owner = "shayanhabibi";
  inputs.src-loony-0_1_0.repo  = "loony";
  inputs.src-loony-0_1_0.type  = "github";
  
  inputs."github.com/disruptek/balls".owner = "nim-nix-pkgs";
  inputs."github.com/disruptek/balls".ref   = "master";
  inputs."github.com/disruptek/balls".repo  = "github.com/disruptek/balls";
  inputs."github.com/disruptek/balls".dir   = "";
  inputs."github.com/disruptek/balls".type  = "github";
  inputs."github.com/disruptek/balls".inputs.nixpkgs.follows = "nixpkgs";
  inputs."github.com/disruptek/balls".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  inputs."github.com/disruptek/cps".owner = "nim-nix-pkgs";
  inputs."github.com/disruptek/cps".ref   = "master";
  inputs."github.com/disruptek/cps".repo  = "github.com/disruptek/cps";
  inputs."github.com/disruptek/cps".dir   = "";
  inputs."github.com/disruptek/cps".type  = "github";
  inputs."github.com/disruptek/cps".inputs.nixpkgs.follows = "nixpkgs";
  inputs."github.com/disruptek/cps".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-loony-0_1_0"];
    over = if builtins.pathExists ./override.nix 
           then { override = import ./override.nix; }
           else { };
  in lib.mkRefOutput (over // {
    inherit self nixpkgs ;
    src  = deps."src-loony-0_1_0";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  } );
}