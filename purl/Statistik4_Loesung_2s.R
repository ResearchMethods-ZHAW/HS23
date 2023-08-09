library(dplyr)
library(readr)
library(ggplot2)

# für Informationen zu den einzelnen Variablen, siehe https://zenodo.org/record/3554884/files/2020_ZHAW_vonRickenbach_Variablen_cleaned_recoded_survey_dataset_anonym_NOVANIMAL.pdf?download=1

## definiert mytheme für ggplot2 (verwendet dabei theme_classic())
mytheme <- 
  theme_classic() + 
  theme(
    axis.line = element_line(color = "black"), 
    axis.text = element_text(size = 20, color = "black"), 
    axis.title = element_text(size = 20, color = "black"), 
    axis.ticks = element_line(size = 1, color = "black"), 
    axis.ticks.length = unit(.5, "cm")
    )

df <- read_csv2("datasets/statistik/Datensatz_novanimal_Uebung_Statistik4.2.csv")

#  sieht euch die Verteilung zwischen Mensagänger und Selbstverpfleger an
# sind nicht gleichmässig verteilt, bei der Vorhersage müssen wir das berücksichtigen
table(df$mensa) 
df |> count(mensa) # alternativ

# definiert das logistische Modell und wendet es auf den Datensatz an

mod0 <-glm(mensa ~ gender + member + age_groups + meat + umwelteinstellung, 
           data = df, binomial("logit"))
summary.lm(mod0) # Umwelteinstellung scheint keinen Einfluss auf die 
# Verpflegung zu haben, gegeben die Daten

# neues Modell ohne Umwelteinstellung
mod1 <- update(mod0, ~. -umwelteinstellung)
summary.lm(mod1)

# Modeldiagnostik (wenn nicht signifikant, dann OK)
1 - pchisq(mod1$deviance, mod1$df.resid) # Ok

#Modellgüte (pseudo-R²)
1 - (mod1$dev / mod1$null) # eher kleines pseudo-R2, deckt sich mit dem R-Squared aus dem obigen output summary.lm()

# Konfusionsmatrix vom  Datensatz
# Model Vorhersage
# hier ein anderes Beispiel: 
predicted <- predict(mod1, df, type = "response")

# erzeugt eine Tabelle mit den beobachteten
# Mensagänger/Selbstverpfleger und den Vorhersagen des Modells
km <- table(predicted > 0.5, df$mensa) 
# alles was höher/grosser ist als 50% ist 
# kommt in die Kategorie Mensagänger

# anpassung der namen
dimnames(km) <- list(
  c("Modell Selbstverpfleger", "Modell Mensagänger"),
  c("Daten Selbstverpfleger", "Daten Mensagänger"))
km

#############
### reminder: https://towardsdatascience.com/understanding-confusion-matrix-a9ad42dcfd62
#############

#TP = true positive: you predicted positive and it’s true; hier Vorhersage 
# Mensagänger stimmt also (727)

#TN = true negative: you predicted negative and it’s true, hier Vorhersage der 
# Selbstverpfleger stimmt (87)

#FP = false positive (fehler 1. art, auch Spezifizität genannt) you predicted 
# and it’s false. hier Modell sagt Mensagänger vorher 
# (obwohl in Realität Selbstverpfleger) (195)

#FN = false negative (fehler 2. art, auch Sensitivität genannt), 
# you predicted negative and it’s false. hier Modell sagt Selbtverpfleger vorher 
# (obwohl in Realität Mensagänger) (59)


# es scheint, dass das Modell häufig einen alpha Fehler macht, d.h.  
# das Modell weist keine hohe Spezifizität auf: konkret werden viele Mensagänger als 
# Selbstverpfleger vorhergesagt resp. klassifiziert. Dafür gibt es mehere Gründe: 

#1) die Kriteriumsvariable ist sehr ungleich verteilt, d.h. es gibt weniger
# Selbstverpfleger als Mensgänger im Datensatz 
 
#2) nicht adäquates Modell z.B. link mit probit zeigt besserer fit

#3) Overfitting: wurde hier nicht berücksichtigt, in einem Paper/Arbeit 
# müsste noch einen Validierungstest gemacht werden z.B. test-train 
# Cross-Validation oder k fold Cross-Validation 

# kalkuliert die Missklassifizierungsrate 
mf <- 1-sum(diag(km)/sum(km)) # ist mit knapp 23 %  eher hoch
mf

# kleiner exkurs: https://www.ncbi.nlm.nih.gov/pmc/articles/PMC2636062/
# col wise proportion, da diese die "Realität" darstellt
km_prop <- prop.table(km,2)

# specificity = a / (a+c) => ability of a test to correctly 
spec = km_prop[1] / (km_prop[1] + km_prop[2])
spec

# sensitivity = d / (b+d) => Sensitivity is the ability of a 
sens = km_prop[4] / (km_prop[3] + km_prop[4])
sens


#| echo: false
#| fig.cap: Konfusionsmatrix
knitr::kable(km)
