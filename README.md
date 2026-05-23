# 🇵🇸 Recunoașterea Palestinei în Europa — Atlas Interactiv & Dinamic

> **Un instrument vizual, istoric și juridic premium care mapează evoluția recunoașterii diplomatice a Statului Palestina pe continentul European.**

Acest proiect reprezintă o transformare radicală a hărților statice tradiționale într-o **operă cartografică digitală de înaltă rezoluție (D3.js)**. Creat special cu o estetică modernă (Dark Mode implicit, Glassmorphism, nuanțe armonice derivate din culorile naționale ale Palestinei), site-ul oferil o experiență interactivă impecabilă.

---

## 🌟 Caracteristici Premium

*   **🔄 Două Moduri de Vizualizare**:
    *   **Proiecție 2D Focalizată pe Europa** (folosind *Azimuthal Equal Area* pentru un unghi optim al continentului).
    *   **Glob 3D Interactiv** cu funcționalități de drag (rotire liberă), zoom, reset și o **rotație cinematică lentă în modul inactiv** (Idle Auto-Rotation).
*   **🎨 Design de Înaltă Clasă**:
    *   **Dark Mode implicit** de tip *Deep Space* combinat cu elemente de sticlă mată (frosted glass/glassmorphism).
    *   **Light Mode selectabil** prin comutator dedicat, adaptând întreaga paletă cromatice într-o versiune extrem de curată și luminoasă.
    *   **Bannere grafice stilizate în CSS pur** (reprezentând culorile Palestinei) în interiorul secțiunilor de prezentare.
*   **📊 Panou Informativ Complet cu 4 Tab-uri**:
    1.  **Prezentare Generală**: Sumar diplomatic, steagul stilizat, datele cheie ale statului selectat.
    2.  **Recunoaștere**: Istoricul complet, data exactă, contextul deciziei (ex. valul istoric din 1988, valul recent din 2024 sau deciziile strategice din toamna anului 2025).
    3.  **Relații Externe**: Regimul actual al vizelor, statutul reprezentanțelor (Ambasadă, Misiune, Consulat) și note specifice de politică externă.
    4.  **Informații Financiare & Demografice**: Populația exactă, suprafața teritorială, moneda oficială și statutul în raport cu Spațiul Schengen și Uniunea Europeană.
*   **🏆 Dashboard de Clasament Cronologic**:
    *   Sortează și afișează toate țările europene în funcție de **anul exact al recunoașterii**. Țările care nu recunosc Palestina sunt ordonate alfabetic la final.
    *   Suportă sortări dinamice instantanee după **Populație** și **Suprafață** cu grafice de tip *visual bar filling* integrate.
*   **🔍 Autocomplete Search Bar**:
    *   Căutare inteligentă în timp real cu sugestii dropdown pentru accesarea instantanee a oricărei țări de pe continent.
*   **🇷🇴 Diacritice Românești Impecabile**:
    *   Textul este editat cu atenție deosebită, fără erori de codificare sau caractere corupte, utilizând UTF-8 curat.

---

## 🛠️ Tehnologii Utilizate

1.  **D3.js (v7)** — Pentru manipularea matematică a hărții și animații ultra-fluide.
2.  **TopoJSON** — Pentru parsarea setului masiv de date geografice mondiale (Natural Earth 110m).
3.  **Vanilla CSS & HTML5** — Layout adaptiv complet (Responsive), flexibil pe desktop, tablete și telefoane mobile.
4.  **Google Fonts** — *Cormorant Garamond* (serif calligrafic premium), *Inter* (sans-serif modern), și *JetBrains Mono* (pentru datele tabulare).

---

## 📂 Structura Proiectului

*   `index.html` — Pagina principală și codul sursă al aplicației (include datele topologice comprimate local și logica interactivă).
*   `d3.min.js` — Biblioteca locală D3 pentru funcționare 100% offline (fără CDN-uri externe).
*   `topojson.min.js` — Biblioteca locală TopoJSON.
*   `assemble_palestina.ps1` — Script de compilare automatizat.

---

## 🚀 Publicare & Găzduire pe GitHub

Proiectul este pregătit pentru a fi găzduit gratuit pe **GitHub Pages**. Odată publicat, poate fi accesat direct în browser la adresa:
`https://bogdan0786.github.io/Recunoasterea-Palestinei-in-Europa/`

---

## ✍️ Dezvoltator

Site-ul a fost conceput, stilizat și implementat de:
**Popa Bogdan** (Ambasada Digitală / Relații Externe)

*— creat de Popa Bogdan*
