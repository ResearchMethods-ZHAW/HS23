## Abstract


Im Kurs Research Methods verwenden wir seit einigen Jahren RMarkdown um die R Unterlagen für die Studenten bereit zu stellen. 

Seit HS2020 arbeiten wir mit Quarto, der Nachfolger von Rmarkdown. Am besten Nils und Dominik machen mit euch eine kleine Einführung dazu. Die Slides sind hier zu finden: <https://researchmethods-zhaw.github.io/Intro-for-Authors/>

## Anleitung 1: Software Aufsetzen

### R, RStudio und Git installieren

*(wer dies bereits gemacht hat oder auf dem RStudio Server arbeitet, kann diesen Schritt überspringen)*

Wer Lokal auf seinem eingenen PC arbeiten will, muss eine aktuell version von R, RStudio und Git installieren. Siehe dazu folgende Anleitungen:

-   [happygitwithr: Install or upgrade R and RStudio](https://happygitwithr.com/install-r-rstudio.html)
-   [happygitwithr: Install Git](https://happygitwithr.com/install-git.html)

### RStudio Konfigurieren

Ich empfehle folgende Konfiguration in RStudio (Tools → `Global Options`):

-   R Markdown
    -   Show document outline by default: checked *(Stellt ein Inhaltsverzeichnis rechts von .Qmd files dar)*
    -   Soft-wrap R Markdown files: checken *(macht autmatische Zeilenumbrüche bei .Qmd files)*
    -   Show in document outline: Sections Only *(zeigt nur "Sections" im Inhaltsverzeichnis)*
    -   Show output preview in: Window *(beim kopilieren von Qmd Files wird im Anschluss ein Popup mit dem Resultat dargestellt)*
    -   Show equation an image previews: In a popup
    -   Evaluate chunks in directory: Document (**← wichtig !**)
-   Code \> Tab "Saving"
    -   Default Text Encoding: UTF-8 (**← wichtig !**)

### Git konfigurieren

Um git benutzen zu können, muss man Benutzernamen und Mailadresse festlegen. Allefalls habt ihr das schon gemacht. Wenn folgende Befehle euren Nutzernamen / Mailadresse anzeigen, könnt ihr diesen Schritt überspringen:

```sh
git config --global user.email
git config --global user.name
```

Falls nicht, müssen diese Angaben zuerst noch gemacht werden. Siehe dazu folgende Kapitel:

-   [happygitwithr: Introduce yourself to Git](https://happygitwithr.com/hello-git.html)
-   [happygitwithr: Cache credentials for HTTPS](https://happygitwithr.com/https-pat)

## Anleitung 2: Projekt aufsetzen

### Repo Klonen

Um die ganzen \*.Qmd Files lokal bearbeiten zu können, muss das Repository geklont werden. Mit RStudio ist dies sehr einfach, siehe dazu nachstehende Anleitung. Als Repo-URL folgendes einfügen: `https://github.com/ResearchMethods-ZHAW/HS23.git`

-   [happygitwithr: New RStudio Project via RStudio IDE](https://happygitwithr.com/new-github-first#rstudio-ide)

Je nach gewählter "Clone"-Methode, muss das Git*Hub* Repo als *upstream* gesetzt werden. Dafür gibt es mehrere Möglichkeiten. Beispielsweise mit dem folgenden Befehl im Terminal

    git branch -u origin/main

Nun solltet ihr fast das ganze Repo lokal auf eurem Computer haben und die einzelnen Files bearbeiten können. Es gibt noch eine Ausnahme: Der `datasets` folder. Hierbei handelt es sich um einen einzelnen Ordner mit sämtlichen Datensätzen (csvs, tiffs, txts usw.) welche im Modul gebraucht werden. *Dieser Ordner ist ein separates, verschachteltes Git-Repo*. Dafür gibt es verschiedene Gründe (siehe FAQ). Wichtig ist jetzt, dass der Inhalt diess Ordners noch nicht auf euerem Computer gelandet ist. Dazu braucht es noch folgenden Befehl im Terminal:

    git submodule update --init --recursive



## Anleitung 3: Inhalte Editieren und veröffentlichen

### Qmd erstellen

Die meisten Inhalte exisitieren bereits und ihr müsst sie nur noch anpassen. Falls ihr aber ein neues .Qmd File erstellen möchtet, müsst ihr einen Unterordner in einem der Ordner erstellen. 

### Qmd editieren

Um Inhalte zu editieren, öffnet ihr das entsprechende .Qmd file in einem der Ordner `prepro`, `infovis`, `rauman` usw.. Ihr könnt dieses File wie ein reguläres, eigenständiges .Qmd File handhaben. **Wichtig**: Alle Pfade im Dokument sind relativ zum Project zu verstehen: **Das Working directory ist der Project folder!!**.

### Qmd Kompilieren / Vorschau

Statt auf den Preview button in RStudio zu clicken empfehlen wir, quarto von der Konsole (Terminal) aus zu bedienen. `quarto render` kompiliert das jeweilige File / Projekt in html (oder pdf). Sehr praktisch ist aber `quarto preview`, welches zusätzlich zum rendern erstellt einen "Webserver" zur Verfügung stellt, wo Änderungen an den qmd Files detektiert und live ge-updated werden.

Hinweis: Auf Windows muss man den Befehl `quarto` mit `quarto.cmd` oder `quarto.exe` ersetzen (siehe [hier](https://community.rstudio.com/t/bash-quarto-command-not-found/144187/2))

### Änderungen veröffentlichen

Hier müssen wir unterscheiden zwischen den Änderungen den Source Files (Qmd) und Änderungen an den Output Files (pdf)

Um die Änderungen an den Source Files zu veröffentlichen müsst ihr diese via git auf das Repository "pushen". Vorher aber müsst ihr die Änderungen `stage`-en und `commit`-en. Ich empfehle, dass ihr zumindest zu beginn mit dem RStudio "Git" Fenster arbeitet.

-   `stage`: Setzen eines Häckchens bei "Staged" (im Terminal mit `git add .`)
-   `commit`: Klick auf den Button "commit" (im Terminal mit `git commit -m "deine message"`)
-   `pull`: Klick auf den Button "Pull" (im Terminal mit `git pull`)
-   `push`: Click auf den button "Push" (im Terminal mit `git push`)
-   

Um Änderungen an den Output Files zu Veröffentlichen muss (TBD)

```sh
quarto publish gh-pages --no-prompt 
```

## FAQ

### Was tun bei folgendem Fehler `ERROR: SyntaxError: Unexpected token < in JSON at position 2`

Nach ausführen von `quarto preview` erhalte ich den obigen Fehler. Der output im Terminal sieht folgendermassen aus:

```
[54/59] fallstudie_n/1_Vorbemerkung.qmd
[55/59] fallstudie_n/2_Datenverarbeitung_Uebung.qmd
[56/59] fallstudie_n/2_Datenverarbeitung_Loesung.qmd
ERROR: SyntaxError: Unexpected token < in JSON at position 2
``` 

Ich kann den fehler beheben, indem ich `quarto render das-letzte-qmd-file-vor-der-fehlermeldung.qmd` ausführe. In dem obigen Fall also:

```sh
quarto render fallstudie_n/2_Datenverarbeitung_Loesung.qmd
```

### Warum ist `datasets` ein separates Git-Repo?
1. Die Datensätze sind häufig ein paar megabyte gross. In der Vergangenheit haben kleine Änderungen an diesen Files das Repo extrem ge-bloatet (vergrössert)
2. Die Datenstäze sind teilweise vertraulich und sollten nicht öffentlich geteilt werden (das entsprechende Repo ist *private*) → dies sollte sich in Zukunft hoffentlich ändern (OER!)


