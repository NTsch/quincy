xquery version "3.1";
declare namespace atom = "http://www.w3.org/2005/Atom";
declare namespace cei = "http://www.monasterium.net/NS/cei";
declare namespace xrx = "http://www.monasterium.net/NS/xrx";
declare namespace eag = "http://www.archivgut-online.de/eag";

(:for $charter in doc('final_cei_FRAD021_000002216.xml')//cei:text[@type='charter']
for $img in $charter//cei:figure
let $url := $img/cei:graphic/@url/data()
let $img-no := substring-before(tokenize($url, '/')[last()], 'full')
let $incremented := xs:int($img-no) + 1
let $new-url := replace($url, $img-no, $incremented)
let $verso := <cei:figure><cei:graphic url='{$new-url}'/></cei:figure>
return update insert $verso following $img:)

for $charter in doc('final_cei_FRAD021_000002216.xml')//cei:text[@type='charter']
let $id := $charter/cei:body/cei:idno/@id/data()
let $official-id := if (contains($id, '-')) then substring-before($id, '-') else ($id)
let $arch-id := <cei:idno id="{$official-id}">{$official-id}</cei:idno>
return (
update delete $charter/cei:body/cei:chDesc/cei:witnessOrig/cei:archIdentifier/cei:idno,
update insert $arch-id preceding $charter/cei:body/cei:chDesc/cei:witnessOrig/cei:archIdentifier/cei:archFond
)