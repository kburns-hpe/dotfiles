let s:p = {"normal": {}, "inactive": {}, "insert": {}, "replace": {}, "visual": {}, "tabline": {} }

let s:p.normal.left = [[["#FFFFFF", 252], ["#193549", 25]], [["#ffc600", 252], ["#193549", 241]]]
let s:p.normal.middle = [[["#FFFFFF", 252], ["#193549", 237]]]
let s:p.normal.right = [[["#c7c7c7", 252], ["#193549", 241]], [["#FFFFFF", 237], ["#193549", 247]], [["#FFFFFF", 252], ["#193549", 241]]]
let s:p.normal.error = [[["#ff2600", 252], ["#193549", 88]]]
let s:p.normal.green = [[["#33ff00", 252], ["#193549", 88]]]
let s:p.normal.yellow = [[["#FFC600", 252], ["#193549", 88]]]
let s:p.normal.warning = [[["#ffc600", 237], ["#193549", 208]]]
let s:p.normal.enabled = [[["#3ad900", 237], ["#193549", 76]]]
let s:p.normal.disabled = [[["#808080", 252], ["#193549", 88]]]

let s:p.inactive.left = [[["#FFFFFF", 252], ["#193549", 25]], [["#ffc600", 252], ["#193549", 241]]]
let s:p.inactive.middle = [[["#FFFFFF", 252], ["#193549", 237]]]
let s:p.inactive.right = [[["#c7c7c7", 252], ["#193549", 241]], [["#FFFFFF", 237], ["#193549", 247]], [["#FFFFFF", 252], ["#193549", 241]]]

let s:p.insert.left = [[["#33ff00", 237], ["#193549", 71]], [["#ffc600", 252], ["#193549", 241]]]
let s:p.insert.middle = [[["#FFFFFF", 252], ["#193549", 237]]]
let s:p.insert.right = [[["#c7c7c7", 252], ["#193549", 241]], [["#FFFFFF", 237], ["#193549", 247]], [["#FFFFFF", 252], ["#193549", 241]]]

let s:p.replace.left = [[["#ff2c70", 212], ["#193549", 88]], [["#ffc600", 252], ["#193549", 241]]]
let s:p.replace.middle = [[["#FFFFFF", 252], ["#193549", 237]]]
let s:p.replace.right = [[["#c7c7c7", 252], ["#193549", 241]], [["#FFFFFF", 237], ["#193549", 247]], [["#FFFFFF", 252], ["#193549", 241]]]

let s:p.visual.left = [[["#ff9d00", 212], ["#193549", 88]], [["#ffc600", 252], ["#193549", 241]]]
let s:p.visual.middle = [[["#FFFFFF", 252], ["#193549", 237]]]
let s:p.visual.right = [[["#c7c7c7", 252], ["#193549", 241]], [["#FFFFFF", 237], ["#193549", 247]], [["#FFFFFF", 252], ["#193549", 241]]]

let s:p.tabline.left = [[["#CCCCCC", 252], ["#193549", 237]]]
let s:p.tabline.tabsel = [[["#1478db", 252], ["#193549", 25]]]
let s:p.tabline.middle = [[["#808080", 237], ["#193549", 237]]]
let s:p.tabline.right = [[["#CCCCCC", 252], ["#193549", 237]]]

let g:lightline#colorscheme#cobalt2#palette = lightline#colorscheme#flatten(s:p)
