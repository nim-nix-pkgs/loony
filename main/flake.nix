{
  description = ''Fast mpmc queue with sympathetic memory behavior'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-loony-main.flake = false;
  inputs.src-loony-main.ref   = "refs/heads/main";
  inputs.src-loony-main.owner = "shayanhabibi";
  inputs.src-loony-main.repo  = "loony";
  inputs.src-loony-main.type  = "github";
  
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
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-loony-main"];
    over = if builtins.pathExists ./override.nix 
           then { override = import ./override.nix; }
           else { };
  in lib.mkRefOutput (over // {
    inherit self nixpkgs ;
    src  = deps."src-loony-main";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  } );
}