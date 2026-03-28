<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
<title>TERRA — Regenerative Farm</title>
<link href="https://fonts.googleapis.com/css2?family=Playfair+Display:ital,wght@0,400;0,700;0,900;1,400;1,700&family=DM+Sans:wght@300;400;500&display=swap" rel="stylesheet"/>
<style>
*,*::before,*::after{box-sizing:border-box;margin:0;padding:0}
html{scroll-behavior:smooth;overflow-x:hidden}
:root{
  --gold:#d4a84b;
  --gold-light:#f0d080;
  --dark:#080f08;
  --deep:#0a1a0b;
  --mid:#0e1c0f;
  --cream:#f8f2e4;
  --white:#fffef9;
  --serif:'Playfair Display',Georgia,serif;
  --sans:'DM Sans',sans-serif;
}
body{background:var(--dark);color:var(--cream);font-family:var(--sans);cursor:none;overflow-x:hidden}

/* CURSOR */
#cur{position:fixed;width:14px;height:14px;border-radius:50%;background:var(--gold);pointer-events:none;z-index:9999;transform:translate(-50%,-50%);transition:width .3s,height .3s;mix-blend-mode:screen}
#cur2{position:fixed;width:44px;height:44px;border-radius:50%;border:1.5px solid rgba(212,168,75,.5);pointer-events:none;z-index:9998;transform:translate(-50%,-50%);transition:width .45s cubic-bezier(.23,1,.32,1),height .45s cubic-bezier(.23,1,.32,1)}

/* LOADER */
#loader{position:fixed;inset:0;background:var(--dark);z-index:9990;display:flex;align-items:center;justify-content:center;flex-direction:column;gap:24px;transition:opacity 1s,visibility 1s}
#loader.out{opacity:0;visibility:hidden;pointer-events:none}
.l-logo{font-family:var(--serif);font-size:52px;font-weight:900;letter-spacing:8px;color:var(--gold);opacity:0;animation:fin .8s .2s forwards}
.l-sub{font-family:var(--sans);font-size:10px;letter-spacing:6px;text-transform:uppercase;color:rgba(212,168,75,.45);opacity:0;animation:fin .8s .5s forwards}
.l-bar{width:220px;height:1px;background:rgba(212,168,75,.15);overflow:hidden}
.l-fill{height:100%;background:linear-gradient(90deg,var(--gold),var(--gold-light));width:0;transition:width .06s linear}
@keyframes fin{to{opacity:1}}

/* NAV */
nav{position:fixed;top:0;left:0;right:0;z-index:200;padding:26px 5vw;display:flex;align-items:center;justify-content:space-between;transition:all .5s}
nav.s{background:rgba(8,15,8,.92);backdrop-filter:blur(28px);padding:14px 5vw;border-bottom:1px solid rgba(212,168,75,.1)}
.nl{font-family:var(--serif);font-size:28px;font-weight:900;letter-spacing:4px;color:var(--gold);text-decoration:none}
.nm{display:flex;gap:32px;list-style:none}
.nm a{font-family:var(--sans);font-size:11px;letter-spacing:3px;text-transform:uppercase;color:rgba(248,242,228,.55);text-decoration:none;transition:color .3s;position:relative}
.nm a::after{content:'';position:absolute;left:0;bottom:-4px;width:0;height:1px;background:var(--gold);transition:width .4s}
.nm a:hover{color:var(--gold)}.nm a:hover::after{width:100%}
.nb{font-family:var(--sans);font-size:10px;letter-spacing:3px;text-transform:uppercase;border:1px solid var(--gold);padding:11px 26px;color:var(--gold);text-decoration:none;transition:all .3s;cursor:none}
.nb:hover{background:var(--gold);color:var(--dark)}

/* ═══ HERO ═══ */
#hero{position:relative;height:100vh;overflow:hidden;display:flex;align-items:center}
.hbg{
  position:absolute;inset:0;
  background:url('https://images.pexels.com/photos/440731/pexels-photo-440731.jpeg?auto=compress&cs=tinysrgb&w=1920') center/cover no-repeat;
  transform:scale(1.1);transition:transform 10s ease-out;will-change:transform;
}
.hbg.go{transform:scale(1)}
.hov{position:absolute;inset:0;background:linear-gradient(100deg,rgba(8,15,8,.93) 0%,rgba(8,15,8,.6) 50%,rgba(8,15,8,.2) 100%)}
.hgrain{position:absolute;inset:0;opacity:.05;background-image:url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='300' height='300'%3E%3Cfilter id='f'%3E%3CfeTurbulence type='fractalNoise' baseFrequency='.85' numOctaves='4' stitchTiles='stitch'/%3E%3C/filter%3E%3Crect width='300' height='300' filter='url(%23f)'/%3E%3C/svg%3E");background-size:200px}
.hc{position:relative;z-index:3;padding:0 8vw;max-width:820px}
.he{font-family:var(--sans);font-size:10px;letter-spacing:7px;text-transform:uppercase;color:var(--gold);margin-bottom:22px;opacity:0;animation:sup .8s .7s forwards;display:flex;align-items:center;gap:14px}
.he::before{content:'';width:36px;height:1px;background:var(--gold)}
.ht{font-family:var(--serif);font-size:clamp(54px,8vw,112px);font-weight:900;line-height:.88;color:var(--white);opacity:0;animation:sup 1s .9s forwards}
.ht em{display:block;font-style:italic;color:var(--gold);font-size:1.05em}
.hp{font-family:var(--sans);font-size:17px;font-weight:300;color:rgba(248,242,228,.65);line-height:1.85;max-width:430px;margin-top:26px;opacity:0;animation:sup .8s 1.15s forwards}
.hb{display:flex;gap:14px;margin-top:42px;opacity:0;animation:sup .8s 1.35s forwards;flex-wrap:wrap}
.bg{background:var(--gold);color:var(--dark);font-family:var(--sans);font-size:10px;letter-spacing:3px;text-transform:uppercase;padding:17px 38px;text-decoration:none;cursor:none;font-weight:500;border:1px solid var(--gold);position:relative;overflow:hidden;display:inline-block;transition:all .3s}
.bg::before{content:'';position:absolute;inset:0;background:rgba(255,255,255,.18);transform:translateX(-110%) skewX(-15deg);transition:transform .5s}
.bg:hover::before{transform:translateX(120%) skewX(-15deg)}
.bw{background:transparent;color:var(--cream);font-family:var(--sans);font-size:10px;letter-spacing:3px;text-transform:uppercase;padding:17px 38px;text-decoration:none;border:1px solid rgba(248,242,228,.3);cursor:none;transition:all .3s;display:inline-block}
.bw:hover{border-color:var(--gold);color:var(--gold)}
.hscr{position:absolute;bottom:32px;left:50%;transform:translateX(-50%);display:flex;flex-direction:column;align-items:center;gap:8px;opacity:0;animation:fin .8s 2s forwards}
.hsl{width:1px;height:56px;position:relative;overflow:hidden}
.hsl::after{content:'';position:absolute;inset:0;background:linear-gradient(to bottom,transparent,var(--gold));animation:scanD 2s ease-in-out infinite}
@keyframes scanD{0%{transform:translateY(-100%)}100%{transform:translateY(200%)}}
.hst{font-family:var(--sans);font-size:9px;letter-spacing:5px;text-transform:uppercase;color:rgba(212,168,75,.5)}
@keyframes sup{from{opacity:0;transform:translateY(30px)}to{opacity:1;transform:translateY(0)}}

/* TICKER */
.ticker{background:var(--gold);padding:13px 0;overflow:hidden;position:relative;z-index:10}
.ttrack{display:flex;animation:tick 28s linear infinite;width:max-content}
.ti{font-family:var(--sans);font-size:11px;letter-spacing:4px;text-transform:uppercase;color:var(--dark);padding:0 28px;white-space:nowrap;font-weight:500}
.td{opacity:.4;margin:0 4px}
@keyframes tick{from{transform:translateX(0)}to{transform:translateX(-50%)}}

/* STATS */
.sbar{display:grid;grid-template-columns:repeat(4,1fr);gap:2px;background:var(--mid)}
.sb{padding:44px 32px;background:var(--deep);transition:all .5s cubic-bezier(.23,1,.32,1);cursor:none;position:relative;overflow:hidden}
.sb::after{content:'';position:absolute;top:0;left:0;right:0;height:1px;background:var(--gold);transform:scaleX(0);transition:transform .4s;transform-origin:left}
.sb:hover::after{transform:scaleX(1)}
.sb:hover{background:#0f2210;transform:translateY(-5px)}
.sbn{font-family:var(--serif);font-size:54px;font-weight:900;color:var(--gold);line-height:1}
.sbl{font-family:var(--sans);font-size:10px;letter-spacing:4px;text-transform:uppercase;color:rgba(248,242,228,.35);margin-top:8px}

/* ═══ ABOUT ═══ */
#about{
  padding:120px 5vw;display:grid;grid-template-columns:1fr 1fr;gap:80px;align-items:center;
  background:var(--deep);position:relative;
}
.av{position:relative;height:580px}
.ai1{
  position:absolute;top:0;left:0;right:60px;bottom:60px;overflow:hidden;
  box-shadow:24px 24px 70px rgba(0,0,0,.7);
  opacity:0;transform:translateX(-30px) rotateY(-8deg);
  transition:opacity .9s,transform .9s;
  transform-style:preserve-3d;
}
.ai1 img{width:100%;height:100%;object-fit:cover;display:block;transition:transform .8s}
.ai1:hover img{transform:scale(1.04)}
.ai1.vis{opacity:1;transform:translateX(0) rotateY(-3deg)}
.ai2{
  position:absolute;bottom:0;right:0;width:52%;height:52%;overflow:hidden;
  border:4px solid var(--dark);box-shadow:12px 12px 45px rgba(0,0,0,.7);
  opacity:0;transform:translateY(28px);
  transition:opacity .9s .25s,transform .9s .25s;
}
.ai2 img{width:100%;height:100%;object-fit:cover;display:block;transition:transform .8s}
.ai2:hover img{transform:scale(1.05)}
.ai2.vis{opacity:1;transform:translateY(0)}
.atag{position:absolute;top:18px;right:38px;background:var(--gold);color:var(--dark);font-family:var(--sans);font-size:9px;letter-spacing:3px;text-transform:uppercase;font-weight:700;padding:8px 16px;z-index:5}
.atx{opacity:0;transform:translateX(36px);transition:opacity .9s .2s,transform .9s .2s}
.atx.vis{opacity:1;transform:translateX(0)}
.ey{font-family:var(--sans);font-size:10px;letter-spacing:5px;text-transform:uppercase;color:var(--gold);margin-bottom:18px;display:flex;align-items:center;gap:12px}
.ey::before{content:'';width:28px;height:1px;background:var(--gold)}
.st{font-family:var(--serif);font-size:clamp(34px,3.5vw,52px);font-weight:700;line-height:1.1;color:var(--white);margin-bottom:22px}
.st em{font-style:italic;color:var(--gold)}
.sbo{font-family:var(--sans);font-size:16px;font-weight:300;line-height:1.9;color:rgba(248,242,228,.58);margin-bottom:16px}

/* ═══ HARVEST CARDS ═══ */
#harvest{padding:100px 5vw;overflow:hidden;background:var(--dark)}
.sh{text-align:center;margin-bottom:64px}
.cs{display:flex;gap:22px;overflow-x:auto;scroll-snap-type:x mandatory;scrollbar-width:none;padding-bottom:8px;cursor:grab}
.cs::-webkit-scrollbar{display:none}
.cs:active{cursor:grabbing}
.hc{min-width:320px;flex-shrink:0;height:460px;position:relative;scroll-snap-align:start;cursor:none;perspective:900px}
.hci{width:100%;height:100%;overflow:hidden;box-shadow:0 30px 80px rgba(0,0,0,.65),0 0 0 1px rgba(212,168,75,.12);transition:transform .6s cubic-bezier(.23,1,.32,1)}
.hc img{width:100%;height:100%;object-fit:cover;transition:transform .8s cubic-bezier(.23,1,.32,1);display:block}
.hc:hover img{transform:scale(1.1)}
.hcgl{position:absolute;inset:0;background:linear-gradient(to top,rgba(8,15,8,.96) 0%,rgba(8,15,8,.25) 55%,transparent 100%)}
.hcglow{position:absolute;inset:0;background:radial-gradient(circle at 50% 0%,rgba(212,168,75,.1),transparent 70%);opacity:0;transition:opacity .4s}
.hc:hover .hcglow{opacity:1}
.hcct{position:absolute;bottom:0;left:0;right:0;padding:26px}
.hctag{font-family:var(--sans);font-size:9px;letter-spacing:4px;text-transform:uppercase;color:var(--gold);margin-bottom:8px}
.hctt{font-family:var(--serif);font-size:26px;font-weight:700;color:var(--white);line-height:1.2;margin-bottom:8px}
.hcds{font-family:var(--sans);font-size:13px;font-weight:300;color:rgba(248,242,228,.6);line-height:1.7;max-height:0;overflow:hidden;transition:max-height .5s}
.hc:hover .hcds{max-height:70px}
.hcar{font-family:var(--sans);font-size:10px;letter-spacing:3px;text-transform:uppercase;color:var(--gold);margin-top:12px;display:flex;align-items:center;gap:6px;opacity:0;transform:translateX(-8px);transition:opacity .4s .1s,transform .4s .1s}
.hc:hover .hcar{opacity:1;transform:translateX(0)}

/* ═══ PARALLAX QUOTE ═══ */
#pq{position:relative;height:62vh;overflow:hidden;display:flex;align-items:center;justify-content:center}
.pqbg{
  position:absolute;inset:-20%;
  background:url('https://images.pexels.com/photos/974314/pexels-photo-974314.jpeg?auto=compress&cs=tinysrgb&w=1920') center/cover;
  will-change:transform;
}
.pqov{position:absolute;inset:0;background:rgba(8,15,8,.62)}
.pqct{position:relative;z-index:2;text-align:center;padding:0 5vw;max-width:820px}
.pqq{font-family:var(--serif);font-size:clamp(26px,3.5vw,50px);font-weight:400;font-style:italic;color:var(--white);line-height:1.35}
.pqq span{color:var(--gold)}
.pqa{font-family:var(--sans);font-size:10px;letter-spacing:5px;text-transform:uppercase;color:rgba(212,168,75,.55);margin-top:22px}

/* ═══ PRODUCTS MOSAIC ═══ */
#products{padding:120px 5vw;background:var(--mid)}
.pm{
  display:grid;
  grid-template-columns:repeat(12,1fr);
  grid-template-rows:280px 280px;
  gap:3px;margin-top:56px;
}
.pi{overflow:hidden;position:relative;cursor:none;transition:transform .6s cubic-bezier(.23,1,.32,1),box-shadow .4s}
.pi:hover{transform:scale(1.02);z-index:5;box-shadow:0 20px 60px rgba(0,0,0,.6)}
.pi:nth-child(1){grid-column:span 5;grid-row:span 2}
.pi:nth-child(2){grid-column:span 4}
.pi:nth-child(3){grid-column:span 3}
.pi:nth-child(4){grid-column:span 3}
.pi:nth-child(5){grid-column:span 4}
.pi img{width:100%;height:100%;object-fit:cover;transition:transform .7s cubic-bezier(.23,1,.32,1);display:block}
.pi:hover img{transform:scale(1.07)}
.piov{position:absolute;inset:0;background:linear-gradient(to top,rgba(8,15,8,.9),transparent 55%);opacity:0;transition:opacity .4s}
.pi:hover .piov{opacity:1}
.piif{position:absolute;bottom:20px;left:20px;right:20px;transform:translateY(10px);opacity:0;transition:all .4s}
.pi:hover .piif{transform:translateY(0);opacity:1}
.pinm{font-family:var(--serif);font-size:21px;font-weight:700;color:var(--white)}
.pitp{font-family:var(--sans);font-size:9px;letter-spacing:3px;text-transform:uppercase;color:var(--gold);margin-top:4px}

/* ═══ ANIMALS ═══ */
#field{
  padding:120px 5vw;display:grid;grid-template-columns:1fr 1fr;gap:80px;align-items:center;
  background:var(--deep);position:relative;overflow:hidden;
}
.fv{perspective:800px;opacity:0;transform:translateX(-36px);transition:opacity .9s,transform .9s}
.fv.vis{opacity:1;transform:translateX(0)}
.fvimg{
  width:100%;aspect-ratio:4/5;object-fit:cover;display:block;
  transform:rotateY(6deg) rotateX(-2deg);
  box-shadow:28px 28px 80px rgba(0,0,0,.75);
  transition:transform .7s cubic-bezier(.23,1,.32,1);
}
.fvimg:hover{transform:rotateY(0) rotateX(0) scale(1.02)}
.fvbdg{
  position:absolute;bottom:-18px;right:-18px;
  width:112px;height:112px;border-radius:50%;
  background:var(--gold);border:5px solid var(--deep);
  display:flex;flex-direction:column;align-items:center;justify-content:center;gap:2px;
  box-shadow:0 12px 40px rgba(0,0,0,.5);
}
.fvbn{font-family:var(--serif);font-size:30px;color:var(--dark);font-weight:900;line-height:1}
.fvbl{font-family:var(--sans);font-size:8px;letter-spacing:2px;text-transform:uppercase;color:var(--dark);font-weight:600;text-align:center}
.ftx{opacity:0;transform:translateX(36px);transition:opacity .9s .2s,transform .9s .2s}
.ftx.vis{opacity:1;transform:translateX(0)}
.al{display:flex;flex-direction:column;gap:10px;margin-top:28px}
.ai{display:flex;align-items:center;gap:16px;padding:14px 16px;border:1px solid rgba(212,168,75,.14);transition:all .35s;cursor:none}
.ai:hover{border-color:rgba(212,168,75,.5);background:rgba(212,168,75,.05);transform:translateX(6px)}
.aic{font-size:24px}
.ain{font-family:var(--serif);font-size:17px;color:var(--white)}
.ais{font-family:var(--sans);font-size:11px;color:rgba(248,242,228,.38);letter-spacing:1px;margin-top:2px}
.aicn{margin-left:auto;font-family:var(--sans);font-size:11px;letter-spacing:2px;color:var(--gold)}

/* ═══ GALLERY STRIP ═══ */
#gallery{display:flex;gap:3px;height:420px;overflow:hidden}
.gi{flex:1;overflow:hidden;position:relative;transition:flex .7s cubic-bezier(.23,1,.32,1);cursor:none}
.gi:hover{flex:2.8}
.gi img{width:100%;height:100%;object-fit:cover;transition:transform .8s cubic-bezier(.23,1,.32,1);display:block}
.gi:hover img{transform:scale(1.06)}
.glab{position:absolute;bottom:18px;left:18px;font-family:var(--sans);font-size:10px;letter-spacing:3px;text-transform:uppercase;color:var(--cream);opacity:0;transform:translateY(6px);transition:all .4s}
.gi:hover .glab{opacity:1;transform:translateY(0)}
.glab::before{content:'';display:block;width:22px;height:1px;background:var(--gold);margin-bottom:6px}

/* ═══ PROCESS ═══ */
#process{padding:120px 5vw;text-align:center;background:var(--dark)}
.psteps{display:grid;grid-template-columns:repeat(4,1fr);gap:3px;margin-top:64px}
.pst{
  padding:44px 28px;background:var(--deep);
  transition:all .5s cubic-bezier(.23,1,.32,1);cursor:none;position:relative;overflow:hidden;
  opacity:0;transform:translateY(36px);transition:opacity .7s ease,transform .7s ease;
}
.pst.vis{opacity:1;transform:translateY(0)}
.pst:nth-child(2).vis{transition-delay:.12s}
.pst:nth-child(3).vis{transition-delay:.24s}
.pst:nth-child(4).vis{transition-delay:.36s}
.pst::before{content:'';position:absolute;top:0;left:0;right:0;height:2px;background:linear-gradient(90deg,transparent,var(--gold),transparent);transform:scaleX(0);transition:transform .5s}
.pst:hover::before{transform:scaleX(1)}
.pst:hover{background:#0f2210;transform:translateY(-8px) !important}
.pstn{width:54px;height:54px;border-radius:50%;border:1px solid rgba(212,168,75,.3);display:flex;align-items:center;justify-content:center;margin:0 auto 22px;font-family:var(--serif);font-size:20px;color:var(--gold);transition:all .4s}
.pst:hover .pstn{background:var(--gold);color:var(--dark);border-color:var(--gold)}
.pstt{font-family:var(--serif);font-size:21px;font-weight:700;color:var(--white);margin-bottom:12px}
.pstd{font-family:var(--sans);font-size:14px;font-weight:300;color:rgba(248,242,228,.48);line-height:1.85}

/* ═══ CTA ═══ */
#cta{position:relative;height:70vh;overflow:hidden;display:flex;align-items:center;justify-content:center}
.ctabg{
  position:absolute;inset:-12%;
  background:url('https://images.pexels.com/photos/1084540/pexels-photo-1084540.jpeg?auto=compress&cs=tinysrgb&w=1920') center/cover;
  animation:cfl 14s ease-in-out infinite alternate;
}
@keyframes cfl{from{transform:scale(1.12) translateY(0)}to{transform:scale(1.12) translateY(-4%)}}
.ctaov{position:absolute;inset:0;background:linear-gradient(135deg,rgba(8,15,8,.84),rgba(8,15,8,.52))}
.ctact{position:relative;z-index:2;text-align:center;max-width:700px;padding:0 5vw}
.ctatt{font-family:var(--serif);font-size:clamp(40px,6vw,80px);font-weight:900;color:var(--white);line-height:1;margin-bottom:22px}
.ctatt em{font-style:italic;color:var(--gold)}
.ctasb{font-family:var(--sans);font-size:16px;font-weight:300;color:rgba(248,242,228,.62);line-height:1.85;margin-bottom:38px}

/* FOOTER */
footer{background:var(--dark);border-top:1px solid rgba(212,168,75,.1);padding:64px 5vw 28px}
.fg{display:grid;grid-template-columns:2fr 1fr 1fr 1fr;gap:56px;margin-bottom:48px}
.fb{font-family:var(--serif);font-size:28px;font-weight:900;letter-spacing:4px;color:var(--gold);margin-bottom:14px}
.ft{font-family:var(--sans);font-size:14px;font-weight:300;color:rgba(248,242,228,.42);line-height:1.8;max-width:240px}
.fct{font-family:var(--sans);font-size:9px;letter-spacing:4px;text-transform:uppercase;color:var(--gold);margin-bottom:18px}
.fls{list-style:none;display:flex;flex-direction:column;gap:10px}
.fls a{font-family:var(--sans);font-size:14px;font-weight:300;color:rgba(248,242,228,.46);text-decoration:none;transition:color .3s;cursor:none}
.fls a:hover{color:var(--cream)}
.fbot{border-top:1px solid rgba(212,168,75,.08);padding-top:22px;display:flex;justify-content:space-between;align-items:center}
.fcp{font-family:var(--sans);font-size:10px;letter-spacing:2px;color:rgba(248,242,228,.22);text-transform:uppercase}
.fso{display:flex;gap:22px}
.fso a{font-family:var(--sans);font-size:10px;letter-spacing:2px;text-transform:uppercase;color:rgba(248,242,228,.32);text-decoration:none;transition:color .3s;cursor:none}
.fso a:hover{color:var(--gold)}

/* LEAVES */
.leaf{position:fixed;pointer-events:none;z-index:50;opacity:0;font-size:18px;animation:lfall linear forwards}
@keyframes lfall{0%{opacity:0;transform:translateY(-20px) rotate(0deg)}10%{opacity:.7}90%{opacity:.2}100%{opacity:0;transform:translateY(100vh) rotate(560deg) translateX(90px)}}

@media(max-width:960px){
  .nm,.nb{display:none}
  #about,#field{grid-template-columns:1fr;gap:40px}
  .sbar{grid-template-columns:repeat(2,1fr)}
  .pm{grid-template-columns:1fr 1fr;grid-template-rows:auto}
  .pm .pi{grid-column:span 1!important;grid-row:auto!important;height:220px}
  .psteps{grid-template-columns:1fr 1fr}
  .fg{grid-template-columns:1fr 1fr}
  #gallery{height:260px}
}
</style>
</head>
<body>

<div id="cur"></div>
<div id="cur2"></div>

<!-- LOADER -->
<div id="loader">
  <div class="l-logo">TERRA</div>
  <div class="l-sub">Regenerative Farm · Kerala</div>
  <div class="l-bar"><div class="l-fill" id="lf"></div></div>
</div>

<!-- NAV -->
<nav id="nav">
  <a class="nl" href="#">TERRA</a>
  <ul class="nm">
    <li><a href="#about">Farm</a></li>
    <li><a href="#harvest">Crops</a></li>
    <li><a href="#products">Produce</a></li>
    <li><a href="#field">Animals</a></li>
    <li><a href="#process">Process</a></li>
  </ul>
  <a class="nb" href="#cta">Visit Us</a>
</nav>

<!-- HERO — real pexels farm field photo -->
<section id="hero">
  <div class="hbg" id="hbg"></div>
  <div class="hov"></div>
  <div class="hgrain"></div>
  <div class="hc">
    <div class="he">Est. 1987 · Kerala, India</div>
    <h1 class="ht">Where Soil<br><em>Speaks</em></h1>
    <p class="hp">Three generations of regenerative farming — 240 acres of living land, cultivated with wisdom and deep reverence for nature.</p>
    <div class="hb">
      <a href="#about" class="bg">Explore the Farm</a>
      <a href="#harvest" class="bw">Our Harvest</a>
    </div>
  </div>
  <div class="hscr"><div class="hsl"></div><div class="hst">Scroll</div></div>
</section>

<!-- TICKER -->
<div class="ticker">
  <div class="ttrack">
    <span class="ti">Organic Certified<span class="td"> ✦ </span></span>
    <span class="ti">Regenerative Farming<span class="td"> ✦ </span></span>
    <span class="ti">Heirloom Seeds<span class="td"> ✦ </span></span>
    <span class="ti">Free Range Livestock<span class="td"> ✦ </span></span>
    <span class="ti">Cold Pressed Oils<span class="td"> ✦ </span></span>
    <span class="ti">Zero Chemicals<span class="td"> ✦ </span></span>
    <span class="ti">Farm to Table<span class="td"> ✦ </span></span>
    <span class="ti">Seasonal Harvest<span class="td"> ✦ </span></span>
    <span class="ti">Organic Certified<span class="td"> ✦ </span></span>
    <span class="ti">Regenerative Farming<span class="td"> ✦ </span></span>
    <span class="ti">Heirloom Seeds<span class="td"> ✦ </span></span>
    <span class="ti">Free Range Livestock<span class="td"> ✦ </span></span>
    <span class="ti">Cold Pressed Oils<span class="td"> ✦ </span></span>
    <span class="ti">Zero Chemicals<span class="td"> ✦ </span></span>
    <span class="ti">Farm to Table<span class="td"> ✦ </span></span>
    <span class="ti">Seasonal Harvest<span class="td"> ✦ </span></span>
  </div>
</div>

<!-- STATS -->
<div class="sbar">
  <div class="sb"><div class="sbn">240</div><div class="sbl">Acres of Land</div></div>
  <div class="sb"><div class="sbn">60+</div><div class="sbl">Crop Varieties</div></div>
  <div class="sb"><div class="sbn">37</div><div class="sbl">Years Growing</div></div>
  <div class="sb"><div class="sbn">100%</div><div class="sbl">Chemical Free</div></div>
</div>

<!-- ABOUT -->
<section id="about">
  <div class="av" id="avBox">
    <div class="ai1" id="ai1">
      <!-- Real pexels farm landscape -->
      <img src="https://images.pexels.com/photos/1500626/pexels-photo-1500626.jpeg?auto=compress&cs=tinysrgb&w=800" alt="Farm landscape"/>
    </div>
    <div class="ai2" id="ai2">
      <!-- Real pexels farming hands -->
      <img src="https://images.pexels.com/photos/2132250/pexels-photo-2132250.jpeg?auto=compress&cs=tinysrgb&w=600" alt="Farmer at work"/>
    </div>
    <div class="atag">Since 1987</div>
  </div>
  <div class="atx" id="atx">
    <div class="ey">Our Story</div>
    <h2 class="st">Land tended with<br><em>love &amp; intention</em></h2>
    <p class="sbo">Three generations of farming wisdom bound to 240 acres of Kerala's richest red soil. We grow not just crops — but entire ecosystems. Every seed planted is a promise to the earth.</p>
    <p class="sbo">Our methods blend ancient Vedic agriculture with modern agroecology — zero synthetic input, maximum biodiversity, deep reverence for the rhythms of nature.</p>
    <a href="#harvest" class="bg" style="margin-top:24px">Discover our Crops</a>
  </div>
</section>

<!-- HARVEST CARDS -->
<section id="harvest">
  <div class="sh">
    <div class="ey" style="justify-content:center">What We Grow</div>
    <h2 class="st">From field to <em>your table</em></h2>
  </div>
  <div class="cs" id="cs">
    <div class="hc">
      <div class="hci">
        <img src="https://images.pexels.com/photos/247599/pexels-photo-247599.jpeg?auto=compress&cs=tinysrgb&w=800" alt="Rice Fields" loading="lazy"/>
        <div class="hcgl"></div><div class="hcglow"></div>
        <div class="hcct">
          <div class="hctag">Kharif Season</div>
          <div class="hctt">Heirloom Rice</div>
          <div class="hcds">Ancient Pokkali and Njavara varieties — flooded paddies, hand-harvested at dawn.</div>
          <div class="hcar">Discover more →</div>
        </div>
      </div>
    </div>
    <div class="hc">
      <div class="hci">
        <img src="https://images.pexels.com/photos/1640774/pexels-photo-1640774.jpeg?auto=compress&cs=tinysrgb&w=800" alt="Vegetables" loading="lazy"/>
        <div class="hcgl"></div><div class="hcglow"></div>
        <div class="hcct">
          <div class="hctag">Rabi Season</div>
          <div class="hctt">Root Vegetables</div>
          <div class="hcds">Winter carrots, beets and yams nourished by composted cattle manure.</div>
          <div class="hcar">Discover more →</div>
        </div>
      </div>
    </div>
    <div class="hc">
      <div class="hci">
        <img src="https://images.pexels.com/photos/2284170/pexels-photo-2284170.jpeg?auto=compress&cs=tinysrgb&w=800" alt="Spices" loading="lazy"/>
        <div class="hcgl"></div><div class="hcglow"></div>
        <div class="hcct">
          <div class="hctag">Year Round</div>
          <div class="hctt">Spice Garden</div>
          <div class="hcds">Black pepper, cardamom, turmeric grown under century-old mango trees.</div>
          <div class="hcar">Discover more →</div>
        </div>
      </div>
    </div>
    <div class="hc">
      <div class="hci">
        <img src="https://images.pexels.com/photos/1268101/pexels-photo-1268101.jpeg?auto=compress&cs=tinysrgb&w=800" alt="Coconut" loading="lazy"/>
        <div class="hcgl"></div><div class="hcglow"></div>
        <div class="hcct">
          <div class="hctag">Perennial</div>
          <div class="hctt">Coconut Groves</div>
          <div class="hcds">200 tall palms yielding virgin oil, coir, and shell charcoal year-round.</div>
          <div class="hcar">Discover more →</div>
        </div>
      </div>
    </div>
    <div class="hc">
      <div class="hci">
        <img src="https://images.pexels.com/photos/1458694/pexels-photo-1458694.jpeg?auto=compress&cs=tinysrgb&w=800" alt="Herbs" loading="lazy"/>
        <div class="hcgl"></div><div class="hcglow"></div>
        <div class="hcct">
          <div class="hctag">Medicinal</div>
          <div class="hctt">Herb Garden</div>
          <div class="hcds">Tulsi, ashwagandha, moringa — a living Ayurvedic apothecary in open air.</div>
          <div class="hcar">Discover more →</div>
        </div>
      </div>
    </div>
  </div>
</section>

<!-- PARALLAX QUOTE -->
<section id="pq">
  <div class="pqbg" id="pqbg"></div>
  <div class="pqov"></div>
  <div class="pqct">
    <div class="pqq">"The soil is the great connector of lives, the source and destination of <span>all</span>."</div>
    <div class="pqa">— Wendell Berry</div>
  </div>
</section>

<!-- PRODUCTS -->
<section id="products">
  <div class="ey">Fresh Harvest</div>
  <h2 class="st">Pure produce, <em>zero compromise</em></h2>
  <div class="pm">
    <div class="pi">
      <img src="https://images.pexels.com/photos/1656663/pexels-photo-1656663.jpeg?auto=compress&cs=tinysrgb&w=900" alt="Heritage Grains" loading="lazy"/>
      <div class="piov"></div>
      <div class="piif"><div class="pinm">Heritage Grains</div><div class="pitp">Staple Crops</div></div>
    </div>
    <div class="pi">
      <img src="https://images.pexels.com/photos/1435735/pexels-photo-1435735.jpeg?auto=compress&cs=tinysrgb&w=600" alt="Coconut Oil" loading="lazy"/>
      <div class="piov"></div>
      <div class="piif"><div class="pinm">Virgin Coconut Oil</div><div class="pitp">Cold Pressed</div></div>
    </div>
    <div class="pi">
      <img src="https://images.pexels.com/photos/533360/pexels-photo-533360.jpeg?auto=compress&cs=tinysrgb&w=600" alt="Raw Honey" loading="lazy"/>
      <div class="piov"></div>
      <div class="piif"><div class="pinm">Raw Forest Honey</div><div class="pitp">Apiary</div></div>
    </div>
    <div class="pi">
      <img src="https://images.pexels.com/photos/1028599/pexels-photo-1028599.jpeg?auto=compress&cs=tinysrgb&w=600" alt="Seasonal Greens" loading="lazy"/>
      <div class="piov"></div>
      <div class="piif"><div class="pinm">Seasonal Greens</div><div class="pitp">Weekly Basket</div></div>
    </div>
    <div class="pi">
      <img src="https://images.pexels.com/photos/1327838/pexels-photo-1327838.jpeg?auto=compress&cs=tinysrgb&w=600" alt="Dried Spices" loading="lazy"/>
      <div class="piov"></div>
      <div class="piif"><div class="pinm">Dried Spices</div><div class="pitp">Spice Garden</div></div>
    </div>
  </div>
</section>

<!-- ANIMALS -->
<section id="field">
  <div class="fv" id="fv">
    <img class="fvimg" src="https://images.pexels.com/photos/735968/pexels-photo-735968.jpeg?auto=compress&cs=tinysrgb&w=800" alt="Farm Animals" loading="lazy"/>
    <div class="fvbdg">
      <div class="fvbn">4</div>
      <div class="fvbl">Species<br>Free Range</div>
    </div>
  </div>
  <div class="ftx" id="ftx">
    <div class="ey">Livestock</div>
    <h2 class="st">Animals at <em>liberty</em></h2>
    <p class="sbo">Our animals roam freely on open pastures — contributing to the farm's ecosystem through natural grazing, composting, and soil aeration.</p>
    <div class="al">
      <div class="ai"><span class="aic">🐄</span><div><div class="ain">Vechur Cattle</div><div class="ais">Indigenous dairy breed</div></div><span class="aicn">12 heads</span></div>
      <div class="ai"><span class="aic">🐐</span><div><div class="ain">Malabari Goat</div><div class="ais">Hardy hill breed</div></div><span class="aicn">28 heads</span></div>
      <div class="ai"><span class="aic">🐓</span><div><div class="ain">Kadaknath Fowl</div><div class="ais">Free range poultry</div></div><span class="aicn">120 birds</span></div>
      <div class="ai"><span class="aic">🐝</span><div><div class="ain">Apis Cerana Bees</div><div class="ais">Native honeybee</div></div><span class="aicn">18 hives</span></div>
    </div>
  </div>
</section>

<!-- GALLERY -->
<div id="gallery">
  <div class="gi">
    <img src="https://images.pexels.com/photos/440731/pexels-photo-440731.jpeg?auto=compress&cs=tinysrgb&w=800" alt="Dawn Fields" loading="lazy"/>
    <div class="glab">Dawn Fields</div>
  </div>
  <div class="gi">
    <img src="https://images.pexels.com/photos/974314/pexels-photo-974314.jpeg?auto=compress&cs=tinysrgb&w=800" alt="The Harvest" loading="lazy"/>
    <div class="glab">The Harvest</div>
  </div>
  <div class="gi">
    <img src="https://images.pexels.com/photos/1084540/pexels-photo-1084540.jpeg?auto=compress&cs=tinysrgb&w=800" alt="Open Pasture" loading="lazy"/>
    <div class="glab">Open Pasture</div>
  </div>
  <div class="gi">
    <img src="https://images.pexels.com/photos/235725/pexels-photo-235725.jpeg?auto=compress&cs=tinysrgb&w=800" alt="Golden Hour" loading="lazy"/>
    <div class="glab">Golden Hour</div>
  </div>
  <div class="gi">
    <img src="https://images.pexels.com/photos/2132250/pexels-photo-2132250.jpeg?auto=compress&cs=tinysrgb&w=800" alt="Farm Creek" loading="lazy"/>
    <div class="glab">Farm Life</div>
  </div>
</div>

<!-- PROCESS -->
<section id="process">
  <div class="ey" style="justify-content:center">How We Work</div>
  <h2 class="st" style="text-align:center">From <em>soil to soul</em></h2>
  <div class="psteps" id="psteps">
    <div class="pst" id="ps1"><div class="pstn">01</div><div class="pstt">Prepare the Soil</div><div class="pstd">Three months of biodynamic composting, cow dung treatment, and natural aeration before the first seed.</div></div>
    <div class="pst" id="ps2"><div class="pstn">02</div><div class="pstt">Sow with Care</div><div class="pstd">Seeds selected by lunar calendar, soaked in panchagavya, and planted by hand at sunrise.</div></div>
    <div class="pst" id="ps3"><div class="pstn">03</div><div class="pstt">Tend &amp; Observe</div><div class="pstd">No pesticides — companion planting, trap crops, and daily observation by experienced farmers.</div></div>
    <div class="pst" id="ps4"><div class="pstn">04</div><div class="pstt">Harvest &amp; Deliver</div><div class="pstd">Hand-picked at peak ripeness, cleaned in spring water, delivered within 12 hours.</div></div>
  </div>
</section>

<!-- CTA -->
<section id="cta">
  <div class="ctabg"></div>
  <div class="ctaov"></div>
  <div class="ctact">
    <h2 class="ctatt">Come walk<br>our <em>fields</em></h2>
    <p class="ctasb">Open farm visits every Saturday and Sunday. Bring your family and experience the true taste of the land.</p>
    <div style="display:flex;gap:14px;justify-content:center;flex-wrap:wrap">
      <a href="#" class="bg">Book a Farm Visit</a>
      <a href="#" class="bw">Subscribe to CSA Box</a>
    </div>
  </div>
</section>

<!-- FOOTER -->
<footer>
  <div class="fg">
    <div>
      <div class="fb">TERRA</div>
      <div class="ft">Regenerative farming from the heart of Kerala. Three generations of love for the land.</div>
    </div>
    <div>
      <div class="fct">Farm</div>
      <ul class="fls"><li><a href="#">Our Story</a></li><li><a href="#">The Fields</a></li><li><a href="#">Animals</a></li><li><a href="#">Certifications</a></li></ul>
    </div>
    <div>
      <div class="fct">Harvest</div>
      <ul class="fls"><li><a href="#">CSA Boxes</a></li><li><a href="#">Spice Shop</a></li><li><a href="#">Oils &amp; Ghee</a></li><li><a href="#">Seasonal Calendar</a></li></ul>
    </div>
    <div>
      <div class="fct">Visit</div>
      <ul class="fls"><li><a href="#">Farm Tours</a></li><li><a href="#">Workshops</a></li><li><a href="#">Stay with Us</a></li><li><a href="#">Contact</a></li></ul>
    </div>
  </div>
  <div class="fbot">
    <div class="fcp">© 2025 TERRA Farm · All Rights Reserved</div>
    <div class="fso"><a href="#">Instagram</a><a href="#">Facebook</a><a href="#">WhatsApp</a></div>
  </div>
</footer>

<script>
/* LOADER */
const lf=document.getElementById('lf'),loader=document.getElementById('loader');
let p=0;
const li=setInterval(()=>{
  p+=Math.random()*9+4;
  if(p>=100){p=100;clearInterval(li);
    setTimeout(()=>{loader.classList.add('out');document.getElementById('hbg').classList.add('go')},400);
  }
  lf.style.width=p+'%';
},70);

/* CURSOR */
const c=document.getElementById('cur'),c2=document.getElementById('cur2');
let mx=0,my=0,rx=0,ry=0;
document.addEventListener('mousemove',e=>{mx=e.clientX;my=e.clientY;c.style.left=mx+'px';c.style.top=my+'px'});
(function lp(){rx+=(mx-rx)*.1;ry+=(my-ry)*.1;c2.style.left=rx+'px';c2.style.top=ry+'px';requestAnimationFrame(lp)})();
document.querySelectorAll('a,button,.hc,.pi,.gi,.ai,.sb,.pst').forEach(el=>{
  el.addEventListener('mouseenter',()=>{c.style.width='22px';c.style.height='22px';c2.style.width='66px';c2.style.height='66px'});
  el.addEventListener('mouseleave',()=>{c.style.width='14px';c.style.height='14px';c2.style.width='44px';c2.style.height='44px'});
});

/* NAV */
window.addEventListener('scroll',()=>document.getElementById('nav').classList.toggle('s',scrollY>50));

/* PARALLAX */
const pqbg=document.getElementById('pqbg');
window.addEventListener('scroll',()=>{
  const r=pqbg.parentElement.getBoundingClientRect();
  if(r.top<innerHeight&&r.bottom>0) pqbg.style.transform=`translateY(${r.top*0.3}px)`;
});

/* INTERSECTION */
const io=new IntersectionObserver(en=>{en.forEach(e=>{if(e.isIntersecting)e.target.classList.add('vis')})},{threshold:.1});
['ai1','ai2','atx','fv','ftx','ps1','ps2','ps3','ps4'].forEach(id=>{const el=document.getElementById(id);if(el)io.observe(el)});

/* DRAGGABLE SCROLL */
const cs=document.getElementById('cs');
let dn=false,sx,sl;
cs.addEventListener('mousedown',e=>{dn=true;sx=e.pageX-cs.offsetLeft;sl=cs.scrollLeft});
['mouseleave','mouseup'].forEach(ev=>cs.addEventListener(ev,()=>dn=false));
cs.addEventListener('mousemove',e=>{if(!dn)return;e.preventDefault();cs.scrollLeft=sl-(e.pageX-cs.offsetLeft-sx)*1.8});

/* 3D MOUSE TILT on CARDS */
document.querySelectorAll('.hc').forEach(card=>{
  card.addEventListener('mousemove',e=>{
    const r=card.getBoundingClientRect();
    const x=(e.clientX-r.left)/r.width-.5;
    const y=(e.clientY-r.top)/r.height-.5;
    card.querySelector('.hci').style.transform=`rotateX(${y*-16}deg) rotateY(${x*16}deg) scale(1.03)`;
    card.querySelector('.hci').style.boxShadow=`${-x*30}px ${-y*30}px 80px rgba(0,0,0,.7)`;
  });
  card.addEventListener('mouseleave',()=>{
    card.querySelector('.hci').style.transform='';
    card.querySelector('.hci').style.boxShadow='';
  });
});

/* 3D MOUSE TILT on STAT BLOCKS */
document.querySelectorAll('.sb').forEach(el=>{
  el.addEventListener('mousemove',e=>{
    const r=el.getBoundingClientRect();
    const x=(e.clientX-r.left)/r.width-.5;
    const y=(e.clientY-r.top)/r.height-.5;
    el.style.transform=`translateY(-5px) rotateX(${y*-12}deg) rotateY(${x*12}deg)`;
  });
  el.addEventListener('mouseleave',()=>el.style.transform='');
});

/* FLOATING LEAVES */
function leaf(){
  const l=document.createElement('div');
  l.className='leaf';
  l.textContent=['🍃','🌿','🍀','🌱','🪴'][Math.floor(Math.random()*5)];
  l.style.cssText=`left:${Math.random()*94}vw;top:-30px;animation-duration:${6+Math.random()*5}s`;
  document.body.appendChild(l);
  setTimeout(()=>l.remove(),12000);
}
setInterval(leaf,5000);setTimeout(leaf,1500);

/* SMOOTH SCROLL */
document.querySelectorAll('a[href^="#"]').forEach(a=>{
  a.addEventListener('click',e=>{
    const t=document.querySelector(a.getAttribute('href'));
    if(t){e.preventDefault();t.scrollIntoView({behavior:'smooth'})}
  });
});
</script>
</body>
</html>
