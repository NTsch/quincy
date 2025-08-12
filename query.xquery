xquery version "3.1";
declare namespace atom = "http://www.w3.org/2005/Atom";
declare namespace cei = "http://www.monasterium.net/NS/cei";
declare namespace xrx = "http://www.monasterium.net/NS/xrx";
declare namespace eag = "http://www.archivgut-online.de/eag";

for $char_corr in doc('img_list_corrected.xml')//cei:text[@type='charter']
where $char_corr//cei:witnessOrig/cei:figure
let $id := $char_corr//cei:idno/@id/data()
let $imgs := $char_corr//cei:witnessOrig//cei:figure
for $char_old in doc('cei_FRAD021_000002216.xml')//cei:text[@type='charter']
where $char_old//cei:idno/@id/data() = $id
return (update delete $char_old//cei:witnessOrig//cei:figure, update insert $imgs into $char_old//cei:witnessOrig)