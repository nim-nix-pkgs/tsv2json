{
  description = ''Turn TSV file or stream into JSON file or stream'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs."tsv2json-master".dir   = "master";
  inputs."tsv2json-master".owner = "nim-nix-pkgs";
  inputs."tsv2json-master".ref   = "master";
  inputs."tsv2json-master".repo  = "tsv2json";
  inputs."tsv2json-master".type  = "github";
  inputs."tsv2json-master".inputs.nixpkgs.follows = "nixpkgs";
  inputs."tsv2json-master".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@inputs:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib"];
  in lib.mkProjectOutput {
    inherit self nixpkgs;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
    refs = builtins.removeAttrs inputs args;
  };
}