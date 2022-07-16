{
  description = ''Fast mpmc queue with sympathetic memory behavior'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-loony-0_1_10.flake = false;
  inputs.src-loony-0_1_10.ref   = "refs/tags/0.1.10";
  inputs.src-loony-0_1_10.owner = "shayanhabibi";
  inputs.src-loony-0_1_10.repo  = "loony";
  inputs.src-loony-0_1_10.type  = "github";
  
  inputs."github.com/disruptek/balls".owner = "nim-nix-pkgs";
  inputs."github.com/disruptek/balls".ref   = "master";
  inputs."github.com/disruptek/balls".repo  = "github.com/disruptek/balls";
  inputs."github.com/disruptek/balls".dir   = "";
  inputs."github.com/disruptek/balls".type  = "github";
  inputs."github.com/disruptek/balls".inputs.nixpkgs.follows = "nixpkgs";
  inputs."github.com/disruptek/balls".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  inputs."github.com/nim-works/cps".owner = "nim-nix-pkgs";
  inputs."github.com/nim-works/cps".ref   = "master";
  inputs."github.com/nim-works/cps".repo  = "github.com/nim-works/cps";
  inputs."github.com/nim-works/cps".dir   = "";
  inputs."github.com/nim-works/cps".type  = "github";
  inputs."github.com/nim-works/cps".inputs.nixpkgs.follows = "nixpkgs";
  inputs."github.com/nim-works/cps".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-loony-0_1_10"];
    over = if builtins.pathExists ./override.nix 
           then { override = import ./override.nix; }
           else { };
  in lib.mkRefOutput (over // {
    inherit self nixpkgs ;
    src  = deps."src-loony-0_1_10";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  } );
}