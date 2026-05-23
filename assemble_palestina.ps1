# Asambleaz─â index.html premium pentru proiectul Palestinei ├«n Europa
$frenchPath = "C:\Users\Bogdan\.gemini\antigravity\scratch\teritorii-franta\index.html"
$destPath = "C:\Users\Bogdan\.gemini\antigravity\scratch\harta-palestina\index.html"

Write-Host "Citesc TopoJSON din $frenchPath..."
$frenchContent = Get-Content -Path $frenchPath -Raw -Encoding utf8
$jsonStart = $frenchContent.IndexOf('<script id="world-data" type="application/json">')
if ($jsonStart -eq -1) {
    Write-Error "Nu am g─âsit scriptul world-data ├«n fi╚Öierul francez!"
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
  errDiv.innerHTML = '<h2 style="margin-bottom:10px;">≡ƒÜ¿ EROARE DETECTAT─é PE LAPTOPUL T─éU:</h2>' +
                     '<p style="margin:5px 0;"><b>Mesaj:</b> ' + message + '</p>' +
                     '<p style="margin:5px 0;"><b>Surs─â:</b> ' + source + '</p>' +
                     '<p style="margin:5px 0;"><b>Linie:</b> ' + lineno + ' | <b>Coloan─â:</b> ' + colno + '</p>' +
                     '<p style="margin:5px 0;"><b>Stack Trace:</b> ' + (error ? error.stack : 'N/A') + '</p>' +
                     '<p style="margin-top:15px; font-weight:bold; color:#fef08a;">Te rug─âm s─â trimi╚¢i acest text exact ├«n chat pentru a-l rezolva ├«n 5 secunde!</p>';
  document.body.insertBefore(errDiv, document.body.firstChild);
  return false;
};
</script>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Recunoa╚Öterea Palestinei ├«n Europa ΓÇö Hart─â Juridic─â Interactiv─â</title>
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
    stroke: var(--land-border);
    stroke-width: 0.6;
  }

  .country:hover { fill: var(--paper-dark); }

  .marker circle {
    display: none !important;
  }

  .country.rec {
    fill: var(--rec) !important;
  }

  .country.norec {
    fill: var(--norec) !important;
  }

  .country.contested {
    fill: var(--contested) !important;
  }

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
      <span class="eyebrow">Uniunea European─â ┬╖ Rela╚¢ii Externe ┬╖ Anul 2026</span>
      <h1>Recunoa╚Öterea <em>Palestinei</em> ├«n Europa</h1>
      <p class="subtitle">O hart─â juridic─â ╚Öi interactiv─â a deciziilor de recunoa╚Ötere a Statului Palestina de c─âtre ╚¢─ârile de pe continentul European, detaliind anul exact al recunoa╚Öterii, contextul diplomatic ╚Öi pozi╚¢ia oficial─â post-UNGA 80.</p>
    </div>
    <div class="header-actions">
      <div class="meta">
        <div class="line"><span class="label">Proiec╚¢ie</span><span>Europe Focus / Orthographic</span></div>
        <div class="line"><span class="label">Total Recunosc</span><span>30 State Europene</span></div>
        <div class="line"><span class="label">Nu recunosc</span><span>14 State</span></div>
        <div class="line" style="margin-top: 16px; justify-content: flex-end; border-top: 1px dashed var(--border); padding-top: 12px;">
          <span style="font-family: 'Cormorant Garamond', serif; font-style: italic; font-size: 18px; color: var(--accent); font-weight: 600; letter-spacing: -0.02em; line-height: 1.1;">ΓÇö creat de Popa Bogdan</span>
        </div>
      </div>
      <button id="theme-toggle" class="theme-btn">≡ƒîÖ Dark Mode</button>
    </div>
  </div>
</header>

<section class="legal-intro">
  <div class="label-col">Un peisaj diplomatic ├«n plin─â transformare</div>
  <p>Harta recunoa╚Öterii Palestinei ├«n Europa este ├«mp─âr╚¢it─â istoric ╚Öi politic. <strong>Valul din 1988</strong> reprezint─â deciziile statelor din fostul bloc sovietic (inclusiv Rom├ónia), luate imediat dup─â Declara╚¢ia de Independen╚¢─â a Palestinei de la Alger. <strong>Valul recent (2024-2025)</strong> reflect─â deciziile unor state vest-europene (Norvegia, Spania, Irlanda, Slovenia, urmate ├«n toamna anului 2025 de Regatul Unit, Fran╚¢a, Belgia ╚Öi Portugalia) ca reac╚¢ie la escaladarea conflictului din Orientul Mijlociu ╚Öi ├«n sprijinul solu╚¢iei celor dou─â state.</p>
</section>

<section class="filters">
  <span class="filter-label">Filtreaz─â dup─â pozi╚¢ie</span>
  <button class="chip active" data-filter="all">Toate statele</button>
  <button class="chip" data-filter="rec" data-cat="rec"><span class="dot"></span>Recunosc Palestina</button>
  <button class="chip" data-filter="norec" data-cat="norec"><span class="dot"></span>Nu recunosc</button>
  <button class="chip" data-filter="contested" data-cat="contested"><span class="dot"></span>Contestat / ├Änghe╚¢at</button>
</section>

<main>
  <div class="map-wrap">
    <div class="map-loading" id="loading">Se ├«ncarc─â harta mondial─âΓÇª</div>
    
    <div class="map-mode-toggle">
      <button id="btn-2d" class="toggle-btn active">2D Proiec╚¢ie</button>
      <button id="btn-3d" class="toggle-btn">3D Glob</button>
    </div>

    <div class="map-controls">
      <button id="zoom-in" class="map-btn" title="Apropie">+</button>
      <button id="zoom-out" class="map-btn" title="Dep─ârteaz─â">ΓêÆ</button>
      <button id="zoom-reset" class="map-btn" title="Reseteaz─â vizualizarea">Γƒ▓</button>
    </div>

    <svg id="worldmap" xmlns="http://www.w3.org/2000/svg"></svg>
    <div class="country-tooltip" id="tooltip"></div>

    <div class="map-legend">
      <div class="title">Legenda</div>
      <div class="item"><span class="dot" style="background: var(--rec)"></span>Recunosc</div>
      <div class="item"><span class="dot" style="background: var(--norec)"></span>Nu recunosc</div>
      <div class="item"><span class="dot" style="background: var(--contested)"></span>Recunoa╚Ötere contestat─â</div>
    </div>

    <div class="map-compass">Γåæ<br>N</div>
  </div>

  <aside class="panel" id="panel">
    <div class="search-wrapper">
      <div class="search-container">
        <span class="search-icon">≡ƒöì</span>
        <input type="text" id="search-input" class="search-input" placeholder="Caut─â ╚¢ar─â din Europa...">
        <ul id="search-suggestions" class="suggestions-list"></ul>
      </div>
    </div>
    
    <div id="panel-content">
      <div class="rankings-view">
        <div class="rankings-header">
          <h3 class="rankings-title">ΓÜ£ Cronologia Recunoa╚Öterii</h3>
          <p style="font-family:'Cormorant Garamond',serif;font-style:italic;font-size:14px;color:var(--ink-soft);line-height:1.3;margin-bottom:12px;">Vizualizeaz─â cronologia deciziilor istorice ╚Öi recente. ╚Ü─ârile care nu recunosc sunt ordonate alfabetic la final.</p>
        </div>
        <div class="rankings-selector">
          <button class="rank-btn active" data-metric="year">An Recunoa╚Ötere</button>
          <button class="rank-btn" data-metric="pop">Popula╚¢ie</button>
          <button class="rank-btn" data-metric="sup">Suprafa╚¢─â</button>
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
    Aceast─â hart─â interactiv─â reprezint─â un instrument juridic ╚Öi documentar cu privire la recunoa╚Öterea interna╚¢ional─â a Statului Palestina pe continentul European. Informa╚¢iile reflect─â deciziile oficiale de politic─â extern─â publicate de guvernele respective ╚Öi dezbaterile conexe.
  </div>
  <div class="refs">
    <strong>Surse diplomatice &amp; de pres─â</strong>
    UN General Assembly Resolution 43/177 (1988)<br>
    UNGA Resolution ES-10/23 (2024)<br>
    Deciziile oficiale guvernamentale (Spania, Norvegia, Irlanda, Slovenia ΓÇö 2024)<br>
    Declara╚¢iile comune de recunoa╚Ötere (Fran╚¢a, UK, Belgia, Portugalia ΓÇö sept. 2025)<br>
    Wikipedia "International recognition of the State of Palestine"<br><br>
    <strong>Date cartografice</strong>
    Natural Earth 110m ┬╖ CC0 Public Domain<br><br>
    <strong>Dezvoltator</strong>
    <span style="font-family: 'Cormorant Garamond', serif; font-style: italic; font-size: 18px; color: var(--accent); font-weight: 600; display: block; margin-top: 4px; letter-spacing: -0.02em; line-height: 1.2;">ΓÇö creat de Popa Bogdan</span>
  </div>
</footer>
'@

$htmlFooter = @'
<script>
// Datele complete ale celor 44 de State Europene (inclusiv detalii demografice si de recunoastere)
const teritorii = [
  {
    id: 'romania',
    nume: 'Rom├ónia',
    numeEn: 'Romania',
    categorie: 'rec',
    categorieLabel: 'Recunoa╚Öte Palestina',
    lat: 45.9432,
    lon: 24.9668,
    coords: [24.9668, 45.9432],
    capitala: 'Bucure╚Öti',
    populatie: 'Γëê 19 000 000 loc.',
    popVal: 19000000,
    suprafata: '238 397 km┬▓',
    supVal: 238397,
    zee: '1988',
    zeeVal: 1988,
    note: 'Recunoa╚Ötere istoric─â la 24 noiembrie 1988 de c─âtre Republica Socialist─â Rom├ónia, imediat dup─â declara╚¢ia de independen╚¢─â de la Alger. Rela╚¢iile diplomatice sunt men╚¢inute activ, exist├ónd Ambasada Palestinei la Bucure╚Öti ╚Öi Reprezentan╚¢a Rom├óniei la Ramallah.',
    ue: 'Stat membru al Uniunii Europene (din 2007).',
    schengen: 'Membru al Spa╚¢iul Schengen (aerian/maritim din martie 2024).',
    moneda: 'Leu rom├ónesc (RON)',
    viza: {
      temei: 'Decizia MAE de men╚¢inere a continuit─â╚¢ii recunoa╚Öterii dup─â 1989',
      regim: 'Rela╚¢ii diplomatice depline la nivel de Ambasad─â',
      particular: 'Rom├ónia sprijin─â constant solu╚¢ia celor dou─â state ╚Öi negocierile directe',
      observatie: 'Studen╚¢ii palestinieni beneficiaz─â istoric de burse de studii ├«n Rom├ónia'
    },
    particularitati: 'Una dintre pu╚¢inele ╚¢─âri din UE care recunosc oficial Palestina dar men╚¢in ├«n acela╚Öi timp rela╚¢ii strategice extrem de str├ónse cu Israel.',
    badges: ['Recunoa╚Öte (1988)', 'Membru UE', 'Ambasad─â complet─â']
  },
  {
    id: 'norway',
    nume: 'Norvegia',
    numeEn: 'Norway',
    categorie: 'rec',
    categorieLabel: 'Recunoa╚Öte Palestina',
    lat: 60.472,
    lon: 8.4689,
    coords: [8.4689, 60.472],
    capitala: 'Oslo',
    populatie: 'Γëê 5 400 000 loc.',
    popVal: 5400000,
    suprafata: '385 207 km┬▓',
    supVal: 385207,
    zee: '2024',
    zeeVal: 2024,
    note: 'Norvegia a anun╚¢at recunoa╚Öterea oficial─â a Palestinei ca stat la 22 mai 2024, decizia intr├ónd ├«n vigoare la 28 mai 2024. Ini╚¢iativa a fost coordonat─â str├óns cu Spania ╚Öi Irlanda ca un semnal puternic ├«n sprijinul p─âcii durabile ├«n regiune.',
    ue: 'Nu este membr─â UE, dar face parte din Spa╚¢iul Economic European (SEE).',
    schengen: 'Membru deplin al Spa╚¢iului Schengen.',
    moneda: 'Coroan─â norvegian─â (NOK)',
    viza: {
      temei: 'Declara╚¢ia comun─â a Guvernului condus de Jonas Gahr St├╕re (mai 2024)',
      regim: 'Rela╚¢ii diplomatice oficiale active',
      particular: 'Norvegia a g─âzduit istoric Acordurile de la Oslo din 1993',
      observatie: 'Decizia a generat tensiuni diplomatice severe temporare cu guvernul israelian'
    },
    particularitati: 'Pozi╚¢ia istoric─â de mediator (Acordurile Oslo 1993) ofer─â recunoa╚Öterii norvegiene o pondere simbolic─â excep╚¢ional─â.',
    badges: ['Recunoa╚Öte (2024)', 'Non-UE', 'Schengen']
  },
  {
    id: 'spain',
    nume: 'Spania',
    numeEn: 'Spain',
    categorie: 'rec',
    categorieLabel: 'Recunoa╚Öte Palestina',
    lat: 40.4637,
    lon: -3.7492,
    coords: [-3.7492, 40.4637],
    capitala: 'Madrid',
    populatie: 'Γëê 47 400 000 loc.',
    popVal: 47400000,
    suprafata: '505 990 km┬▓',
    supVal: 505990,
    zee: '2024',
    zeeVal: 2024,
    note: 'Spania a recunoscut oficial Statul Palestina la 28 mai 2024, sub conducerea premierului Pedro S├ínchez. Decizia a fost descris─â ca o necesitate istoric─â pentru ob╚¢inerea p─âcii ╚Öi implementarea rezolu╚¢iilor ONU.',
    ue: 'Stat membru al Uniunii Europene (din 1986).',
    schengen: 'Membru al Spa╚¢iului Schengen.',
    moneda: 'Euro (EUR)',
    viza: {
      temei: 'Hot─âr├órea Consiliului de Mini╚Ötri al Spaniei (mai 2024)',
      regim: 'Recunoa╚Ötere oficial─â deplin─â ca stat suveran',
      particular: 'Spania pledeaz─â activ pentru organizarea unei conferin╚¢e interna╚¢ionale de pace',
      observatie: 'Pedro S├ínchez a c─âl─âtorit personal ├«n regiune pentru a sus╚¢ine decizia'
    },
    particularitati: 'Promotorul principal din Europa de Vest al recunoa╚Öterii, asum├óndu-╚Öi un rol de lider diplomatic ├«n UE.',
    badges: ['Recunoa╚Öte (2024)', 'Membru UE', 'Schengen']
  },
  {
    id: 'ireland',
    nume: 'Irlanda',
    numeEn: 'Ireland',
    categorie: 'rec',
    categorieLabel: 'Recunoa╚Öte Palestina',
    lat: 53.4129,
    lon: -8.2439,
    coords: [-8.2439, 53.4129],
    capitala: 'Dublin',
    populatie: 'Γëê 5 000 000 loc.',
    popVal: 5000000,
    suprafata: '70 273 km┬▓',
    supVal: 70273,
    zee: '2024',
    zeeVal: 2024,
    note: 'Irlanda a recunoscut oficial Palestina la 28 mai 2024. Premierul Simon Harris a subliniat c─â poporul irlandez empatizeaz─â istoric profund cu lupta pentru autodeterminare ╚Öi recunoa╚Ötere statal─â.',
    ue: 'Stat membru al Uniunii Europene (din 1973).',
    schengen: 'Nu face parte din Schengen (men╚¢ine Common Travel Area cu UK).',
    moneda: 'Euro (EUR)',
    viza: {
      temei: 'Decizia Guvernului Irlandez (mai 2024)',
      regim: 'Rela╚¢ii diplomatice oficiale depline',
      particular: 'Sprijin public masiv din partea societ─â╚¢ii civile irlandeze',
      observatie: 'Irlanda a fost printre primele ╚¢─âri vest-europene care au cerut constant un stat palestinian'
    },
    particularitati: 'Sensibilitatea istoric─â fa╚¢─â de ocupa╚¢ie ╚Öi colonizare face din Irlanda cel mai vocal sus╚¢in─âtor al cauzei palestiniene din Europa de Vest.',
    badges: ['Recunoa╚Öte (2024)', 'Membru UE', 'Non-Schengen']
  },
  {
    id: 'sweden',
    nume: 'Suedia',
    numeEn: 'Sweden',
    categorie: 'rec',
    categorieLabel: 'Recunoa╚Öte Palestina',
    lat: 60.1282,
    lon: 18.6435,
    coords: [18.6435, 60.1282],
    capitala: 'Stockholm',
    populatie: 'Γëê 10 400 000 loc.',
    popVal: 10400000,
    suprafata: '450 295 km┬▓',
    supVal: 450295,
    zee: '2014',
    zeeVal: 2014,
    note: 'Suedia a devenit prima ╚¢ar─â membr─â a Uniunii Europene (care a aderat dup─â recunoa╚Ötere) care a recunoscut oficial Palestina la 30 octombrie 2014, sub guvernul social-democrat condus de Stefan L├╢fven.',
    ue: 'Stat membru al Uniunii Europene (din 1995).',
    schengen: 'Membru al Spa╚¢iului Schengen.',
    moneda: 'Coroan─â suedez─â (SEK)',
    viza: {
      temei: 'Decret oficial al Guvernului Suedez (octombrie 2014)',
      regim: 'Ambasad─â deplin─â la Stockholm ╚Öi Consulat general la Ierusalim',
      particular: 'Decizia a provocat ├«nghe╚¢area temporar─â a rela╚¢iilor diplomatice cu Israel ├«n 2014',
      observatie: 'Statutul a fost men╚¢inut ├«n ciuda schimb─ârilor ulterioare de guvern'
    },
    particularitati: 'Decizia din 2014 a spart ghea╚¢a diplomatic─â ├«n cadrul UE, de╚Öi a fost intens criticat─â de alia╚¢ii occidentali la acea vreme.',
    badges: ['Recunoa╚Öte (2014)', 'Membru UE', 'Schengen']
  },
  {
    id: 'united kingdom',
    nume: 'Regatul Unit',
    numeEn: 'United Kingdom',
    categorie: 'rec',
    categorieLabel: 'Recunoa╚Öte Palestina',
    lat: 55.3781,
    lon: -3.436,
    coords: [-3.436, 55.3781],
    capitala: 'Londra',
    populatie: 'Γëê 67 000 000 loc.',
    popVal: 67000000,
    suprafata: '243 610 km┬▓',
    supVal: 243610,
    zee: '2025',
    zeeVal: 2025,
    note: 'Regatul Unit a recunoscut oficial Statul Palestina ├«n septembrie 2025, o decizie istoric─â luat─â ├«n timpul sesiunii UNGA 80 de c─âtre cabinetul condus de Partidul Laburist, abandon├ónd pozi╚¢ia anterioar─â de recunoa╚Ötere doar ca rezultat al unui acord direct.',
    ue: 'Fost membru UE (Brexited ├«n 2020).',
    schengen: 'Nu este membru Schengen.',
    moneda: 'Lir─â sterlin─â (GBP)',
    viza: {
      temei: 'Declara╚¢ia oficial─â de politic─â extern─â a Guvernului Majest─â╚¢ii Sale (septembrie 2025)',
      regim: 'Rela╚¢ii diplomatice depline, ridicarea misiunii palestiniene la statut de ambasad─â',
      particular: 'Decizie de cotitur─â istoric─â av├ónd ├«n vedere responsabilitatea istoric─â a Mandatului Britanic (Declara╚¢ia Balfour 1917)',
      observatie: 'Anun╚¢ corelat ╚Öi sprijinit de Fran╚¢a ├«n cadrul UNGA 80'
    },
    particularitati: 'O schimbare seismic─â ├«n geopolitica mondial─â, av├ónd ├«n vedere statutul UK de membru permanent al Consiliului de Securitate al ONU.',
    badges: ['Recunoa╚Öte (2025)', 'Membru Permanent Consiliu Securitate', 'Balfour Legacy']
  },
  {
    id: 'france',
    nume: 'Fran╚¢a',
    numeEn: 'France',
    categorie: 'rec',
    categorieLabel: 'Recunoa╚Öte Palestina',
    lat: 46.2276,
    lon: 2.2137,
    coords: [2.2137, 46.2276],
    capitala: 'Paris',
    populatie: 'Γëê 68 000 000 loc.',
    popVal: 68000000,
    suprafata: '551 695 km┬▓',
    supVal: 551695,
    zee: '2025',
    zeeVal: 2025,
    note: 'Fran╚¢a a recunoscut oficial Statul Palestina ├«n septembrie 2025. Pre╚Öedintele Emmanuel Macron a anun╚¢at decizia istoric─â la Adunarea General─â a ONU (UNGA 80), preciz├ónd c─â Fran╚¢a consider─â c─â blocajul din regiune face imposibil─â solu╚¢ia celor dou─â state f─âr─â acest act suveran.',
    ue: 'Stat membru al Uniunii Europene (fondator).',
    schengen: 'Membru al Spa╚¢iului Schengen.',
    moneda: 'Euro (EUR)',
    viza: {
      temei: 'Declara╚¢ia solemn─â a Pre╚Öedintelui Republicii Franceze la UNGA 80 (septembrie 2025)',
      regim: 'Rela╚¢ii diplomatice oficiale depline la nivel de Ambasador',
      particular: 'Fran╚¢a men╚¢ine o re╚¢ea cultural─â ╚Öi consular─â istoric─â ├«n Ierusalimul de Est',
      observatie: 'A marcat o aliniere strategic─â deosebit─â cu Regatul Unit ├«n toamna anului 2025'
    },
    particularitati: 'A doua mare putere nuclear─â din Europa ╚Öi membru permanent al CS al ONU care recunoa╚Öte Palestina.',
    badges: ['Recunoa╚Öte (2025)', 'Membru UE', 'Schengen']
  },
  {
    id: 'belgium',
    nume: 'Belgia',
    numeEn: 'Belgium',
    categorie: 'rec',
    categorieLabel: 'Recunoa╚Öte Palestina',
    lat: 50.8503,
    lon: 4.3517,
    coords: [4.3517, 50.8503],
    capitala: 'Bruxelles',
    populatie: 'Γëê 11 600 000 loc.',
    popVal: 11600000,
    suprafata: '30 689 km┬▓',
    supVal: 30689,
    zee: '2025',
    zeeVal: 2025,
    note: 'Belgia a recunoscut oficial Palestina ├«n septembrie 2025, ca parte a unui val coordonat vest-european la ONU. Parlamentul belgian aprobase rezolu╚¢ii favorabile ├«nc─â din anii anteriori, condi╚¢ionate ├«ns─â de contextul politic.',
    ue: 'Stat membru al Uniunii Europene (fondator).',
    schengen: 'Membru al Spa╚¢iului Schengen.',
    moneda: 'Euro (EUR)',
    viza: {
      temei: 'Decizia Guvernului Federal Belgian (septembrie 2025)',
      regim: 'Rela╚¢ii diplomatice oficiale depline',
      particular: 'Bruxelles g─âzduie╚Öte institu╚¢iile UE, oferind deciziei un impact simbolic adi╚¢ional',
      observatie: 'Sprijin masiv din partea regiunilor Valonia ╚Öi Flandra'
    },
    particularitati: 'Capitala simbolic─â a Europei recunoa╚Öte acum oficial ambele state din conflict.',
    badges: ['Recunoa╚Öte (2025)', 'Membru UE', 'Schengen']
  },
  {
    id: 'portugal',
    nume: 'Portugalia',
    numeEn: 'Portugal',
    categorie: 'rec',
    categorieLabel: 'Recunoa╚Öte Palestina',
    lat: 39.3999,
    lon: -8.2245,
    coords: [-8.2245, 39.3999],
    capitala: 'Lisabona',
    populatie: 'Γëê 10 300 000 loc.',
    popVal: 10300000,
    suprafata: '92 090 km┬▓',
    supVal: 92090,
    zee: '2025',
    zeeVal: 2025,
    note: 'Portugalia s-a al─âturat valului istoric din septembrie 2025, recunosc├ónd oficial Statul Palestina ├«n marja Adun─ârii Generale a ONU. Decizia a urmat recomand─ârilor repetate ale Parlamentului portughez.',
    ue: 'Stat membru al Uniunii Europene (din 1986).',
    schengen: 'Membru al Spa╚¢iului Schengen.',
    moneda: 'Euro (EUR)',
    viza: {
      temei: 'Decret-Lege al Guvernului Republicii Portugheze (septembrie 2025)',
      regim: 'Stabilirea de rela╚¢ii diplomatice formale',
      particular: 'Aliniere deplin─â cu pozi╚¢ia Spaniei, vecina sa iberic─â',
      observatie: 'Consens politic larg ├«ntre principalele partide de st├ónga ╚Öi centru-dreapta'
    },
    particularitati: 'Finalizeaz─â reprezentarea complet─â a Peninsulei Iberice ├«n tab─âra ╚¢─ârilor care recunosc Palestina.',
    badges: ['Recunoa╚Öte (2025)', 'Membru UE', 'Schengen']
  },
  {
    id: 'poland',
    nume: 'Polonia',
    numeEn: 'Poland',
    categorie: 'rec',
    categorieLabel: 'Recunoa╚Öte Palestina',
    lat: 51.9194,
    lon: 19.1451,
    coords: [19.1451, 51.9194],
    capitala: 'Var╚Öovia',
    populatie: 'Γëê 38 000 000 loc.',
    popVal: 38000000,
    suprafata: '312 696 km┬▓',
    supVal: 312696,
    zee: '1988',
    zeeVal: 1988,
    note: 'Polonia a recunoscut Palestina la 14 decembrie 1988 ca stat suveran ├«n perioada regimului comunist (Republica Popular─â Polon─â). Misiunea diplomatic─â a Palestinei la Var╚Öovia a fost deschis─â imediat dup─â.',
    ue: 'Stat membru al Uniunii Europene (din 2004).',
    schengen: 'Membru al Spa╚¢iului Schengen.',
    moneda: 'Zlot polonez (PLN)',
    viza: {
      temei: 'Declara╚¢ia formal─â a Guvernului Polonez din decembrie 1988',
      regim: 'Rela╚¢ii diplomatice bilaterale depline',
      particular: 'Polonia a men╚¢inut recunoa╚Öterea ╚Öi dup─â tranzi╚¢ia democratic─â din 1989',
      observatie: 'Men╚¢ine un dialog activ cu ambele p─âr╚¢i ale conflictului'
    },
    particularitati: 'Una dintre cele mai mari ╚¢─âri din flancul estic al UE care men╚¢ine recunoa╚Öterea oficial─â din perioada R─âzboiului Rece.',
    badges: ['Recunoa╚Öte (1988)', 'Membru UE', 'Schengen']
  },
  {
    id: 'bulgaria',
    nume: 'Bulgaria',
    numeEn: 'Bulgaria',
    categorie: 'rec',
    categorieLabel: 'Recunoa╚Öte Palestina',
    lat: 42.7339,
    lon: 25.4858,
    coords: [25.4858, 42.7339],
    capitala: 'Sofia',
    populatie: 'Γëê 6 900 000 loc.',
    popVal: 6900000,
    suprafata: '110 994 km┬▓',
    supVal: 110994,
    zee: '1988',
    zeeVal: 1988,
    note: 'Bulgaria a recunoscut oficial Statul Palestina la 25 noiembrie 1988. Rela╚¢iile diplomatice formale au fost stabilire ├«n decembrie 1988 la nivel de ambasad─â.',
    ue: 'Stat membru al Uniunii Europene (din 2007).',
    schengen: 'Membru al Spa╚¢iului Schengen (aerian/maritim din martie 2024).',
    moneda: 'Leva bulg─âreasc─â (BGN)',
    viza: {
      temei: 'Decizia Consiliului de Stat al Republicii Populare Bulgaria (noiembrie 1988)',
      regim: 'Ambasad─â palestinian─â deschis─â la Sofia',
      particular: 'Bulgaria sprijin─â rezolu╚¢iile ONU privind pacea ├«n Orientul Mijlociu',
      observatie: 'Schimburi comerciale ╚Öi educa╚¢ionale istorice ├«n perioada 1988-1990'
    },
    particularitati: 'Urmeaz─â linia diplomatic─â stabilit─â de ╚¢─ârile din Pactul de la Var╚Öovia ├«n 1988.',
    badges: ['Recunoa╚Öte (1988)', 'Membru UE', 'Schengen']
  },
  {
    id: 'slovakia',
    nume: 'Slovacia',
    numeEn: 'Slovakia',
    categorie: 'rec',
    categorieLabel: 'Recunoa╚Öte Palestina',
    lat: 48.669,
    lon: 19.699,
    coords: [19.699, 48.669],
    capitala: 'Bratislava',
    populatie: 'Γëê 5 400 000 loc.',
    popVal: 5400000,
    suprafata: '49 035 km┬▓',
    supVal: 49035,
    zee: '1988',
    zeeVal: 1988,
    note: 'Slovacia a mo╚Ötenit statutul de recunoa╚Ötere oficial─â de la fosta Cehoslovacie, care a recunoscut Palestina la 18 noiembrie 1988. La dizolvarea pa╚Önic─â a federa╚¢iei ├«n 1993, Slovacia a ales s─â continue rela╚¢iile depline.',
    ue: 'Stat membru al Uniunii Europene (din 2004).',
    schengen: 'Membru al Spa╚¢iului Schengen.',
    moneda: 'Euro (EUR)',
    viza: {
      temei: 'Declara╚¢ia de succesiune a tratatelor interna╚¢ionale din 1 ianuarie 1993',
      regim: 'Rela╚¢ii diplomatice oficiale depline la nivel de Ambasad─â',
      particular: 'Slovacia are o pozi╚¢ie nuan╚¢at─â, diferit─â de cea a Cehiei vecine',
      observatie: 'Ambasada Palestinei este activ─â ├«n Bratislava'
    },
    particularitati: 'Spre deosebire de Cehia care contest─â recunoa╚Öterea din 1988, Slovacia a men╚¢inut un caracter diplomatic neutru-pozitiv.',
    badges: ['Recunoa╚Öte (1988)', 'Membru UE', 'Schengen']
  },
  {
    id: 'ukraine',
    nume: 'Ucraina',
    numeEn: 'Ukraine',
    categorie: 'rec',
    categorieLabel: 'Recunoa╚Öte Palestina',
    lat: 48.3794,
    lon: 31.1656,
    coords: [31.1656, 48.3794],
    capitala: 'Kiev',
    populatie: 'Γëê 41 000 000 loc.',
    popVal: 41000000,
    suprafata: '603 628 km┬▓',
    supVal: 603628,
    zee: '1988',
    zeeVal: 1988,
    note: 'Ucraina (ca RSS Ucrainean─â ├«n cadrul URSS) a votat ╚Öi a recunoscut oficial independen╚¢a Palestinei la 19 noiembrie 1988. Dup─â declararea independen╚¢ei ├«n 1991, statul ucrainean a reconfirmat statutul diplomatic.',
    ue: 'Stat candidat la aderarea ├«n Uniunea European─â.',
    schengen: 'Nu face parte din Schengen.',
    moneda: 'Hrivn─â ucrainean─â (UAH)',
    viza: {
      temei: 'Decizia Parlamentului Ucrainean (Rada Suprem─â) din 1991',
      regim: 'Misiune diplomatic─â activ─â la Kiev',
      particular: 'Rela╚¢iile au continuat activ inclusiv ├«n timpul conflictelor geopolitice din flancul estic',
      observatie: 'Ucraina pledeaz─â pentru respectarea dreptului interna╚¢ional ├«n ambele cazuri'
    },
    particularitati: 'O pozi╚¢ie complex─â, fiind un partener strategic major al SUA ╚Öi av├ónd rela╚¢ii diplomatice solide cu ambele state.',
    badges: ['Recunoa╚Öte (1988)', 'Candidat UE', 'Flancul Estic']
  },
  {
    id: 'belarus',
    nume: 'Belarus',
    numeEn: 'Belarus',
    categorie: 'rec',
    categorieLabel: 'Recunoa╚Öte Palestina',
    lat: 53.7098,
    lon: 27.9534,
    coords: [27.9534, 53.7098],
    capitala: 'Minsk',
    populatie: 'Γëê 9 400 000 loc.',
    popVal: 9400000,
    suprafata: '207 600 km┬▓',
    supVal: 207600,
    zee: '1988',
    zeeVal: 1988,
    note: 'Belarus (ca RSS Bielorus─â) a recunoscut Palestina ├«n noiembrie 1988. Rela╚¢iile diplomatice depline au fost men╚¢inute f─âr─â ├«ntrerupere dup─â dizolvarea URSS ├«n 1991.',
    ue: 'Nu este membru UE ╚Öi nu este candidat.',
    schengen: 'Nu face parte din Schengen.',
    moneda: 'Rubl─â belarus─â (BYN)',
    viza: {
      temei: 'Succesiunea acordurilor sovietice ├«n 1991',
      regim: 'Ambasad─â func╚¢ional─â la Minsk',
      particular: 'Belarus are o pozi╚¢ie ferm─â pro-palestinian─â pe scena interna╚¢ional─â',
      observatie: 'Vizite guvernamentale bilaterale periodice'
    },
    particularitati: 'Aliniere total─â cu linia istoric─â a Moscovei ├«n ceea ce prive╚Öte geopolitica Orientului Mijlociu.',
    badges: ['Recunoa╚Öte (1988)', 'Non-UE', 'Minsk Group']
  },
  {
    id: 'slovenia',
    nume: 'Slovenia',
    numeEn: 'Slovenia',
    categorie: 'rec',
    categorieLabel: 'Recunoa╚Öte Palestina',
    lat: 46.1512,
    lon: 14.9955,
    coords: [14.9955, 46.1512],
    capitala: 'Ljubljana',
    populatie: 'Γëê 2 100 000 loc.',
    popVal: 2100000,
    suprafata: '20 273 km┬▓',
    supVal: 20273,
    zee: '2024',
    zeeVal: 2024,
    note: 'Slovenia a recunoscut oficial Statul Palestina la 4 iunie 2024, dup─â ce Parlamentul de la Ljubljana a votat cu o majoritate cov├ór╚Öitoare propunerea ├«naintat─â de premierul Robert Golob, ca reac╚¢ie la criza umanitar─â din Gaza.',
    ue: 'Stat membru al Uniunii Europene (din 2004).',
    schengen: 'Membru al Spa╚¢iului Schengen.',
    moneda: 'Euro (EUR)',
    viza: {
      temei: 'Votul oficial al Parlamentului Sloven (iunie 2024)',
      regim: 'Rela╚¢ii diplomatice formale depline ca stat suveran',
      particular: 'Procedura a fost accelerat─â pentru a se corela cu ini╚¢iativa spaniolo-irlandez─â',
      observatie: 'Opozi╚¢ia de dreapta a ├«ncercat suspendarea votului, f─âr─â succes'
    },
    particularitati: 'Prima ╚¢ar─â din fosta Iugoslavie (care a aderat ulterior la UE) care a realizat acest pas diplomatic formal dup─â dizolvarea federa╚¢iei.',
    badges: ['Recunoa╚Öte (2024)', 'Membru UE', 'Schengen']
  },
  {
    id: 'iceland',
    nume: 'Islanda',
    numeEn: 'Iceland',
    categorie: 'rec',
    categorieLabel: 'Recunoa╚Öte Palestina',
    lat: 64.9631,
    lon: -19.0208,
    coords: [-19.0208, 64.9631],
    capitala: 'Reykjav├¡k',
    populatie: 'Γëê 370 000 loc.',
    popVal: 370000,
    suprafata: '103 000 km┬▓',
    supVal: 103000,
    zee: '2011',
    zeeVal: 2011,
    note: 'Islanda a recunoscut oficial Palestina ca stat suveran ╚Öi independent la 29 noiembrie 2011, ├«n urma unei rezolu╚¢ii aprobate ├«n unanimitate de Parlamentul de la Reykjav├¡k (Althing), fiind primul stat pur vest-european care a f─âcut acest pas.',
    ue: 'Nu este membru UE.',
    schengen: 'Membru al Spa╚¢iului Schengen (prin acorduri asociate).',
    moneda: 'Coroan─â islandez─â (ISK)',
    viza: {
      temei: 'Rezolu╚¢ia oficial─â a Parlamentului Islandez (noiembrie 2011)',
      regim: 'Rela╚¢ii diplomatice formale active',
      particular: 'Votul istoric a coincis cu Ziua Interna╚¢ional─â de Solidaritate cu Poporul Palestinian',
      observatie: 'Islanda a sus╚¢inut constant statutul de membru observator al Palestinei la ONU'
    },
    particularitati: 'Decizia istoric─â din 2011 a reconfirmat politica extern─â profund independent─â a Islandei.',
    badges: ['Recunoa╚Öte (2011)', 'Non-UE', 'Schengen']
  },
  {
    id: 'cyprus',
    nume: 'Cipru',
    numeEn: 'Cyprus',
    categorie: 'rec',
    categorieLabel: 'Recunoa╚Öte Palestina',
    lat: 35.1264,
    lon: 33.4299,
    coords: [33.4299, 35.1264],
    capitala: 'Nicosia',
    populatie: 'Γëê 1 200 000 loc.',
    popVal: 1200000,
    suprafata: '9 251 km┬▓',
    supVal: 9251,
    zee: '1988',
    zeeVal: 1988,
    note: 'Cipru a recunoscut Palestina ├«n noiembrie 1988. ├Än ciuda rela╚¢iilor extrem de apropiate geopolitic din prezent cu Israelul, Cipru continu─â s─â men╚¢in─â ├«n mod oficial recunoa╚Öterea ╚Öi Ambasada Palestinei la Nicosia.',
    ue: 'Stat membru al Uniunii Europene (din 2004).',
    schengen: 'Nu face parte din Schengen.',
    moneda: 'Euro (EUR)',
    viza: {
      temei: 'Decizia oficial─â a Pre╚Öedintelui cipriot George Vassiliou (noiembrie 1988)',
      regim: 'Reprezentare diplomatic─â reciproc─â complet─â',
      particular: 'Cipru a reconfirmat pozi╚¢ia istoric─â ├«n 2011, preciz├ónd c─â nu va reveni asupra deciziei',
      observatie: 'Oportunit─â╚¢i educa╚¢ionale de lung─â durat─â oferite studen╚¢ilor palestinieni'
    },
    particularitati: 'O pozi╚¢ie de echilibru delicat ├«n Mediterana de Est, ├«mp─âr╚¢it ├«ntre leg─âturile istorice cu lumea arab─â ╚Öi parteneriatul energetic modern cu Israel.',
    badges: ['Recunoa╚Öte (1988)', 'Membru UE', 'Pozi╚¢ie Delicat─â']
  },
  {
    id: 'albania',
    nume: 'Albania',
    numeEn: 'Albania',
    categorie: 'rec',
    categorieLabel: 'Recunoa╚Öte Palestina',
    lat: 41.1533,
    lon: 20.1683,
    coords: [20.1683, 41.1533],
    capitala: 'Tirana',
    populatie: 'Γëê 2 800 000 loc.',
    popVal: 2800000,
    suprafata: '28 748 km┬▓',
    supVal: 28748,
    zee: '1988',
    zeeVal: 1988,
    note: 'Albania a recunoscut Statul Palestina la 17 noiembrie 1988, ├«n timpul regimului socialist. Rela╚¢iile diplomatice au fost p─âstrate ne├«ntrerupt, exist├ónd Ambasada Palestinei la Tirana.',
    ue: 'Stat candidat la aderarea ├«n Uniunea European─â.',
    schengen: 'Nu face parte din Schengen.',
    moneda: 'Lek albanez (ALL)',
    viza: {
      temei: 'Declara╚¢ia oficial─â a Guvernului Socialist al Albaniei (noiembrie 1988)',
      regim: 'Rela╚¢ii diplomatice bilaterale func╚¢ionale',
      particular: 'Albania sprijin─â constant solu╚¢ia pacii durabile bazat─â pe cele dou─â state',
      observatie: 'Schimburi diplomatice periodice constructive'
    },
    particularitati: 'Are un profil unic ├«n Balcanii de Vest, av├ónd o popula╚¢ie majoritar musulman─â dar ╚Öi rela╚¢ii politice solide cu SUA.',
    badges: ['Recunoa╚Öte (1988)', 'Candidat UE', 'Balcani']
  },
  {
    id: 'serbia',
    nume: 'Serbia',
    numeEn: 'Serbia',
    categorie: 'rec',
    categorieLabel: 'Recunoa╚Öte Palestina',
    lat: 44.0165,
    lon: 21.0059,
    coords: [21.0059, 44.0165],
    capitala: 'Belgrad',
    populatie: 'Γëê 6 800 000 loc.',
    popVal: 6800000,
    suprafata: '88 361 km┬▓',
    supVal: 88361,
    zee: '1988',
    zeeVal: 1988,
    note: 'Serbia a mo╚Ötenit recunoa╚Öterea oficial─â de la fosta Iugoslavie (SFRJ), care a recunoscut Palestina la 16 noiembrie 1988. Iugoslavia a fost un lider istoric al Mi╚Öc─ârii de Non-Aliniere, oferind sprijin diplomatic masiv PLO.',
    ue: 'Stat candidat la aderarea ├«n Uniunea European─â.',
    schengen: 'Nu face parte din Schengen.',
    moneda: 'Dinar s├órbesc (RSD)',
    viza: {
      temei: 'Succesiunea direct─â a tratatelor diplomatice ale SFR Iugoslavia',
      regim: 'Ambasada Palestinei deschis─â activ la Belgrad',
      particular: 'Serbia sprijin─â Palestina, iar la r├óndul s─âu, Palestina nu recunoa╚Öte independen╚¢a Kosovo',
      observatie: 'Rela╚¢ii de sprijin diplomatic reciproc extrem de solide'
    },
    particularitati: 'Sprijinul s├órbesc este consolidat de faptul c─â Autoritatea Palestinian─â refuz─â strict recunoa╚Öterea Kosovo, sus╚¢in├ónd integritatea teritorial─â a Serbiei.',
    badges: ['Recunoa╚Öte (1988)', 'Candidat UE', 'Kosovo Issue']
  },
  {
    id: 'bosnia and herz.',
    nume: 'Bosnia-Her╚¢.',
    numeEn: 'Bosnia and Herzegovina',
    categorie: 'rec',
    categorieLabel: 'Recunoa╚Öte Palestina',
    lat: 43.9159,
    lon: 17.6791,
    coords: [17.6791, 43.9159],
    capitala: 'Sarajevo',
    populatie: 'Γëê 3 200 000 loc.',
    popVal: 3200000,
    suprafata: '51 129 km┬▓',
    supVal: 51129,
    zee: '1992',
    zeeVal: 1992,
    note: 'Bosnia ╚Öi Her╚¢egovina a recunoscut oficial Palestina la 27 mai 1992, imediat dup─â declararea propriei sale independen╚¢e ├«n timpul destr─âm─ârii Iugoslaviei, continu├ónd linia istoric─â stabilit─â de Belgrad.',
    ue: 'Stat candidat la aderarea ├«n Uniunea European─â.',
    schengen: 'Nu face parte din Schengen.',
    moneda: 'Marc─â convertibil─â (BAM)',
    viza: {
      temei: 'Decretul Pre╚Öedin╚¢iei colective a Bosniei din mai 1992',
      regim: 'Rela╚¢ii de reprezentare diplomatic─â',
      particular: 'Consens fragil local din cauza structurii etnice complexe a ╚¢─ârii',
      observatie: 'Misiunea palestinian─â este coordonat─â activ la Sarajevo'
    },
    particularitati: 'De╚Öi structura etnic─â intern─â tripartit─â genereaz─â uneori tensiuni de politic─â extern─â, recunoa╚Öterea oficial─â a fost men╚¢inut─â stabil─â.',
    badges: ['Recunoa╚Öte (1992)', 'Candidat UE', 'Balcani']
  },
  {
    id: 'macedonia',
    nume: 'Macedonia de Nord',
    numeEn: 'North Macedonia',
    categorie: 'rec',
    categorieLabel: 'Recunoa╚Öte Palestina',
    lat: 41.6086,
    lon: 21.7453,
    coords: [21.7453, 41.6086],
    capitala: 'Skopje',
    populatie: 'Γëê 2 000 000 loc.',
    popVal: 2000000,
    suprafata: '25 713 km┬▓',
    supVal: 25713,
    zee: '1990',
    zeeVal: 1990,
    note: 'Macedonia de Nord a recunoscut Palestina ├«n anul 1990, ca parte a procesului de succesiune iugoslav, consolid├ónd ulterior rela╚¢iile formale diplomatice.',
    ue: 'Stat candidat la aderarea ├«n Uniunea European─â.',
    schengen: 'Nu face parte din Schengen.',
    moneda: 'Denar macedonean (MKD)',
    viza: {
      temei: 'Deciziile bilaterale formale post-independen╚¢─â',
      regim: 'Rela╚¢ii de sprijin diplomatic',
      particular: 'Skopje urmeaz─â ├«n mare parte linia de politic─â extern─â a UE ╚Öi SUA',
      observatie: 'Pozi╚¢ie diplomatic─â relativ discret─â dar stabil─â'
    },
    particularitati: 'Men╚¢ine o pozi╚¢ie constructiv─â, aliniat─â cu tratatele interna╚¢ionale ale dreptului umanitar.',
    badges: ['Recunoa╚Öte (1990)', 'Candidat UE', 'Balcani']
  },
  {
    id: 'montenegro',
    nume: 'Muntenegru',
    numeEn: 'Montenegro',
    categorie: 'rec',
    categorieLabel: 'Recunoa╚Öte Palestina',
    lat: 42.7087,
    lon: 19.3744,
    coords: [19.3744, 42.7087],
    capitala: 'Podgorica',
    populatie: 'Γëê 620 000 loc.',
    popVal: 620000,
    suprafata: '13 812 km┬▓',
    supVal: 13812,
    zee: '2006',
    zeeVal: 2006,
    note: 'Muntenegru a recunoscut Palestina ├«n mod oficial ├«n anul 2006, la scurt timp dup─â ob╚¢inerea independen╚¢ei sale prin dizolvarea uniunii statale cu Serbia.',
    ue: 'Stat candidat avansat la aderarea ├«n Uniunea European─â.',
    schengen: 'Nu face parte din Schengen.',
    moneda: 'Euro (EUR) ΓÇö utilizat de facto',
    viza: {
      temei: 'Declara╚¢ia oficial─â de politic─â extern─â din anul 2006',
      regim: 'Rela╚¢ii diplomatice formale',
      particular: 'Coordonare str├óns─â cu pozi╚¢iile europene',
      observatie: 'Muntenegru sprijin─â activ eforturile interna╚¢ionale pentru pace'
    },
    particularitati: 'Una dintre cele mai rapide integr─âri a recunoa╚Öterii succesorale dup─â declararea independen╚¢ei ├«n Balcani.',
    badges: ['Recunoa╚Öte (2006)', 'Candidat UE', 'Eurozone']
  },
  {
    id: 'germany',
    nume: 'Germania',
    numeEn: 'Germany',
    categorie: 'norec',
    categorieLabel: 'Nu recunoa╚Öte',
    lat: 51.1657,
    lon: 10.4515,
    coords: [10.4515, 51.1657],
    capitala: 'Berlin',
    populatie: 'Γëê 83 200 000 loc.',
    popVal: 83200000,
    suprafata: '357 022 km┬▓',
    supVal: 357022,
    zee: 'ΓÇö',
    zeeVal: 9999,
    note: 'Germania nu recunoa╚Öte oficial Palestina ca stat, sus╚¢in├ónd ferm c─â statutul statalitate poate fi ob╚¢inut exclusiv ├«n urma unor negocieri directe finalizate ├«ntre Israel ╚Öi Autoritatea Palestinian─â.',
    ue: 'Stat membru al Uniunii Europene (fondator).',
    schengen: 'Membru al Spa╚¢iului Schengen.',
    moneda: 'Euro (EUR)',
    viza: {
      temei: 'Linia oficial─â a Ministerului Federal al Afacerilor Externe (Ausw├ñrtiges Amt)',
      regim: 'F─âr─â recunoa╚Ötere formal─â, ├«ns─â men╚¢ine Reprezentan╚¢a Germaniei la Ramallah',
      particular: 'Germania este unul dintre cei mai mari donatori de ajutor umanitar ╚Öi dezvoltare pentru teritoriile palestiniene',
      observatie: 'Responsabilitatea istoric─â fa╚¢─â de securitatea statului Israel este considerat─â ra╚¢iune de stat (Staatsr├ñson)'
    },
    particularitati: 'Pozi╚¢ie extrem de ferm─â, influen╚¢at─â profund de factori istorici sensibili post-WWII.',
    badges: ['Nu recunoa╚Öte', 'Membru UE', 'Schengen']
  },
  {
    id: 'italy',
    nume: 'Italia',
    numeEn: 'Italy',
    categorie: 'norec',
    categorieLabel: 'Nu recunoa╚Öte',
    lat: 41.8719,
    lon: 12.5674,
    coords: [12.5674, 41.8719],
    capitala: 'Roma',
    populatie: 'Γëê 59 000 000 loc.',
    popVal: 59000000,
    suprafata: '301 340 km┬▓',
    supVal: 301340,
    zee: 'ΓÇö',
    zeeVal: 9999,
    note: 'Italia nu recunoa╚Öte oficial Palestina. Cu toate acestea, guvernul italian a indicat de mai multe ori disponibilitatea de a recunoa╚Öte statul ├«n viitor, ├«ns─â exclusiv sub auspiciile unui proces de pace agreat de ambele p─âr╚¢i.',
    ue: 'Stat membru al Uniunii Europene (fondator).',
    schengen: 'Membru al Spa╚¢iului Schengen.',
    moneda: 'Euro (EUR)',
    viza: {
      temei: 'Pozi╚¢ia oficial─â a Ministerului Afacerilor Externe (Farnesina)',
      regim: 'Men╚¢ine rela╚¢ii diplomatice neoficiale de nivel ├«nalt cu Autoritatea Palestinian─â',
      particular: 'Parlamentul italian a aprobat ├«n trecut rezolu╚¢ii cu caracter orientativ recomand├ónd recunoa╚Öterea',
      observatie: 'Sprijin activ pentru proiecte umanitare ├«n Cisiordania ╚Öi Gaza'
    },
    particularitati: 'O atitudine considerat─â "flexibil─â" dar prudent─â, str├óns aliniat─â cu pozi╚¢iile oficiale de la Washington ╚Öi Bruxelles.',
    badges: ['Nu recunoa╚Öte', 'Membru UE', 'Schengen']
  },
  {
    id: 'france_placeholder_norec',
    idReal: 'france',
    nume: 'Fran╚¢a (Istoric)',
    numeEn: 'France_Placeholder',
    categorie: 'norec',
    popVal: 0, supVal: 0, zeeVal: 9999, note: 'Pentru evitarea erorilor, Fran╚¢a este trecut─â ├«n categoria celor care recunosc dup─â decizia istoric─â din septembrie 2025.',
    badges: []
  },
  {
    id: 'austria',
    nume: 'Austria',
    numeEn: 'Austria',
    categorie: 'norec',
    categorieLabel: 'Nu recunoa╚Öte',
    lat: 47.5162,
    lon: 14.5501,
    coords: [14.5501, 47.5162],
    capitala: 'Viena',
    populatie: 'Γëê 8 900 000 loc.',
    popVal: 8900000,
    suprafata: '83 879 km┬▓',
    supVal: 83879,
    zee: 'ΓÇö',
    zeeVal: 9999,
    note: 'Austria nu recunoa╚Öte oficial Palestina ca stat. Pozi╚¢ia sa extern─â sprijin─â o solu╚¢ie negociat─â, resping├ónd deciziile unilaterale de recunoa╚Ötere ├«n afara acordurilor de pace.',
    ue: 'Stat membru al Uniunii Europene (din 1995).',
    schengen: 'Membru al Spa╚¢iului Schengen.',
    moneda: 'Euro (EUR)',
    viza: {
      temei: 'Strategia oficial─â a Ministerului de Externe de la Viena',
      regim: 'Rela╚¢ii diplomatice limitate la reprezentan╚¢─â oficial─â',
      particular: 'Austria a devenit ├«n ultimii ani unul dintre cei mai fermi sus╚¢in─âtori europeni ai Israelului',
      observatie: 'Pozi╚¢ie restrictiv─â privind rezolu╚¢iile favorabile Palestinei la ONU'
    },
    particularitati: 'O turnur─â puternic pro-Israel ├«n ultimul deceniu, schimb├ónd politica istoric─â mai neutr─â a fostului cancelar Bruno Kreisky.',
    badges: ['Nu recunoa╚Öte', 'Membru UE', 'Schengen']
  },
  {
    id: 'hungary',
    nume: 'Ungaria',
    numeEn: 'Hungary',
    categorie: 'contested',
    categorieLabel: 'Recunoa╚Öte (Contestat)',
    lat: 47.1625,
    lon: 19.5033,
    coords: [19.5033, 47.1625],
    capitala: 'Budapesta',
    populatie: 'Γëê 9 700 000 loc.',
    popVal: 9700000,
    suprafata: '93 028 km┬▓',
    supVal: 93028,
    zee: '1988',
    zeeVal: 1988,
    note: 'Ungaria a recunoscut Palestina ├«n mod oficial la 23 noiembrie 1988 (├«n perioada regimului comunist din Republica Popular─â Ungar─â). ├Än prezent, sub conducerea cabinetului condus de Viktor Orb├ín, Ungaria contest─â de facto acea decizie istoric─â, fiind cel mai ferm aliat al Israelului ├«n cadrul UE.',
    ue: 'Stat membru al Uniunii Europene (din 2004).',
    schengen: 'Membru al Spa╚¢iului Schengen.',
    moneda: 'Forint maghiar (HUF)',
    viza: {
      temei: 'Deciziile constitu╚¢ionale de analiz─â a tratatelor socialiste',
      regim: 'Rela╚¢ii diplomatice formale ├«nghe╚¢ate sau reduse la minim',
      particular: 'Ungaria blocheaz─â constant declara╚¢iile comune ale UE care critic─â Israelul',
      observatie: 'Ambasada Palestinei r─âm├óne fizic deschis─â la Budapesta din ra╚¢iuni juridice complexe'
    },
    particularitati: 'Cel mai straniu caz diplomatic: tehnic men╚¢ine o recunoa╚Ötere din 1988 pe care politic o respinge ╚Öi o blocheaz─â sistematic.',
    badges: ['Contestat de facto', 'Membru UE', 'Schengen']
  },
  {
    id: 'czechia',
    nume: 'Cehia',
    numeEn: 'Czech Republic',
    categorie: 'contested',
    categorieLabel: 'Recunoa╚Öte (Contestat)',
    lat: 49.8175,
    lon: 15.473,
    coords: [15.473, 49.8175],
    capitala: 'Praga',
    populatie: 'Γëê 10 700 000 loc.',
    popVal: 10700000,
    suprafata: '78 867 km┬▓',
    supVal: 78867,
    zee: '1988',
    zeeVal: 1988,
    note: 'Cehoslovacia a recunoscut oficial Palestina la 18 noiembrie 1988. ├Än urma diviz─ârii, Cehia a succedat tratatele dar a precizat oficial ├«n repetate r├ónduri c─â acea recunoa╚Ötere comunist─â nu mai reflect─â politica extern─â actual─â, Praga fiind cel mai apropiat partener strategic al Israelului din Europa.',
    ue: 'Stat membru al Uniunii Europene (din 2004).',
    schengen: 'Membru al Spa╚¢iului Schengen.',
    moneda: 'Coroan─â ceh─â (CZK)',
    viza: {
      temei: 'Declara╚¢iile Ministerului Afacerilor Externe al Cehiei privind validitatea recunoa╚Öterii istorice',
      regim: 'Rela╚¢ii diplomatice bilaterale minime, puternic nuan╚¢ate',
      particular: 'Praga a votat constant ├«mpotriva rezolu╚¢iilor palestiniene la Adunarea General─â a ONU',
      observatie: 'Exist─â Ambasada Palestinei la Praga, ├«n ciuda protestelor politice interne'
    },
    particularitati: 'Pozi╚¢ie oficial─â extrem de critic─â fa╚¢─â de Autoritatea Palestinian─â, sprijinind total mutarea ambasadelor la Ierusalim.',
    badges: ['Contestat de facto', 'Membru UE', 'Schengen']
  },
  {
    id: 'greece',
    nume: 'Grecia',
    numeEn: 'Greece',
    categorie: 'norec',
    categorieLabel: 'Nu recunoa╚Öte',
    lat: 39.0742,
    lon: 21.8243,
    coords: [21.8243, 39.0742],
    capitala: 'Atena',
    populatie: 'Γëê 10 400 000 loc.',
    popVal: 10400000,
    suprafata: '131 957 km┬▓',
    supVal: 131957,
    zee: 'ΓÇö',
    zeeVal: 9999,
    note: 'Grecia nu recunoa╚Öte ├«n mod oficial Palestina, ├«n ciuda unor rezolu╚¢ii favorabile adoptate ├«n unanimitate de Parlamentul elen ├«n anul 2015. Guvernul grec a ales s─â nu pun─â ├«n aplicare recomand─ârile legislative pentru a nu afecta parteneriatul strategic cu Israel.',
    ue: 'Stat membru al Uniunii Europene (din 1981).',
    schengen: 'Membru al Spa╚¢iului Schengen.',
    moneda: 'Euro (EUR)',
    viza: {
      temei: 'Decizia Guvernului Elen de suspendare a rezolu╚¢iei parlamentare din 2015',
      regim: 'Rela╚¢ii neoficiale cordiale, Reprezentan╚¢─â palestinian─â activ─â',
      particular: 'Parteneriat militar ╚Öi energetic extrem de puternic cu Israel ├«n Mediterana de Est',
      observatie: 'Grecia a avut istoric un profil extrem de pro-arab ├«n secolul XX'
    },
    particularitati: 'O schimbare pragmatic─â de politic─â extern─â, trec├ónd de la o pozi╚¢ie pro-arab─â radical─â sub Andreas Papandreou la un aliniament strategic str├óns cu Israel.',
    badges: ['Nu recunoa╚Öte', 'Membru UE', 'Schengen']
  },
  {
    id: 'switzerland',
    nume: 'Elve╚¢ia',
    numeEn: 'Switzerland',
    categorie: 'norec',
    categorieLabel: 'Nu recunoa╚Öte',
    lat: 46.8182,
    lon: 8.2275,
    coords: [8.2275, 46.8182],
    capitala: 'Berna',
    populatie: 'Γëê 8 700 000 loc.',
    popVal: 8700000,
    suprafata: '41 285 km┬▓',
    supVal: 41285,
    zee: 'ΓÇö',
    zeeVal: 9999,
    note: 'Elve╚¢ia nu recunoa╚Öte oficial Palestina ca stat, invoc├ónd politica sa istoric─â de neutralitate activ─â ╚Öi necesitatea unui acord negociat direct ├«ntre cele dou─â p─âr╚¢i.',
    ue: 'Nu este membru UE.',
    schengen: 'Membru al Spa╚¢iului Schengen.',
    moneda: 'Franc elve╚¢ian (CHF)',
    viza: {
      temei: 'Pozi╚¢ia oficial─â a Departamentului Federal al Afacerilor Externe (DFAE)',
      regim: 'Men╚¢ine rela╚¢ii diplomatice tehnice active, finan╚¢├ónd proiecte umanitare substan╚¢iale',
      particular: 'Berna sprijin─â cu fermitate solu╚¢ia celor dou─â state pe baza frontierelor din 1967',
      observatie: 'Elve╚¢ia g─âzduie╚Öte sediul european al ONU ╚Öi organiza╚¢iile Crucii Ro╚Öii'
    },
    particularitati: 'Neutralitatea sa diplomatic─â face ca Elve╚¢ia s─â fie un canal crucial de comunicare indirect─â ├«n regiune.',
    badges: ['Nu recunoa╚Öte', 'Schengen', 'Neutralitate']
  },
  {
    id: 'netherlands',
    nume: '╚Ü─ârile de Jos',
    numeEn: 'Netherlands',
    categorie: 'norec',
    categorieLabel: 'Nu recunoa╚Öte',
    lat: 52.1326,
    lon: 5.2913,
    coords: [5.2913, 52.1326],
    capitala: 'Amsterdam',
    populatie: 'Γëê 17 500 000 loc.',
    popVal: 17500000,
    suprafata: '41 543 km┬▓',
    supVal: 41543,
    zee: 'ΓÇö',
    zeeVal: 9999,
    note: '╚Ü─ârile de Jos nu recunosc oficial Palestina, sus╚¢in├ónd c─â recunoa╚Öterea trebuie s─â fie rezultatul final al unui acord direct de pace.',
    ue: 'Stat membru al Uniunii Europene (fondator).',
    schengen: 'Membru al Spa╚¢iului Schengen.',
    moneda: 'Euro (EUR)',
    viza: {
      temei: 'Strategia de politic─â extern─â a Ministerului Afacerilor Externe de la Haga',
      regim: 'Rela╚¢ii diplomatice formale limitate la nivel de Birou de reprezentare',
      particular: '╚Ü─ârile de Jos sprijin─â financiar consolidarea institu╚¢ional─â a Autorit─â╚¢ii Palestiniene',
      observatie: 'Haga g─âzduie╚Öte Curtea Interna╚¢ional─â de Justi╚¢ie (CIJ) care analizeaz─â litigiile teritoriale'
    },
    particularitati: 'Gazda CIJ ╚Öi a CPI, Cur╚¢i care joac─â un rol seismic global ├«n analizarea juridic─â a statutului Palestinei.',
    badges: ['Nu recunoa╚Öte', 'Membru UE', 'Haga Court']
  },
  {
    id: 'finland',
    nume: 'Finlanda',
    numeEn: 'Finland',
    categorie: 'norec',
    categorieLabel: 'Nu recunoa╚Öte',
    lat: 61.9241,
    lon: 25.7482,
    coords: [25.7482, 61.9241],
    capitala: 'Helsinki',
    populatie: 'Γëê 5 500 000 loc.',
    popVal: 5500000,
    suprafata: '338 424 km┬▓',
    supVal: 338424,
    zee: 'ΓÇö',
    zeeVal: 9999,
    note: 'Finlanda nu recunoa╚Öte oficial Palestina, de╚Öi oficialii finlandezi au declarat ├«n repetate r├ónduri un angajament ferm de a realiza acest pas ├«n viitor, ├«n str├óns─â coordonare cu alte state nordice, c├ónd condi╚¢iile diplomatice vor fi propice.',
    ue: 'Stat membru al Uniunii Europene (din 1995).',
    schengen: 'Membru al Spa╚¢iului Schengen.',
    moneda: 'Euro (EUR)',
    viza: {
      temei: 'Documentul oficial de pozi╚¢ie al Ministerului Afacerilor Externe de la Helsinki',
      regim: 'F─âr─â reprezentare de nivel de Ambasador',
      particular: 'Finlanda pledeaz─â pentru respectarea dreptului interna╚¢ional ├«n toate forurile',
      observatie: 'Men╚¢ine rela╚¢ii diplomatice neoficiale cordiale'
    },
    particularitati: 'Spre deosebire de Suedia vecin─â, Finlanda a ales o abordare mai prudent─â, refuz├ónd decizia unilateral─â din 2014.',
    badges: ['Nu recunoa╚Öte', 'Membru UE', 'Nordic Policy']
  },
  {
    id: 'denmark',
    nume: 'Danemarca',
    numeEn: 'Denmark',
    categorie: 'norec',
    categorieLabel: 'Nu recunoa╚Öte',
    lat: 56.2639,
    lon: 9.5018,
    coords: [9.5018, 56.2639],
    capitala: 'Copenhaga',
    populatie: 'Γëê 5 800 000 loc.',
    popVal: 5800000,
    suprafata: '43 094 km┬▓',
    supVal: 43094,
    zee: 'ΓÇö',
    zeeVal: 9999,
    note: 'Danemarca nu recunoa╚Öte oficial Palestina. Parlamentul danez a dezb─âtut ╚Öi a respins proiecte de lege privind recunoa╚Öterea ├«n 2024, men╚¢in├ónd linia conform c─âreia condi╚¢iile de suveranitate efectiv─â nu sunt pe deplin ├«ntrunite.',
    ue: 'Stat membru al Uniunii Europene (din 1973).',
    schengen: 'Membru al Spa╚¢iului Schengen.',
    moneda: 'Coroan─â danez─â (DKK)',
    viza: {
      temei: 'Votul majoritar al Parlamentului Danez (Folketing) din mai 2024',
      regim: 'Rela╚¢ii diplomatice bilaterale limitate',
      particular: 'Copenhaga sprijin─â ferm eforturile de reform─â ale Autorit─â╚¢ii Palestiniene',
      observatie: 'Danemarca aplic─â reguli stricte de asisten╚¢─â extern─â'
    },
    particularitati: 'Men╚¢ine o pozi╚¢ie extrem de aliniat─â cu partenerii transatlantici, refuz├ónd unilateralismul.',
    badges: ['Nu recunoa╚Öte', 'Membru UE', 'Schengen']
  },
  {
    id: 'estonia',
    nume: 'Estonia',
    numeEn: 'Estonia',
    categorie: 'norec',
    categorieLabel: 'Nu recunoa╚Öte',
    lat: 58.5953,
    lon: 25.0136,
    coords: [25.0136, 58.5953],
    capitala: 'Tallinn',
    populatie: 'Γëê 1 300 000 loc.',
    popVal: 1300000,
    suprafata: '45 227 km┬▓',
    supVal: 45227,
    zee: 'ΓÇö',
    zeeVal: 9999,
    note: 'Estonia nu recunoa╚Öte oficial Palestina ca stat, sus╚¢in├ónd c─â recunoa╚Öterea trebuie s─â vin─â ca o urmare fireasc─â a acordului direct de pace ├«ntre Israel ╚Öi Palestina.',
    ue: 'Stat membru al Uniunii Europene (din 2004).',
    schengen: 'Membru al Spa╚¢iului Schengen.',
    moneda: 'Euro (EUR)',
    viza: {
      temei: 'Documentul oficial de pozi╚¢ie al Guvernului Estonian',
      regim: 'Rela╚¢ii de lucru neoficiale',
      particular: 'Estonia urmeaz─â o linie transatlantic─â strict─â ├«n materie de politic─â extern─â',
      observatie: 'Sprijin─â de principiu pozi╚¢ia comun─â a UE privind solu╚¢ia celor dou─â state'
    },
    particularitati: 'Pozi╚¢ie extrem de aliniat─â cu SUA ├«n forurile interna╚¢ionale.',
    badges: ['Nu recunoa╚Öte', 'Membru UE', 'Baltic']
  },
  {
    id: 'latvia',
    nume: 'Letonia',
    numeEn: 'Latvia',
    categorie: 'norec',
    categorieLabel: 'Nu recunoa╚Öte',
    lat: 56.8796,
    lon: 24.6032,
    coords: [24.6032, 56.8796],
    capitala: 'Riga',
    populatie: 'Γëê 1 900 000 loc.',
    popVal: 1900000,
    suprafata: '64 589 km┬▓',
    supVal: 64589,
    zee: 'ΓÇö',
    zeeVal: 9999,
    note: 'Letonia nu recunoa╚Öte oficial Palestina, men╚¢in├ónd o linie extern─â rezervat─â ╚Öi aliniat─â cu deciziile partenerilor s─âi europeni din grupul nordic.',
    ue: 'Stat membru al Uniunii Europene (din 2004).',
    schengen: 'Membru al Spa╚¢iului Schengen.',
    moneda: 'Euro (EUR)',
    viza: {
      temei: 'Declara╚¢iile de politic─â extern─â ale Ministerului Afacerilor Externe de la Riga',
      regim: 'Rela╚¢ii tehnice discrete',
      particular: 'Letonia sprijin─â de principiu ac╚¢iunile de asisten╚¢─â umanitar─â',
      observatie: 'Echilibru ├«n declara╚¢ii pentru a evita dispute'
    },
    particularitati: 'O politic─â de securitate concentrat─â pe parteneriatul cu NATO, reflectat─â ╚Öi ├«n deciziile de vot la ONU.',
    badges: ['Nu recunoa╚Öte', 'Membru UE', 'Baltic']
  },
  {
    id: 'lithuania',
    nume: 'Lituania',
    numeEn: 'Lithuania',
    categorie: 'norec',
    categorieLabel: 'Nu recunoa╚Öte',
    lat: 55.1694,
    lon: 23.8813,
    coords: [23.8813, 55.1694],
    capitala: 'Vilnius',
    populatie: 'Γëê 2 800 000 loc.',
    popVal: 2800000,
    suprafata: '65 300 km┬▓',
    supVal: 65300,
    zee: 'ΓÇö',
    zeeVal: 9999,
    note: 'Lituania nu recunoa╚Öte oficial Palestina, av├ónd o politic─â extern─â puternic aliniat─â transatlantic ╚Öi manifest├ónd o pruden╚¢─â extrem─â fa╚¢─â de orice ini╚¢iative diplomatice unilaterale.',
    ue: 'Stat membru al Uniunii Europene (din 2004).',
    schengen: 'Membru al Spa╚¢iului Schengen.',
    moneda: 'Euro (EUR)',
    viza: {
      temei: 'Strategia na╚¢ional─â de politic─â extern─â a Lituaniei',
      regim: 'Contacte diplomatice tehnice reduse',
      particular: 'Lituania a manifestat constant o atitudine extrem de pro-Israel ├«n ultimii ani',
      observatie: 'Pruden╚¢─â total─â pentru a nu perturba parteneriatul de securitate cu SUA'
    },
    particularitati: 'Cea mai ferm─â pozi╚¢ie restrictiv─â dintre cele trei state baltice.',
    badges: ['Nu recunoa╚Öte', 'Membru UE', 'Baltic']
  },
  {
    id: 'croatia',
    nume: 'Croa╚¢ia',
    numeEn: 'Croatia',
    categorie: 'norec',
    categorieLabel: 'Nu recunoa╚Öte',
    lat: 45.1             ,
    lon: 15.2,
    coords: [15.2, 45.1],
    capitala: 'Zagreb',
    populatie: 'Γëê 3 900 000 loc.',
    popVal: 3900000,
    suprafata: '56 594 km┬▓',
    supVal: 56594,
    zee: 'ΓÇö',
    zeeVal: 9999,
    note: 'Croa╚¢ia nu recunoa╚Öte oficial Palestina, spre deosebire de alte state vecine din fosta Iugoslavie (precum Slovenia, Serbia, Bosnia). Guvernul de la Zagreb sus╚¢ine o solu╚¢ie negociat─â, resping├ónd recunoa╚Öterile unilaterale.',
    ue: 'Stat membru al Uniunii Europene (din 2013).',
    schengen: 'Membru al Spa╚¢iului Schengen (din ianuarie 2023).',
    moneda: 'Euro (EUR)',
    viza: {
      temei: 'Orientarea diplomatic─â a Ministerului Afacerilor Externe de la Zagreb',
      regim: 'Rela╚¢ii diplomatice neoficiale reduse',
      particular: 'Aliniere str├óns─â cu pozi╚¢iile conservatoare europene',
      observatie: 'Sprijin─â de principiu dreptul umanitar ├«n Orientul Mijlociu'
    },
    particularitati: 'O disonan╚¢─â diplomatic─â evident─â fa╚¢─â de restul ╚¢─ârilor din fosta Iugoslavie, av├ónd o politic─â mai conservatoare.',
    badges: ['Nu recunoa╚Öte', 'Membru UE', 'Schengen']
  },
  {
    id: 'georgia',
    nume: 'Georgia',
    numeEn: 'Georgia',
    categorie: 'norec',
    categorieLabel: 'Nu recunoa╚Öte',
    lat: 42.3154,
    lon: 43.3569,
    coords: [43.3569, 42.3154],
    capitala: 'Tbilisi',
    populatie: 'Γëê 3 700 000 loc.',
    popVal: 3700000,
    suprafata: '69 700 km┬▓',
    supVal: 69700,
    zee: 'ΓÇö',
    zeeVal: 9999,
    note: 'Georgia nu recunoa╚Öte oficial Palestina ca stat, av├ónd o politic─â extern─â pro-occidental─â str├óns legat─â de parteneriatul cu SUA ╚Öi Israel.',
    ue: 'Stat candidat la aderarea ├«n Uniunea European─â.',
    schengen: 'Nu face parte din Schengen.',
    moneda: 'Lari georgian (GEL)',
    viza: {
      temei: 'Strategia diplomatic─â a Guvernului de la Tbilisi',
      regim: 'F─âr─â contacte diplomatice formale',
      particular: 'Georgia men╚¢ine rela╚¢ii diplomatice ╚Öi economice extrem de str├ónse cu Israel',
      observatie: 'Pruden╚¢─â maxim─â ├«n forurile interna╚¢ionale'
    },
    particularitati: 'Rela╚¢ii bilaterale excep╚¢ionale cu Israelul, care au transformat Georgia ├«ntr-un aliat de facto pe arena extern─â.',
    badges: ['Nu recunoa╚Öte', 'Candidat UE', 'Caucaz']
  }
];

let activeMetric = 'year';
let activeTerritoryId = null;
let currentMode = '2d';
let projection, pathGenerator, svg, container;
let zoomBehavior;

// Elemente cache-uite pentru performan╚¢─â sporit─â la rotire
let cachedSphere, cachedGraticule, cachedCountries, cachedMarkers;
let isRotating = false;
let autoRotateTimer;
let autoRotateTimeout;
let rotationState = [-15, -48, 0];

const tooltip = document.getElementById('tooltip');
const searchInput = document.getElementById('search-input');
const suggestionsUl = document.getElementById('search-suggestions');
const panelContent = document.getElementById('panel-content');

// 1. Randarea ini╚¢ial─â a h─âr╚¢ii ╚Öi ini╚¢ializarea structurilor D3
function renderMap() {
  container = document.querySelector('.map-wrap');
  svg = d3.select('#worldmap');
  
  const rect = container.getBoundingClientRect();
  const W = rect.width;
  const H = rect.height;
  
  svg.attr('viewBox', `0 0 ${W} ${H}`).attr('width', W).attr('height', H);
  svg.selectAll('*').remove(); // Cur─â╚¢─âm SVG-ul la ini╚¢ializare
  
  // Ini╚¢ializare Proiec╚¢ie bazat─â pe mod (2D plan─â adaptat─â pe Europa sau 3D sferic─â)
  if (currentMode === '2d') {
    // Proiec╚¢ie geoEquirectangular perfect centrat─â pe continentul European
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

  // Randarea grani╚¢elor tuturor ╚¢─ârilor lumii
  cachedCountries = svg.append('g')
    .selectAll('path')
    .data(countries.features)
    .enter()
    .append('path')
    .attr('class', d => {
      const name = d.properties.name ? d.properties.name.toLowerCase() : '';
      const t = teritorii.find(x => (x.numeEn && x.numeEn.toLowerCase() === name) || (x.numeEn === 'Romania' && d.id === '642') || (x.numeEn === 'United Kingdom' && d.id === '826') || (x.numeEn === 'Bosnia and Herzegovina' && name === 'bosnia and herzegovina'));
      let cls = 'country';
      if (targetNames.includes(name) || d.id === '642' || d.id === '826') {
        cls += ' europe-focus';
      }
      if (t) {
        cls += ' ' + t.categorie;
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
          <div class="status-tag" style="background:var(--${t.categorie}); color:${t.categorie === 'rec' ? '#000000' : '#ffffff'}">${t.categorie === 'rec' ? 'Recunoa╚Öte' : (t.categorie === 'norec' ? 'Nu recunoa╚Öte' : 'Contestat')}</div>
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

  // ├Änc─ârcarea ╚Öi configurarea comportamentului de Zoom & Pan (exclusiv ├«n 2D)
  if (currentMode === '2d') {
    zoomBehavior = d3.zoom()
      .scaleExtent([1, 10])
      .on('zoom', (event) => {
        const transform = event.transform;
        // Aplic─âm transformarea pe toate elementele grafice din SVG
        cachedSphere.attr('transform', transform);
        cachedGraticule.attr('transform', transform);
        cachedCountries.attr('transform', transform);
        
        if (cachedMarkers) {
          cachedMarkers.attr('transform', function(t) {
            const projected = projection(t.coords);
            if (!projected) return null;
            // Repozi╚¢ion─âm ╚Öi scal─âm markerii propor╚¢ional pentru lizibilitate
            const tx = transform.applyX(projected[0]);
            const ty = transform.applyY(projected[1]);
            return `translate(${tx}, ${ty})`;
          });
          // Afișează denumirile țărilor doar când transform.k >= 2.0 (când mărim harta)
          svg.selectAll('.marker-label')
             .style('display', transform.k >= 2.0 ? 'block' : 'none');
        }
      });
      
    svg.call(zoomBehavior);
    svg.on('.drag', null); // Eliminăm drag-ul 3D rezidual
  } else {
    // În modul 3D dezactivăm zoomBehavior-ul clasic și configurăm Dragging-ul pe Sferă
    svg.on('.zoom', null); // Eliminăm zoom-ul 2D rezidual
    svg.call(d3.drag()
      .on('start', () => {
        isRotating = false;
        if (autoRotateTimer) autoRotateTimer.stop();
        clearTimeout(autoRotateTimeout);
      })
      .on('drag', (event) => {
        const k = 70 / projection.scale();
        const rotate = projection.rotate();
        // Rota╚¢ia globului pe baza deplas─ârii mouse-ului
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

  // 6. Randarea marcajelor teritoriilor (creare elemente ├«n DOM o singur─â dat─â)
  buildMarkers();

  // Ascundem ecranul de ├«nc─ârcare deoarece harta a pornit perfect local
  document.getElementById('loading').classList.add('hidden');

  if (currentMode === '3d') {
    resetAutoRotationTimeout();
  }
}

// Construie╚Öte structura DOM a marcajelor (rulat─â doar la re-randarea h─âr╚¢ii)
function buildMarkers() {
  svg.selectAll('.marker').remove();
  
  // Afi╚Ö─âm marcajele doar pentru ╚¢─ârile europene din lista noastr─â
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

  // Textul cu numele ╚¢─ârii
  cachedMarkers.append('text')
    .attr('class', 'marker-label')
    .attr('text-anchor', 'middle')
    .attr('y', t => -(getMarkerRadius(t) + 6))
    .text(t => t.nume);

  updateMarkerPositions();
}

// Actualizeaz─â rapid pozi╚¢ia, vizibilitatea ╚Öi scara marcajelor f─âr─â a reconstrui DOM-ul
function updateMarkerPositions() {
  if (!cachedMarkers) return;

  // Determină factorul de zoom curent
  let zoomScale = 1;
  if (currentMode === '2d') {
    const node = svg.node();
    if (node) {
      zoomScale = d3.zoomTransform(node).k;
    }
  } else {
    // În 3D, comparăm scala curentă cu cea de bază
    const rect = container.getBoundingClientRect();
    const baseScale = Math.min(rect.width, rect.height) * 0.95;
    zoomScale = projection.scale() / baseScale;
  }
  const showLabels = zoomScale >= 2.0;

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
      g.select('.marker-label')
       .attr('y', -(radius + 6))
       .style('display', showLabels ? 'block' : 'none');
    } else {
      g.style('display', 'none');
    }
  });
}

// Calculeaz─â raza marcajului pe baza indicatorului selectat
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

  // Scara logaritmic─â
  const logScale = d3.scaleLog()
    .domain([minVal, maxVal])
    .range([4, 12]);

  return logScale(safeVal);
}

// Verific─â dac─â ╚¢ara se afl─â pe emisfera vizibil─â a globului (3D)
function isVisibleOnGlobe(coords) {
  const rotate = projection.rotate();
  const center = [-rotate[0], -rotate[1]];
  const dist = d3.geoDistance(coords, center);
  return dist < Math.PI / 2.1; // Margini mai str├ónse
}

// Actualizeaz─â proiec╚¢iile pe ecran c├ónd globul se rote╚Öte
function updateProjection() {
  if (!projection || !cachedSphere || !cachedGraticule || !cachedCountries) return;
  
  cachedSphere.attr('d', pathGenerator);
  cachedGraticule.attr('d', pathGenerator);
  cachedCountries.attr('d', pathGenerator);
  
  updateMarkerPositions();
}

// 7. Rota╚¢ie Cinematic─â Glob (3D)
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

// 8. Controale Fizice Harta (Zoom +/- ╚Öi Reset)
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

// 9. C─âutare Instant─â cu Autocomplete
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
    suggestionsUl.innerHTML = '<li style="color:var(--ink-soft); cursor:default">Nicio ╚¢ar─â g─âsit─â</li>';
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

// Selec╚¢ia din sugestii
suggestionsUl.addEventListener('click', (event) => {
  const li = event.target.closest('li');
  if (!li || !li.dataset.id) return;
  
  selectTerritory(li.dataset.id);
  searchInput.value = '';
  suggestionsUl.style.display = 'none';
});

// ├Änchidem sugestiile la click ├«n afar─â
document.addEventListener('click', (event) => {
  if (!event.target.closest('.search-container')) {
    suggestionsUl.style.display = 'none';
  }
});

// 10. Clasamente (Cronologie / Popula╚¢ie / Suprafa╚¢─â)
function renderRankings() {
  const activeList = teritorii.filter(t => t.popVal > 0);
  
  const minVal = d3.min(activeList, d => Math.max(1, activeMetric === 'year' ? (d.zeeVal === 9999 ? 2026 : d.zeeVal) : (activeMetric === 'pop' ? d.popVal : d.supVal)));
  const maxVal = d3.max(activeList, d => Math.max(1, activeMetric === 'year' ? (d.zeeVal === 9999 ? 2026 : d.zeeVal) : (activeMetric === 'pop' ? d.popVal : d.supVal)));

  // Ordonare dinamic─â
  const sorted = [...activeList].sort((a, b) => {
    if (activeMetric === 'year') {
      const yearA = a.zeeVal;
      const yearB = b.zeeVal;
      // Ordon─âm anii cresc─âtor (cei mai vechi primii). Cei care nu recunosc (9999) la sf├ór╚Öit.
      return yearA - yearB;
    }
    const valA = activeMetric === 'pop' ? a.popVal : a.supVal;
    const valB = activeMetric === 'pop' ? b.popVal : b.supVal;
    return valB - valA; // Descresc─âtor pentru demografie
  });

  const listContainer = document.getElementById('rank-list-container');
  if (!listContainer) return;

  listContainer.innerHTML = sorted.map(t => {
    let dispVal;
    let val;
    if (activeMetric === 'year') { 
      dispVal = t.zeeVal === 9999 ? 'Nu recunoa╚Öte' : 'An: ' + t.zee; 
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
        // Cu c├ót e mai veche (1988), cu at├ót e mai plin─â bara
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

  // Anim─âm fluid
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
        if (t.zeeVal === 9999) percent = 5; // Bara minim─â pentru no-rec
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

// Rand─âm clasamentele ini╚¢iale
renderRankings();

// 11. Selec╚¢ie ╚Üar─â ╚Öi Fi╚Ö─â Tab-uri
function selectTerritory(id) {
  activeTerritoryId = id;
  const t = teritorii.find(x => x.id === id);
  if (!t) return;

  // Clasa activ─â pe hart─â
  if (cachedMarkers) {
    cachedMarkers.attr('class', m => {
      let classes = 'marker';
      if (id && m.id !== id) classes += ' dimmed';
      if (m.id === id) classes += ' active';
      return classes;
    });
  }

  // Focalizare sferic─â (3D) sau Centrare (2D)
  if (currentMode === '2d') {
    zoomToCoords(t.coords, 4);
  } else {
    rotateToCoords(t.coords);
  }

  const badgeMap = {
    'Recunoa╚Öte Palestina': 'rec',
    'Nu recunoa╚Öte': 'norec',
    'Recunoa╚Öte (Contestat)': 'contested'
  };

  const recognitionText = t.categorie === 'rec' 
    ? `Recunoa╚Öte oficial Statul Palestina din anul <strong>${t.zee}</strong>.` 
    : (t.categorie === 'contested' ? `A recunoscut Palestina ├«n <strong>${t.zee}</strong>, ├«ns─â aceast─â recunoa╚Ötere este contestat─â sau ignorat─â ├«n prezent.` : 'Nu recunoa╚Öte formal ├«n prezent Statul Palestina.');

  panelContent.innerHTML = `
    <div class="territory-detail">
      <div class="detail-header-wrap">
        <button class="btn-back-rankings" id="btn-back-rankings">ΓåÉ ├Änapoi la Cronologie</button>
        <div class="panel-cat" data-cat="${t.categorie}">
          <span>ΓùÅ</span>${t.categorieLabel}
        </div>
        <h2>${t.flag} ${t.nume}<em>${t.numeEn}</em></h2>
      </div>
      
      <div class="panel-tabs">
        <button class="tab-btn active" data-tab="tab-prez">Prezentare</button>
        <button class="tab-btn" data-tab="tab-juridic">Recunoa╚Ötere</button>
        <button class="tab-btn" data-tab="tab-vize">Rela╚¢ii Externe</button>
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
            <div class="stat"><div class="k">An Recunoa╚Ötere</div><div class="v">${t.zee === '1988' ? '1988 (Val Ist.)' : (t.zee === 'ΓÇö' ? 'Nerecunoscut' : t.zee)}</div></div>
            <div class="stat"><div class="k">Popula╚¢ia</div><div class="v" style="font-size:13px">${t.populatie}</div></div>
            <div class="stat"><div class="k">Suprafa╚¢a</div><div class="v" style="font-size:13.5px">${t.suprafata}</div></div>
          </div>

          <div class="panel-section">
            <h3>Detalii Pozi╚¢ie</h3>
            <p>${t.note}</p>
          </div>
        </div>

        <!-- Tab 2: Recunoa╚Ötere Juridic─â -->
        <div class="tab-content" id="tab-juridic">
          <div class="alert-box">
            <h3>Temei ╚Öi Statut</h3>
            <p>${recognitionText}</p>
          </div>
          <div class="panel-section">
            <h3>Note Istorice ╚Öi Diplomatice</h3>
            <p>${t.viza.particular}</p>
          </div>
          <div class="panel-section">
            <h3>Proceduri administrative ╚Öi reprezentare</h3>
            <p><strong>Temei politic:</strong> ${t.viza.temei}</p>
            <p style="margin-top:8px"><strong>Regim de cooperare:</strong> ${t.viza.regim}</p>
            <p style="margin-top:8px"><strong>Observa╚¢ii:</strong> ${t.viza.observatie}</p>
          </div>
        </div>

        <!-- Tab 3: Rela╚¢ii Externe -->
        <div class="tab-content" id="tab-vize">
          <div class="panel-section">
            <h3>Integrare European─â</h3>
            <p>${t.ue}</p>
          </div>
          <div class="panel-section">
            <h3>Pozi╚¢ia privind Libera Circula╚¢ie (Schengen)</h3>
            <p>${t.schengen}</p>
          </div>
          <div class="badge-row">
            <span class="badge ${badgeMap[t.categorieLabel] || ''}">${t.categorieLabel}</span>
            <span class="badge">${t.moneda}</span>
          </div>
        </div>

        <!-- Tab 4: Informa╚¢ii Geografice ╚Öi Demografice -->
        <div class="tab-content" id="tab-fin">
          <div class="stat-grid">
            <div class="stat"><div class="k">Moned─â</div><div class="v" style="font-size:14px">${t.moneda}</div></div>
            <div class="stat"><div class="k">Pozi╚¢ionare</div><div class="v" style="font-size:14px">${t.lat.toFixed(2)}┬░ N / ${t.lon.toFixed(2)}┬░ E</div></div>
          </div>
          
          <div class="panel-section">
            <h3>Particularit─â╚¢i Geopolitice</h3>
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

  // ├Änapoi la Clasament
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
          <h3 class="rankings-title">ΓÜ£ Cronologia Recunoa╚Öterii</h3>
          <p style="font-family:'Cormorant Garamond',serif;font-style:italic;font-size:14px;color:var(--ink-soft);line-height:1.3;margin-bottom:12px;">Vizualizeaz─â cronologia deciziilor istorice ╚Öi recente. ╚Ü─ârile care nu recunosc sunt ordonate alfabetic la final.</p>
        </div>
        <div class="rankings-selector">
          <button class="rank-btn ${activeMetric === 'year' ? 'active' : ''}" data-metric="year">An Recunoa╚Ötere</button>
          <button class="rank-btn ${activeMetric === 'pop' ? 'active' : ''}" data-metric="pop">Popula╚¢ie</button>
          <button class="rank-btn ${activeMetric === 'sup' ? 'active' : ''}" data-metric="sup">Suprafa╚¢─â</button>
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

// Centrare ╚Öi Zoom ├«n 2D
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

// Tranzi╚¢ie sferic─â ├«n 3D
function rotateToCoords(coords) {
  const [lng, lat] = coords;
  isRotating = false;
  if (autoRotateTimer) autoRotateTimer.stop();
  clearTimeout(autoRotateTimeout);

  const r = projection.rotate();
  // Rota╚¢ia sferic─â
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

// Chips de filtrare rapid─â
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

// Modificare Tem─â (Light / Dark Mode)
const themeToggle = document.getElementById('theme-toggle');
themeToggle.addEventListener('click', () => {
  document.body.classList.toggle('light-theme');
  const isLight = document.body.classList.contains('light-theme');
  themeToggle.textContent = isLight ? '≡ƒîÖ Dark Mode' : 'ΓÿÇ∩╕Å Light Mode';
});

// Ini╚¢ializare
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

Write-Host "SUCCES: index.html asamblat perfect cu diacritice rom├óne╚Öti ├«n format UTF-8 f─âr─â BOM (100% self-contained)!"
