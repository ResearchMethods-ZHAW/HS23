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

Ich empfehle folgende Konfiguration in RStudio (`Global Options`):

-   R Markdown
    -   Show document outline by default: checked *(Stellt ein Inhaltsverzeichnis rechts von .Rmd files dar)*
    -   Soft-wrap R Markdown files: checken *(macht autmatische Zeilenumbrüche bei .Rmd files)*
    -   Show in document outline: Sections Only *(zeigt nur "Sections" im Inhaltsverzeichnis)*
    -   Show output preview in: Window *(beim kopilieren von Rmd Files wird im Anschluss ein Popup mit dem Resultat dargestellt)*
    -   Show equation an image previews: In a popup
    -   Evaluate chunks in directory: Document (**← wichtig !**)
-   Code \> Tab "Saving"
    -   Default Text Encoding: UTF-8 (**← wichtig !**)

### Git konfigurieren

*(wer dies bereits gemacht hat, kann diesen Schritt überspringen)*

Nach der Installation muss git konfiguriert werden. Siehe dazu folgende Kapitel:

-   [happygitwithr: Introduce yourself to Git](https://happygitwithr.com/hello-git.html)
-   [happygitwithr: Cache credentials for HTTPS](https://happygitwithr.com/credential-caching.html)

## Anleitung 2: Projekt aufsetzen

### Repo Klonen

Um die ganzen \*.Qmd Files lokal bearbeiten zu können, muss das Repository geklont werden. Mit RStudio ist dies sehr einfach, siehe dazu nachstehende Anleitung. Als Repo-URL folgendes einfügen: `https://github.com/ResearchMethods-ZHAW/HS22.git`

-   [happygitwithr: New RStudio Project via RStudio IDE](https://happygitwithr.com/new-github-first#rstudio-ide)

Je nach gewählter "Clone"-Methode, muss das Git*Hub* Repo als *upstream* gesetzt werden. Dafür gibt es mehrere Möglichkeiten. Beispielsweise mit dem folgenden Befehl im Terminal

    git branch -u origin/main

Nun solltet ihr fast das ganze Repo lokal auf eurem Computer haben und die einzelnen Files bearbeiten können. Es gibt noch eine Ausnahme: Der `datasets` folder. Hierbei handelt es sich um einen einzelnen Ordner mit sämtlichen Datensätzen (csvs, tiffs, txts usw.) welche im Modul gebraucht werden. *Dieser Ordner ist ein separates, verschachteltes Git-Repo*. Dafür gibt es verschiedene Gründe (s.u.). Wichtig ist jetzt, dass der Inhalt diess Ordners noch nicht auf euerem Computer gelandet ist. Dazu braucht es noch folgenden Befehl im Terminal:

    git submodule update --init --recursive


*Warum ist `datasets` ein separates Git-Repo?*
1. Die Datensätze sind häufig ein paar MB gross. In der Vergangenheit haben kleine Änderungen an diesen Files das Repo extrem ge-bloatet (vergrössert)
2. Die Datenstäze sind teilweise vertraulich und sollten nicht öffentlich geteilt werden (das entsprechende Repo ist *private*)


## Anleitung 3: Inhalte Editieren und veröffentlichen

### Qmd erstellen

Die meisten Inhalte exisitieren bereits und ihr müsst sie nur noch anpassen. Falls ihr aber ein neues .Qmd File erstellen möchtet, müsst ihr einen Unterordner in einem der Ordner erstellen. 

### Qmd editieren

Um Inhalte zu editieren, öffnet ihr das entsprechende .Rmd file in einem der Ordner `prepro`, `infovis`, `rauman` usw.. Ihr könnt dieses File wie ein reguläres, eigenständiges .Qmd File handhaben. **Wichtig**: Alle Pfade im Dokument sind relativ zum Project zu verstehen: **Das Working directory ist der Project folder!!**.

### Qmd Kompilieren / Vorschau

```
quarto preview
```

oder 

```
quarto.cmd preview
```

### Änderungen veröffentlichen

Um die Änderungen zu veröffentlichen (für die Studenten sichtbar zu machen) müsst ihr diese via git auf das Repository "pushen". Vorher aber müsst ihr die Änderungen `stage`-en und `commit`-en. Ich empfehle, dass ihr zumindest zu beginn mit dem RStudio "Git" Fenster arbeitet.

-   `stage`: Setzen eines Häckchens bei "Staged" (im Terminal mit `git add .`)
-   `commit`: Klick auf den Button "commit" (im Terminal mit `git commit -m "deine message"`)
-   `pull`: Klick auf den Button "Pull" (im Terminal mit `git pull`)
-   `push`: Click auf den button "Push" (im Terminal mit `git push`)

## Submodules hinzufügen

***(Nur für Geo-Team)***

Um die Datensätze, welche in einem privaten Repo names `datasets` abgelegt ist, muss dieses als Submodul zu diesem Repo hinzugefügt werden.

- Navigiere zum Root Ordner des Repo
- `git submodule add https://github.com/ResearchMethods-ZHAW/datasets datasets`
- `git add datasets`
- `git commit -m "Added datasets as a submodule"`

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

## Todo's

- bring back `mypurl`?

```
mypurl <- function(documentation = 0, quiet = TRUE, ...){
    tmp <- tempfile(fileext = ".R")
    knitr::purl(..., output = tmp, documentation = documentation, quiet = quiet)

    readLines(tmp)
}

mypurl(input = "index.qmd", quiet = TRUE, documentation = 0)
```
