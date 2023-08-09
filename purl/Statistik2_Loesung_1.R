
SAR <- read.delim("datasets/statistik/SAR.csv", sep = ";") # Daten einlesen
head(SAR) # Daten anschauen
str(SAR) # Datenformat überprüfen


summary(SAR) # Überblick verschaffen


boxplot(SAR$area) # Boxplot der Flächengrösse


boxplot(SAR$richness) # Boxplot der Artenzahl


plot(richness~area, data = SAR) # Daten plotten


lm.1 <- lm(richness~area, data = SAR) # lm erstellen
summary(lm.1) # lm anschauen


# Modell und Daten plotten
plot(SAR$area, SAR$richness, xlab = "Area [m²]", ylab = "Species richness") # Daten plotten
abline(lm.1, col = "red") # Modell plotten


# Modelldiagnostik
par(mfrow = c(2, 2)) # 4-Plot-panel
plot(lm.1) 


# Daten vor und nach log10-Transformation vergleichen
par(mfrow=c(2,2))
boxplot(SAR$richness)
boxplot(log10(SAR$richness))
hist(SAR$richness)
hist(log10(SAR$richness))


# lm rechnen mit log10 transformierter abhängigen Variable
SAR$log_richness <- log10(SAR$richness)
lm.2 <- lm(log_richness~area, data = SAR)
summary(lm.2)


# Modelldiagnostik
par(mfrow = c(2, 2))
plot(lm.2)


# Daten vor und nach log10-Transformation vergleichen
par(mfrow=c(2,2))
boxplot(SAR$area)
boxplot(log10(SAR$area))
hist(SAR$area)
hist(log10(SAR$area))


# lm rechnen mit log10-Transformation beider VAriablen
SAR$log_area <- log10(SAR$area)
lm.3 <- lm(log_richness~log_area, data = SAR)
summary(lm.3)


# Modelldiagnostik
par(mfrow = c(2, 2))
plot(lm.3)


# Modell und Daten plotten
plot(SAR$log_area, SAR$log_richness, xlab = "log10(Area [m²])", ylab = "log10(Species richness)") # Daten plotten
abline(lm.3, col = "red") # Modell plotten


# Input-Vektor mit x-Werten für die Modelle erstellen, der die Bandbreite der Daten abdeckt
xv <- seq(min(SAR$area), max(SAR$area), 0.1)


plot(SAR$area, SAR$richness)# Daten plotten
abline(lm.1, col="red") # Modell 1 (untransformiert) zu Plot hinzufügen

# Modell 2 (Anhängige Variable log10-transformiert) 
# Modellvoraussagen berechnen
logyvlm2 <- predict(lm.2, list(area = xv)) 
# Modellvoraussagen rücktransformieren
yvlm2 <- 10^logyvlm2 # 10^ ist Umkekrfunktion von Log10
# Zu Plot hinzufügen
lines(xv, yvlm2, col = "blue") # Modell 2 auf untransformierte Fläche plotten


# Modell 2 (beide Variablen log10-transformiert) 
# Modellvoraussagen berechnen
log10xv <- log10(xv) # Tansformierter Input-Vektor erstellen
logyvlm3 <- predict(lm.3, list(log_area = log10xv ))
# Modellvoraussagen rücktransformieren 
yvlm3 <- 10^logyvlm3 # 10^ ist Umkekrfunktion von Log10
lines(xv, yvlm3, col = "green") # Modell 2 auf untransformierte Fläche plotten
