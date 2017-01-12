{nixpkgs ? import <nixpkgs> {}}:

with nixpkgs;

let
  toXML = stylesheet: attrs:
    let xml = pkgs.writeText "out.xml" (builtins.toXML attrs);
    in pkgs.runCommand "xml-builder" {buildInputs = [libxslt];} ''
        xsltproc ${stylesheet} ${xml} > $out
      '';

  getPaths = pkg: dirs: map (x: (stdenv.lib.removeSuffix "\n" "${pkg}/${x}"))
    (stdenv.lib.splitString "\n"
      (builtins.readFile
        (pkgs.runCommand "${pkg.name}-paths" {} ''
          cd ${pkg}
          for dir in ${builtins.concatStringsSep " " dirs}; do
            for file in $dir/*; do
              echo $file >> $out
            done
          done
        '')));

  removeEmpty = set:
    removeAttrs set (builtins.filter (x: set.${x} == "") # ''
      (builtins.attrNames set));

  parseAppdata = path: removeEmpty
    (builtins.fromJSON
      (builtins.readFile
        (pkgs.runCommand "parse-appdata" {buildInputs=[pkgs.libxml2];} ''
          root=$(xmllint --xpath "name(/*)" ${path})
          cat > $out << EOF
          {
            "id": "$(xmllint --xpath "$root/id/text()" ${path})",
            "name": "$(xmllint --xpath "$root/name/text()" ${path})",
            "projectLicense": "$(xmllint --xpath "$root/project_license/text()" ${path})",
            "metadataLicense": "$(xmllint --xpath "$root/metadata_license/text()" ${path})",
            "longDescription": "$(xmllint --xpath "$root/description/node()" ${path} | sed 's/\"/\\"/g')",
            "homepage": "$(xmllint --xpath "$root/url/text()" ${path})",
            "projectGroup": "$(xmllint --xpath "$root/project_group/text()" ${path})",
            "type": "$root"
          }
          EOF
        '')));

  getAttr = name: set:
    if builtins.hasAttr name set
      then { ${name} = set.${name}; } # ''
      else {};

  nix2appstream = pkgs:
    toXML ./components.xslt (map (pkg: (builtins.foldl' (x: y: x // y) {}) ([] ++
      [
        ({ name = (builtins.parseDrvName pkg.name).name; })
        (getAttr "description" pkg.meta)
        (getAttr "longDescription" pkg.meta)
      ] ++
      (map parseAppdata (getPaths pkg ["share/metainfo" "share/appdata"])) ++
      # (map parseDesktopFile (getPaths pkg ["share/applications"])) ++
      [
        ({ pkgname = (builtins.parseDrvName pkg.name).name; })
        (getAttr "spdxId" pkg.meta.license)
        (getAttr "projectGroup" pkg.meta)
        (getAttr "developerName" pkg.meta)
        (getAttr "icon" pkg.meta)
        (getAttr "homepage" pkg.meta)
        (getAttr "keywords" pkg.meta)
        (getAttr "categories" pkg.meta)
        (getAttr "mimetypes" pkg.meta)
        (getAttr "suggests" pkg.meta)
        (getAttr "languages" pkg.meta)
      ])) pkgs);

in

{
  inherit nix2appstream;
}
