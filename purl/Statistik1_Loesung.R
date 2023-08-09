#lade Packages
library(ggplot2)
library(dplyr)
library(readr)

## definiert mytheme für ggplot2 (verwendet dabei theme_classic())
mytheme <- 
  theme_classic() + 
  theme(
    axis.line = element_line(color = "black"), 
    axis.text = element_text(size = 12, color = "black"), 
    axis.title = element_text(size = 12, color = "black"), 
    axis.ticks = element_line(size = .75, color = "black"), 
    axis.ticks.length = unit(.5, "cm")
    )

# Matrix erstellen
Aargauer <- c(4, 2)
names(Aargauer) <- c("Weiss", "NotWeiss")
NotAargauer <-c (7,22)
names(NotAargauer) <- c("Weiss", "NotWeiss")
AGsocks <- data.frame(Aargauer, NotAargauer)
AGsocks <- as.matrix(AGsocks)
AGsocks

# Daten anschauen mit erstem Google-Ergebnis für "Assoziation Plot r"
assocplot(AGsocks) # Interpretation des Plots mit dem Befehl ?assocplot

# Tests durchführen
chisq.test(AGsocks) # Chi-Quadrat-Test nur zum anschauen.
fisher.test(AGsocks) # "Fisher's Exact Test for Count Data"

#lade Daten
df <- readr::read_csv2("datasets/statistik/Datensatz_novanimal_Uebung_Statistik1.2.csv")

# überprüft die Voraussetzungen für einen t-Test
ggplot2::ggplot(df, aes(x = condit, y= tot_sold)) + # achtung 0 Punkt fehlt
    geom_boxplot(fill = "white", color = "black", size = 1) + 
    labs(x="\nBedingungen", y="Durchschnittlich verkaufte Gerichte pro Woche\n") + 
    mytheme

# Auf den ersten Blick scheint es keine starken Abweichungen zu einer 
#Normalverteilung zu geben resp. es sind keine extremen schiefen Verteilungen
# ersichtlich (vgl. Skript Statistik 2)

# führt einen t-Tests durch; 
# es wird angenommen, dass die Verkaufszahlen zwischen den Bedingungen 
# unabhängig sind

t_test <- t.test(tot_sold ~ condit, data=df, var.equl = T)
t_test

#alternative Formulierung
t.test(df[df$condit == "Basis", ]$tot_sold, 
                 df[df$condit == "Intervention", ]$tot_sold) 

# zeigt die Ergebnisse mit einer Abbildung
p <- ggplot2::ggplot(df, aes(x = condit, y= tot_sold)) + 
  # erzeugt sogenannte Whiskers mit Strichen, achtung reihenfloge zählt hier
  stat_boxplot(geom ='errorbar', width = .25) + 
  geom_boxplot(fill = "white", color = "black", size = 1) +
  labs(x="\nBedingungen", y="Durchschnittlich verkaufte Gerichte pro Woche\n") + 
  mytheme

print(p)

