var mparts = ["devops", "sail-it", "pro", ".", "@"];
var mhashed = mparts[0] + mparts[4] + mparts[1] + mparts[3] + mparts[2];
var isPolish = (document.documentElement.lang || "").toLowerCase().indexOf("pl") === 0;
document.getElementById("mhashed2").innerHTML=mhashed;
document.getElementById("mhashed1").href="mailto:"+mhashed;
document.getElementById("mhashed1").setAttribute("aria-label", (isPolish ? "Wyslij email: " : "Send email: ") + mhashed);

var tparts = ["727", "+48", "610", "510", " "];
var thashed1 = tparts[1] + tparts[4] + tparts[3] + tparts[4] + tparts[0] + tparts[4] + tparts[2];
var thashed2 = tparts[1] + tparts[3] + tparts[0] + tparts[2];
document.getElementById("thashed1").innerHTML=thashed1;
document.getElementById("thashed2").href="tel:" + thashed2;
document.getElementById("thashed2").setAttribute("aria-label", (isPolish ? "Zadzwon: " : "Call: ") + thashed1);