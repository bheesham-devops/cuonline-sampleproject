<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>GitOps-Based Cloud Application Deployment</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
  <style>
    *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
    html { scroll-behavior: smooth; }
    body { font-family: "Inter", sans-serif; background: #f8fafc; color: #1e293b; -webkit-font-smoothing: antialiased; }

    /* Top Bar */
    .topbar { background: #7b0d0d; padding: 9px 40px; display: flex; align-items: center; justify-content: space-between; flex-wrap: wrap; gap: 8px; }
    .topbar-left { display: flex; align-items: center; gap: 12px; }
    .cu-logo-box { background: #fff; border-radius: 7px; padding: 4px 10px; display: flex; align-items: center; min-width: 44px; min-height: 44px; justify-content: center; }
    .cu-logo-box img { height: 34px; width: auto; display: block; }
    .cu-name { font-size: .9rem; font-weight: 700; color: #fff; }
    .cu-dept { font-size: .7rem; color: rgba(255,255,255,.75); margin-top: 1px; }
    .topbar-right { display: flex; align-items: center; gap: 8px; }
    .t-pill { font-size: .68rem; font-weight: 600; color: rgba(255,255,255,.9); background: rgba(255,255,255,.12); border: 1px solid rgba(255,255,255,.22); border-radius: 999px; padding: 4px 11px; }
    .live-dot { display: flex; align-items: center; gap: 5px; font-size: .68rem; font-weight: 600; color: #86efac; }
    .live-dot::before { content: ""; width: 7px; height: 7px; border-radius: 50%; background: #86efac; box-shadow: 0 0 7px #86efac; animation: blink 1.5s ease-in-out infinite; }
    @keyframes blink { 0%,100%{opacity:1} 50%{opacity:.2} }

    /* Navbar */
    .navbar { position: sticky; top: 0; z-index: 100; background: rgba(255,255,255,.96); backdrop-filter: blur(14px); border-bottom: 1px solid #e2e8f0; padding: 0 40px; height: 56px; display: flex; align-items: center; justify-content: space-between; box-shadow: 0 1px 4px rgba(0,0,0,.05); }
    .nav-brand { display: flex; align-items: center; gap: 8px; font-family: "Plus Jakarta Sans", sans-serif; font-size: .92rem; font-weight: 800; color: #7b0d0d; text-decoration: none; }
    .nav-links { display: flex; gap: 2px; align-items: center; }
    .nav-links a { font-size: .8rem; font-weight: 500; color: #475569; text-decoration: none; padding: 6px 13px; border-radius: 7px; transition: background .14s, color .14s; }
    .nav-links a:hover { background: #fef2f2; color: #7b0d0d; }
    .nav-cta { background: #7b0d0d !important; color: #fff !important; border-radius: 8px !important; padding: 7px 16px !important; }
    .nav-cta:hover { background: #5f0a0a !important; }

    /* Hero */
    .hero { background: linear-gradient(150deg,#fff8f8 0%,#fef2f2 35%,#fffbf0 70%,#f8fafc 100%); border-bottom: 1px solid #e2e8f0; padding: 68px 40px 60px; position: relative; overflow: hidden; }
    .hero::before { content: ""; position: absolute; top: -80px; right: -100px; width: 480px; height: 480px; border-radius: 50%; background: radial-gradient(circle,rgba(123,13,13,.07) 0%,transparent 70%); pointer-events: none; }
    .hero-grid { max-width: 1140px; margin: 0 auto; display: grid; grid-template-columns: 1fr 390px; gap: 56px; align-items: center; position: relative; z-index: 1; }
    .hero-eyebrow { display: inline-flex; align-items: center; gap: 6px; font-size: .68rem; font-weight: 700; letter-spacing: 1px; text-transform: uppercase; color: #7b0d0d; background: #fef2f2; border: 1px solid #fca5a5; border-radius: 999px; padding: 5px 13px; margin-bottom: 18px; }
    .hero-eyebrow span { width: 6px; height: 6px; border-radius: 50%; background: #7b0d0d; display: inline-block; }
    h1 { font-family: "Plus Jakarta Sans", sans-serif; font-size: clamp(1.9rem,3.6vw,2.85rem); font-weight: 900; line-height: 1.1; letter-spacing: -1.3px; color: #0f172a; margin-bottom: 18px; }
    h1 em { font-style: normal; background: linear-gradient(135deg,#7b0d0d 0%,#dc2626 100%); -webkit-background-clip: text; background-clip: text; -webkit-text-fill-color: transparent; }
    .hero-desc { font-size: .97rem; color: #64748b; line-height: 1.75; max-width: 490px; margin-bottom: 30px; }
    .hero-btns { display: flex; gap: 11px; flex-wrap: wrap; }
    .btn { display: inline-flex; align-items: center; gap: 7px; font-size: .85rem; font-weight: 600; border-radius: 9px; padding: 11px 22px; text-decoration: none; transition: all .17s; border: none; cursor: pointer; }
    .btn-red { background: #7b0d0d; color: #fff; box-shadow: 0 4px 14px rgba(123,13,13,.28); }
    .btn-red:hover { background: #5f0a0a; transform: translateY(-1px); }
    .btn-out { background: #fff; color: #1e293b; border: 1.5px solid #e2e8f0; }
    .btn-out:hover { border-color: #fca5a5; color: #7b0d0d; transform: translateY(-1px); }

    /* Side card */
    .side-card { background: #fff; border: 1px solid #e2e8f0; border-radius: 18px; padding: 24px; box-shadow: 0 10px 36px rgba(0,0,0,.09); }
    .sc-lbl { font-size: .67rem; font-weight: 700; letter-spacing: .9px; text-transform: uppercase; color: #94a3b8; margin-bottom: 16px; }
    .prog { margin-bottom: 14px; }
    .prog-row { display: flex; justify-content: space-between; margin-bottom: 5px; }
    .prog-name { font-size: .8rem; font-weight: 600; color: #334155; }
    .prog-pct  { font-size: .77rem; font-weight: 700; }
    .prog-bg   { height: 6px; background: #f1f5f9; border-radius: 999px; overflow: hidden; }
    .prog-fill { height: 100%; border-radius: 999px; }
    .c-red{color:#7b0d0d}.c-ora{color:#ea580c}.c-grn{color:#059669}.c-amb{color:#d97706}
    .f-red{background:linear-gradient(90deg,#7b0d0d,#ef4444);width:100%}
    .f-ora{background:linear-gradient(90deg,#ea580c,#fb923c);width:100%}
    .f-grn{background:linear-gradient(90deg,#059669,#34d399);width:100%}
    .f-amb{background:linear-gradient(90deg,#d97706,#fbbf24);width:100%}
    .sc-rule { height: 1px; background: #f1f5f9; margin: 16px 0; }
    .sc-counts { display: grid; grid-template-columns: repeat(3,1fr); gap: 8px; }
    .scc { background: #f8fafc; border-radius: 10px; padding: 12px 4px; text-align: center; }
    .scc-v { font-size: 1.25rem; font-weight: 800; color: #1e293b; }
    .scc-l { font-size: .66rem; color: #94a3b8; margin-top: 2px; }

    /* Page */
    .page { max-width: 1140px; margin: 0 auto; padding: 0 40px 80px; }

    /* Section heading */
    .sh { margin: 54px 0 22px; }
    .stag { display: inline-block; font-size: .65rem; font-weight: 700; letter-spacing: 1.1px; text-transform: uppercase; border-radius: 999px; padding: 4px 12px; margin-bottom: 10px; }
    .stag.red   { color:#7b0d0d; background:#fef2f2; border:1px solid #fca5a5; }
    .stag.green { color:#059669; background:#ecfdf5; border:1px solid #a7f3d0; }
    .stag.dark  { color:#334155; background:#f1f5f9; border:1px solid #e2e8f0; }
    .sh h2 { font-family: "Plus Jakarta Sans", sans-serif; font-size: 1.5rem; font-weight: 800; color: #0f172a; letter-spacing: -.4px; margin-bottom: 5px; }
    .sh p  { font-size: .86rem; color: #64748b; max-width: 520px; }

    /* Stat strip */
    .stat-strip { display: grid; grid-template-columns: repeat(auto-fit,minmax(155px,1fr)); gap: 12px; margin-top: 38px; }
    .stat-card { background: #fff; border: 1px solid #e2e8f0; border-radius: 14px; padding: 20px 16px; box-shadow: 0 1px 3px rgba(0,0,0,.05); transition: transform .17s, box-shadow .17s; }
    .stat-card:hover { transform: translateY(-3px); box-shadow: 0 8px 22px rgba(0,0,0,.09); }
    .stat-ico { font-size: 1.35rem; margin-bottom: 10px; }
    .stat-val { font-size: 1.5rem; font-weight: 800; color: #1e293b; line-height: 1; }
    .stat-lbl { font-size: .73rem; font-weight: 600; color: #64748b; margin-top: 4px; }

    /* Objectives */
    .obj-grid { display: grid; grid-template-columns: repeat(auto-fit,minmax(260px,1fr)); gap: 13px; }
    .obj-card { background: #fff; border: 1px solid #e2e8f0; border-radius: 13px; padding: 22px; box-shadow: 0 1px 3px rgba(0,0,0,.05); position: relative; overflow: hidden; transition: transform .17s, box-shadow .17s; }
    .obj-card::before { content: ""; position: absolute; top: 0; left: 0; right: 0; height: 3px; background: linear-gradient(90deg,#7b0d0d,#dc2626); opacity: 0; transition: opacity .18s; }
    .obj-card:hover { transform: translateY(-3px); box-shadow: 0 8px 22px rgba(0,0,0,.09); }
    .obj-card:hover::before { opacity: 1; }
    .obj-ico { font-size: 1.5rem; margin-bottom: 13px; }
    .obj-card h3 { font-size: .9rem; font-weight: 700; color: #1e293b; margin-bottom: 7px; }
    .obj-card p  { font-size: .8rem; color: #64748b; line-height: 1.65; }

    /* Milestone tracker */
    .overall-banner { background: linear-gradient(135deg,#7b0d0d 0%,#b91c1c 100%); border-radius: 14px; padding: 24px 28px; margin-bottom: 18px; display: flex; align-items: center; justify-content: space-between; flex-wrap: wrap; gap: 20px; }
    .ob-left h3 { font-size: .92rem; font-weight: 700; color: #fff; margin-bottom: 3px; }
    .ob-left p  { font-size: .78rem; color: rgba(255,255,255,.7); }
    .ob-nums { display: flex; gap: 22px; flex-wrap: wrap; }
    .obn { text-align: center; }
    .obn-v { font-size: 1.5rem; font-weight: 800; color: #fff; }
    .obn-l { font-size: .67rem; color: rgba(255,255,255,.7); margin-top: 1px; }
    .ob-ring { position: relative; width: 78px; height: 78px; }
    .ob-ring svg { transform: rotate(-90deg); }
    .ob-ring-text { position: absolute; inset: 0; display: flex; flex-direction: column; align-items: center; justify-content: center; color: #fff; }
    .ob-ring-text .rp { font-size: .95rem; font-weight: 800; }
    .ob-ring-text .rl { font-size: .56rem; opacity: .7; }

    .ms-list { display: flex; flex-direction: column; gap: 8px; }
    .ms-row { display: flex; align-items: center; gap: 13px; background: #fff; border: 1px solid #e2e8f0; border-radius: 11px; padding: 13px 17px; box-shadow: 0 1px 2px rgba(0,0,0,.04); transition: border-color .16s; }
    .ms-row:hover { border-color: #fca5a5; }
    .ms-num { min-width: 32px; height: 32px; border-radius: 8px; display: flex; align-items: center; justify-content: center; font-size: .72rem; font-weight: 800; flex-shrink: 0; }
    .n-done    { background: #ecfdf5; border: 1.5px solid #a7f3d0; color: #059669; }
    .n-active  { background: #fef2f2; border: 1.5px solid #fca5a5; color: #7b0d0d; }
    .n-pending { background: #f8fafc; border: 1.5px solid #e2e8f0; color: #94a3b8; }
    .ms-body { flex: 1; min-width: 0; }
    .ms-title { font-size: .85rem; font-weight: 600; color: #1e293b; }
    .ms-sub   { font-size: .72rem; color: #94a3b8; margin-top: 2px; }
    .ms-pw { width: 108px; flex-shrink: 0; }
    .ms-pct-lbl { font-size: .68rem; font-weight: 700; color: #94a3b8; text-align: right; margin-bottom: 3px; }
    .ms-bg   { height: 5px; background: #f1f5f9; border-radius: 999px; overflow: hidden; }
    .ms-fill { height: 100%; border-radius: 999px; }
    .badge { font-size: .65rem; font-weight: 700; letter-spacing: .4px; text-transform: uppercase; padding: 3px 9px; border-radius: 999px; white-space: nowrap; flex-shrink: 0; }
    .b-done    { background: #ecfdf5; color: #059669; border: 1px solid #a7f3d0; }
    .b-active  { background: #fef2f2; color: #7b0d0d;  border: 1px solid #fca5a5; }
    .b-pending { background: #fffbeb; color: #d97706; border: 1px solid #fcd34d; }

    /* Pipeline */
    .pipe-wrap { background: #fff; border: 1px solid #e2e8f0; border-radius: 18px; overflow: hidden; box-shadow: 0 4px 16px rgba(0,0,0,.07); }
    .pipe-hdr { background: linear-gradient(135deg,#0f172a 0%,#1e293b 100%); padding: 20px 26px; display: flex; align-items: center; justify-content: space-between; flex-wrap: wrap; gap: 10px; }
    .pipe-hdr h3 { font-size: .92rem; font-weight: 700; color: #fff; margin-bottom: 3px; }
    .pipe-hdr p  { font-size: .73rem; color: #94a3b8; }
    .argo-badge { display: flex; align-items: center; gap: 8px; background: rgba(255,255,255,.07); border: 1px solid rgba(255,255,255,.12); border-radius: 9px; padding: 7px 14px; }
    .argo-badge .ab-name { font-size: .8rem; font-weight: 700; color: #f1f5f9; display: block; }
    .argo-badge .ab-sub  { font-size: .68rem; color: #86efac; }
    .pipe-body { padding: 26px; }
    .pipe-stages { display: grid; grid-template-columns: repeat(8,1fr); position: relative; }
    .pipe-stages::before { content: ""; position: absolute; top: 29px; left: 52px; right: 52px; height: 2px; background: linear-gradient(90deg,#fca5a5,#7b0d0d,#fca5a5); z-index: 0; }
    .ps { display: flex; flex-direction: column; align-items: center; gap: 8px; position: relative; z-index: 1; }
    .ps-ico { width: 58px; height: 58px; border-radius: 13px; background: #fff; border: 2px solid #e2e8f0; display: flex; align-items: center; justify-content: center; font-size: 1.35rem; box-shadow: 0 2px 6px rgba(0,0,0,.06); transition: transform .17s, border-color .17s, box-shadow .17s; }
    .ps:hover .ps-ico { transform: translateY(-4px); border-color: #fca5a5; box-shadow: 0 8px 18px rgba(123,13,13,.15); }
    .ps-ico.done { border-color: #a7f3d0; background: #ecfdf5; }
    .ps-ico.argo { border-color: #ee6c4d; box-shadow: 0 3px 10px rgba(238,108,77,.2); }
    .ps-lbl { font-size: .68rem; font-weight: 600; color: #475569; text-align: center; }
    .ps-sub { font-size: .6rem; color: #94a3b8; text-align: center; margin-top: -4px; }
    .argo-info { display: grid; grid-template-columns: repeat(auto-fit,minmax(200px,1fr)); gap: 11px; margin-top: 22px; }
    .ai-card { border-radius: 11px; padding: 16px; border: 1px solid transparent; }
    .ai-card.r{background:#fef2f2;border-color:#fca5a5} .ai-card.s{background:#f8fafc;border-color:#e2e8f0}
    .ai-card.g{background:#ecfdf5;border-color:#a7f3d0} .ai-card.a{background:#fffbeb;border-color:#fcd34d}
    .ai-card h4 { font-size: .8rem; font-weight: 700; margin-bottom: 5px; }
    .ai-card.r h4{color:#7b0d0d}.ai-card.s h4{color:#334155}.ai-card.g h4{color:#059669}.ai-card.a h4{color:#d97706}
    .ai-card p { font-size: .73rem; color: #64748b; line-height: 1.6; }

    /* Tech Stack */
    .tech-wrap { display: flex; flex-wrap: wrap; gap: 9px; }
    .tech-pill { display: flex; align-items: center; gap: 7px; background: #fff; border: 1.5px solid #e2e8f0; border-radius: 9px; padding: 7px 14px; font-size: .8rem; font-weight: 600; color: #334155; box-shadow: 0 1px 3px rgba(0,0,0,.04); transition: border-color .14s, transform .14s, box-shadow .14s; }
    .tech-pill:hover { border-color: #fca5a5; transform: translateY(-2px); box-shadow: 0 4px 12px rgba(0,0,0,.08); }
    .td { width: 9px; height: 9px; border-radius: 50%; flex-shrink: 0; }

    /* Footer */
    .footer { background: #fff; border-top: 1px solid #e2e8f0; padding: 26px 40px; }
    .footer-in { max-width: 1140px; margin: 0 auto; display: flex; align-items: center; justify-content: space-between; flex-wrap: wrap; gap: 14px; }
    .footer-brand { display: flex; align-items: center; gap: 11px; }
    .footer-brand img { height: 28px; width: auto; }
    .fb-name { font-size: .86rem; font-weight: 700; color: #1e293b; }
    .fb-sub  { font-size: .71rem; color: #94a3b8; margin-top: 1px; }
    .footer-copy { font-size: .73rem; color: #94a3b8; }
    .footer-status { display: flex; align-items: center; gap: 5px; font-size: .7rem; font-weight: 600; color: #059669; background: #ecfdf5; border: 1px solid #a7f3d0; border-radius: 999px; padding: 5px 12px; }

    @media(max-width:860px){.hero-grid{grid-template-columns:1fr}.side-card{display:none}.pipe-stages{grid-template-columns:repeat(4,1fr)}.pipe-stages::before{display:none}}
    @media(max-width:580px){.topbar,.navbar,.hero,.page,.footer{padding-left:16px;padding-right:16px}.pipe-stages{grid-template-columns:repeat(2,1fr)}}
  </style>
</head>
<body>

<!-- CU Top Bar -->
<div class="topbar">
  <div class="topbar-left">
    <div class="cu-logo-box">
      <img src="https://upload.wikimedia.org/wikipedia/en/thumb/2/28/Chandigarh_University_logo.png/200px-Chandigarh_University_logo.png"
           alt="Chandigarh University"
           onerror="this.parentElement.innerHTML='<b style=&quot;color:#7b0d0d;font-size:.9rem&quot;>CU</b>'"/>
    </div>
    <div>
      <div class="cu-name">Chandigarh University &mdash; CU Online</div>
      <div class="cu-dept">School of Distance &amp; Online Education</div>
    </div>
  </div>
  <div class="topbar-right">
    <span class="t-pill">DevOps Engineering</span>
    <span class="t-pill">AY 2025&ndash;26</span>
    <span class="live-dot">Live</span>
  </div>
</div>

<!-- Navbar -->
<nav class="navbar">
  <a class="nav-brand" href="#">
    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.3" stroke-linecap="round" stroke-linejoin="round"><path d="M12 2L2 7l10 5 10-5-10-5zM2 17l10 5 10-5M2 12l10 5 10-5"/></svg>
    GitOps Cloud Deployment
  </a>
  <div class="nav-links">
    <a href="#objectives">Objectives</a>
    <a href="#milestones">Milestones</a>
    <a href="#pipeline">CI/CD</a>
    <a href="#stack">Stack</a>
    <a href="#pipeline" class="nav-cta">ArgoCD</a>
  </div>
</nav>

<!-- Hero -->
<section class="hero">
  <div class="hero-grid">
    <div>
      <div class="hero-eyebrow"><span></span>GitOps &bull; DevOps &bull; Cloud</div>
      <h1><em>GitOps-Based</em><br/>Cloud Application<br/>Deployment</h1>
      <p class="hero-desc">A production-grade DevOps automation system combining Docker containerisation, Kubernetes on GKE, Terraform infrastructure-as-code, ArgoCD-powered GitOps continuous delivery, and full-stack observability with Prometheus &amp; Grafana — all running live on Google Cloud.</p>
      <div class="hero-btns">
        <a href="#milestones" class="btn btn-red">
          <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><path d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/></svg>
          View Milestones
        </a>
        <a href="#pipeline" class="btn btn-out">
          <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><path d="M10 20l4-16m4 4l4 4-4 4M6 16l-4-4 4-4"/></svg>
          ArgoCD Pipeline
        </a>
      </div>
    </div>
    <div class="side-card">
      <div class="sc-lbl">Project Progress Overview</div>
      <div class="prog"><div class="prog-row"><span class="prog-name">&#x1F433; Containerization</span><span class="prog-pct c-red">100%</span></div><div class="prog-bg"><div class="prog-fill f-red"></div></div></div>
      <div class="prog"><div class="prog-row"><span class="prog-name">&#x2638;&#xFE0F; Kubernetes / GKE</span><span class="prog-pct c-ora">100%</span></div><div class="prog-bg"><div class="prog-fill f-ora"></div></div></div>
      <div class="prog"><div class="prog-row"><span class="prog-name">&#x2699;&#xFE0F; Terraform IaC</span><span class="prog-pct c-grn">100%</span></div><div class="prog-bg"><div class="prog-fill f-grn"></div></div></div>
      <div class="prog"><div class="prog-row"><span class="prog-name">&#x1F4CA; Monitoring</span><span class="prog-pct c-amb">100%</span></div><div class="prog-bg"><div class="prog-fill f-amb"></div></div></div>
      <div class="sc-rule"></div>
      <div class="sc-counts">
        <div class="scc"><div class="scc-v" style="color:#059669">8</div><div class="scc-l">Done</div></div>
        <div class="scc"><div class="scc-v" style="color:#7b0d0d">0</div><div class="scc-l">Active</div></div>
        <div class="scc"><div class="scc-v" style="color:#d97706">2</div><div class="scc-l">Pending</div></div>
      </div>
    </div>
  </div>
</section>

<div class="page">

  <!-- Stat strip -->
  <div class="stat-strip">
    <div class="stat-card"><div class="stat-ico">&#x1F433;</div><div class="stat-val" style="color:#2496ed">Docker</div><div class="stat-lbl">Containerized</div></div>
    <div class="stat-card"><div class="stat-ico">&#x2638;&#xFE0F;</div><div class="stat-val" style="color:#4285f4">GKE</div><div class="stat-lbl">Kubernetes Cluster</div></div>
    <div class="stat-card"><div class="stat-ico">&#x1F527;</div><div class="stat-val">8+</div><div class="stat-lbl">Terraform Modules</div></div>
    <div class="stat-card"><div class="stat-ico">&#x1F419;</div><div class="stat-val" style="color:#ee6c4d">ArgoCD</div><div class="stat-lbl">GitOps CI/CD</div></div>
    <div class="stat-card"><div class="stat-ico">&#x1F4CA;</div><div class="stat-val" style="color:#d97706">10</div><div class="stat-lbl">Milestones</div></div>
  </div>

  <!-- Objectives -->
  <div id="objectives" class="sh">
    <div class="stag red">Objectives</div>
    <h2>What We Are Building</h2>
    <p>Core goals driving every design and implementation decision across the project.</p>
  </div>
  <div class="obj-grid">
    <div class="obj-card"><div class="obj-ico">&#x1F3D7;&#xFE0F;</div><h3>DevOps Automation System</h3><p>A unified platform eliminating manual intervention across provisioning, configuration, and deployment workflows on Google Cloud Platform.</p></div>
    <div class="obj-card"><div class="obj-ico">&#x1F4E6;</div><h3>Docker Containerization</h3><p>Portable, reproducible multi-stage Docker images pushed to Google Artifact Registry, minimising image size and attack surface.</p></div>
    <div class="obj-card"><div class="obj-ico">&#x2638;&#xFE0F;</div><h3>Kubernetes on GKE</h3><p>Production GKE cluster with GKE Gateway API (L7 HTTPS), wildcard SSL, HPA auto-scaling, and Workload Identity — all provisioned via Terraform.</p></div>
    <div class="obj-card"><div class="obj-ico">&#x1F6E0;&#xFE0F;</div><h3>Terraform Infrastructure as Code</h3><p>8 Terraform modules managing the full GCP stack — network, GKE, ingress, ArgoCD, monitoring, and CI/CD — with remote GCS state and GitHub Actions pipeline.</p></div>
    <div class="obj-card"><div class="obj-ico">&#x1F419;</div><h3>GitOps with ArgoCD</h3><p>Git as the single source of truth &mdash; ArgoCD continuously reconciles the live GKE cluster to the declared Helm chart state in the GitOps repository.</p></div>
    <div class="obj-card"><div class="obj-ico">&#x1F4CA;</div><h3>Observability &amp; Alerting</h3><p>kube-prometheus-stack with Prometheus, Grafana, and Alertmanager — persistent storage, resource limits, GKE-tuned alert rules, and live dashboards at grafana.nayaratech.online.</p></div>
  </div>

  <!-- Milestones -->
  <div id="milestones" class="sh">
    <div class="stag green">Milestones</div>
    <h2>Project Status Tracker</h2>
    <p>Live snapshot of all 10 project milestones with individual progress indicators.</p>
  </div>
  <div class="overall-banner">
    <div class="ob-left"><h3>Overall Project Completion</h3><p>8 of 10 complete &middot; 0 in progress &middot; 2 pending</p></div>
    <div class="ob-nums">
      <div class="obn"><div class="obn-v">8</div><div class="obn-l">&#x2705; Done</div></div>
      <div class="obn"><div class="obn-v">0</div><div class="obn-l">&#x1F534; Active</div></div>
      <div class="obn"><div class="obn-v">2</div><div class="obn-l">&#x23F3; Pending</div></div>
    </div>
    <div class="ob-ring">
      <!-- circumference = 2*π*30 ≈ 188.5 | 80% done → dashoffset = 188.5 * 0.20 ≈ 38 -->
      <svg width="78" height="78" viewBox="0 0 78 78">
        <circle cx="39" cy="39" r="30" fill="none" stroke="rgba(255,255,255,.2)" stroke-width="7"/>
        <circle cx="39" cy="39" r="30" fill="none" stroke="#fff" stroke-width="7" stroke-dasharray="188" stroke-dashoffset="38" stroke-linecap="round"/>
      </svg>
      <div class="ob-ring-text"><div class="rp">80%</div><div class="rl">DONE</div></div>
    </div>
  </div>
  <div class="ms-list">
    <div class="ms-row"><div class="ms-num n-done">01</div><div class="ms-body"><div class="ms-title">Develop Sample Application</div><div class="ms-sub">Java 21 / Maven webapp &mdash; Greeter service, JUnit tests, WAR packaging, Apache Tomcat 9</div></div><div class="ms-pw"><div class="ms-pct-lbl">100%</div><div class="ms-bg"><div class="ms-fill" style="width:100%;background:#059669"></div></div></div><span class="badge b-done">Complete</span></div>
    <div class="ms-row"><div class="ms-num n-done">02</div><div class="ms-body"><div class="ms-title">Containerize with Docker</div><div class="ms-sub">Multi-stage Dockerfile &mdash; Maven builder + Tomcat 9 runtime, pushed to Google Artifact Registry</div></div><div class="ms-pw"><div class="ms-pct-lbl">100%</div><div class="ms-bg"><div class="ms-fill" style="width:100%;background:#059669"></div></div></div><span class="badge b-done">Complete</span></div>
    <div class="ms-row"><div class="ms-num n-done">03</div><div class="ms-body"><div class="ms-title">Deploy on Kubernetes (GKE)</div><div class="ms-sub">Helm chart with Deployment, Service, HPA, HTTPRoute &mdash; live at app.nayaratech.online on GKE via ArgoCD</div></div><div class="ms-pw"><div class="ms-pct-lbl">100%</div><div class="ms-bg"><div class="ms-fill" style="width:100%;background:#059669"></div></div></div><span class="badge b-done">Complete</span></div>
    <div class="ms-row"><div class="ms-num n-done">04</div><div class="ms-body"><div class="ms-title">Automate Cluster Configuration</div><div class="ms-sub">8 Terraform modules automate full GCP stack &mdash; VPC, GKE, Gateway API, SSL certificates, namespaces</div></div><div class="ms-pw"><div class="ms-pct-lbl">100%</div><div class="ms-bg"><div class="ms-fill" style="width:100%;background:#059669"></div></div></div><span class="badge b-done">Complete</span></div>
    <div class="ms-row"><div class="ms-num n-done">05</div><div class="ms-body"><div class="ms-title">Integrate ArgoCD CI/CD Pipeline</div><div class="ms-sub">ArgoCD installed via Helm on GKE &mdash; App-of-Apps pattern, auto-sync, live at argocd.nayaratech.online</div></div><div class="ms-pw"><div class="ms-pct-lbl">100%</div><div class="ms-bg"><div class="ms-fill" style="width:100%;background:#059669"></div></div></div><span class="badge b-done">Complete</span></div>
    <div class="ms-row"><div class="ms-num n-done">06</div><div class="ms-body"><div class="ms-title">GitHub Actions CI Pipeline</div><div class="ms-sub">App pipeline: Maven build → Docker push → GitOps repo update. Terraform pipeline: fmt → validate → plan → manual-gated apply</div></div><div class="ms-pw"><div class="ms-pct-lbl">100%</div><div class="ms-bg"><div class="ms-fill" style="width:100%;background:#059669"></div></div></div><span class="badge b-done">Complete</span></div>
    <div class="ms-row"><div class="ms-num n-done">07</div><div class="ms-body"><div class="ms-title">System Monitoring Setup</div><div class="ms-sub">kube-prometheus-stack &mdash; Prometheus (20Gi PVC), Grafana, Alertmanager, GKE-tuned alert rules, live at grafana.nayaratech.online</div></div><div class="ms-pw"><div class="ms-pct-lbl">100%</div><div class="ms-bg"><div class="ms-fill" style="width:100%;background:#059669"></div></div></div><span class="badge b-done">Complete</span></div>
    <div class="ms-row"><div class="ms-num n-done">08</div><div class="ms-body"><div class="ms-title">Validate Automation Workflows</div><div class="ms-sub">Firing alerts diagnosed &amp; resolved, Terraform CI/CD pipeline verified end-to-end, infrastructure state confirmed drift-free</div></div><div class="ms-pw"><div class="ms-pct-lbl">100%</div><div class="ms-bg"><div class="ms-fill" style="width:100%;background:#059669"></div></div></div><span class="badge b-done">Complete</span></div>
    <div class="ms-row"><div class="ms-num n-pending">09</div><div class="ms-body"><div class="ms-title">Conduct Performance Tests</div><div class="ms-sub">Load testing with k6 / JMeter &mdash; throughput, latency, HPA auto-scale verification under peak traffic</div></div><div class="ms-pw"><div class="ms-pct-lbl">0%</div><div class="ms-bg"><div class="ms-fill" style="width:0%"></div></div></div><span class="badge b-pending">Pending</span></div>
    <div class="ms-row"><div class="ms-num n-pending">10</div><div class="ms-body"><div class="ms-title">Document Automation Scripts</div><div class="ms-sub">Architecture diagrams, Terraform module docs, runbooks, project report submission</div></div><div class="ms-pw"><div class="ms-pct-lbl">0%</div><div class="ms-bg"><div class="ms-fill" style="width:0%"></div></div></div><span class="badge b-pending">Pending</span></div>
  </div>

  <!-- ArgoCD Pipeline -->
  <div id="pipeline" class="sh">
    <div class="stag dark">GitOps CI/CD</div>
    <h2>ArgoCD Deployment Pipeline</h2>
    <p>Every change flows through Git &mdash; GitHub Actions builds and pushes the image, then ArgoCD continuously reconciles the GKE cluster to the declared Helm state.</p>
  </div>
  <div class="pipe-wrap">
    <div class="pipe-hdr">
      <div><h3>Continuous Delivery via ArgoCD GitOps on GKE</h3><p>Git push &rarr; Maven build &rarr; Docker push to Artifact Registry &rarr; GitOps update &rarr; ArgoCD auto-sync to GKE</p></div>
      <div class="argo-badge"><span style="font-size:1.1rem">&#x1F419;</span><div><span class="ab-name">ArgoCD</span><span class="ab-sub">&#x25CF; GitOps Controller Active</span></div></div>
    </div>
    <div class="pipe-body">
      <div class="pipe-stages">
        <div class="ps"><div class="ps-ico done">&#x1F4BE;</div><div class="ps-lbl">Code Push</div><div class="ps-sub">Git / GitHub</div></div>
        <div class="ps"><div class="ps-ico done">&#x1F527;</div><div class="ps-lbl">Build &amp; Test</div><div class="ps-sub">Maven + JUnit</div></div>
        <div class="ps"><div class="ps-ico done">&#x1F433;</div><div class="ps-lbl">Docker Build</div><div class="ps-sub">Multi-stage</div></div>
        <div class="ps"><div class="ps-ico done">&#x1F3F7;&#xFE0F;</div><div class="ps-lbl">Image Push</div><div class="ps-sub">Artifact Registry</div></div>
        <div class="ps"><div class="ps-ico done">&#x1F4DD;</div><div class="ps-lbl">Update Manifests</div><div class="ps-sub">Helm values</div></div>
        <div class="ps"><div class="ps-ico argo">&#x1F419;</div><div class="ps-lbl">ArgoCD Sync</div><div class="ps-sub">Drift detection</div></div>
        <div class="ps"><div class="ps-ico done">&#x2638;&#xFE0F;</div><div class="ps-lbl">Deploy to GKE</div><div class="ps-sub">Rolling update</div></div>
        <div class="ps"><div class="ps-ico done">&#x1F4E1;</div><div class="ps-lbl">Monitor</div><div class="ps-sub">Prometheus/Grafana</div></div>
      </div>
      <div class="argo-info">
        <div class="ai-card r"><h4>&#x1F500; App Repository</h4><p>Java source code in a dedicated GitHub repo. Every push triggers the GitHub Actions pipeline — Maven build, JUnit tests, Docker push to Google Artifact Registry.</p></div>
        <div class="ai-card s"><h4>&#x1F4CB; GitOps Repository</h4><p>A separate cuonline-gitops repo holds all Helm charts and manifests. The CI pipeline auto-updates the image tag, then ArgoCD detects the change.</p></div>
        <div class="ai-card g"><h4>&#x1F419; ArgoCD Reconciliation</h4><p>ArgoCD watches the GitOps repo and automatically reconciles the live GKE cluster to the declared Helm chart state — no manual kubectl apply.</p></div>
        <div class="ai-card a"><h4>&#x1F6E1;&#xFE0F; Terraform Pipeline</h4><p>Separate GitHub Actions workflow for infrastructure — terraform fmt, validate, plan on every push, with a mandatory manual approval gate before apply.</p></div>
      </div>
    </div>
  </div>

  <!-- Tech Stack -->
  <div id="stack" class="sh">
    <div class="stag red">Technology Stack</div>
    <h2>Tools &amp; Technologies</h2>
    <p>The full set of tools powering this project from code to cloud.</p>
  </div>
  <div class="tech-wrap">
    <div class="tech-pill"><div class="td" style="background:#f59e0b"></div>Java 21</div>
    <div class="tech-pill"><div class="td" style="background:#ef4444"></div>Apache Maven</div>
    <div class="tech-pill"><div class="td" style="background:#2496ed"></div>Docker</div>
    <div class="tech-pill"><div class="td" style="background:#e05243"></div>Apache Tomcat 9</div>
    <div class="tech-pill"><div class="td" style="background:#4285f4"></div>Kubernetes (GKE)</div>
    <div class="tech-pill"><div class="td" style="background:#ff6b6b"></div>Helm 3</div>
    <div class="tech-pill"><div class="td" style="background:#ee6c4d"></div>ArgoCD</div>
    <div class="tech-pill"><div class="td" style="background:#7b42bc"></div>Terraform</div>
    <div class="tech-pill"><div class="td" style="background:#4285f4"></div>Google Cloud (GCP)</div>
    <div class="tech-pill"><div class="td" style="background:#34a853"></div>Google Artifact Registry</div>
    <div class="tech-pill"><div class="td" style="background:#0f9d58"></div>GKE Gateway API</div>
    <div class="tech-pill"><div class="td" style="background:#1a73e8"></div>Google Certificate Manager</div>
    <div class="tech-pill"><div class="td" style="background:#e6522c"></div>Prometheus</div>
    <div class="tech-pill"><div class="td" style="background:#f46800"></div>Grafana</div>
    <div class="tech-pill"><div class="td" style="background:#e6522c"></div>Alertmanager</div>
    <div class="tech-pill"><div class="td" style="background:#239120"></div>GitHub Actions</div>
  </div>

</div>

<!-- Footer -->
<footer class="footer">
  <div class="footer-in">
    <div class="footer-brand">
      <img src="https://upload.wikimedia.org/wikipedia/en/thumb/2/28/Chandigarh_University_logo.png/200px-Chandigarh_University_logo.png" alt="CU" onerror="this.style.display='none'"/>
      <div>
        <div class="fb-name">Chandigarh University &mdash; CU Online</div>
        <div class="fb-sub">GitOps-Based Cloud Application Deployment &nbsp;&middot;&nbsp; AY 2025&ndash;26</div>
      </div>
    </div>
    <div class="footer-copy">&copy; 2026 Chandigarh University. All rights reserved.</div>
    <div class="footer-status">
      <svg width="11" height="11" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><path d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/></svg>
      System Operational
    </div>
  </div>
</footer>

</body>
</html>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>GitOps-Based Cloud Application Deployment</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
  <style>
    *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
    html { scroll-behavior: smooth; }
    body { font-family: "Inter", sans-serif; background: #f8fafc; color: #1e293b; -webkit-font-smoothing: antialiased; }

    /* Top Bar */
    .topbar { background: #7b0d0d; padding: 9px 40px; display: flex; align-items: center; justify-content: space-between; flex-wrap: wrap; gap: 8px; }
    .topbar-left { display: flex; align-items: center; gap: 12px; }
    .cu-logo-box { background: #fff; border-radius: 7px; padding: 4px 10px; display: flex; align-items: center; min-width: 44px; min-height: 44px; justify-content: center; }
    .cu-logo-box img { height: 34px; width: auto; display: block; }
    .cu-name { font-size: .9rem; font-weight: 700; color: #fff; }
    .cu-dept { font-size: .7rem; color: rgba(255,255,255,.75); margin-top: 1px; }
    .topbar-right { display: flex; align-items: center; gap: 8px; }
    .t-pill { font-size: .68rem; font-weight: 600; color: rgba(255,255,255,.9); background: rgba(255,255,255,.12); border: 1px solid rgba(255,255,255,.22); border-radius: 999px; padding: 4px 11px; }
    .live-dot { display: flex; align-items: center; gap: 5px; font-size: .68rem; font-weight: 600; color: #86efac; }
    .live-dot::before { content: ""; width: 7px; height: 7px; border-radius: 50%; background: #86efac; box-shadow: 0 0 7px #86efac; animation: blink 1.5s ease-in-out infinite; }
    @keyframes blink { 0%,100%{opacity:1} 50%{opacity:.2} }

    /* Navbar */
    .navbar { position: sticky; top: 0; z-index: 100; background: rgba(255,255,255,.96); backdrop-filter: blur(14px); border-bottom: 1px solid #e2e8f0; padding: 0 40px; height: 56px; display: flex; align-items: center; justify-content: space-between; box-shadow: 0 1px 4px rgba(0,0,0,.05); }
    .nav-brand { display: flex; align-items: center; gap: 8px; font-family: "Plus Jakarta Sans", sans-serif; font-size: .92rem; font-weight: 800; color: #7b0d0d; text-decoration: none; }
    .nav-links { display: flex; gap: 2px; align-items: center; }
    .nav-links a { font-size: .8rem; font-weight: 500; color: #475569; text-decoration: none; padding: 6px 13px; border-radius: 7px; transition: background .14s, color .14s; }
    .nav-links a:hover { background: #fef2f2; color: #7b0d0d; }
    .nav-cta { background: #7b0d0d !important; color: #fff !important; border-radius: 8px !important; padding: 7px 16px !important; }
    .nav-cta:hover { background: #5f0a0a !important; }

    /* Hero */
    .hero { background: linear-gradient(150deg,#fff8f8 0%,#fef2f2 35%,#fffbf0 70%,#f8fafc 100%); border-bottom: 1px solid #e2e8f0; padding: 68px 40px 60px; position: relative; overflow: hidden; }
    .hero::before { content: ""; position: absolute; top: -80px; right: -100px; width: 480px; height: 480px; border-radius: 50%; background: radial-gradient(circle,rgba(123,13,13,.07) 0%,transparent 70%); pointer-events: none; }
    .hero-grid { max-width: 1140px; margin: 0 auto; display: grid; grid-template-columns: 1fr 390px; gap: 56px; align-items: center; position: relative; z-index: 1; }
    .hero-eyebrow { display: inline-flex; align-items: center; gap: 6px; font-size: .68rem; font-weight: 700; letter-spacing: 1px; text-transform: uppercase; color: #7b0d0d; background: #fef2f2; border: 1px solid #fca5a5; border-radius: 999px; padding: 5px 13px; margin-bottom: 18px; }
    .hero-eyebrow span { width: 6px; height: 6px; border-radius: 50%; background: #7b0d0d; display: inline-block; }
    h1 { font-family: "Plus Jakarta Sans", sans-serif; font-size: clamp(1.9rem,3.6vw,2.85rem); font-weight: 900; line-height: 1.1; letter-spacing: -1.3px; color: #0f172a; margin-bottom: 18px; }
    h1 em { font-style: normal; background: linear-gradient(135deg,#7b0d0d 0%,#dc2626 100%); -webkit-background-clip: text; background-clip: text; -webkit-text-fill-color: transparent; }
    .hero-desc { font-size: .97rem; color: #64748b; line-height: 1.75; max-width: 490px; margin-bottom: 30px; }
    .hero-btns { display: flex; gap: 11px; flex-wrap: wrap; }
    .btn { display: inline-flex; align-items: center; gap: 7px; font-size: .85rem; font-weight: 600; border-radius: 9px; padding: 11px 22px; text-decoration: none; transition: all .17s; border: none; cursor: pointer; }
    .btn-red { background: #7b0d0d; color: #fff; box-shadow: 0 4px 14px rgba(123,13,13,.28); }
    .btn-red:hover { background: #5f0a0a; transform: translateY(-1px); }
    .btn-out { background: #fff; color: #1e293b; border: 1.5px solid #e2e8f0; }
    .btn-out:hover { border-color: #fca5a5; color: #7b0d0d; transform: translateY(-1px); }

    /* Side card */
    .side-card { background: #fff; border: 1px solid #e2e8f0; border-radius: 18px; padding: 24px; box-shadow: 0 10px 36px rgba(0,0,0,.09); }
    .sc-lbl { font-size: .67rem; font-weight: 700; letter-spacing: .9px; text-transform: uppercase; color: #94a3b8; margin-bottom: 16px; }
    .prog { margin-bottom: 14px; }
    .prog-row { display: flex; justify-content: space-between; margin-bottom: 5px; }
    .prog-name { font-size: .8rem; font-weight: 600; color: #334155; }
    .prog-pct  { font-size: .77rem; font-weight: 700; }
    .prog-bg   { height: 6px; background: #f1f5f9; border-radius: 999px; overflow: hidden; }
    .prog-fill { height: 100%; border-radius: 999px; }
    .c-red{color:#7b0d0d}.c-ora{color:#ea580c}.c-grn{color:#059669}.c-amb{color:#d97706}
    .f-red{background:linear-gradient(90deg,#7b0d0d,#ef4444);width:100%}
    .f-ora{background:linear-gradient(90deg,#ea580c,#fb923c);width:75%}
    .f-grn{background:linear-gradient(90deg,#059669,#34d399);width:40%}
    .f-amb{background:linear-gradient(90deg,#d97706,#fbbf24);width:20%}
    .sc-rule { height: 1px; background: #f1f5f9; margin: 16px 0; }
    .sc-counts { display: grid; grid-template-columns: repeat(3,1fr); gap: 8px; }
    .scc { background: #f8fafc; border-radius: 10px; padding: 12px 4px; text-align: center; }
    .scc-v { font-size: 1.25rem; font-weight: 800; color: #1e293b; }
    .scc-l { font-size: .66rem; color: #94a3b8; margin-top: 2px; }

    /* Page */
    .page { max-width: 1140px; margin: 0 auto; padding: 0 40px 80px; }

    /* Section heading */
    .sh { margin: 54px 0 22px; }
    .stag { display: inline-block; font-size: .65rem; font-weight: 700; letter-spacing: 1.1px; text-transform: uppercase; border-radius: 999px; padding: 4px 12px; margin-bottom: 10px; }
    .stag.red   { color:#7b0d0d; background:#fef2f2; border:1px solid #fca5a5; }
    .stag.green { color:#059669; background:#ecfdf5; border:1px solid #a7f3d0; }
    .stag.dark  { color:#334155; background:#f1f5f9; border:1px solid #e2e8f0; }
    .sh h2 { font-family: "Plus Jakarta Sans", sans-serif; font-size: 1.5rem; font-weight: 800; color: #0f172a; letter-spacing: -.4px; margin-bottom: 5px; }
    .sh p  { font-size: .86rem; color: #64748b; max-width: 520px; }

    /* Stat strip */
    .stat-strip { display: grid; grid-template-columns: repeat(auto-fit,minmax(155px,1fr)); gap: 12px; margin-top: 38px; }
    .stat-card { background: #fff; border: 1px solid #e2e8f0; border-radius: 14px; padding: 20px 16px; box-shadow: 0 1px 3px rgba(0,0,0,.05); transition: transform .17s, box-shadow .17s; }
    .stat-card:hover { transform: translateY(-3px); box-shadow: 0 8px 22px rgba(0,0,0,.09); }
    .stat-ico { font-size: 1.35rem; margin-bottom: 10px; }
    .stat-val { font-size: 1.5rem; font-weight: 800; color: #1e293b; line-height: 1; }
    .stat-lbl { font-size: .73rem; font-weight: 600; color: #64748b; margin-top: 4px; }

    /* Objectives */
    .obj-grid { display: grid; grid-template-columns: repeat(auto-fit,minmax(260px,1fr)); gap: 13px; }
    .obj-card { background: #fff; border: 1px solid #e2e8f0; border-radius: 13px; padding: 22px; box-shadow: 0 1px 3px rgba(0,0,0,.05); position: relative; overflow: hidden; transition: transform .17s, box-shadow .17s; }
    .obj-card::before { content: ""; position: absolute; top: 0; left: 0; right: 0; height: 3px; background: linear-gradient(90deg,#7b0d0d,#dc2626); opacity: 0; transition: opacity .18s; }
    .obj-card:hover { transform: translateY(-3px); box-shadow: 0 8px 22px rgba(0,0,0,.09); }
    .obj-card:hover::before { opacity: 1; }
    .obj-ico { font-size: 1.5rem; margin-bottom: 13px; }
    .obj-card h3 { font-size: .9rem; font-weight: 700; color: #1e293b; margin-bottom: 7px; }
    .obj-card p  { font-size: .8rem; color: #64748b; line-height: 1.65; }

    /* Milestone tracker */
    .overall-banner { background: linear-gradient(135deg,#7b0d0d 0%,#b91c1c 100%); border-radius: 14px; padding: 24px 28px; margin-bottom: 18px; display: flex; align-items: center; justify-content: space-between; flex-wrap: wrap; gap: 20px; }
    .ob-left h3 { font-size: .92rem; font-weight: 700; color: #fff; margin-bottom: 3px; }
    .ob-left p  { font-size: .78rem; color: rgba(255,255,255,.7); }
    .ob-nums { display: flex; gap: 22px; flex-wrap: wrap; }
    .obn { text-align: center; }
    .obn-v { font-size: 1.5rem; font-weight: 800; color: #fff; }
    .obn-l { font-size: .67rem; color: rgba(255,255,255,.7); margin-top: 1px; }
    .ob-ring { position: relative; width: 78px; height: 78px; }
    .ob-ring svg { transform: rotate(-90deg); }
    .ob-ring-text { position: absolute; inset: 0; display: flex; flex-direction: column; align-items: center; justify-content: center; color: #fff; }
    .ob-ring-text .rp { font-size: .95rem; font-weight: 800; }
    .ob-ring-text .rl { font-size: .56rem; opacity: .7; }

    .ms-list { display: flex; flex-direction: column; gap: 8px; }
    .ms-row { display: flex; align-items: center; gap: 13px; background: #fff; border: 1px solid #e2e8f0; border-radius: 11px; padding: 13px 17px; box-shadow: 0 1px 2px rgba(0,0,0,.04); transition: border-color .16s; }
    .ms-row:hover { border-color: #fca5a5; }
    .ms-num { min-width: 32px; height: 32px; border-radius: 8px; display: flex; align-items: center; justify-content: center; font-size: .72rem; font-weight: 800; flex-shrink: 0; }
    .n-done    { background: #ecfdf5; border: 1.5px solid #a7f3d0; color: #059669; }
    .n-active  { background: #fef2f2; border: 1.5px solid #fca5a5; color: #7b0d0d; }
    .n-pending { background: #f8fafc; border: 1.5px solid #e2e8f0; color: #94a3b8; }
    .ms-body { flex: 1; min-width: 0; }
    .ms-title { font-size: .85rem; font-weight: 600; color: #1e293b; }
    .ms-sub   { font-size: .72rem; color: #94a3b8; margin-top: 2px; }
    .ms-pw { width: 108px; flex-shrink: 0; }
    .ms-pct-lbl { font-size: .68rem; font-weight: 700; color: #94a3b8; text-align: right; margin-bottom: 3px; }
    .ms-bg   { height: 5px; background: #f1f5f9; border-radius: 999px; overflow: hidden; }
    .ms-fill { height: 100%; border-radius: 999px; }
    .badge { font-size: .65rem; font-weight: 700; letter-spacing: .4px; text-transform: uppercase; padding: 3px 9px; border-radius: 999px; white-space: nowrap; flex-shrink: 0; }
    .b-done    { background: #ecfdf5; color: #059669; border: 1px solid #a7f3d0; }
    .b-active  { background: #fef2f2; color: #7b0d0d;  border: 1px solid #fca5a5; }
    .b-pending { background: #fffbeb; color: #d97706; border: 1px solid #fcd34d; }

    /* Pipeline */
    .pipe-wrap { background: #fff; border: 1px solid #e2e8f0; border-radius: 18px; overflow: hidden; box-shadow: 0 4px 16px rgba(0,0,0,.07); }
    .pipe-hdr { background: linear-gradient(135deg,#0f172a 0%,#1e293b 100%); padding: 20px 26px; display: flex; align-items: center; justify-content: space-between; flex-wrap: wrap; gap: 10px; }
    .pipe-hdr h3 { font-size: .92rem; font-weight: 700; color: #fff; margin-bottom: 3px; }
    .pipe-hdr p  { font-size: .73rem; color: #94a3b8; }
    .argo-badge { display: flex; align-items: center; gap: 8px; background: rgba(255,255,255,.07); border: 1px solid rgba(255,255,255,.12); border-radius: 9px; padding: 7px 14px; }
    .argo-badge .ab-name { font-size: .8rem; font-weight: 700; color: #f1f5f9; display: block; }
    .argo-badge .ab-sub  { font-size: .68rem; color: #86efac; }
    .pipe-body { padding: 26px; }
    .pipe-stages { display: grid; grid-template-columns: repeat(8,1fr); position: relative; }
    .pipe-stages::before { content: ""; position: absolute; top: 29px; left: 52px; right: 52px; height: 2px; background: linear-gradient(90deg,#fca5a5,#7b0d0d,#fca5a5); z-index: 0; }
    .ps { display: flex; flex-direction: column; align-items: center; gap: 8px; position: relative; z-index: 1; }
    .ps-ico { width: 58px; height: 58px; border-radius: 13px; background: #fff; border: 2px solid #e2e8f0; display: flex; align-items: center; justify-content: center; font-size: 1.35rem; box-shadow: 0 2px 6px rgba(0,0,0,.06); transition: transform .17s, border-color .17s, box-shadow .17s; }
    .ps:hover .ps-ico { transform: translateY(-4px); border-color: #fca5a5; box-shadow: 0 8px 18px rgba(123,13,13,.15); }
    .ps-ico.done { border-color: #a7f3d0; background: #ecfdf5; }
    .ps-ico.argo { border-color: #ee6c4d; box-shadow: 0 3px 10px rgba(238,108,77,.2); }
    .ps-lbl { font-size: .68rem; font-weight: 600; color: #475569; text-align: center; }
    .ps-sub { font-size: .6rem; color: #94a3b8; text-align: center; margin-top: -4px; }
    .argo-info { display: grid; grid-template-columns: repeat(auto-fit,minmax(200px,1fr)); gap: 11px; margin-top: 22px; }
    .ai-card { border-radius: 11px; padding: 16px; border: 1px solid transparent; }
    .ai-card.r{background:#fef2f2;border-color:#fca5a5} .ai-card.s{background:#f8fafc;border-color:#e2e8f0}
    .ai-card.g{background:#ecfdf5;border-color:#a7f3d0} .ai-card.a{background:#fffbeb;border-color:#fcd34d}
    .ai-card h4 { font-size: .8rem; font-weight: 700; margin-bottom: 5px; }
    .ai-card.r h4{color:#7b0d0d}.ai-card.s h4{color:#334155}.ai-card.g h4{color:#059669}.ai-card.a h4{color:#d97706}
    .ai-card p { font-size: .73rem; color: #64748b; line-height: 1.6; }

    /* Tech Stack */
    .tech-wrap { display: flex; flex-wrap: wrap; gap: 9px; }
    .tech-pill { display: flex; align-items: center; gap: 7px; background: #fff; border: 1.5px solid #e2e8f0; border-radius: 9px; padding: 7px 14px; font-size: .8rem; font-weight: 600; color: #334155; box-shadow: 0 1px 3px rgba(0,0,0,.04); transition: border-color .14s, transform .14s, box-shadow .14s; }
    .tech-pill:hover { border-color: #fca5a5; transform: translateY(-2px); box-shadow: 0 4px 12px rgba(0,0,0,.08); }
    .td { width: 9px; height: 9px; border-radius: 50%; flex-shrink: 0; }

    /* Footer */
    .footer { background: #fff; border-top: 1px solid #e2e8f0; padding: 26px 40px; }
    .footer-in { max-width: 1140px; margin: 0 auto; display: flex; align-items: center; justify-content: space-between; flex-wrap: wrap; gap: 14px; }
    .footer-brand { display: flex; align-items: center; gap: 11px; }
    .footer-brand img { height: 28px; width: auto; }
    .fb-name { font-size: .86rem; font-weight: 700; color: #1e293b; }
    .fb-sub  { font-size: .71rem; color: #94a3b8; margin-top: 1px; }
    .footer-copy { font-size: .73rem; color: #94a3b8; }
    .footer-status { display: flex; align-items: center; gap: 5px; font-size: .7rem; font-weight: 600; color: #059669; background: #ecfdf5; border: 1px solid #a7f3d0; border-radius: 999px; padding: 5px 12px; }

    @media(max-width:860px){.hero-grid{grid-template-columns:1fr}.side-card{display:none}.pipe-stages{grid-template-columns:repeat(4,1fr)}.pipe-stages::before{display:none}}
    @media(max-width:580px){.topbar,.navbar,.hero,.page,.footer{padding-left:16px;padding-right:16px}.pipe-stages{grid-template-columns:repeat(2,1fr)}}
  </style>
</head>
<body>

<!-- CU Top Bar -->
<div class="topbar">
  <div class="topbar-left">
    <div class="cu-logo-box">
      <img src="https://upload.wikimedia.org/wikipedia/en/thumb/2/28/Chandigarh_University_logo.png/200px-Chandigarh_University_logo.png"
           alt="Chandigarh University"
           onerror="this.parentElement.innerHTML='<b style=&quot;color:#7b0d0d;font-size:.9rem&quot;>CU</b>'"/>
    </div>
    <div>
      <div class="cu-name">Chandigarh University &mdash; CU Online</div>
      <div class="cu-dept">School of Distance &amp; Online Education</div>
    </div>
  </div>
  <div class="topbar-right">
    <span class="t-pill">DevOps Engineering</span>
    <span class="t-pill">AY 2025&ndash;26</span>
    <span class="live-dot">Live</span>
  </div>
</div>

<!-- Navbar -->
<nav class="navbar">
  <a class="nav-brand" href="#">
    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.3" stroke-linecap="round" stroke-linejoin="round"><path d="M12 2L2 7l10 5 10-5-10-5zM2 17l10 5 10-5M2 12l10 5 10-5"/></svg>
    GitOps Cloud Deployment
  </a>
  <div class="nav-links">
    <a href="#objectives">Objectives</a>
    <a href="#milestones">Milestones</a>
    <a href="#pipeline">CI/CD</a>
    <a href="#stack">Stack</a>
    <a href="#pipeline" class="nav-cta">ArgoCD</a>
  </div>
</nav>

<!-- Hero -->
<section class="hero">
  <div class="hero-grid">
    <div>
      <div class="hero-eyebrow"><span></span>GitOps &bull; DevOps &bull; Cloud</div>
      <h1><em>GitOps-Based</em><br/>Cloud Application<br/>Deployment</h1>
      <p class="hero-desc">A production-grade DevOps automation system combining Docker containerisation, Kubernetes on AWS EKS, Terraform infrastructure-as-code, Ansible automation, and ArgoCD-powered GitOps continuous delivery.</p>
      <div class="hero-btns">
        <a href="#milestones" class="btn btn-red">
          <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><path d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/></svg>
          View Milestones
        </a>
        <a href="#pipeline" class="btn btn-out">
          <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><path d="M10 20l4-16m4 4l4 4-4 4M6 16l-4-4 4-4"/></svg>
          ArgoCD Pipeline
        </a>
      </div>
    </div>
    <div class="side-card">
      <div class="sc-lbl">Project Progress Overview</div>
      <div class="prog"><div class="prog-row"><span class="prog-name">&#x1F433; Containerization</span><span class="prog-pct c-red">100%</span></div><div class="prog-bg"><div class="prog-fill f-red"></div></div></div>
      <div class="prog"><div class="prog-row"><span class="prog-name">&#x2638;&#xFE0F; Kubernetes / EKS</span><span class="prog-pct c-ora">75%</span></div><div class="prog-bg"><div class="prog-fill f-ora"></div></div></div>
      <div class="prog"><div class="prog-row"><span class="prog-name">&#x2699;&#xFE0F; Terraform IaC</span><span class="prog-pct c-grn">40%</span></div><div class="prog-bg"><div class="prog-fill f-grn"></div></div></div>
      <div class="prog"><div class="prog-row"><span class="prog-name">&#x1F4CA; Monitoring</span><span class="prog-pct c-amb">20%</span></div><div class="prog-bg"><div class="prog-fill f-amb"></div></div></div>
      <div class="sc-rule"></div>
      <div class="sc-counts">
        <div class="scc"><div class="scc-v" style="color:#059669">2</div><div class="scc-l">Done</div></div>
        <div class="scc"><div class="scc-v" style="color:#7b0d0d">2</div><div class="scc-l">Active</div></div>
        <div class="scc"><div class="scc-v" style="color:#d97706">6</div><div class="scc-l">Pending</div></div>
      </div>
    </div>
  </div>
</section>

<div class="page">

  <!-- Stat strip -->
  <div class="stat-strip">
    <div class="stat-card"><div class="stat-ico">&#x1F433;</div><div class="stat-val" style="color:#2496ed">Docker</div><div class="stat-lbl">Containerized</div></div>
    <div class="stat-card"><div class="stat-ico">&#x2638;&#xFE0F;</div><div class="stat-val" style="color:#326ce5">EKS</div><div class="stat-lbl">Kubernetes Cluster</div></div>
    <div class="stat-card"><div class="stat-ico">&#x1F527;</div><div class="stat-val">7+</div><div class="stat-lbl">Terraform Modules</div></div>
    <div class="stat-card"><div class="stat-ico">&#x1F419;</div><div class="stat-val" style="color:#ee6c4d">ArgoCD</div><div class="stat-lbl">GitOps CI/CD</div></div>
    <div class="stat-card"><div class="stat-ico">&#x1F4CA;</div><div class="stat-val" style="color:#d97706">10</div><div class="stat-lbl">Milestones</div></div>
  </div>

  <!-- Objectives -->
  <div id="objectives" class="sh">
    <div class="stag red">Objectives</div>
    <h2>What We Are Building</h2>
    <p>Core goals driving every design and implementation decision across the project.</p>
  </div>
  <div class="obj-grid">
    <div class="obj-card"><div class="obj-ico">&#x1F3D7;&#xFE0F;</div><h3>DevOps Automation System</h3><p>A unified platform eliminating manual intervention across provisioning, configuration, and deployment workflows.</p></div>
    <div class="obj-card"><div class="obj-ico">&#x1F4E6;</div><h3>Docker Containerization</h3><p>Portable, reproducible multi-stage Docker images minimising image size and attack surface.</p></div>
    <div class="obj-card"><div class="obj-ico">&#x2638;&#xFE0F;</div><h3>Kubernetes Orchestration</h3><p>Scale workloads on Amazon EKS with auto-scaling, self-healing, and rolling updates via Helm.</p></div>
    <div class="obj-card"><div class="obj-ico">&#x1F4DC;</div><h3>Ansible IaC Playbooks</h3><p>Idempotent Ansible playbooks automating server setup, cluster bootstrap, and application configuration.</p></div>
    <div class="obj-card"><div class="obj-ico">&#x1F419;</div><h3>GitOps with ArgoCD</h3><p>Git as the single source of truth &mdash; ArgoCD continuously reconciles cluster state to the declared desired state.</p></div>
    <div class="obj-card"><div class="obj-ico">&#x1F4CA;</div><h3>Observability &amp; Performance</h3><p>Prometheus, Grafana, and alerting rules with load testing to validate system behaviour under peak traffic.</p></div>
  </div>

  <!-- Milestones -->
  <div id="milestones" class="sh">
    <div class="stag green">Milestones</div>
    <h2>Project Status Tracker</h2>
    <p>Live snapshot of all 10 project milestones with individual progress indicators.</p>
  </div>
  <div class="overall-banner">
    <div class="ob-left"><h3>Overall Project Completion</h3><p>2 of 10 complete &middot; 2 in progress &middot; 6 pending</p></div>
    <div class="ob-nums">
      <div class="obn"><div class="obn-v">2</div><div class="obn-l">&#x2705; Done</div></div>
      <div class="obn"><div class="obn-v">2</div><div class="obn-l">&#x1F534; Active</div></div>
      <div class="obn"><div class="obn-v">6</div><div class="obn-l">&#x23F3; Pending</div></div>
    </div>
    <div class="ob-ring">
      <svg width="78" height="78" viewBox="0 0 78 78">
        <circle cx="39" cy="39" r="30" fill="none" stroke="rgba(255,255,255,.2)" stroke-width="7"/>
        <circle cx="39" cy="39" r="30" fill="none" stroke="#fff" stroke-width="7" stroke-dasharray="188" stroke-dashoffset="150" stroke-linecap="round"/>
      </svg>
      <div class="ob-ring-text"><div class="rp">20%</div><div class="rl">DONE</div></div>
    </div>
  </div>
  <div class="ms-list">
    <div class="ms-row"><div class="ms-num n-done">01</div><div class="ms-body"><div class="ms-title">Develop Sample Application</div><div class="ms-sub">Java/Maven webapp &mdash; Greeter service, JUnit tests, WAR packaging</div></div><div class="ms-pw"><div class="ms-pct-lbl">100%</div><div class="ms-bg"><div class="ms-fill" style="width:100%;background:#059669"></div></div></div><span class="badge b-done">Complete</span></div>
    <div class="ms-row"><div class="ms-num n-done">02</div><div class="ms-body"><div class="ms-title">Containerize with Docker</div><div class="ms-sub">Multi-stage Dockerfile &mdash; Maven builder + Tomcat 9 runtime</div></div><div class="ms-pw"><div class="ms-pct-lbl">100%</div><div class="ms-bg"><div class="ms-fill" style="width:100%;background:#059669"></div></div></div><span class="badge b-done">Complete</span></div>
    <div class="ms-row"><div class="ms-num n-active">03</div><div class="ms-body"><div class="ms-title">Deploy on Kubernetes (EKS)</div><div class="ms-sub">Helm charts, Ingress-ALB, HPA on Amazon EKS</div></div><div class="ms-pw"><div class="ms-pct-lbl">65%</div><div class="ms-bg"><div class="ms-fill" style="width:65%;background:#7b0d0d"></div></div></div><span class="badge b-active">In Progress</span></div>
    <div class="ms-row"><div class="ms-num n-active">04</div><div class="ms-body"><div class="ms-title">Ansible Playbooks &mdash; Server Setup</div><div class="ms-sub">Idempotent playbooks for OS hardening, Docker, K8s node config</div></div><div class="ms-pw"><div class="ms-pct-lbl">45%</div><div class="ms-bg"><div class="ms-fill" style="width:45%;background:#7b0d0d"></div></div></div><span class="badge b-active">In Progress</span></div>
    <div class="ms-row"><div class="ms-num n-pending">05</div><div class="ms-body"><div class="ms-title">Automate Cluster Configuration</div><div class="ms-sub">EKS add-ons: EBS CSI, ALB Controller, External DNS via Ansible</div></div><div class="ms-pw"><div class="ms-pct-lbl">0%</div><div class="ms-bg"><div class="ms-fill" style="width:0%"></div></div></div><span class="badge b-pending">Pending</span></div>
    <div class="ms-row"><div class="ms-num n-pending">06</div><div class="ms-body"><div class="ms-title">Integrate ArgoCD CI/CD Pipeline</div><div class="ms-sub">App-of-Apps pattern, sync policies, RBAC on EKS</div></div><div class="ms-pw"><div class="ms-pct-lbl">0%</div><div class="ms-bg"><div class="ms-fill" style="width:0%"></div></div></div><span class="badge b-pending">Pending</span></div>
    <div class="ms-row"><div class="ms-num n-pending">07</div><div class="ms-body"><div class="ms-title">System Monitoring Setup</div><div class="ms-sub">Prometheus + Grafana + Alertmanager via kube-prometheus-stack</div></div><div class="ms-pw"><div class="ms-pct-lbl">0%</div><div class="ms-bg"><div class="ms-fill" style="width:0%"></div></div></div><span class="badge b-pending">Pending</span></div>
    <div class="ms-row"><div class="ms-num n-pending">08</div><div class="ms-body"><div class="ms-title">Validate Automation Workflows</div><div class="ms-sub">Smoke tests, rollback validation, GitOps reconciliation checks</div></div><div class="ms-pw"><div class="ms-pct-lbl">0%</div><div class="ms-bg"><div class="ms-fill" style="width:0%"></div></div></div><span class="badge b-pending">Pending</span></div>
    <div class="ms-row"><div class="ms-num n-pending">09</div><div class="ms-body"><div class="ms-title">Conduct Performance Tests</div><div class="ms-sub">Load testing with k6/JMeter &mdash; throughput, latency, auto-scale</div></div><div class="ms-pw"><div class="ms-pct-lbl">0%</div><div class="ms-bg"><div class="ms-fill" style="width:0%"></div></div></div><span class="badge b-pending">Pending</span></div>
    <div class="ms-row"><div class="ms-num n-pending">10</div><div class="ms-body"><div class="ms-title">Document Automation Scripts</div><div class="ms-sub">Architecture diagrams, runbooks, Terraform module docs, project report</div></div><div class="ms-pw"><div class="ms-pct-lbl">0%</div><div class="ms-bg"><div class="ms-fill" style="width:0%"></div></div></div><span class="badge b-pending">Pending</span></div>
  </div>

  <!-- ArgoCD Pipeline -->
  <div id="pipeline" class="sh">
    <div class="stag dark">GitOps CI/CD</div>
    <h2>ArgoCD Deployment Pipeline</h2>
    <p>Every change flows through Git &mdash; ArgoCD continuously reconciles the cluster to the declared desired state.</p>
  </div>
  <div class="pipe-wrap">
    <div class="pipe-hdr">
      <div><h3>Continuous Delivery via ArgoCD GitOps</h3><p>Git push &rarr; build &rarr; image push &rarr; ArgoCD detects drift &rarr; auto-sync to EKS</p></div>
      <div class="argo-badge"><span style="font-size:1.1rem">&#x1F419;</span><div><span class="ab-name">ArgoCD</span><span class="ab-sub">&#x25CF; GitOps Controller Active</span></div></div>
    </div>
    <div class="pipe-body">
      <div class="pipe-stages">
        <div class="ps"><div class="ps-ico done">&#x1F4BE;</div><div class="ps-lbl">Code Push</div><div class="ps-sub">Git / GitHub</div></div>
        <div class="ps"><div class="ps-ico done">&#x1F527;</div><div class="ps-lbl">Build &amp; Test</div><div class="ps-sub">Maven + JUnit</div></div>
        <div class="ps"><div class="ps-ico done">&#x1F433;</div><div class="ps-lbl">Docker Build</div><div class="ps-sub">Multi-stage</div></div>
        <div class="ps"><div class="ps-ico">&#x1F3F7;&#xFE0F;</div><div class="ps-lbl">Image Push</div><div class="ps-sub">AWS ECR</div></div>
        <div class="ps"><div class="ps-ico">&#x1F4DD;</div><div class="ps-lbl">Update Manifests</div><div class="ps-sub">Helm values</div></div>
        <div class="ps"><div class="ps-ico argo">&#x1F419;</div><div class="ps-lbl">ArgoCD Sync</div><div class="ps-sub">Drift detection</div></div>
        <div class="ps"><div class="ps-ico">&#x2638;&#xFE0F;</div><div class="ps-lbl">Deploy to EKS</div><div class="ps-sub">Rolling update</div></div>
        <div class="ps"><div class="ps-ico">&#x1F4E1;</div><div class="ps-lbl">Monitor</div><div class="ps-sub">Prometheus/Grafana</div></div>
      </div>
      <div class="argo-info">
        <div class="ai-card r"><h4>&#x1F500; Source Repository</h4><p>Application code in a dedicated Git repo. Every PR triggers the build pipeline &mdash; no direct cluster access.</p></div>
        <div class="ai-card s"><h4>&#x1F4CB; Config Repository</h4><p>A separate GitOps repo holds all Helm values and manifests. ArgoCD watches this repo for changes.</p></div>
        <div class="ai-card g"><h4>&#x1F419; ArgoCD Reconciliation</h4><p>ArgoCD detects drift between the live cluster and the config repo, then automatically reconciles to desired state.</p></div>
        <div class="ai-card a"><h4>&#x1F501; Auto-Rollback</h4><p>Failed deployments trigger automated rollback via ArgoCD sync policies, maintaining cluster stability.</p></div>
      </div>
    </div>
  </div>

  <!-- Tech Stack -->
  <div id="stack" class="sh">
    <div class="stag red">Technology Stack</div>
    <h2>Tools &amp; Technologies</h2>
    <p>The full set of tools powering this project from code to cloud.</p>
  </div>
  <div class="tech-wrap">
    <div class="tech-pill"><div class="td" style="background:#f59e0b"></div>Java 21</div>
    <div class="tech-pill"><div class="td" style="background:#ef4444"></div>Apache Maven</div>
    <div class="tech-pill"><div class="td" style="background:#2496ed"></div>Docker</div>
    <div class="tech-pill"><div class="td" style="background:#e05243"></div>Apache Tomcat 9</div>
    <div class="tech-pill"><div class="td" style="background:#326ce5"></div>Kubernetes (EKS)</div>
    <div class="tech-pill"><div class="td" style="background:#ff6b6b"></div>Helm 3</div>
    <div class="tech-pill"><div class="td" style="background:#ee6c4d"></div>ArgoCD</div>
    <div class="tech-pill"><div class="td" style="background:#7b42bc"></div>Terraform</div>
    <div class="tech-pill"><div class="td" style="background:#cc0000"></div>Ansible</div>
    <div class="tech-pill"><div class="td" style="background:#d24939"></div>Jenkins</div>
    <div class="tech-pill"><div class="td" style="background:#e6522c"></div>Prometheus</div>
    <div class="tech-pill"><div class="td" style="background:#f46800"></div>Grafana</div>
    <div class="tech-pill"><div class="td" style="background:#232f3e"></div>AWS</div>
    <div class="tech-pill"><div class="td" style="background:#239120"></div>GitHub Actions</div>
  </div>

</div>

<!-- Footer -->
<footer class="footer">
  <div class="footer-in">
    <div class="footer-brand">
      <img src="https://upload.wikimedia.org/wikipedia/en/thumb/2/28/Chandigarh_University_logo.png/200px-Chandigarh_University_logo.png" alt="CU" onerror="this.style.display='none'"/>
      <div>
        <div class="fb-name">Chandigarh University &mdash; CU Online</div>
        <div class="fb-sub">GitOps-Based Cloud Application Deployment &nbsp;&middot;&nbsp; AY 2025&ndash;26</div>
      </div>
    </div>
    <div class="footer-copy">&copy; 2026 Chandigarh University. All rights reserved.</div>
    <div class="footer-status">
      <svg width="11" height="11" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><path d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/></svg>
      System Operational
    </div>
  </div>
</footer>

</body>
</html>
