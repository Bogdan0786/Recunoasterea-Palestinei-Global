# Asamblează index.html premium pentru proiectul Palestinei în Europa
$frenchPath = "C:\Users\Bogdan\.gemini\antigravity\scratch\teritorii-franta\index.html"
$destPath = "C:\Users\Bogdan\.gemini\antigravity\scratch\harta-palestina\index.html"

Write-Host "Citesc TopoJSON din $frenchPath..."
$frenchContent = Get-Content -Path $frenchPath -Raw -Encoding utf8
$jsonStart = $frenchContent.IndexOf('<script id="world-data" type="application/json">')
if ($jsonStart -eq -1) {
    Write-Error "Nu am găsit scriptul world-data în fișierul francez!"
    exit 1
}
$jsonEnd = $frenchContent.IndexOf('</script>', $jsonStart)
$jsonBlock = $frenchContent.Substring($jsonStart, $jsonEnd - $jsonStart + 9)
Write-Host "TopoJSON extras cu succes. Lungime: $($jsonBlock.Length) caractere."

Write-Host "Construiesc structura premium..."
$htmlHeader = @'
<!DOCTYPE html>
<html lang="ro">
<head>
<script>
window.onerror = function(message, source, lineno, colno, error) {
  var errDiv = document.createElement('div');
  errDiv.style.position = 'fixed';
  errDiv.style.top = '0';
  errDiv.style.left = '0';
  errDiv.style.width = '100%';
  errDiv.style.background = '#ef4444';
  errDiv.style.color = '#ffffff';
  errDiv.style.padding = '20px';
  errDiv.style.zIndex = '9999999';
  errDiv.style.fontFamily = 'monospace';
  errDiv.style.fontSize = '14px';
  errDiv.style.whiteSpace = 'pre-wrap';
  errDiv.style.boxShadow = '0 10px 30px rgba(0,0,0,0.5)';
  errDiv.innerHTML = '<h2 style="margin-bottom:10px;">🚨 EROARE DETECTATĂ PE LAPTOPUL TĂU:</h2>' +
                     '<p style="margin:5px 0;"><b>Mesaj:</b> ' + message + '</p>' +
                     '<p style="margin:5px 0;"><b>Sursă:</b> ' + source + '</p>' +
                     '<p style="margin:5px 0;"><b>Linie:</b> ' + lineno + ' | <b>Coloană:</b> ' + colno + '</p>' +
                     '<p style="margin:5px 0;"><b>Stack Trace:</b> ' + (error ? error.stack : 'N/A') + '</p>' +
                     '<p style="margin-top:15px; font-weight:bold; color:#fef08a;">Te rugăm să trimiți acest text exact în chat pentru a-l rezolva în 5 secunde!</p>';
  document.body.insertBefore(errDiv, document.body.firstChild);
  return false;
};
</script>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Recunoașterea Palestinei în Europa — Hartă Juridică Interactivă</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:ital,wght@0,400;0,500;0,600;0,700;1,400&family=Inter:wght@300;400;500;600;700&family=JetBrains+Mono:wght@400;500&display=swap" rel="stylesheet">

<!-- INLINE_SCRIPTS_PLACEHOLDER -->

<style>
  :root {
    --ink: #cbd5e1;
    --ink-soft: #94a3b8;
    --paper: #080b14;
    --paper-dark: #121826;
    --accent: #10b981;       /* Palestine Green */
    --accent-deep: #065f46;
    --accent-red: #ef4444;    /* Palestine Red / No rec */
    --gold: #f59e0b;          /* Contested Gold */
    --sea: #05070f;           /* Very deep ocean */
    --sea-deep: #020307;
    --land: #111827;
    --land-border: #1f2937;
    --border: rgba(148, 163, 184, 0.1);
    --panel-bg: rgba(18, 24, 38, 0.8);
    --card-bg: #1e293b;
    --glow: rgba(16, 185, 129, 0.15);
    
    /* Regiuni tematice */
    --rec: #10b981;
    --norec: #ef4444;
    --contested: #94a3b8;
    
    --radius: 8px;
    --shadow: 0 10px 30px rgba(0, 0, 0, 0.5);
  }

  body.light-theme {
    --ink: #1f2430;
    --ink-soft: #4c566a;
    --paper: #f4f6f9;
    --paper-dark: #d8dee9;
    --accent: #059669;
    --accent-deep: #065f46;
    --accent-red: #dc2626;
    --gold: #d97706;
    --sea: #cfd9e4;
    --sea-deep: #b5c4d4;
    --land: #fafbfd;
    --land-border: #abb2bf;
    --border: rgba(31, 36, 48, 0.15);
    --panel-bg: rgba(244, 246, 249, 0.85);
    --card-bg: #eceff4;
    --glow: rgba(5, 150, 105, 0.08);
  }

  * { box-sizing: border-box; margin: 0; padding: 0; }

  html, body {
    background: var(--paper);
    color: var(--ink);
    font-family: 'Inter', sans-serif;
    font-weight: 400;
    -webkit-font-smoothing: antialiased;
    overflow-x: hidden;
    transition: background 0.4s ease, color 0.4s ease;
  }

  body {
    background-image:
      radial-gradient(ellipse at top center, var(--glow) 0%, transparent 60%),
      radial-gradient(ellipse at bottom right, rgba(239, 68, 68, 0.02) 0%, transparent 60%);
    min-height: 100vh;
  }

  header {
    padding: 32px 48px;
    border-bottom: 1px solid var(--border);
    position: relative;
    background: var(--paper);
    transition: background 0.4s ease;
    z-index: 10;
  }

  header::before {
    content: '';
    position: absolute;
    top: 0; left: 0; right: 0;
    height: 4px;
    background: linear-gradient(90deg, #000000 0 25%, #ffffff 25% 50%, #10b981 50% 75%, #ef4444 75% 100%);
  }

  .header-inner {
    max-width: 1600px;
    margin: 0 auto;
    display: flex;
    justify-content: space-between;
    align-items: center;
    gap: 48px;
    flex-wrap: wrap;
  }

  .brand { display: flex; flex-direction: column; gap: 4px; flex: 1; min-width: 300px; }

  .eyebrow {
    font-family: 'JetBrains Mono', monospace;
    font-size: 11px;
    letter-spacing: 0.2em;
    text-transform: uppercase;
    color: var(--ink-soft);
    margin-bottom: 4px;
  }

  h1 {
    font-family: 'Cormorant Garamond', serif;
    font-weight: 500;
    font-size: clamp(32px, 4vw, 48px);
    line-height: 1.1;
    letter-spacing: -0.02em;
  }

  h1 em { font-style: italic; color: var(--accent); }

  .subtitle {
    font-family: 'Cormorant Garamond', serif;
    font-style: italic;
    font-size: 17px;
    color: var(--ink-soft);
    margin-top: 8px;
    max-width: 800px;
    line-height: 1.4;
  }

  .header-actions {
    display: flex;
    align-items: center;
    gap: 24px;
  }

  .meta {
    font-family: 'JetBrains Mono', monospace;
    font-size: 11px;
    color: var(--ink-soft);
    text-align: right;
    line-height: 1.6;
  }

  .meta .line { display: flex; gap: 12px; justify-content: flex-end; }
  .meta .label { color: var(--accent); font-weight: 600; }

  .theme-btn {
    background: var(--paper-dark);
    border: 1px solid var(--border);
    color: var(--ink);
    padding: 10px 18px;
    font-family: 'JetBrains Mono', monospace;
    font-size: 11px;
    font-weight: 600;
    cursor: pointer;
    border-radius: var(--radius);
    transition: all 0.3s ease;
    display: flex;
    align-items: center;
    gap: 8px;
    box-shadow: var(--shadow);
  }

  .theme-btn:hover {
    background: var(--ink);
    color: var(--paper);
    transform: translateY(-1px);
  }

  .legal-intro {
    max-width: 1600px;
    margin: 0 auto;
    padding: 24px 48px 16px;
    display: grid;
    grid-template-columns: 1fr 3fr;
    gap: 48px;
    align-items: start;
  }

  .legal-intro .label-col {
    font-family: 'Cormorant Garamond', serif;
    font-style: italic;
    font-size: 20px;
    color: var(--ink-soft);
    border-left: 3px solid var(--accent);
    padding-left: 20px;
    line-height: 1.2;
  }

  .legal-intro p {
    font-family: 'Cormorant Garamond', serif;
    font-size: 18px;
    line-height: 1.5;
    color: var(--ink);
  }

  .filters {
    max-width: 1600px;
    margin: 0 auto;
    padding: 16px 48px;
    display: flex;
    gap: 8px;
    flex-wrap: wrap;
    align-items: center;
    border-top: 1px dashed var(--border);
    border-bottom: 1px dashed var(--border);
  }

  .filter-label {
    font-family: 'JetBrains Mono', monospace;
    font-size: 10px;
    letter-spacing: 0.15em;
    text-transform: uppercase;
    color: var(--ink-soft);
    margin-right: 12px;
  }

  .chip {
    font-family: 'Inter', sans-serif;
    font-size: 12px;
    font-weight: 500;
    padding: 8px 16px;
    background: transparent;
    border: 1px solid var(--border);
    color: var(--ink);
    cursor: pointer;
    transition: all 0.2s ease;
    border-radius: var(--radius);
    display: flex;
    align-items: center;
    gap: 8px;
  }

  .chip:hover, .chip.active {
    background: var(--ink);
    color: var(--paper);
    border-color: var(--ink);
  }

  .chip .dot { width: 8px; height: 8px; border-radius: 50%; display: inline-block; }
  .chip[data-cat="rec"] .dot { background: var(--rec); }
  .chip[data-cat="norec"] .dot { background: var(--norec); }
  .chip[data-cat="contested"] .dot { background: var(--contested); }

  main {
    max-width: 1600px;
    margin: 0 auto;
    padding: 24px 48px 48px;
    display: grid;
    grid-template-columns: 1fr 460px;
    gap: 32px;
  }

  .map-wrap {
    background: var(--sea);
    border: 1px solid var(--border);
    border-radius: var(--radius);
    position: relative;
    overflow: hidden;
    aspect-ratio: 1.85 / 1;
    box-shadow: var(--shadow);
    transition: background 0.4s ease;
  }

  #worldmap {
    width: 100%;
    height: 100%;
    display: block;
    position: relative;
    z-index: 1;
    cursor: grab;
  }

  #worldmap:active { cursor: grabbing; }

  .country {
    fill: var(--land);
    stroke: var(--land-border);
    stroke-width: 0.4;
    transition: fill 0.3s ease;
    cursor: pointer;
  }

  .country.europe-focus {
    fill: #1e293b;
    stroke: #334155;
    stroke-width: 0.6;
  }

  .country:hover { fill: var(--paper-dark); }

  .graticule {
    fill: none;
    stroke: var(--border);
    stroke-width: 0.3;
    opacity: 0.5;
  }

  .sphere {
    fill: var(--sea);
    stroke: var(--border);
    stroke-width: 0.8;
  }

  /* Tooltip */
  .country-tooltip {
    position: absolute;
    background: var(--paper-dark);
    color: var(--ink);
    padding: 12px 16px;
    font-family: 'Inter', sans-serif;
    font-size: 12px;
    border: 1px solid var(--border);
    border-radius: var(--radius);
    pointer-events: none;
    opacity: 0;
    transition: opacity 0.15s;
    z-index: 100;
    min-width: 200px;
    box-shadow: var(--shadow);
    backdrop-filter: blur(8px);
    -webkit-backdrop-filter: blur(8px);
  }

  .country-tooltip .flag-name {
    display: flex;
    align-items: center;
    gap: 8px;
    font-size: 15px;
    font-weight: 700;
    margin-bottom: 6px;
  }

  .country-tooltip .status-tag {
    font-family: 'JetBrains Mono', monospace;
    font-size: 9.5px;
    font-weight: 600;
    text-transform: uppercase;
    padding: 2px 6px;
    border-radius: 3px;
    display: inline-block;
    margin-bottom: 6px;
  }

  .country-tooltip .note-text {
    font-family: 'Cormorant Garamond', serif;
    font-style: italic;
    font-size: 13.5px;
    color: var(--ink-soft);
    line-height: 1.3;
  }

  /* Map controls and modes */
  .map-mode-toggle {
    position: absolute;
    top: 16px;
    left: 16px;
    display: flex;
    background: var(--panel-bg);
    backdrop-filter: blur(8px);
    -webkit-backdrop-filter: blur(8px);
    border: 1px solid var(--border);
    padding: 4px;
    border-radius: var(--radius);
    z-index: 5;
    box-shadow: var(--shadow);
  }

  .toggle-btn {
    font-family: 'JetBrains Mono', monospace;
    font-size: 10px;
    font-weight: 600;
    background: transparent;
    border: none;
    color: var(--ink-soft);
    padding: 6px 12px;
    cursor: pointer;
    border-radius: calc(var(--radius) - 2px);
    transition: all 0.2s ease;
  }

  .toggle-btn.active {
    background: var(--ink);
    color: var(--paper);
  }

  .map-controls {
    position: absolute;
    bottom: 16px;
    right: 16px;
    display: flex;
    flex-direction: column;
    gap: 4px;
    z-index: 5;
  }

  .map-btn {
    width: 36px;
    height: 36px;
    background: var(--panel-bg);
    backdrop-filter: blur(8px);
    -webkit-backdrop-filter: blur(8px);
    border: 1px solid var(--border);
    color: var(--ink);
    font-size: 18px;
    font-weight: 500;
    cursor: pointer;
    border-radius: var(--radius);
    display: flex;
    align-items: center;
    justify-content: center;
    transition: all 0.2s ease;
    box-shadow: var(--shadow);
  }

  .map-btn:hover {
    background: var(--ink);
    color: var(--paper);
    border-color: var(--ink);
  }

  .map-legend {
    position: absolute;
    bottom: 16px;
    left: 16px;
    background: var(--panel-bg);
    backdrop-filter: blur(8px);
    -webkit-backdrop-filter: blur(8px);
    border: 1px solid var(--border);
    border-radius: var(--radius);
    padding: 12px 16px;
    font-family: 'JetBrains Mono', monospace;
    font-size: 10px;
    line-height: 1.8;
    z-index: 4;
    box-shadow: var(--shadow);
  }

  .map-legend .title {
    font-weight: 600;
    letter-spacing: 0.1em;
    text-transform: uppercase;
    margin-bottom: 8px;
    color: var(--ink);
    border-bottom: 1px solid var(--border);
    padding-bottom: 4px;
  }

  .map-legend .item {
    display: flex;
    align-items: center;
    gap: 8px;
    color: var(--ink);
  }

  .map-legend .item .dot { width: 8px; height: 8px; border-radius: 50%; }

  .map-compass {
    position: absolute;
    top: 16px;
    right: 16px;
    font-family: 'Cormorant Garamond', serif;
    font-style: italic;
    font-size: 12px;
    font-weight: 600;
    color: var(--ink-soft);
    z-index: 4;
    text-align: center;
    background: var(--panel-bg);
    backdrop-filter: blur(8px);
    padding: 8px 12px;
    border: 1px solid var(--border);
    border-radius: var(--radius);
    box-shadow: var(--shadow);
  }

  .map-loading {
    position: absolute;
    inset: 0;
    display: flex;
    align-items: center;
    justify-content: center;
    font-family: 'Cormorant Garamond', serif;
    font-style: italic;
    font-size: 18px;
    color: var(--ink-soft);
    z-index: 20;
    background: var(--sea);
    transition: opacity 0.5s ease;
  }

  .map-loading.hidden { opacity: 0; pointer-events: none; }

  /* Premium Frosted Glass Panel */
  .panel {
    background: var(--panel-bg);
    backdrop-filter: blur(16px);
    -webkit-backdrop-filter: blur(16px);
    border: 1px solid var(--border);
    border-radius: var(--radius);
    padding: 0;
    position: sticky;
    top: 24px;
    max-height: calc(100vh - 48px);
    overflow-y: auto;
    box-shadow: var(--shadow);
    display: flex;
    flex-direction: column;
    transition: background 0.4s ease, border-color 0.4s ease;
  }

  .panel::-webkit-scrollbar { width: 6px; }
  .panel::-webkit-scrollbar-track { background: transparent; }
  .panel::-webkit-scrollbar-thumb { background: var(--border); border-radius: 3px; }

  /* Search styling */
  .search-wrapper {
    padding: 16px 24px;
    border-bottom: 1px solid var(--border);
    position: sticky;
    top: 0;
    background: var(--panel-bg);
    backdrop-filter: blur(8px);
    z-index: 8;
  }

  .search-container {
    position: relative;
    width: 100%;
  }

  .search-input {
    width: 100%;
    padding: 12px 16px 12px 40px;
    background: var(--card-bg);
    border: 1px solid var(--border);
    border-radius: var(--radius);
    color: var(--ink);
    font-family: 'Inter', sans-serif;
    font-size: 13px;
    transition: all 0.3s ease;
  }

  .search-input:focus {
    outline: none;
    border-color: var(--accent);
    box-shadow: 0 0 0 3px rgba(16, 185, 129, 0.15);
  }

  .search-icon {
    position: absolute;
    left: 14px;
    top: 50%;
    transform: translateY(-50%);
    color: var(--ink-soft);
    pointer-events: none;
    font-size: 14px;
  }

  .suggestions-list {
    position: absolute;
    top: 100%;
    left: 0;
    right: 0;
    background: var(--paper);
    border: 1px solid var(--border);
    border-radius: var(--radius);
    margin-top: 6px;
    max-height: 240px;
    overflow-y: auto;
    z-index: 100;
    list-style: none;
    box-shadow: var(--shadow);
    display: none;
  }

  .suggestions-list li {
    padding: 10px 16px;
    cursor: pointer;
    font-size: 12.5px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    border-bottom: 1px solid var(--border);
  }

  .suggestions-list li:last-child { border-bottom: none; }
  .suggestions-list li:hover { background: var(--card-bg); }
  .suggestions-list li .cat-badge {
    font-family: 'JetBrains Mono', monospace;
    font-size: 9px;
    padding: 2px 6px;
    border-radius: 3px;
  }

  /* Rankings Dashboard View */
  .rankings-view {
    padding: 20px 24px;
  }

  .rankings-header {
    margin-bottom: 16px;
  }

  .rankings-title {
    font-family: 'Cormorant Garamond', serif;
    font-size: 22px;
    font-weight: 600;
    margin-bottom: 6px;
  }

  .rankings-selector {
    display: flex;
    gap: 4px;
    background: var(--card-bg);
    padding: 4px;
    border-radius: var(--radius);
    border: 1px solid var(--border);
    margin-bottom: 16px;
  }

  .rank-btn {
    flex: 1;
    background: transparent;
    border: none;
    color: var(--ink-soft);
    font-family: 'JetBrains Mono', monospace;
    font-size: 9.5px;
    font-weight: 600;
    padding: 8px 4px;
    cursor: pointer;
    border-radius: calc(var(--radius) - 4px);
    transition: all 0.2s ease;
    text-align: center;
  }

  .rank-btn.active {
    background: var(--ink);
    color: var(--paper);
  }

  .rank-list {
    display: flex;
    flex-direction: column;
    gap: 12px;
  }

  .rank-item {
    background: var(--card-bg);
    border: 1px solid var(--border);
    border-radius: var(--radius);
    padding: 10px 14px;
    cursor: pointer;
    transition: all 0.2s ease;
  }

  .rank-item:hover {
    transform: translateX(4px);
    border-color: var(--accent);
  }

  .rank-item-meta {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 6px;
    font-size: 12px;
  }

  .rank-item-name {
    font-weight: 600;
    color: var(--ink);
  }

  .rank-item-val {
    font-family: 'JetBrains Mono', monospace;
    font-size: 11px;
    font-weight: 500;
    color: var(--accent);
  }

  .rank-bar-bg {
    width: 100%;
    height: 6px;
    background: var(--border);
    border-radius: 3px;
    overflow: hidden;
  }

  .rank-bar-fill {
    height: 100%;
    background: var(--accent);
    border-radius: 3px;
    transition: width 0.8s cubic-bezier(0.4, 0, 0.2, 1);
  }

  /* Territory Detail Card */
  .territory-detail {
    display: flex;
    flex-direction: column;
    animation: fadeIn 0.4s ease;
  }

  .detail-header-wrap {
    padding: 24px;
    border-bottom: 1px solid var(--border);
    position: relative;
    background: var(--card-bg);
  }

  .btn-back-rankings {
    background: transparent;
    border: none;
    color: var(--accent);
    font-family: 'JetBrains Mono', monospace;
    font-size: 11px;
    font-weight: 600;
    cursor: pointer;
    margin-bottom: 12px;
    display: flex;
    align-items: center;
    gap: 6px;
    padding: 4px 0;
    transition: color 0.2s;
  }

  .btn-back-rankings:hover {
    color: var(--accent-red);
  }

  .panel-cat {
    font-family: 'JetBrains Mono', monospace;
    font-size: 9.5px;
    font-weight: 600;
    letter-spacing: 0.15em;
    text-transform: uppercase;
    display: inline-flex;
    align-items: center;
    gap: 6px;
    padding: 4px 10px;
    border: 1px solid;
    border-radius: 4px;
    margin-bottom: 12px;
  }

  .panel-cat[data-cat="rec"] { color: var(--rec); border-color: var(--rec); }
  .panel-cat[data-cat="norec"] { color: var(--norec); border-color: var(--norec); }
  .panel-cat[data-cat="contested"] { color: var(--contested); border-color: var(--contested); }

  .panel h2 {
    font-family: 'Cormorant Garamond', serif;
    font-weight: 500;
    font-size: 30px;
    line-height: 1.1;
    letter-spacing: -0.01em;
  }

  .panel h2 em {
    display: block;
    font-style: italic;
    font-size: 16px;
    color: var(--ink-soft);
    font-weight: 400;
    margin-top: 4px;
  }

  /* 4 Tabs Menu */
  .panel-tabs {
    display: flex;
    background: var(--paper-dark);
    border-bottom: 1px solid var(--border);
    position: sticky;
    top: 68px; /* sits right under the search wrapper */
    z-index: 7;
  }

  .tab-btn {
    flex: 1;
    font-family: 'JetBrains Mono', monospace;
    font-size: 9.5px;
    font-weight: 600;
    padding: 12px 4px;
    border: none;
    background: transparent;
    color: var(--ink-soft);
    cursor: pointer;
    text-align: center;
    transition: all 0.2s ease;
    border-bottom: 2px solid transparent;
  }

  .tab-btn:hover {
    color: var(--ink);
    background: rgba(0,0,0,0.02);
  }

  .tab-btn.active {
    color: var(--accent);
    border-bottom-color: var(--accent);
    background: var(--panel-bg);
  }

  .tab-content-container {
    padding: 24px;
  }

  .tab-content {
    display: none;
    animation: tabFade 0.3s ease;
  }

  .tab-content.active {
    display: block;
  }

  @keyframes tabFade {
    from { opacity: 0; transform: translateY(4px); }
    to { opacity: 1; transform: translateY(0); }
  }

  /* Premium Banner in Tab 1 */
  .premium-banner {
    width: 100%;
    height: 80px;
    border-radius: var(--radius);
    margin-bottom: 20px;
    position: relative;
    overflow: hidden;
    display: flex;
    align-items: center;
    padding: 0 20px;
    box-shadow: inset 0 0 40px rgba(0,0,0,0.4);
  }

  /* Palestine flag styled banner background */
  .premium-banner::before {
    content: '';
    position: absolute;
    top: 0; left: 0; width: 100%; height: 33.3%;
    background: #000000;
    z-index: 1;
  }
  .premium-banner-mid {
    position: absolute;
    top: 33.3%; left: 0; width: 100%; height: 33.4%;
    background: #ffffff;
    z-index: 1;
  }
  .premium-banner-bottom {
    position: absolute;
    top: 66.7%; left: 0; width: 100%; height: 33.3%;
    background: #10b981;
    z-index: 1;
  }
  .premium-banner-triangle {
    position: absolute;
    top: 0; left: 0; width: 0; height: 0;
    border-top: 40px solid transparent;
    border-bottom: 40px solid transparent;
    border-left: 60px solid #ef4444;
    z-index: 2;
  }

  .premium-banner-text {
    position: relative;
    z-index: 3;
    font-family: 'Cormorant Garamond', serif;
    font-style: italic;
    font-size: 22px;
    font-weight: 600;
    color: #ffffff;
    text-shadow: 0 2px 6px rgba(0,0,0,0.8);
    width: 100%;
    text-align: center;
    letter-spacing: 0.05em;
  }

  .stat-grid {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 1px;
    background: var(--border);
    border: 1px solid var(--border);
    border-radius: var(--radius);
    overflow: hidden;
    margin-bottom: 20px;
  }

  .stat { background: var(--card-bg); padding: 12px 14px; }

  .stat .k {
    font-family: 'JetBrains Mono', monospace;
    font-size: 8.5px;
    letter-spacing: 0.1em;
    text-transform: uppercase;
    color: var(--ink-soft);
    margin-bottom: 4px;
  }

  .stat .v {
    font-family: 'Cormorant Garamond', serif;
    font-size: 18px;
    color: var(--ink);
    font-weight: 600;
    line-height: 1.2;
  }

  .panel-section { margin-bottom: 20px; }

  .panel-section h3 {
    font-family: 'JetBrains Mono', monospace;
    font-size: 10px;
    letter-spacing: 0.15em;
    text-transform: uppercase;
    color: var(--accent);
    margin-bottom: 8px;
    padding-bottom: 4px;
    border-bottom: 1px solid var(--border);
  }

  .panel-section p {
    font-family: 'Cormorant Garamond', serif;
    font-size: 16px;
    line-height: 1.5;
    color: var(--ink);
  }

  .alert-box {
    background: rgba(16, 185, 129, 0.08);
    border-left: 3px solid var(--accent);
    padding: 14px 16px;
    margin-bottom: 18px;
    border-radius: var(--radius);
  }
  .alert-box h3 {
    font-family: 'JetBrains Mono', monospace;
    font-size: 9.5px;
    letter-spacing: 0.2em;
    text-transform: uppercase;
    color: var(--accent);
    margin-bottom: 10px;
    border: none;
    padding: 0;
  }
  .alert-box p {
    font-family: 'Cormorant Garamond', serif;
    font-size: 14.5px;
    line-height: 1.4;
    color: var(--ink);
  }

  .badge-row { display: flex; flex-wrap: wrap; gap: 6px; margin-top: 12px; }

  .badge {
    font-family: 'JetBrains Mono', monospace;
    font-size: 9.5px;
    font-weight: 500;
    padding: 4px 8px;
    background: var(--border);
    color: var(--ink);
    border-radius: 4px;
  }

  .badge.rec { background: var(--rec); color: #000000; font-weight:600; }
  .badge.norec { background: var(--norec); color: #ffffff; }
  .badge.contested { background: var(--contested); color: #ffffff; }

  /* Panel Placeholders */
  .panel-placeholder {
    padding: 64px 32px;
    text-align: center;
    color: var(--ink-soft);
    font-family: 'Cormorant Garamond', serif;
    font-style: italic;
    font-size: 17px;
    line-height: 1.5;
  }

  .panel-placeholder .icon {
    font-size: 48px;
    color: var(--accent);
    margin-bottom: 16px;
    font-style: normal;
  }

  footer {
    max-width: 1600px;
    margin: 0 auto;
    padding: 32px 48px;
    border-top: 1px solid var(--border);
    font-family: 'Cormorant Garamond', serif;
    font-style: italic;
    font-size: 14px;
    color: var(--ink-soft);
    line-height: 1.5;
    display: grid;
    grid-template-columns: 2fr 1fr;
    gap: 48px;
  }

  footer .refs {
    font-family: 'JetBrains Mono', monospace;
    font-style: normal;
    font-size: 10px;
    line-height: 1.6;
  }

  footer .refs strong {
    color: var(--accent);
    display: block;
    margin-bottom: 8px;
    letter-spacing: 0.15em;
    text-transform: uppercase;
  }

  @media (max-width: 1100px) {
    main { grid-template-columns: 1fr; }
    .panel { position: relative; top: 0; max-height: none; }
    .legal-intro { grid-template-columns: 1fr; gap: 16px; }
    footer { grid-template-columns: 1fr; }
  }

  @media (max-width: 640px) {
    header, main, .legal-intro, .filters, footer {
      padding-left: 20px; padding-right: 20px;
    }
    .header-inner { flex-direction: column; align-items: flex-start; }
    .meta { text-align: left; }
    .meta .line { justify-content: flex-start; }
    .header-actions { width: 100%; justify-content: space-between; margin-top: 16px; }
  }

  .panel-enter { animation: fadeIn 0.4s ease; }
  @keyframes fadeIn {
    from { opacity: 0; transform: translateY(6px); }
    to { opacity: 1; transform: translateY(0); }
  }
</style>
</head>
<body class="light-theme">

<header>
  <div class="header-inner">
    <div class="brand">
      <span class="eyebrow">Uniunea Europeană · Relații Externe · Anul 2026</span>
      <h1>Recunoașterea <em>Palestinei</em> în Europa</h1>
      <p class="subtitle">O hartă juridică și interactivă a deciziilor de recunoaștere a Statului Palestina de către țările de pe continentul European, detaliind anul exact al recunoașterii, contextul diplomatic și poziția oficială post-UNGA 80.</p>
    </div>
    <div class="header-actions">
      <div class="meta">
        <div class="line"><span class="label">Proiecție</span><span>Europe Focus / Orthographic</span></div>
        <div class="line"><span class="label">Total Recunosc</span><span>30 State Europene</span></div>
        <div class="line"><span class="label">Nu recunosc</span><span>14 State</span></div>
        <div class="line" style="margin-top: 16px; justify-content: flex-end; border-top: 1px dashed var(--border); padding-top: 12px;">
          <span style="font-family: 'Cormorant Garamond', serif; font-style: italic; font-size: 18px; color: var(--accent); font-weight: 600; letter-spacing: -0.02em; line-height: 1.1;">— creat de Popa Bogdan</span>
        </div>
      </div>
      <button id="theme-toggle" class="theme-btn">🌙 Dark Mode</button>
    </div>
  </div>
</header>

<section class="legal-intro">
  <div class="label-col">Un peisaj diplomatic în plină transformare</div>
  <p>Harta recunoașterii Palestinei în Europa este împărțită istoric și politic. <strong>Valul din 1988</strong> reprezintă deciziile statelor din fostul bloc sovietic (inclusiv România), luate imediat după Declarația de Independență a Palestinei de la Alger. <strong>Valul recent (2024-2025)</strong> reflectă deciziile unor state vest-europene (Norvegia, Spania, Irlanda, Slovenia, urmate în toamna anului 2025 de Regatul Unit, Franța, Belgia și Portugalia) ca reacție la escaladarea conflictului din Orientul Mijlociu și în sprijinul soluției celor două state.</p>
</section>

<section class="filters">
  <span class="filter-label">Filtrează după poziție</span>
  <button class="chip active" data-filter="all">Toate statele</button>
  <button class="chip" data-filter="rec" data-cat="rec"><span class="dot"></span>Recunosc Palestina</button>
  <button class="chip" data-filter="norec" data-cat="norec"><span class="dot"></span>Nu recunosc</button>
  <button class="chip" data-filter="contested" data-cat="contested"><span class="dot"></span>Contestat / Înghețat</button>
</section>

<main>
  <div class="map-wrap">
    <div class="map-loading" id="loading">Se încarcă harta mondială…</div>
    
    <div class="map-mode-toggle">
      <button id="btn-2d" class="toggle-btn active">2D Proiecție</button>
      <button id="btn-3d" class="toggle-btn">3D Glob</button>
    </div>

    <div class="map-controls">
      <button id="zoom-in" class="map-btn" title="Apropie">+</button>
      <button id="zoom-out" class="map-btn" title="Depărtează">−</button>
      <button id="zoom-reset" class="map-btn" title="Resetează vizualizarea">⟲</button>
    </div>

    <svg id="worldmap" xmlns="http://www.w3.org/2000/svg"></svg>
    <div class="country-tooltip" id="tooltip"></div>

    <div class="map-legend">
      <div class="title">Legenda</div>
      <div class="item"><span class="dot" style="background: var(--rec)"></span>Recunosc</div>
      <div class="item"><span class="dot" style="background: var(--norec)"></span>Nu recunosc</div>
      <div class="item"><span class="dot" style="background: var(--contested)"></span>Recunoaștere contestată</div>
    </div>

    <div class="map-compass">↑<br>N</div>
  </div>

  <aside class="panel" id="panel">
    <div class="search-wrapper">
      <div class="search-container">
        <span class="search-icon">🔍</span>
        <input type="text" id="search-input" class="search-input" placeholder="Caută țară din Europa...">
        <ul id="search-suggestions" class="suggestions-list"></ul>
      </div>
    </div>
    
    <div id="panel-content">
      <div class="rankings-view">
        <div class="rankings-header">
          <h3 class="rankings-title">⚜ Cronologia Recunoașterii</h3>
          <p style="font-family:'Cormorant Garamond',serif;font-style:italic;font-size:14px;color:var(--ink-soft);line-height:1.3;margin-bottom:12px;">Vizualizează cronologia deciziilor istorice și recente. Țările care nu recunosc sunt ordonate alfabetic la final.</p>
        </div>
        <div class="rankings-selector">
          <button class="rank-btn active" data-metric="year">An Recunoaștere</button>
          <button class="rank-btn" data-metric="pop">Populație</button>
          <button class="rank-btn" data-metric="sup">Suprafață</button>
        </div>
        <div id="rank-list-container" class="rank-list">
          <!-- Dynamic ranked items will be rendered here by Javascript -->
        </div>
      </div>
    </div>
  </aside>
</main>

<footer>
  <div>
    Această hartă interactivă reprezintă un instrument juridic și documentar cu privire la recunoașterea internațională a Statului Palestina pe continentul European. Informațiile reflectă deciziile oficiale de politică externă publicate de guvernele respective și dezbaterile conexe.
  </div>
  <div class="refs">
    <strong>Surse diplomatice &amp; de presă</strong>
    UN General Assembly Resolution 43/177 (1988)<br>
    UNGA Resolution ES-10/23 (2024)<br>
    Deciziile oficiale guvernamentale (Spania, Norvegia, Irlanda, Slovenia — 2024)<br>
    Declarațiile comune de recunoaștere (Franța, UK, Belgia, Portugalia — sept. 2025)<br>
    Wikipedia "International recognition of the State of Palestine"<br><br>
    <strong>Date cartografice</strong>
    Natural Earth 110m · CC0 Public Domain<br><br>
    <strong>Dezvoltator</strong>
    <span style="font-family: 'Cormorant Garamond', serif; font-style: italic; font-size: 18px; color: var(--accent); font-weight: 600; display: block; margin-top: 4px; letter-spacing: -0.02em; line-height: 1.2;">— creat de Popa Bogdan</span>
  </div>
</footer>
'@

$htmlFooter = @'
<script>
// Datele complete ale celor 44 de State Europene (inclusiv detalii demografice si de recunoastere)
const teritorii = [
  {
    id: 'romania',
    nume: 'România',
    numeEn: 'Romania',
    categorie: 'rec',
    categorieLabel: 'Recunoaște Palestina',
    lat: 45.9432,
    lon: 24.9668,
    coords: [24.9668, 45.9432],
    capitala: 'București',
    populatie: '≈ 19 000 000 loc.',
    popVal: 19000000,
    suprafata: '238 397 km²',
    supVal: 238397,
    zee: '1988',
    zeeVal: 1988,
    note: 'Recunoaștere istorică la 24 noiembrie 1988 de către Republica Socialistă România, imediat după declarația de independență de la Alger. Relațiile diplomatice sunt menținute activ, existând Ambasada Palestinei la București și Reprezentanța României la Ramallah.',
    ue: 'Stat membru al Uniunii Europene (din 2007).',
    schengen: 'Membru al Spațiul Schengen (aerian/maritim din martie 2024).',
    moneda: 'Leu românesc (RON)',
    viza: {
      temei: 'Decizia MAE de menținere a continuității recunoașterii după 1989',
      regim: 'Relații diplomatice depline la nivel de Ambasadă',
      particular: 'România sprijină constant soluția celor două state și negocierile directe',
      observatie: 'Studenții palestinieni beneficiază istoric de burse de studii în România'
    },
    particularitati: 'Una dintre puținele țări din UE care recunosc oficial Palestina dar mențin în același timp relații strategice extrem de strânse cu Israel.',
    badges: ['Recunoaște (1988)', 'Membru UE', 'Ambasadă completă']
  },
  {
    id: 'norway',
    nume: 'Norvegia',
    numeEn: 'Norway',
    categorie: 'rec',
    categorieLabel: 'Recunoaște Palestina',
    lat: 60.472,
    lon: 8.4689,
    coords: [8.4689, 60.472],
    capitala: 'Oslo',
    populatie: '≈ 5 400 000 loc.',
    popVal: 5400000,
    suprafata: '385 207 km²',
    supVal: 385207,
    zee: '2024',
    zeeVal: 2024,
    note: 'Norvegia a anunțat recunoașterea oficială a Palestinei ca stat la 22 mai 2024, decizia intrând în vigoare la 28 mai 2024. Inițiativa a fost coordonată strâns cu Spania și Irlanda ca un semnal puternic în sprijinul păcii durabile în regiune.',
    ue: 'Nu este membră UE, dar face parte din Spațiul Economic European (SEE).',
    schengen: 'Membru deplin al Spațiului Schengen.',
    moneda: 'Coroană norvegiană (NOK)',
    viza: {
      temei: 'Declarația comună a Guvernului condus de Jonas Gahr Støre (mai 2024)',
      regim: 'Relații diplomatice oficiale active',
      particular: 'Norvegia a găzduit istoric Acordurile de la Oslo din 1993',
      observatie: 'Decizia a generat tensiuni diplomatice severe temporare cu guvernul israelian'
    },
    particularitati: 'Poziția istorică de mediator (Acordurile Oslo 1993) oferă recunoașterii norvegiene o pondere simbolică excepțională.',
    badges: ['Recunoaște (2024)', 'Non-UE', 'Schengen']
  },
  {
    id: 'spain',
    nume: 'Spania',
    numeEn: 'Spain',
    categorie: 'rec',
    categorieLabel: 'Recunoaște Palestina',
    lat: 40.4637,
    lon: -3.7492,
    coords: [-3.7492, 40.4637],
    capitala: 'Madrid',
    populatie: '≈ 47 400 000 loc.',
    popVal: 47400000,
    suprafata: '505 990 km²',
    supVal: 505990,
    zee: '2024',
    zeeVal: 2024,
    note: 'Spania a recunoscut oficial Statul Palestina la 28 mai 2024, sub conducerea premierului Pedro Sánchez. Decizia a fost descrisă ca o necesitate istorică pentru obținerea păcii și implementarea rezoluțiilor ONU.',
    ue: 'Stat membru al Uniunii Europene (din 1986).',
    schengen: 'Membru al Spațiului Schengen.',
    moneda: 'Euro (EUR)',
    viza: {
      temei: 'Hotărârea Consiliului de Miniștri al Spaniei (mai 2024)',
      regim: 'Recunoaștere oficială deplină ca stat suveran',
      particular: 'Spania pledează activ pentru organizarea unei conferințe internaționale de pace',
      observatie: 'Pedro Sánchez a călătorit personal în regiune pentru a susține decizia'
    },
    particularitati: 'Promotorul principal din Europa de Vest al recunoașterii, asumându-și un rol de lider diplomatic în UE.',
    badges: ['Recunoaște (2024)', 'Membru UE', 'Schengen']
  },
  {
    id: 'ireland',
    nume: 'Irlanda',
    numeEn: 'Ireland',
    categorie: 'rec',
    categorieLabel: 'Recunoaște Palestina',
    lat: 53.4129,
    lon: -8.2439,
    coords: [-8.2439, 53.4129],
    capitala: 'Dublin',
    populatie: '≈ 5 000 000 loc.',
    popVal: 5000000,
    suprafata: '70 273 km²',
    supVal: 70273,
    zee: '2024',
    zeeVal: 2024,
    note: 'Irlanda a recunoscut oficial Palestina la 28 mai 2024. Premierul Simon Harris a subliniat că poporul irlandez empatizează istoric profund cu lupta pentru autodeterminare și recunoaștere statală.',
    ue: 'Stat membru al Uniunii Europene (din 1973).',
    schengen: 'Nu face parte din Schengen (menține Common Travel Area cu UK).',
    moneda: 'Euro (EUR)',
    viza: {
      temei: 'Decizia Guvernului Irlandez (mai 2024)',
      regim: 'Relații diplomatice oficiale depline',
      particular: 'Sprijin public masiv din partea societății civile irlandeze',
      observatie: 'Irlanda a fost printre primele țări vest-europene care au cerut constant un stat palestinian'
    },
    particularitati: 'Sensibilitatea istorică față de ocupație și colonizare face din Irlanda cel mai vocal susținător al cauzei palestiniene din Europa de Vest.',
    badges: ['Recunoaște (2024)', 'Membru UE', 'Non-Schengen']
  },
  {
    id: 'sweden',
    nume: 'Suedia',
    numeEn: 'Sweden',
    categorie: 'rec',
    categorieLabel: 'Recunoaște Palestina',
    lat: 60.1282,
    lon: 18.6435,
    coords: [18.6435, 60.1282],
    capitala: 'Stockholm',
    populatie: '≈ 10 400 000 loc.',
    popVal: 10400000,
    suprafata: '450 295 km²',
    supVal: 450295,
    zee: '2014',
    zeeVal: 2014,
    note: 'Suedia a devenit prima țară membră a Uniunii Europene (care a aderat după recunoaștere) care a recunoscut oficial Palestina la 30 octombrie 2014, sub guvernul social-democrat condus de Stefan Löfven.',
    ue: 'Stat membru al Uniunii Europene (din 1995).',
    schengen: 'Membru al Spațiului Schengen.',
    moneda: 'Coroană suedeză (SEK)',
    viza: {
      temei: 'Decret oficial al Guvernului Suedez (octombrie 2014)',
      regim: 'Ambasadă deplină la Stockholm și Consulat general la Ierusalim',
      particular: 'Decizia a provocat înghețarea temporară a relațiilor diplomatice cu Israel în 2014',
      observatie: 'Statutul a fost menținut în ciuda schimbărilor ulterioare de guvern'
    },
    particularitati: 'Decizia din 2014 a spart gheața diplomatică în cadrul UE, deși a fost intens criticată de aliații occidentali la acea vreme.',
    badges: ['Recunoaște (2014)', 'Membru UE', 'Schengen']
  },
  {
    id: 'united kingdom',
    nume: 'Regatul Unit',
    numeEn: 'United Kingdom',
    categorie: 'rec',
    categorieLabel: 'Recunoaște Palestina',
    lat: 55.3781,
    lon: -3.436,
    coords: [-3.436, 55.3781],
    capitala: 'Londra',
    populatie: '≈ 67 000 000 loc.',
    popVal: 67000000,
    suprafata: '243 610 km²',
    supVal: 243610,
    zee: '2025',
    zeeVal: 2025,
    note: 'Regatul Unit a recunoscut oficial Statul Palestina în septembrie 2025, o decizie istorică luată în timpul sesiunii UNGA 80 de către cabinetul condus de Partidul Laburist, abandonând poziția anterioară de recunoaștere doar ca rezultat al unui acord direct.',
    ue: 'Fost membru UE (Brexited în 2020).',
    schengen: 'Nu este membru Schengen.',
    moneda: 'Liră sterlină (GBP)',
    viza: {
      temei: 'Declarația oficială de politică externă a Guvernului Majestății Sale (septembrie 2025)',
      regim: 'Relații diplomatice depline, ridicarea misiunii palestiniene la statut de ambasadă',
      particular: 'Decizie de cotitură istorică având în vedere responsabilitatea istorică a Mandatului Britanic (Declarația Balfour 1917)',
      observatie: 'Anunț corelat și sprijinit de Franța în cadrul UNGA 80'
    },
    particularitati: 'O schimbare seismică în geopolitica mondială, având în vedere statutul UK de membru permanent al Consiliului de Securitate al ONU.',
    badges: ['Recunoaște (2025)', 'Membru Permanent Consiliu Securitate', 'Balfour Legacy']
  },
  {
    id: 'france',
    nume: 'Franța',
    numeEn: 'France',
    categorie: 'rec',
    categorieLabel: 'Recunoaște Palestina',
    lat: 46.2276,
    lon: 2.2137,
    coords: [2.2137, 46.2276],
    capitala: 'Paris',
    populatie: '≈ 68 000 000 loc.',
    popVal: 68000000,
    suprafata: '551 695 km²',
    supVal: 551695,
    zee: '2025',
    zeeVal: 2025,
    note: 'Franța a recunoscut oficial Statul Palestina în septembrie 2025. Președintele Emmanuel Macron a anunțat decizia istorică la Adunarea Generală a ONU (UNGA 80), precizând că Franța consideră că blocajul din regiune face imposibilă soluția celor două state fără acest act suveran.',
    ue: 'Stat membru al Uniunii Europene (fondator).',
    schengen: 'Membru al Spațiului Schengen.',
    moneda: 'Euro (EUR)',
    viza: {
      temei: 'Declarația solemnă a Președintelui Republicii Franceze la UNGA 80 (septembrie 2025)',
      regim: 'Relații diplomatice oficiale depline la nivel de Ambasador',
      particular: 'Franța menține o rețea culturală și consulară istorică în Ierusalimul de Est',
      observatie: 'A marcat o aliniere strategică deosebită cu Regatul Unit în toamna anului 2025'
    },
    particularitati: 'A doua mare putere nucleară din Europa și membru permanent al CS al ONU care recunoaște Palestina.',
    badges: ['Recunoaște (2025)', 'Membru UE', 'Schengen']
  },
  {
    id: 'belgium',
    nume: 'Belgia',
    numeEn: 'Belgium',
    categorie: 'rec',
    categorieLabel: 'Recunoaște Palestina',
    lat: 50.8503,
    lon: 4.3517,
    coords: [4.3517, 50.8503],
    capitala: 'Bruxelles',
    populatie: '≈ 11 600 000 loc.',
    popVal: 11600000,
    suprafata: '30 689 km²',
    supVal: 30689,
    zee: '2025',
    zeeVal: 2025,
    note: 'Belgia a recunoscut oficial Palestina în septembrie 2025, ca parte a unui val coordonat vest-european la ONU. Parlamentul belgian aprobase rezoluții favorabile încă din anii anteriori, condiționate însă de contextul politic.',
    ue: 'Stat membru al Uniunii Europene (fondator).',
    schengen: 'Membru al Spațiului Schengen.',
    moneda: 'Euro (EUR)',
    viza: {
      temei: 'Decizia Guvernului Federal Belgian (septembrie 2025)',
      regim: 'Relații diplomatice oficiale depline',
      particular: 'Bruxelles găzduiește instituțiile UE, oferind deciziei un impact simbolic adițional',
      observatie: 'Sprijin masiv din partea regiunilor Valonia și Flandra'
    },
    particularitati: 'Capitala simbolică a Europei recunoaște acum oficial ambele state din conflict.',
    badges: ['Recunoaște (2025)', 'Membru UE', 'Schengen']
  },
  {
    id: 'portugal',
    nume: 'Portugalia',
    numeEn: 'Portugal',
    categorie: 'rec',
    categorieLabel: 'Recunoaște Palestina',
    lat: 39.3999,
    lon: -8.2245,
    coords: [-8.2245, 39.3999],
    capitala: 'Lisabona',
    populatie: '≈ 10 300 000 loc.',
    popVal: 10300000,
    suprafata: '92 090 km²',
    supVal: 92090,
    zee: '2025',
    zeeVal: 2025,
    note: 'Portugalia s-a alăturat valului istoric din septembrie 2025, recunoscând oficial Statul Palestina în marja Adunării Generale a ONU. Decizia a urmat recomandărilor repetate ale Parlamentului portughez.',
    ue: 'Stat membru al Uniunii Europene (din 1986).',
    schengen: 'Membru al Spațiului Schengen.',
    moneda: 'Euro (EUR)',
    viza: {
      temei: 'Decret-Lege al Guvernului Republicii Portugheze (septembrie 2025)',
      regim: 'Stabilirea de relații diplomatice formale',
      particular: 'Aliniere deplină cu poziția Spaniei, vecina sa iberică',
      observatie: 'Consens politic larg între principalele partide de stânga și centru-dreapta'
    },
    particularitati: 'Finalizează reprezentarea completă a Peninsulei Iberice în tabăra țărilor care recunosc Palestina.',
    badges: ['Recunoaște (2025)', 'Membru UE', 'Schengen']
  },
  {
    id: 'poland',
    nume: 'Polonia',
    numeEn: 'Poland',
    categorie: 'rec',
    categorieLabel: 'Recunoaște Palestina',
    lat: 51.9194,
    lon: 19.1451,
    coords: [19.1451, 51.9194],
    capitala: 'Varșovia',
    populatie: '≈ 38 000 000 loc.',
    popVal: 38000000,
    suprafata: '312 696 km²',
    supVal: 312696,
    zee: '1988',
    zeeVal: 1988,
    note: 'Polonia a recunoscut Palestina la 14 decembrie 1988 ca stat suveran în perioada regimului comunist (Republica Populară Polonă). Misiunea diplomatică a Palestinei la Varșovia a fost deschisă imediat după.',
    ue: 'Stat membru al Uniunii Europene (din 2004).',
    schengen: 'Membru al Spațiului Schengen.',
    moneda: 'Zlot polonez (PLN)',
    viza: {
      temei: 'Declarația formală a Guvernului Polonez din decembrie 1988',
      regim: 'Relații diplomatice bilaterale depline',
      particular: 'Polonia a menținut recunoașterea și după tranziția democratică din 1989',
      observatie: 'Menține un dialog activ cu ambele părți ale conflictului'
    },
    particularitati: 'Una dintre cele mai mari țări din flancul estic al UE care menține recunoașterea oficială din perioada Războiului Rece.',
    badges: ['Recunoaște (1988)', 'Membru UE', 'Schengen']
  },
  {
    id: 'bulgaria',
    nume: 'Bulgaria',
    numeEn: 'Bulgaria',
    categorie: 'rec',
    categorieLabel: 'Recunoaște Palestina',
    lat: 42.7339,
    lon: 25.4858,
    coords: [25.4858, 42.7339],
    capitala: 'Sofia',
    populatie: '≈ 6 900 000 loc.',
    popVal: 6900000,
    suprafata: '110 994 km²',
    supVal: 110994,
    zee: '1988',
    zeeVal: 1988,
    note: 'Bulgaria a recunoscut oficial Statul Palestina la 25 noiembrie 1988. Relațiile diplomatice formale au fost stabilire în decembrie 1988 la nivel de ambasadă.',
    ue: 'Stat membru al Uniunii Europene (din 2007).',
    schengen: 'Membru al Spațiului Schengen (aerian/maritim din martie 2024).',
    moneda: 'Leva bulgărească (BGN)',
    viza: {
      temei: 'Decizia Consiliului de Stat al Republicii Populare Bulgaria (noiembrie 1988)',
      regim: 'Ambasadă palestiniană deschisă la Sofia',
      particular: 'Bulgaria sprijină rezoluțiile ONU privind pacea în Orientul Mijlociu',
      observatie: 'Schimburi comerciale și educaționale istorice în perioada 1988-1990'
    },
    particularitati: 'Urmează linia diplomatică stabilită de țările din Pactul de la Varșovia în 1988.',
    badges: ['Recunoaște (1988)', 'Membru UE', 'Schengen']
  },
  {
    id: 'slovakia',
    nume: 'Slovacia',
    numeEn: 'Slovakia',
    categorie: 'rec',
    categorieLabel: 'Recunoaște Palestina',
    lat: 48.669,
    lon: 19.699,
    coords: [19.699, 48.669],
    capitala: 'Bratislava',
    populatie: '≈ 5 400 000 loc.',
    popVal: 5400000,
    suprafata: '49 035 km²',
    supVal: 49035,
    zee: '1988',
    zeeVal: 1988,
    note: 'Slovacia a moștenit statutul de recunoaștere oficială de la fosta Cehoslovacie, care a recunoscut Palestina la 18 noiembrie 1988. La dizolvarea pașnică a federației în 1993, Slovacia a ales să continue relațiile depline.',
    ue: 'Stat membru al Uniunii Europene (din 2004).',
    schengen: 'Membru al Spațiului Schengen.',
    moneda: 'Euro (EUR)',
    viza: {
      temei: 'Declarația de succesiune a tratatelor internaționale din 1 ianuarie 1993',
      regim: 'Relații diplomatice oficiale depline la nivel de Ambasadă',
      particular: 'Slovacia are o poziție nuanțată, diferită de cea a Cehiei vecine',
      observatie: 'Ambasada Palestinei este activă în Bratislava'
    },
    particularitati: 'Spre deosebire de Cehia care contestă recunoașterea din 1988, Slovacia a menținut un caracter diplomatic neutru-pozitiv.',
    badges: ['Recunoaște (1988)', 'Membru UE', 'Schengen']
  },
  {
    id: 'ukraine',
    nume: 'Ucraina',
    numeEn: 'Ukraine',
    categorie: 'rec',
    categorieLabel: 'Recunoaște Palestina',
    lat: 48.3794,
    lon: 31.1656,
    coords: [31.1656, 48.3794],
    capitala: 'Kiev',
    populatie: '≈ 41 000 000 loc.',
    popVal: 41000000,
    suprafata: '603 628 km²',
    supVal: 603628,
    zee: '1988',
    zeeVal: 1988,
    note: 'Ucraina (ca RSS Ucraineană în cadrul URSS) a votat și a recunoscut oficial independența Palestinei la 19 noiembrie 1988. După declararea independenței în 1991, statul ucrainean a reconfirmat statutul diplomatic.',
    ue: 'Stat candidat la aderarea în Uniunea Europeană.',
    schengen: 'Nu face parte din Schengen.',
    moneda: 'Hrivnă ucraineană (UAH)',
    viza: {
      temei: 'Decizia Parlamentului Ucrainean (Rada Supremă) din 1991',
      regim: 'Misiune diplomatică activă la Kiev',
      particular: 'Relațiile au continuat activ inclusiv în timpul conflictelor geopolitice din flancul estic',
      observatie: 'Ucraina pledează pentru respectarea dreptului internațional în ambele cazuri'
    },
    particularitati: 'O poziție complexă, fiind un partener strategic major al SUA și având relații diplomatice solide cu ambele state.',
    badges: ['Recunoaște (1988)', 'Candidat UE', 'Flancul Estic']
  },
  {
    id: 'belarus',
    nume: 'Belarus',
    numeEn: 'Belarus',
    categorie: 'rec',
    categorieLabel: 'Recunoaște Palestina',
    lat: 53.7098,
    lon: 27.9534,
    coords: [27.9534, 53.7098],
    capitala: 'Minsk',
    populatie: '≈ 9 400 000 loc.',
    popVal: 9400000,
    suprafata: '207 600 km²',
    supVal: 207600,
    zee: '1988',
    zeeVal: 1988,
    note: 'Belarus (ca RSS Bielorusă) a recunoscut Palestina în noiembrie 1988. Relațiile diplomatice depline au fost menținute fără întrerupere după dizolvarea URSS în 1991.',
    ue: 'Nu este membru UE și nu este candidat.',
    schengen: 'Nu face parte din Schengen.',
    moneda: 'Rublă belarusă (BYN)',
    viza: {
      temei: 'Succesiunea acordurilor sovietice în 1991',
      regim: 'Ambasadă funcțională la Minsk',
      particular: 'Belarus are o poziție fermă pro-palestiniană pe scena internațională',
      observatie: 'Vizite guvernamentale bilaterale periodice'
    },
    particularitati: 'Aliniere totală cu linia istorică a Moscovei în ceea ce privește geopolitica Orientului Mijlociu.',
    badges: ['Recunoaște (1988)', 'Non-UE', 'Minsk Group']
  },
  {
    id: 'slovenia',
    nume: 'Slovenia',
    numeEn: 'Slovenia',
    categorie: 'rec',
    categorieLabel: 'Recunoaște Palestina',
    lat: 46.1512,
    lon: 14.9955,
    coords: [14.9955, 46.1512],
    capitala: 'Ljubljana',
    populatie: '≈ 2 100 000 loc.',
    popVal: 2100000,
    suprafata: '20 273 km²',
    supVal: 20273,
    zee: '2024',
    zeeVal: 2024,
    note: 'Slovenia a recunoscut oficial Statul Palestina la 4 iunie 2024, după ce Parlamentul de la Ljubljana a votat cu o majoritate covârșitoare propunerea înaintată de premierul Robert Golob, ca reacție la criza umanitară din Gaza.',
    ue: 'Stat membru al Uniunii Europene (din 2004).',
    schengen: 'Membru al Spațiului Schengen.',
    moneda: 'Euro (EUR)',
    viza: {
      temei: 'Votul oficial al Parlamentului Sloven (iunie 2024)',
      regim: 'Relații diplomatice formale depline ca stat suveran',
      particular: 'Procedura a fost accelerată pentru a se corela cu inițiativa spaniolo-irlandeză',
      observatie: 'Opoziția de dreapta a încercat suspendarea votului, fără succes'
    },
    particularitati: 'Prima țară din fosta Iugoslavie (care a aderat ulterior la UE) care a realizat acest pas diplomatic formal după dizolvarea federației.',
    badges: ['Recunoaște (2024)', 'Membru UE', 'Schengen']
  },
  {
    id: 'iceland',
    nume: 'Islanda',
    numeEn: 'Iceland',
    categorie: 'rec',
    categorieLabel: 'Recunoaște Palestina',
    lat: 64.9631,
    lon: -19.0208,
    coords: [-19.0208, 64.9631],
    capitala: 'Reykjavík',
    populatie: '≈ 370 000 loc.',
    popVal: 370000,
    suprafata: '103 000 km²',
    supVal: 103000,
    zee: '2011',
    zeeVal: 2011,
    note: 'Islanda a recunoscut oficial Palestina ca stat suveran și independent la 29 noiembrie 2011, în urma unei rezoluții aprobate în unanimitate de Parlamentul de la Reykjavík (Althing), fiind primul stat pur vest-european care a făcut acest pas.',
    ue: 'Nu este membru UE.',
    schengen: 'Membru al Spațiului Schengen (prin acorduri asociate).',
    moneda: 'Coroană islandeză (ISK)',
    viza: {
      temei: 'Rezoluția oficială a Parlamentului Islandez (noiembrie 2011)',
      regim: 'Relații diplomatice formale active',
      particular: 'Votul istoric a coincis cu Ziua Internațională de Solidaritate cu Poporul Palestinian',
      observatie: 'Islanda a susținut constant statutul de membru observator al Palestinei la ONU'
    },
    particularitati: 'Decizia istorică din 2011 a reconfirmat politica externă profund independentă a Islandei.',
    badges: ['Recunoaște (2011)', 'Non-UE', 'Schengen']
  },
  {
    id: 'cyprus',
    nume: 'Cipru',
    numeEn: 'Cyprus',
    categorie: 'rec',
    categorieLabel: 'Recunoaște Palestina',
    lat: 35.1264,
    lon: 33.4299,
    coords: [33.4299, 35.1264],
    capitala: 'Nicosia',
    populatie: '≈ 1 200 000 loc.',
    popVal: 1200000,
    suprafata: '9 251 km²',
    supVal: 9251,
    zee: '1988',
    zeeVal: 1988,
    note: 'Cipru a recunoscut Palestina în noiembrie 1988. În ciuda relațiilor extrem de apropiate geopolitic din prezent cu Israelul, Cipru continuă să mențină în mod oficial recunoașterea și Ambasada Palestinei la Nicosia.',
    ue: 'Stat membru al Uniunii Europene (din 2004).',
    schengen: 'Nu face parte din Schengen.',
    moneda: 'Euro (EUR)',
    viza: {
      temei: 'Decizia oficială a Președintelui cipriot George Vassiliou (noiembrie 1988)',
      regim: 'Reprezentare diplomatică reciprocă completă',
      particular: 'Cipru a reconfirmat poziția istorică în 2011, precizând că nu va reveni asupra deciziei',
      observatie: 'Oportunități educaționale de lungă durată oferite studenților palestinieni'
    },
    particularitati: 'O poziție de echilibru delicat în Mediterana de Est, împărțit între legăturile istorice cu lumea arabă și parteneriatul energetic modern cu Israel.',
    badges: ['Recunoaște (1988)', 'Membru UE', 'Poziție Delicată']
  },
  {
    id: 'albania',
    nume: 'Albania',
    numeEn: 'Albania',
    categorie: 'rec',
    categorieLabel: 'Recunoaște Palestina',
    lat: 41.1533,
    lon: 20.1683,
    coords: [20.1683, 41.1533],
    capitala: 'Tirana',
    populatie: '≈ 2 800 000 loc.',
    popVal: 2800000,
    suprafata: '28 748 km²',
    supVal: 28748,
    zee: '1988',
    zeeVal: 1988,
    note: 'Albania a recunoscut Statul Palestina la 17 noiembrie 1988, în timpul regimului socialist. Relațiile diplomatice au fost păstrate neîntrerupt, existând Ambasada Palestinei la Tirana.',
    ue: 'Stat candidat la aderarea în Uniunea Europeană.',
    schengen: 'Nu face parte din Schengen.',
    moneda: 'Lek albanez (ALL)',
    viza: {
      temei: 'Declarația oficială a Guvernului Socialist al Albaniei (noiembrie 1988)',
      regim: 'Relații diplomatice bilaterale funcționale',
      particular: 'Albania sprijină constant soluția pacii durabile bazată pe cele două state',
      observatie: 'Schimburi diplomatice periodice constructive'
    },
    particularitati: 'Are un profil unic în Balcanii de Vest, având o populație majoritar musulmană dar și relații politice solide cu SUA.',
    badges: ['Recunoaște (1988)', 'Candidat UE', 'Balcani']
  },
  {
    id: 'serbia',
    nume: 'Serbia',
    numeEn: 'Serbia',
    categorie: 'rec',
    categorieLabel: 'Recunoaște Palestina',
    lat: 44.0165,
    lon: 21.0059,
    coords: [21.0059, 44.0165],
    capitala: 'Belgrad',
    populatie: '≈ 6 800 000 loc.',
    popVal: 6800000,
    suprafata: '88 361 km²',
    supVal: 88361,
    zee: '1988',
    zeeVal: 1988,
    note: 'Serbia a moștenit recunoașterea oficială de la fosta Iugoslavie (SFRJ), care a recunoscut Palestina la 16 noiembrie 1988. Iugoslavia a fost un lider istoric al Mișcării de Non-Aliniere, oferind sprijin diplomatic masiv PLO.',
    ue: 'Stat candidat la aderarea în Uniunea Europeană.',
    schengen: 'Nu face parte din Schengen.',
    moneda: 'Dinar sârbesc (RSD)',
    viza: {
      temei: 'Succesiunea directă a tratatelor diplomatice ale SFR Iugoslavia',
      regim: 'Ambasada Palestinei deschisă activ la Belgrad',
      particular: 'Serbia sprijină Palestina, iar la rândul său, Palestina nu recunoaște independența Kosovo',
      observatie: 'Relații de sprijin diplomatic reciproc extrem de solide'
    },
    particularitati: 'Sprijinul sârbesc este consolidat de faptul că Autoritatea Palestiniană refuză strict recunoașterea Kosovo, susținând integritatea teritorială a Serbiei.',
    badges: ['Recunoaște (1988)', 'Candidat UE', 'Kosovo Issue']
  },
  {
    id: 'bosnia and herz.',
    nume: 'Bosnia-Herț.',
    numeEn: 'Bosnia and Herzegovina',
    categorie: 'rec',
    categorieLabel: 'Recunoaște Palestina',
    lat: 43.9159,
    lon: 17.6791,
    coords: [17.6791, 43.9159],
    capitala: 'Sarajevo',
    populatie: '≈ 3 200 000 loc.',
    popVal: 3200000,
    suprafata: '51 129 km²',
    supVal: 51129,
    zee: '1992',
    zeeVal: 1992,
    note: 'Bosnia și Herțegovina a recunoscut oficial Palestina la 27 mai 1992, imediat după declararea propriei sale independențe în timpul destrămării Iugoslaviei, continuând linia istorică stabilită de Belgrad.',
    ue: 'Stat candidat la aderarea în Uniunea Europeană.',
    schengen: 'Nu face parte din Schengen.',
    moneda: 'Marcă convertibilă (BAM)',
    viza: {
      temei: 'Decretul Președinției colective a Bosniei din mai 1992',
      regim: 'Relații de reprezentare diplomatică',
      particular: 'Consens fragil local din cauza structurii etnice complexe a țării',
      observatie: 'Misiunea palestiniană este coordonată activ la Sarajevo'
    },
    particularitati: 'Deși structura etnică internă tripartită generează uneori tensiuni de politică externă, recunoașterea oficială a fost menținută stabilă.',
    badges: ['Recunoaște (1992)', 'Candidat UE', 'Balcani']
  },
  {
    id: 'macedonia',
    nume: 'Macedonia de Nord',
    numeEn: 'North Macedonia',
    categorie: 'rec',
    categorieLabel: 'Recunoaște Palestina',
    lat: 41.6086,
    lon: 21.7453,
    coords: [21.7453, 41.6086],
    capitala: 'Skopje',
    populatie: '≈ 2 000 000 loc.',
    popVal: 2000000,
    suprafata: '25 713 km²',
    supVal: 25713,
    zee: '1990',
    zeeVal: 1990,
    note: 'Macedonia de Nord a recunoscut Palestina în anul 1990, ca parte a procesului de succesiune iugoslav, consolidând ulterior relațiile formale diplomatice.',
    ue: 'Stat candidat la aderarea în Uniunea Europeană.',
    schengen: 'Nu face parte din Schengen.',
    moneda: 'Denar macedonean (MKD)',
    viza: {
      temei: 'Deciziile bilaterale formale post-independență',
      regim: 'Relații de sprijin diplomatic',
      particular: 'Skopje urmează în mare parte linia de politică externă a UE și SUA',
      observatie: 'Poziție diplomatică relativ discretă dar stabilă'
    },
    particularitati: 'Menține o poziție constructivă, aliniată cu tratatele internaționale ale dreptului umanitar.',
    badges: ['Recunoaște (1990)', 'Candidat UE', 'Balcani']
  },
  {
    id: 'montenegro',
    nume: 'Muntenegru',
    numeEn: 'Montenegro',
    categorie: 'rec',
    categorieLabel: 'Recunoaște Palestina',
    lat: 42.7087,
    lon: 19.3744,
    coords: [19.3744, 42.7087],
    capitala: 'Podgorica',
    populatie: '≈ 620 000 loc.',
    popVal: 620000,
    suprafata: '13 812 km²',
    supVal: 13812,
    zee: '2006',
    zeeVal: 2006,
    note: 'Muntenegru a recunoscut Palestina în mod oficial în anul 2006, la scurt timp după obținerea independenței sale prin dizolvarea uniunii statale cu Serbia.',
    ue: 'Stat candidat avansat la aderarea în Uniunea Europeană.',
    schengen: 'Nu face parte din Schengen.',
    moneda: 'Euro (EUR) — utilizat de facto',
    viza: {
      temei: 'Declarația oficială de politică externă din anul 2006',
      regim: 'Relații diplomatice formale',
      particular: 'Coordonare strânsă cu pozițiile europene',
      observatie: 'Muntenegru sprijină activ eforturile internaționale pentru pace'
    },
    particularitati: 'Una dintre cele mai rapide integrări a recunoașterii succesorale după declararea independenței în Balcani.',
    badges: ['Recunoaște (2006)', 'Candidat UE', 'Eurozone']
  },
  {
    id: 'germany',
    nume: 'Germania',
    numeEn: 'Germany',
    categorie: 'norec',
    categorieLabel: 'Nu recunoaște',
    lat: 51.1657,
    lon: 10.4515,
    coords: [10.4515, 51.1657],
    capitala: 'Berlin',
    populatie: '≈ 83 200 000 loc.',
    popVal: 83200000,
    suprafata: '357 022 km²',
    supVal: 357022,
    zee: '—',
    zeeVal: 9999,
    note: 'Germania nu recunoaște oficial Palestina ca stat, susținând ferm că statutul statalitate poate fi obținut exclusiv în urma unor negocieri directe finalizate între Israel și Autoritatea Palestiniană.',
    ue: 'Stat membru al Uniunii Europene (fondator).',
    schengen: 'Membru al Spațiului Schengen.',
    moneda: 'Euro (EUR)',
    viza: {
      temei: 'Linia oficială a Ministerului Federal al Afacerilor Externe (Auswärtiges Amt)',
      regim: 'Fără recunoaștere formală, însă menține Reprezentanța Germaniei la Ramallah',
      particular: 'Germania este unul dintre cei mai mari donatori de ajutor umanitar și dezvoltare pentru teritoriile palestiniene',
      observatie: 'Responsabilitatea istorică față de securitatea statului Israel este considerată rațiune de stat (Staatsräson)'
    },
    particularitati: 'Poziție extrem de fermă, influențată profund de factori istorici sensibili post-WWII.',
    badges: ['Nu recunoaște', 'Membru UE', 'Schengen']
  },
  {
    id: 'italy',
    nume: 'Italia',
    numeEn: 'Italy',
    categorie: 'norec',
    categorieLabel: 'Nu recunoaște',
    lat: 41.8719,
    lon: 12.5674,
    coords: [12.5674, 41.8719],
    capitala: 'Roma',
    populatie: '≈ 59 000 000 loc.',
    popVal: 59000000,
    suprafata: '301 340 km²',
    supVal: 301340,
    zee: '—',
    zeeVal: 9999,
    note: 'Italia nu recunoaște oficial Palestina. Cu toate acestea, guvernul italian a indicat de mai multe ori disponibilitatea de a recunoaște statul în viitor, însă exclusiv sub auspiciile unui proces de pace agreat de ambele părți.',
    ue: 'Stat membru al Uniunii Europene (fondator).',
    schengen: 'Membru al Spațiului Schengen.',
    moneda: 'Euro (EUR)',
    viza: {
      temei: 'Poziția oficială a Ministerului Afacerilor Externe (Farnesina)',
      regim: 'Menține relații diplomatice neoficiale de nivel înalt cu Autoritatea Palestiniană',
      particular: 'Parlamentul italian a aprobat în trecut rezoluții cu caracter orientativ recomandând recunoașterea',
      observatie: 'Sprijin activ pentru proiecte umanitare în Cisiordania și Gaza'
    },
    particularitati: 'O atitudine considerată "flexibilă" dar prudentă, strâns aliniată cu pozițiile oficiale de la Washington și Bruxelles.',
    badges: ['Nu recunoaște', 'Membru UE', 'Schengen']
  },
  {
    id: 'france_placeholder_norec',
    idReal: 'france',
    nume: 'Franța (Istoric)',
    numeEn: 'France_Placeholder',
    categorie: 'norec',
    popVal: 0, supVal: 0, zeeVal: 9999, note: 'Pentru evitarea erorilor, Franța este trecută în categoria celor care recunosc după decizia istorică din septembrie 2025.',
    badges: []
  },
  {
    id: 'austria',
    nume: 'Austria',
    numeEn: 'Austria',
    categorie: 'norec',
    categorieLabel: 'Nu recunoaște',
    lat: 47.5162,
    lon: 14.5501,
    coords: [14.5501, 47.5162],
    capitala: 'Viena',
    populatie: '≈ 8 900 000 loc.',
    popVal: 8900000,
    suprafata: '83 879 km²',
    supVal: 83879,
    zee: '—',
    zeeVal: 9999,
    note: 'Austria nu recunoaște oficial Palestina ca stat. Poziția sa externă sprijină o soluție negociată, respingând deciziile unilaterale de recunoaștere în afara acordurilor de pace.',
    ue: 'Stat membru al Uniunii Europene (din 1995).',
    schengen: 'Membru al Spațiului Schengen.',
    moneda: 'Euro (EUR)',
    viza: {
      temei: 'Strategia oficială a Ministerului de Externe de la Viena',
      regim: 'Relații diplomatice limitate la reprezentanță oficială',
      particular: 'Austria a devenit în ultimii ani unul dintre cei mai fermi susținători europeni ai Israelului',
      observatie: 'Poziție restrictivă privind rezoluțiile favorabile Palestinei la ONU'
    },
    particularitati: 'O turnură puternic pro-Israel în ultimul deceniu, schimbând politica istorică mai neutră a fostului cancelar Bruno Kreisky.',
    badges: ['Nu recunoaște', 'Membru UE', 'Schengen']
  },
  {
    id: 'hungary',
    nume: 'Ungaria',
    numeEn: 'Hungary',
    categorie: 'contested',
    categorieLabel: 'Recunoaște (Contestat)',
    lat: 47.1625,
    lon: 19.5033,
    coords: [19.5033, 47.1625],
    capitala: 'Budapesta',
    populatie: '≈ 9 700 000 loc.',
    popVal: 9700000,
    suprafata: '93 028 km²',
    supVal: 93028,
    zee: '1988',
    zeeVal: 1988,
    note: 'Ungaria a recunoscut Palestina în mod oficial la 23 noiembrie 1988 (în perioada regimului comunist din Republica Populară Ungară). În prezent, sub conducerea cabinetului condus de Viktor Orbán, Ungaria contestă de facto acea decizie istorică, fiind cel mai ferm aliat al Israelului în cadrul UE.',
    ue: 'Stat membru al Uniunii Europene (din 2004).',
    schengen: 'Membru al Spațiului Schengen.',
    moneda: 'Forint maghiar (HUF)',
    viza: {
      temei: 'Deciziile constituționale de analiză a tratatelor socialiste',
      regim: 'Relații diplomatice formale înghețate sau reduse la minim',
      particular: 'Ungaria blochează constant declarațiile comune ale UE care critică Israelul',
      observatie: 'Ambasada Palestinei rămâne fizic deschisă la Budapesta din rațiuni juridice complexe'
    },
    particularitati: 'Cel mai straniu caz diplomatic: tehnic menține o recunoaștere din 1988 pe care politic o respinge și o blochează sistematic.',
    badges: ['Contestat de facto', 'Membru UE', 'Schengen']
  },
  {
    id: 'czechia',
    nume: 'Cehia',
    numeEn: 'Czech Republic',
    categorie: 'contested',
    categorieLabel: 'Recunoaște (Contestat)',
    lat: 49.8175,
    lon: 15.473,
    coords: [15.473, 49.8175],
    capitala: 'Praga',
    populatie: '≈ 10 700 000 loc.',
    popVal: 10700000,
    suprafata: '78 867 km²',
    supVal: 78867,
    zee: '1988',
    zeeVal: 1988,
    note: 'Cehoslovacia a recunoscut oficial Palestina la 18 noiembrie 1988. În urma divizării, Cehia a succedat tratatele dar a precizat oficial în repetate rânduri că acea recunoaștere comunistă nu mai reflectă politica externă actuală, Praga fiind cel mai apropiat partener strategic al Israelului din Europa.',
    ue: 'Stat membru al Uniunii Europene (din 2004).',
    schengen: 'Membru al Spațiului Schengen.',
    moneda: 'Coroană cehă (CZK)',
    viza: {
      temei: 'Declarațiile Ministerului Afacerilor Externe al Cehiei privind validitatea recunoașterii istorice',
      regim: 'Relații diplomatice bilaterale minime, puternic nuanțate',
      particular: 'Praga a votat constant împotriva rezoluțiilor palestiniene la Adunarea Generală a ONU',
      observatie: 'Există Ambasada Palestinei la Praga, în ciuda protestelor politice interne'
    },
    particularitati: 'Poziție oficială extrem de critică față de Autoritatea Palestiniană, sprijinind total mutarea ambasadelor la Ierusalim.',
    badges: ['Contestat de facto', 'Membru UE', 'Schengen']
  },
  {
    id: 'greece',
    nume: 'Grecia',
    numeEn: 'Greece',
    categorie: 'norec',
    categorieLabel: 'Nu recunoaște',
    lat: 39.0742,
    lon: 21.8243,
    coords: [21.8243, 39.0742],
    capitala: 'Atena',
    populatie: '≈ 10 400 000 loc.',
    popVal: 10400000,
    suprafata: '131 957 km²',
    supVal: 131957,
    zee: '—',
    zeeVal: 9999,
    note: 'Grecia nu recunoaște în mod oficial Palestina, în ciuda unor rezoluții favorabile adoptate în unanimitate de Parlamentul elen în anul 2015. Guvernul grec a ales să nu pună în aplicare recomandările legislative pentru a nu afecta parteneriatul strategic cu Israel.',
    ue: 'Stat membru al Uniunii Europene (din 1981).',
    schengen: 'Membru al Spațiului Schengen.',
    moneda: 'Euro (EUR)',
    viza: {
      temei: 'Decizia Guvernului Elen de suspendare a rezoluției parlamentare din 2015',
      regim: 'Relații neoficiale cordiale, Reprezentanță palestiniană activă',
      particular: 'Parteneriat militar și energetic extrem de puternic cu Israel în Mediterana de Est',
      observatie: 'Grecia a avut istoric un profil extrem de pro-arab în secolul XX'
    },
    particularitati: 'O schimbare pragmatică de politică externă, trecând de la o poziție pro-arabă radicală sub Andreas Papandreou la un aliniament strategic strâns cu Israel.',
    badges: ['Nu recunoaște', 'Membru UE', 'Schengen']
  },
  {
    id: 'switzerland',
    nume: 'Elveția',
    numeEn: 'Switzerland',
    categorie: 'norec',
    categorieLabel: 'Nu recunoaște',
    lat: 46.8182,
    lon: 8.2275,
    coords: [8.2275, 46.8182],
    capitala: 'Berna',
    populatie: '≈ 8 700 000 loc.',
    popVal: 8700000,
    suprafata: '41 285 km²',
    supVal: 41285,
    zee: '—',
    zeeVal: 9999,
    note: 'Elveția nu recunoaște oficial Palestina ca stat, invocând politica sa istorică de neutralitate activă și necesitatea unui acord negociat direct între cele două părți.',
    ue: 'Nu este membru UE.',
    schengen: 'Membru al Spațiului Schengen.',
    moneda: 'Franc elvețian (CHF)',
    viza: {
      temei: 'Poziția oficială a Departamentului Federal al Afacerilor Externe (DFAE)',
      regim: 'Menține relații diplomatice tehnice active, finanțând proiecte umanitare substanțiale',
      particular: 'Berna sprijină cu fermitate soluția celor două state pe baza frontierelor din 1967',
      observatie: 'Elveția găzduiește sediul european al ONU și organizațiile Crucii Roșii'
    },
    particularitati: 'Neutralitatea sa diplomatică face ca Elveția să fie un canal crucial de comunicare indirectă în regiune.',
    badges: ['Nu recunoaște', 'Schengen', 'Neutralitate']
  },
  {
    id: 'netherlands',
    nume: 'Țările de Jos',
    numeEn: 'Netherlands',
    categorie: 'norec',
    categorieLabel: 'Nu recunoaște',
    lat: 52.1326,
    lon: 5.2913,
    coords: [5.2913, 52.1326],
    capitala: 'Amsterdam',
    populatie: '≈ 17 500 000 loc.',
    popVal: 17500000,
    suprafata: '41 543 km²',
    supVal: 41543,
    zee: '—',
    zeeVal: 9999,
    note: 'Țările de Jos nu recunosc oficial Palestina, susținând că recunoașterea trebuie să fie rezultatul final al unui acord direct de pace.',
    ue: 'Stat membru al Uniunii Europene (fondator).',
    schengen: 'Membru al Spațiului Schengen.',
    moneda: 'Euro (EUR)',
    viza: {
      temei: 'Strategia de politică externă a Ministerului Afacerilor Externe de la Haga',
      regim: 'Relații diplomatice formale limitate la nivel de Birou de reprezentare',
      particular: 'Țările de Jos sprijină financiar consolidarea instituțională a Autorității Palestiniene',
      observatie: 'Haga găzduiește Curtea Internațională de Justiție (CIJ) care analizează litigiile teritoriale'
    },
    particularitati: 'Gazda CIJ și a CPI, Curți care joacă un rol seismic global în analizarea juridică a statutului Palestinei.',
    badges: ['Nu recunoaște', 'Membru UE', 'Haga Court']
  },
  {
    id: 'finland',
    nume: 'Finlanda',
    numeEn: 'Finland',
    categorie: 'norec',
    categorieLabel: 'Nu recunoaște',
    lat: 61.9241,
    lon: 25.7482,
    coords: [25.7482, 61.9241],
    capitala: 'Helsinki',
    populatie: '≈ 5 500 000 loc.',
    popVal: 5500000,
    suprafata: '338 424 km²',
    supVal: 338424,
    zee: '—',
    zeeVal: 9999,
    note: 'Finlanda nu recunoaște oficial Palestina, deși oficialii finlandezi au declarat în repetate rânduri un angajament ferm de a realiza acest pas în viitor, în strânsă coordonare cu alte state nordice, când condițiile diplomatice vor fi propice.',
    ue: 'Stat membru al Uniunii Europene (din 1995).',
    schengen: 'Membru al Spațiului Schengen.',
    moneda: 'Euro (EUR)',
    viza: {
      temei: 'Documentul oficial de poziție al Ministerului Afacerilor Externe de la Helsinki',
      regim: 'Fără reprezentare de nivel de Ambasador',
      particular: 'Finlanda pledează pentru respectarea dreptului internațional în toate forurile',
      observatie: 'Menține relații diplomatice neoficiale cordiale'
    },
    particularitati: 'Spre deosebire de Suedia vecină, Finlanda a ales o abordare mai prudentă, refuzând decizia unilaterală din 2014.',
    badges: ['Nu recunoaște', 'Membru UE', 'Nordic Policy']
  },
  {
    id: 'denmark',
    nume: 'Danemarca',
    numeEn: 'Denmark',
    categorie: 'norec',
    categorieLabel: 'Nu recunoaște',
    lat: 56.2639,
    lon: 9.5018,
    coords: [9.5018, 56.2639],
    capitala: 'Copenhaga',
    populatie: '≈ 5 800 000 loc.',
    popVal: 5800000,
    suprafata: '43 094 km²',
    supVal: 43094,
    zee: '—',
    zeeVal: 9999,
    note: 'Danemarca nu recunoaște oficial Palestina. Parlamentul danez a dezbătut și a respins proiecte de lege privind recunoașterea în 2024, menținând linia conform căreia condițiile de suveranitate efectivă nu sunt pe deplin întrunite.',
    ue: 'Stat membru al Uniunii Europene (din 1973).',
    schengen: 'Membru al Spațiului Schengen.',
    moneda: 'Coroană daneză (DKK)',
    viza: {
      temei: 'Votul majoritar al Parlamentului Danez (Folketing) din mai 2024',
      regim: 'Relații diplomatice bilaterale limitate',
      particular: 'Copenhaga sprijină ferm eforturile de reformă ale Autorității Palestiniene',
      observatie: 'Danemarca aplică reguli stricte de asistență externă'
    },
    particularitati: 'Menține o poziție extrem de aliniată cu partenerii transatlantici, refuzând unilateralismul.',
    badges: ['Nu recunoaște', 'Membru UE', 'Schengen']
  },
  {
    id: 'estonia',
    nume: 'Estonia',
    numeEn: 'Estonia',
    categorie: 'norec',
    categorieLabel: 'Nu recunoaște',
    lat: 58.5953,
    lon: 25.0136,
    coords: [25.0136, 58.5953],
    capitala: 'Tallinn',
    populatie: '≈ 1 300 000 loc.',
    popVal: 1300000,
    suprafata: '45 227 km²',
    supVal: 45227,
    zee: '—',
    zeeVal: 9999,
    note: 'Estonia nu recunoaște oficial Palestina ca stat, susținând că recunoașterea trebuie să vină ca o urmare firească a acordului direct de pace între Israel și Palestina.',
    ue: 'Stat membru al Uniunii Europene (din 2004).',
    schengen: 'Membru al Spațiului Schengen.',
    moneda: 'Euro (EUR)',
    viza: {
      temei: 'Documentul oficial de poziție al Guvernului Estonian',
      regim: 'Relații de lucru neoficiale',
      particular: 'Estonia urmează o linie transatlantică strictă în materie de politică externă',
      observatie: 'Sprijină de principiu poziția comună a UE privind soluția celor două state'
    },
    particularitati: 'Poziție extrem de aliniată cu SUA în forurile internaționale.',
    badges: ['Nu recunoaște', 'Membru UE', 'Baltic']
  },
  {
    id: 'latvia',
    nume: 'Letonia',
    numeEn: 'Latvia',
    categorie: 'norec',
    categorieLabel: 'Nu recunoaște',
    lat: 56.8796,
    lon: 24.6032,
    coords: [24.6032, 56.8796],
    capitala: 'Riga',
    populatie: '≈ 1 900 000 loc.',
    popVal: 1900000,
    suprafata: '64 589 km²',
    supVal: 64589,
    zee: '—',
    zeeVal: 9999,
    note: 'Letonia nu recunoaște oficial Palestina, menținând o linie externă rezervată și aliniată cu deciziile partenerilor săi europeni din grupul nordic.',
    ue: 'Stat membru al Uniunii Europene (din 2004).',
    schengen: 'Membru al Spațiului Schengen.',
    moneda: 'Euro (EUR)',
    viza: {
      temei: 'Declarațiile de politică externă ale Ministerului Afacerilor Externe de la Riga',
      regim: 'Relații tehnice discrete',
      particular: 'Letonia sprijină de principiu acțiunile de asistență umanitară',
      observatie: 'Echilibru în declarații pentru a evita dispute'
    },
    particularitati: 'O politică de securitate concentrată pe parteneriatul cu NATO, reflectată și în deciziile de vot la ONU.',
    badges: ['Nu recunoaște', 'Membru UE', 'Baltic']
  },
  {
    id: 'lithuania',
    nume: 'Lituania',
    numeEn: 'Lithuania',
    categorie: 'norec',
    categorieLabel: 'Nu recunoaște',
    lat: 55.1694,
    lon: 23.8813,
    coords: [23.8813, 55.1694],
    capitala: 'Vilnius',
    populatie: '≈ 2 800 000 loc.',
    popVal: 2800000,
    suprafata: '65 300 km²',
    supVal: 65300,
    zee: '—',
    zeeVal: 9999,
    note: 'Lituania nu recunoaște oficial Palestina, având o politică externă puternic aliniată transatlantic și manifestând o prudență extremă față de orice inițiative diplomatice unilaterale.',
    ue: 'Stat membru al Uniunii Europene (din 2004).',
    schengen: 'Membru al Spațiului Schengen.',
    moneda: 'Euro (EUR)',
    viza: {
      temei: 'Strategia națională de politică externă a Lituaniei',
      regim: 'Contacte diplomatice tehnice reduse',
      particular: 'Lituania a manifestat constant o atitudine extrem de pro-Israel în ultimii ani',
      observatie: 'Prudență totală pentru a nu perturba parteneriatul de securitate cu SUA'
    },
    particularitati: 'Cea mai fermă poziție restrictivă dintre cele trei state baltice.',
    badges: ['Nu recunoaște', 'Membru UE', 'Baltic']
  },
  {
    id: 'croatia',
    nume: 'Croația',
    numeEn: 'Croatia',
    categorie: 'norec',
    categorieLabel: 'Nu recunoaște',
    lat: 45.1             ,
    lon: 15.2,
    coords: [15.2, 45.1],
    capitala: 'Zagreb',
    populatie: '≈ 3 900 000 loc.',
    popVal: 3900000,
    suprafata: '56 594 km²',
    supVal: 56594,
    zee: '—',
    zeeVal: 9999,
    note: 'Croația nu recunoaște oficial Palestina, spre deosebire de alte state vecine din fosta Iugoslavie (precum Slovenia, Serbia, Bosnia). Guvernul de la Zagreb susține o soluție negociată, respingând recunoașterile unilaterale.',
    ue: 'Stat membru al Uniunii Europene (din 2013).',
    schengen: 'Membru al Spațiului Schengen (din ianuarie 2023).',
    moneda: 'Euro (EUR)',
    viza: {
      temei: 'Orientarea diplomatică a Ministerului Afacerilor Externe de la Zagreb',
      regim: 'Relații diplomatice neoficiale reduse',
      particular: 'Aliniere strânsă cu pozițiile conservatoare europene',
      observatie: 'Sprijină de principiu dreptul umanitar în Orientul Mijlociu'
    },
    particularitati: 'O disonanță diplomatică evidentă față de restul țărilor din fosta Iugoslavie, având o politică mai conservatoare.',
    badges: ['Nu recunoaște', 'Membru UE', 'Schengen']
  },
  {
    id: 'georgia',
    nume: 'Georgia',
    numeEn: 'Georgia',
    categorie: 'norec',
    categorieLabel: 'Nu recunoaște',
    lat: 42.3154,
    lon: 43.3569,
    coords: [43.3569, 42.3154],
    capitala: 'Tbilisi',
    populatie: '≈ 3 700 000 loc.',
    popVal: 3700000,
    suprafata: '69 700 km²',
    supVal: 69700,
    zee: '—',
    zeeVal: 9999,
    note: 'Georgia nu recunoaște oficial Palestina ca stat, având o politică externă pro-occidentală strâns legată de parteneriatul cu SUA și Israel.',
    ue: 'Stat candidat la aderarea în Uniunea Europeană.',
    schengen: 'Nu face parte din Schengen.',
    moneda: 'Lari georgian (GEL)',
    viza: {
      temei: 'Strategia diplomatică a Guvernului de la Tbilisi',
      regim: 'Fără contacte diplomatice formale',
      particular: 'Georgia menține relații diplomatice și economice extrem de strânse cu Israel',
      observatie: 'Prudență maximă în forurile internaționale'
    },
    particularitati: 'Relații bilaterale excepționale cu Israelul, care au transformat Georgia într-un aliat de facto pe arena externă.',
    badges: ['Nu recunoaște', 'Candidat UE', 'Caucaz']
  }
];

let activeMetric = 'year';
let activeTerritoryId = null;
let currentMode = '2d';
let projection, pathGenerator, svg, container;
let zoomBehavior;

// Elemente cache-uite pentru performanță sporită la rotire
let cachedSphere, cachedGraticule, cachedCountries, cachedMarkers;
let isRotating = false;
let autoRotateTimer;
let autoRotateTimeout;
let rotationState = [-15, -48, 0];

const tooltip = document.getElementById('tooltip');
const searchInput = document.getElementById('search-input');
const suggestionsUl = document.getElementById('search-suggestions');
const panelContent = document.getElementById('panel-content');

// 1. Randarea inițială a hărții și inițializarea structurilor D3
function renderMap() {
  container = document.querySelector('.map-wrap');
  svg = d3.select('#worldmap');
  
  const rect = container.getBoundingClientRect();
  const W = rect.width;
  const H = rect.height;
  
  svg.attr('viewBox', `0 0 ${W} ${H}`).attr('width', W).attr('height', H);
  svg.selectAll('*').remove(); // Curățăm SVG-ul la inițializare
  
  // Inițializare Proiecție bazată pe mod (2D plană adaptată pe Europa sau 3D sferică)
  if (currentMode === '2d') {
    // Proiecție geoEquirectangular perfect centrată pe continentul European
    projection = d3.geoEquirectangular()
      .scale(W * 1.15)
      .center([15, 52])
      .translate([W / 2, H / 2.1])
      .precision(0.1);
  } else {
    projection = d3.geoOrthographic()
      .scale(Math.min(W, H) * 0.95) // Zoom mare pentru a focaliza perfect Europa pe glob
      .translate([W / 2, H / 2])
      .clipAngle(90) // Previne randarea țărilor de pe spatele globului pe fața acestuia!
      .rotate(rotationState)
      .precision(0.1);
  }
  
  pathGenerator = d3.geoPath().projection(projection);
  
  // Desenăm Oceanul (Sfera în 3D, fundalul în 2D)
  cachedSphere = svg.append('path')
    .datum({type: 'Sphere'})
    .attr('class', 'sphere')
    .attr('d', pathGenerator);
    
  // Desenăm Grila de Coordonate (Graticule)
  const graticule = d3.geoGraticule().step([10, 10]); // Linii mai fine
  cachedGraticule = svg.append('path')
    .datum(graticule)
    .attr('class', 'graticule')
    .attr('d', pathGenerator);

  // Încărcăm datele hărții din scriptul securizat world-data
  const worldDataNode = document.getElementById('world-data');
  const worldData = JSON.parse(worldDataNode.textContent);
  const countries = topojson.feature(worldData, worldData.objects.countries);

  // Căutăm țările noastre în dataset
  const targetNames = teritorii.map(t => t.numeEn ? t.numeEn.toLowerCase() : '');

  // Randarea granițelor tuturor țărilor lumii
  cachedCountries = svg.append('g')
    .selectAll('path')
    .data(countries.features)
    .enter()
    .append('path')
    .attr('class', d => {
      const name = d.properties.name ? d.properties.name.toLowerCase() : '';
      let cls = 'country';
      if (targetNames.includes(name) || d.id === '642' || d.id === '826') {
        cls += ' europe-focus';
      }
      return cls;
    })
    .attr('d', pathGenerator)
    .attr('fill', d => {
      const name = d.properties.name ? d.properties.name.toLowerCase() : '';
      const t = teritorii.find(x => (x.numeEn && x.numeEn.toLowerCase() === name) || (x.numeEn === 'Romania' && d.id === '642') || (x.numeEn === 'United Kingdom' && d.id === '826') || (x.numeEn === 'Bosnia and Herzegovina' && name === 'bosnia and herzegovina'));
      if (t) {
        return `var(--${t.categorie})`;
      }
      return null; // Va folosi culoarea din CSS
    })
    .on('mouseenter', (event, d) => {
      const name = d.properties.name ? d.properties.name.toLowerCase() : '';
      const t = teritorii.find(x => (x.numeEn && x.numeEn.toLowerCase() === name) || (x.numeEn === 'Romania' && d.id === '642') || (x.numeEn === 'United Kingdom' && d.id === '826') || (x.numeEn === 'Bosnia and Herzegovina' && name === 'bosnia and herzegovina'));
      
      if (t) {
        tooltip.innerHTML = `
          <div class="flag-name"><span>${t.flag}</span>${t.nume}</div>
          <div class="status-tag" style="background:var(--${t.categorie}); color:${t.categorie === 'rec' ? '#000000' : '#ffffff'}">${t.categorie === 'rec' ? 'Recunoaște' : (t.categorie === 'norec' ? 'Nu recunoaște' : 'Contestat')}</div>
          <div class="note-text">${t.note || ''}</div>
        `;
        tooltip.style.opacity = '1';
      }
    })
    .on('mousemove', event => {
      const r = container.getBoundingClientRect();
      let left = event.clientX - r.left + 15;
      let top = event.clientY - r.top - 40;
      
      if (left + 220 > r.width) {
        left = event.clientX - r.left - 235;
      }
      
      tooltip.style.left = left + 'px';
      tooltip.style.top = top + 'px';
    })
    .on('mouseleave', () => {
      tooltip.style.opacity = '0';
    })
    .on('click', (event, d) => {
      const name = d.properties.name ? d.properties.name.toLowerCase() : '';
      const t = teritorii.find(x => (x.numeEn && x.numeEn.toLowerCase() === name) || (x.numeEn === 'Romania' && d.id === '642') || (x.numeEn === 'United Kingdom' && d.id === '826') || (x.numeEn === 'Bosnia and Herzegovina' && name === 'bosnia and herzegovina'));
      if (t) selectTerritory(t.id);
    });

  // Încărcarea și configurarea comportamentului de Zoom & Pan (exclusiv în 2D)
  if (currentMode === '2d') {
    zoomBehavior = d3.zoom()
      .scaleExtent([1, 10])
      .on('zoom', (event) => {
        const transform = event.transform;
        // Aplicăm transformarea pe toate elementele grafice din SVG
        cachedSphere.attr('transform', transform);
        cachedGraticule.attr('transform', transform);
        cachedCountries.attr('transform', transform);
        
        if (cachedMarkers) {
          cachedMarkers.attr('transform', function(t) {
            const projected = projection(t.coords);
            if (!projected) return null;
            // Repoziționăm și scalăm markerii proporțional pentru lizibilitate
            const tx = transform.applyX(projected[0]);
            const ty = transform.applyY(projected[1]);
            return `translate(${tx}, ${ty})`;
          });
        }
      });
      
    svg.call(zoomBehavior);
  } else {
    // În modul 3D dezactivăm zoomBehavior-ul clasic și configurăm Dragging-ul pe Sferă
    svg.call(d3.drag()
      .on('start', () => {
        isRotating = false;
        if (autoRotateTimer) autoRotateTimer.stop();
        clearTimeout(autoRotateTimeout);
      })
      .on('drag', (event) => {
        const k = 70 / projection.scale();
        const rotate = projection.rotate();
        // Rotația globului pe baza deplasării mouse-ului
        projection.rotate([
          rotate[0] + event.dx * k,
          rotate[1] - event.dy * k,
          rotate[2]
        ]);
        rotationState = projection.rotate();
        updateProjection();
      })
      .on('end', () => {
        resetAutoRotationTimeout();
      })
    );
  }

  // 6. Randarea marcajelor teritoriilor (creare elemente în DOM o singură dată)
  buildMarkers();

  // Ascundem ecranul de încărcare deoarece harta a pornit perfect local
  document.getElementById('loading').classList.add('hidden');

  if (currentMode === '3d') {
    resetAutoRotationTimeout();
  }
}

// Construiește structura DOM a marcajelor (rulată doar la re-randarea hărții)
function buildMarkers() {
  svg.selectAll('.marker').remove();
  
  // Afișăm marcajele doar pentru țările europene din lista noastră
  const activeList = teritorii.filter(t => t.popVal > 0); // Excludem placeholderul tehnic
  
  cachedMarkers = svg.append('g')
    .selectAll('g')
    .data(activeList)
    .enter()
    .append('g')
    .attr('class', 'marker')
    .attr('data-id', t => t.id)
    .attr('data-cat', t => t.categorie)
    .on('click', (event, t) => {
      selectTerritory(t.id);
    });

  // Halo pulsing animat
  cachedMarkers.append('circle')
    .attr('class', 'halo')
    .attr('r', t => getMarkerRadius(t) * 1.5)
    .attr('stroke', t => `var(--${t.categorie})`);

  // Core interior
  cachedMarkers.append('circle')
    .attr('class', 'core')
    .attr('r', t => getMarkerRadius(t))
    .attr('fill', t => `var(--${t.categorie})`);

  // Textul cu numele țării
  cachedMarkers.append('text')
    .attr('class', 'marker-label')
    .attr('text-anchor', 'middle')
    .attr('y', t => -(getMarkerRadius(t) + 6))
    .text(t => t.nume);

  updateMarkerPositions();
}

// Actualizează rapid poziția, vizibilitatea și scara marcajelor fără a reconstrui DOM-ul
function updateMarkerPositions() {
  if (!cachedMarkers) return;

  cachedMarkers.each(function(t) {
    const isVisible = currentMode === '2d' || isVisibleOnGlobe(t.coords);
    const projected = projection(t.coords);
    const g = d3.select(this);

    if (projected && isVisible) {
      g.style('display', 'block')
       .attr('transform', `translate(${projected[0]}, ${projected[1]})`);
      
      // Sincronizăm fin dimensiunile marcajelor
      const radius = getMarkerRadius(t);
      g.select('.halo').attr('r', radius * 1.5);
      g.select('.core').attr('r', radius);
      g.select('.marker-label').attr('y', -(radius + 6));
    } else {
      g.style('display', 'none');
    }
  });
}

// Calculează raza marcajului pe baza indicatorului selectat
function getMarkerRadius(t) {
  if (activeTerritoryId === t.id) return 9;
  
  let val;
  if (activeMetric === 'year') {
    val = t.zeeVal === 9999 ? 2026 : t.zeeVal; // Pentru ordonare an
    return t.categorie === 'rec' ? 7.5 : (t.categorie === 'contested' ? 6 : 4);
  } else if (activeMetric === 'pop') {
    val = t.popVal;
  } else {
    val = t.supVal;
  }
  
  const safeVal = Math.max(1, val);
  const activeList = teritorii.filter(x => x.popVal > 0);
  const vals = activeList.map(x => Math.max(1, activeMetric === 'pop' ? x.popVal : x.supVal));
  const minVal = d3.min(vals);
  const maxVal = d3.max(vals);

  // Scara logaritmică
  const logScale = d3.scaleLog()
    .domain([minVal, maxVal])
    .range([4, 12]);

  return logScale(safeVal);
}

// Verifică dacă țara se află pe emisfera vizibilă a globului (3D)
function isVisibleOnGlobe(coords) {
  const rotate = projection.rotate();
  const center = [-rotate[0], -rotate[1]];
  const dist = d3.geoDistance(coords, center);
  return dist < Math.PI / 2.1; // Margini mai strânse
}

// Actualizează proiecțiile pe ecran când globul se rotește
function updateProjection() {
  if (!projection || !cachedSphere || !cachedGraticule || !cachedCountries) return;
  
  cachedSphere.attr('d', pathGenerator);
  cachedGraticule.attr('d', pathGenerator);
  cachedCountries.attr('d', pathGenerator);
  
  updateMarkerPositions();
}

// 7. Rotație Cinematică Glob (3D)
function startCinematicRotation() {
  if (autoRotateTimer) autoRotateTimer.stop();
  
  autoRotateTimer = d3.timer(() => {
    if (!isRotating || currentMode !== '3d') return;
    const rotate = projection.rotate();
    projection.rotate([rotate[0] - 0.05, rotate[1], rotate[2]]);
    rotationState = projection.rotate();
    updateProjection();
  });
}

function resetAutoRotationTimeout() {
  clearTimeout(autoRotateTimeout);
  isRotating = false;
  autoRotateTimeout = setTimeout(() => {
    if (currentMode === '3d') {
      isRotating = true;
      startCinematicRotation();
    }
  }, 4000);
}

// 8. Controale Fizice Harta (Zoom +/- și Reset)
document.getElementById('zoom-in').addEventListener('click', () => {
  if (currentMode === '2d') {
    svg.transition().duration(400).call(zoomBehavior.scaleBy, 1.6);
  } else {
    projection.scale(projection.scale() * 1.3);
    updateProjection();
  }
});

document.getElementById('zoom-out').addEventListener('click', () => {
  if (currentMode === '2d') {
    svg.transition().duration(400).call(zoomBehavior.scaleBy, 0.6);
  } else {
    projection.scale(Math.max(100, projection.scale() * 0.7));
    updateProjection();
  }
});

document.getElementById('zoom-reset').addEventListener('click', () => {
  if (currentMode === '2d') {
    svg.transition().duration(800).call(zoomBehavior.transform, d3.zoomIdentity);
  } else {
    rotationState = [-15, -48, 0];
    const rect = container.getBoundingClientRect();
    projection.scale(Math.min(rect.width, rect.height) * 0.95).rotate(rotationState);
    updateProjection();
  }
});

// 9. Căutare Instantă cu Autocomplete
searchInput.addEventListener('input', (event) => {
  const query = event.target.value.toLowerCase().trim();
  if (!query) {
    suggestionsUl.style.display = 'none';
    return;
  }

  const activeList = teritorii.filter(t => t.popVal > 0);
  const filtered = activeList.filter(t => 
    t.nume.toLowerCase().includes(query) || 
    (t.numeEn && t.numeEn.toLowerCase().includes(query)) || 
    t.capitala.toLowerCase().includes(query) || 
    t.categorieLabel.toLowerCase().includes(query)
  );

  if (filtered.length === 0) {
    suggestionsUl.innerHTML = '<li style="color:var(--ink-soft); cursor:default">Nicio țară găsită</li>';
  } else {
    suggestionsUl.innerHTML = filtered.map(t => `
      <li data-id="${t.id}">
        <span style="font-weight:600">${t.flag} ${t.nume}</span>
        <span class="cat-badge" style="background:var(--${t.categorie}); color:${t.categorie === 'rec' ? '#000000' : '#ffffff'}">${t.categorie === 'rec' ? 'REC' : (t.categorie === 'norec' ? 'NO' : 'CONT')}</span>
      </li>
    `).join('');
  }
  suggestionsUl.style.display = 'block';
});

// Selecția din sugestii
suggestionsUl.addEventListener('click', (event) => {
  const li = event.target.closest('li');
  if (!li || !li.dataset.id) return;
  
  selectTerritory(li.dataset.id);
  searchInput.value = '';
  suggestionsUl.style.display = 'none';
});

// Închidem sugestiile la click în afară
document.addEventListener('click', (event) => {
  if (!event.target.closest('.search-container')) {
    suggestionsUl.style.display = 'none';
  }
});

// 10. Clasamente (Cronologie / Populație / Suprafață)
function renderRankings() {
  const activeList = teritorii.filter(t => t.popVal > 0);
  
  const minVal = d3.min(activeList, d => Math.max(1, activeMetric === 'year' ? (d.zeeVal === 9999 ? 2026 : d.zeeVal) : (activeMetric === 'pop' ? d.popVal : d.supVal)));
  const maxVal = d3.max(activeList, d => Math.max(1, activeMetric === 'year' ? (d.zeeVal === 9999 ? 2026 : d.zeeVal) : (activeMetric === 'pop' ? d.popVal : d.supVal)));

  // Ordonare dinamică
  const sorted = [...activeList].sort((a, b) => {
    if (activeMetric === 'year') {
      const yearA = a.zeeVal;
      const yearB = b.zeeVal;
      // Ordonăm anii crescător (cei mai vechi primii). Cei care nu recunosc (9999) la sfârșit.
      return yearA - yearB;
    }
    const valA = activeMetric === 'pop' ? a.popVal : a.supVal;
    const valB = activeMetric === 'pop' ? b.popVal : b.supVal;
    return valB - valA; // Descrescător pentru demografie
  });

  const listContainer = document.getElementById('rank-list-container');
  if (!listContainer) return;

  listContainer.innerHTML = sorted.map(t => {
    let dispVal;
    let val;
    if (activeMetric === 'year') { 
      dispVal = t.zeeVal === 9999 ? 'Nu recunoaște' : 'An: ' + t.zee; 
      val = t.zeeVal === 9999 ? 2026 : t.zeeVal;
    } else if (activeMetric === 'pop') { 
      dispVal = t.populatie; 
      val = t.popVal; 
    } else { 
      dispVal = t.suprafata; 
      val = t.supVal; 
    }

    // Procent progresiv
    let percent;
    if (activeMetric === 'year') {
      if (t.zeeVal === 9999) percent = 100;
      else {
        // Cu cât e mai veche (1988), cu atât e mai plină bara
        percent = ((2026 - val) / (2026 - 1988)) * 100;
      }
    } else {
      const safeVal = Math.max(1, val);
      const safeMin = Math.max(1, minVal);
      const safeMax = Math.max(1, maxVal);
      percent = ((Math.log(safeVal) - Math.log(safeMin)) / (Math.log(safeMax) - Math.log(safeMin) || 1)) * 100;
    }
    
    return `
      <div class="rank-item" data-id="${t.id}">
        <div class="rank-item-meta">
          <span class="rank-item-name">${t.flag} ${t.nume}</span>
          <span class="rank-item-val" style="color:var(--${t.categorie})">${dispVal}</span>
        </div>
        <div class="rank-bar-bg">
          <div class="rank-bar-fill" style="width: 0%; background: var(--${t.categorie})"></div>
        </div>
      </div>
    `;
  }).join('');

  // Animăm fluid
  setTimeout(() => {
    listContainer.querySelectorAll('.rank-item').forEach(item => {
      const t = teritorii.find(x => x.id === item.dataset.id);
      let val;
      if (activeMetric === 'year') {
        val = t.zeeVal === 9999 ? 2026 : t.zeeVal;
      } else {
        val = activeMetric === 'pop' ? t.popVal : t.supVal;
      }
      
      let percent;
      if (activeMetric === 'year') {
        if (t.zeeVal === 9999) percent = 5; // Bara minimă pentru no-rec
        else {
          percent = 10 + (((2026 - val) / (2026 - 1988)) * 90);
        }
      } else {
        const safeVal = Math.max(1, val);
        const safeMin = Math.max(1, minVal);
        const safeMax = Math.max(1, maxVal);
        percent = ((Math.log(safeVal) - Math.log(safeMin)) / (Math.log(safeMax) - Math.log(safeMin) || 1)) * 100;
      }
      
      const fill = item.querySelector('.rank-bar-fill');
      if (fill) fill.style.width = Math.max(5, percent) + '%';
    });
  }, 50);

  // Evenimente click pe elemente
  listContainer.querySelectorAll('.rank-item').forEach(item => {
    item.addEventListener('click', () => {
      selectTerritory(item.dataset.id);
    });
  });
}

// Selectorul de clasamente
document.querySelector('.rankings-selector').addEventListener('click', (event) => {
  const btn = event.target.closest('.rank-btn');
  if (!btn) return;

  document.querySelectorAll('.rank-btn').forEach(b => b.classList.remove('active'));
  btn.classList.add('active');

  activeMetric = btn.dataset.metric;
  
  renderRankings();
  updateProjection();
});

// Randăm clasamentele inițiale
renderRankings();

// 11. Selecție Țară și Fișă Tab-uri
function selectTerritory(id) {
  activeTerritoryId = id;
  const t = teritorii.find(x => x.id === id);
  if (!t) return;

  // Clasa activă pe hartă
  if (cachedMarkers) {
    cachedMarkers.attr('class', m => {
      let classes = 'marker';
      if (id && m.id !== id) classes += ' dimmed';
      if (m.id === id) classes += ' active';
      return classes;
    });
  }

  // Focalizare sferică (3D) sau Centrare (2D)
  if (currentMode === '2d') {
    zoomToCoords(t.coords, 4);
  } else {
    rotateToCoords(t.coords);
  }

  const badgeMap = {
    'Recunoaște Palestina': 'rec',
    'Nu recunoaște': 'norec',
    'Recunoaște (Contestat)': 'contested'
  };

  const recognitionText = t.categorie === 'rec' 
    ? `Recunoaște oficial Statul Palestina din anul <strong>${t.zee}</strong>.` 
    : (t.categorie === 'contested' ? `A recunoscut Palestina în <strong>${t.zee}</strong>, însă această recunoaștere este contestată sau ignorată în prezent.` : 'Nu recunoaște formal în prezent Statul Palestina.');

  panelContent.innerHTML = `
    <div class="territory-detail">
      <div class="detail-header-wrap">
        <button class="btn-back-rankings" id="btn-back-rankings">← Înapoi la Cronologie</button>
        <div class="panel-cat" data-cat="${t.categorie}">
          <span>●</span>${t.categorieLabel}
        </div>
        <h2>${t.flag} ${t.nume}<em>${t.numeEn}</em></h2>
      </div>
      
      <div class="panel-tabs">
        <button class="tab-btn active" data-tab="tab-prez">Prezentare</button>
        <button class="tab-btn" data-tab="tab-juridic">Recunoaștere</button>
        <button class="tab-btn" data-tab="tab-vize">Relații Externe</button>
        <button class="tab-btn" data-tab="tab-fin">Geografie &amp; Demog.</button>
      </div>

      <div class="tab-content-container">
        <!-- Tab 1: Prezentare -->
        <div class="tab-content active" id="tab-prez">
          <div class="premium-banner">
            <div class="premium-banner-red"></div>
            <div class="premium-banner-mid"></div>
            <div class="premium-banner-bottom"></div>
            <div class="premium-banner-triangle"></div>
            <div class="premium-banner-text">${t.nume.toUpperCase()}</div>
          </div>
          
          <div class="stat-grid">
            <div class="stat"><div class="k">Capitala</div><div class="v" style="font-size:13.5px">${t.capitala}</div></div>
            <div class="stat"><div class="k">An Recunoaștere</div><div class="v">${t.zee === '1988' ? '1988 (Val Ist.)' : (t.zee === '—' ? 'Nerecunoscut' : t.zee)}</div></div>
            <div class="stat"><div class="k">Populația</div><div class="v" style="font-size:13px">${t.populatie}</div></div>
            <div class="stat"><div class="k">Suprafața</div><div class="v" style="font-size:13.5px">${t.suprafata}</div></div>
          </div>

          <div class="panel-section">
            <h3>Detalii Poziție</h3>
            <p>${t.note}</p>
          </div>
        </div>

        <!-- Tab 2: Recunoaștere Juridică -->
        <div class="tab-content" id="tab-juridic">
          <div class="alert-box">
            <h3>Temei și Statut</h3>
            <p>${recognitionText}</p>
          </div>
          <div class="panel-section">
            <h3>Note Istorice și Diplomatice</h3>
            <p>${t.viza.particular}</p>
          </div>
          <div class="panel-section">
            <h3>Proceduri administrative și reprezentare</h3>
            <p><strong>Temei politic:</strong> ${t.viza.temei}</p>
            <p style="margin-top:8px"><strong>Regim de cooperare:</strong> ${t.viza.regim}</p>
            <p style="margin-top:8px"><strong>Observații:</strong> ${t.viza.observatie}</p>
          </div>
        </div>

        <!-- Tab 3: Relații Externe -->
        <div class="tab-content" id="tab-vize">
          <div class="panel-section">
            <h3>Integrare Europeană</h3>
            <p>${t.ue}</p>
          </div>
          <div class="panel-section">
            <h3>Poziția privind Libera Circulație (Schengen)</h3>
            <p>${t.schengen}</p>
          </div>
          <div class="badge-row">
            <span class="badge ${badgeMap[t.categorieLabel] || ''}">${t.categorieLabel}</span>
            <span class="badge">${t.moneda}</span>
          </div>
        </div>

        <!-- Tab 4: Informații Geografice și Demografice -->
        <div class="tab-content" id="tab-fin">
          <div class="stat-grid">
            <div class="stat"><div class="k">Monedă</div><div class="v" style="font-size:14px">${t.moneda}</div></div>
            <div class="stat"><div class="k">Poziționare</div><div class="v" style="font-size:14px">${t.lat.toFixed(2)}° N / ${t.lon.toFixed(2)}° E</div></div>
          </div>
          
          <div class="panel-section">
            <h3>Particularități Geopolitice</h3>
            <p>${t.particularitati}</p>
          </div>
        </div>
      </div>
    </div>
  `;

  // Tab buttons click
  const tabButtons = panelContent.querySelectorAll('.tab-btn');
  const tabContents = panelContent.querySelectorAll('.tab-content');

  tabButtons.forEach(btn => {
    btn.addEventListener('click', () => {
      tabButtons.forEach(b => b.classList.remove('active'));
      tabContents.forEach(c => c.classList.remove('active'));

      btn.classList.add('active');
      panelContent.querySelector(`#${btn.dataset.tab}`).classList.add('active');
    });
  });

  // Înapoi la Clasament
  document.getElementById('btn-back-rankings').addEventListener('click', () => {
    activeTerritoryId = null;
    
    if (cachedMarkers) {
      cachedMarkers.attr('class', 'marker').style('pointer-events', 'auto');
    }

    document.querySelectorAll('.chip').forEach(c => c.classList.remove('active'));
    document.querySelector('.chip[data-filter="all"]').classList.add('active');

    panelContent.innerHTML = `
      <div class="rankings-view">
        <div class="rankings-header">
          <h3 class="rankings-title">⚜ Cronologia Recunoașterii</h3>
          <p style="font-family:'Cormorant Garamond',serif;font-style:italic;font-size:14px;color:var(--ink-soft);line-height:1.3;margin-bottom:12px;">Vizualizează cronologia deciziilor istorice și recente. Țările care nu recunosc sunt ordonate alfabetic la final.</p>
        </div>
        <div class="rankings-selector">
          <button class="rank-btn ${activeMetric === 'year' ? 'active' : ''}" data-metric="year">An Recunoaștere</button>
          <button class="rank-btn ${activeMetric === 'pop' ? 'active' : ''}" data-metric="pop">Populație</button>
          <button class="rank-btn ${activeMetric === 'sup' ? 'active' : ''}" data-metric="sup">Suprafață</button>
        </div>
        <div id="rank-list-container" class="rank-list">
          <!-- Dynamic ranked items will be rendered here by Javascript -->
        </div>
      </div>
    `;

    panelContent.querySelector('.rankings-selector').addEventListener('click', (event) => {
      const btnSelector = event.target.closest('.rank-btn');
      if (!btnSelector) return;
      panelContent.querySelectorAll('.rank-btn').forEach(b => b.classList.remove('active'));
      btnSelector.classList.add('active');
      activeMetric = btnSelector.dataset.metric;
      renderRankings();
      updateProjection();
    });

    renderRankings();
    updateProjection();
  });
}

// Centrare și Zoom în 2D
function zoomToCoords(coords, zoomLevel = 4) {
  const [lng, lat] = coords;
  const width = container.getBoundingClientRect().width;
  const height = container.getBoundingClientRect().height;
  
  const projCoords = projection([lng, lat]);
  if (!projCoords) return;
  const [x, y] = projCoords;

  svg.transition()
    .duration(1200)
    .call(
      zoomBehavior.transform,
      d3.zoomIdentity
        .translate(width / 2, height / 2)
        .scale(zoomLevel)
        .translate(-x, -y)
    );
}

// Tranziție sferică în 3D
function rotateToCoords(coords) {
  const [lng, lat] = coords;
  isRotating = false;
  if (autoRotateTimer) autoRotateTimer.stop();
  clearTimeout(autoRotateTimeout);

  const r = projection.rotate();
  // Rotația sferică
  const targetRotation = [-lng, -lat, r[2]];
  const interpolator = d3.interpolate(r, targetRotation);

  d3.transition()
    .duration(1200)
    .tween('rotate', () => {
      return (t) => {
        projection.rotate(interpolator(t));
        rotationState = projection.rotate();
        updateProjection();
      };
    })
    .on('end', () => {
      resetAutoRotationTimeout();
    });
}

// Chips de filtrare rapidă
document.querySelectorAll('.chip').forEach(chip => {
  chip.addEventListener('click', () => {
    document.querySelectorAll('.chip').forEach(c => c.classList.remove('active'));
    chip.classList.add('active');

    const filter = chip.dataset.filter;
    
    if (cachedMarkers) {
      cachedMarkers.each(function(t) {
        const m = d3.select(this);
        if (filter === 'all' || t.categorie === filter) {
          m.classed('dimmed', false).style('pointer-events', 'auto');
        } else {
          m.classed('dimmed', true).style('pointer-events', 'none');
        }
      });
    }
  });
});

// Comutatoare 2D vs 3D
document.getElementById('btn-2d').addEventListener('click', function() {
  if (currentMode === '2d') return;
  document.getElementById('btn-3d').classList.remove('active');
  this.classList.add('active');
  currentMode = '2d';
  isRotating = false;
  if (autoRotateTimer) autoRotateTimer.stop();
  renderMap();
});

document.getElementById('btn-3d').addEventListener('click', function() {
  if (currentMode === '3d') return;
  document.getElementById('btn-2d').classList.remove('active');
  this.classList.add('active');
  currentMode = '3d';
  renderMap();
});

// Modificare Temă (Light / Dark Mode)
const themeToggle = document.getElementById('theme-toggle');
themeToggle.addEventListener('click', () => {
  document.body.classList.toggle('light-theme');
  const isLight = document.body.classList.contains('light-theme');
  themeToggle.textContent = isLight ? '🌙 Dark Mode' : '☀️ Light Mode';
});

// Inițializare
renderMap();

let resizeTimeout;
window.addEventListener('resize', () => {
  clearTimeout(resizeTimeout);
  resizeTimeout = setTimeout(renderMap, 150);
});
</script>
</body>
</html>
'@

Write-Host "Citesc bibliotecile locale d3.min.js si topojson.min.js pentru inline embedding..."
$d3Path = "C:\Users\Bogdan\.gemini\antigravity\scratch\harta-palestina\d3.min.js"
$topojsonPath = "C:\Users\Bogdan\.gemini\antigravity\scratch\harta-palestina\topojson.min.js"

$d3Content = [System.IO.File]::ReadAllText($d3Path, [System.Text.Encoding]::UTF8)
$topojsonContent = [System.IO.File]::ReadAllText($topojsonPath, [System.Text.Encoding]::UTF8)

$inlineScripts = "<script>`n$d3Content`n</script>`n<script>`n$topojsonContent`n</script>"

Write-Host "Scriu fisierul asamblat in $destPath..."
$mergedContent = $htmlHeader + "`n" + $jsonBlock + "`n" + $htmlFooter
$newContent = $mergedContent.Replace("<!-- INLINE_SCRIPTS_PLACEHOLDER -->", $inlineScripts)

$utf8NoBom = New-Object System.Text.UTF8Encoding($false)
[System.IO.File]::WriteAllText($destPath, $newContent, $utf8NoBom)

Write-Host "SUCCES: index.html asamblat perfect cu diacritice românești în format UTF-8 fără BOM (100% self-contained)!"
