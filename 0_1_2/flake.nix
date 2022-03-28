{
  description = ''fast mpmc queue with sympathetic memory behavior'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-loony-0_1_2.flake = false;
  inputs.src-loony-0_1_2.ref   = "refs/tags/0.1.2";
  inputs.src-loony-0_1_2.owner = "shayanhabibi";
  inputs.src-loony-0_1_2.repo  = "loony";
  inputs.src-loony-0_1_2.type  = "github";
  
  inputs."github-disruptek-balls".owner = "nim-nix-pkgs";
  inputs."github-disruptek-balls".ref   = "master";
  inputs."github-disruptek-balls".repo  = "github-disruptek-balls";
  inputs."github-disruptek-balls".dir   = "3_7_0";
  inputs."github-disruptek-balls".type  = "github";
  inputs."github-disruptek-balls".inputs.nixpkgs.follows = "nixpkgs";
  inputs."github-disruptek-balls".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
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
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-loony-0_1_2"];
    over = if builtins.pathExists ./override.nix 
           then { override = import ./override.nix; }
           else { };
  in lib.mkRefOutput (over // {
    inherit self nixpkgs ;
    src  = deps."src-loony-0_1_2";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  } );
}