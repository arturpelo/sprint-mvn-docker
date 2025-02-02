# Etap budowania

# Określamy obraz bazowy z JDK 21 na Alpine Linux. Ten etap będzie używany do budowy aplikacji.
FROM eclipse-temurin:23-jdk-alpine AS builder

# Ustawiamy katalog roboczy w kontenerze na /opt/app, w którym będziemy przechowywać aplikację.
WORKDIR /opt/app


# Kopiujemy plik Maven Wrapper (mvnw) do kontenera.
COPY mvnw .

# Kopiujemy katalog .mvn, który zawiera pliki konfiguracyjne dla Maven Wrappera.
COPY .mvn .mvn

# Kopiujemy plik pom.xml, który zawiera informacje o zależnościach i konfiguracji projektu.
COPY pom.xml .

# Nadajemy plikowi mvnw prawa wykonywalne, aby można było go uruchomić.
RUN chmod +x mvnw

# Pobieramy zależności projektu i przygotowujemy je do pracy offline.
RUN ./mvnw dependency:go-offline

# Kopiujemy cały katalog źródłowy aplikacji (src) do kontenera.
COPY src ./src

# Budujemy aplikację, wykonujemy testy i pakujemy ją do pliku JAR w katalogu target.
RUN ./mvnw clean install

# Etap uruchamiania
# Określamy obraz bazowy z JRE 21 na Alpine Linux. Ten etap jest lżejszy i służy tylko do uruchamiania aplikacji.
FROM eclipse-temurin:23-jre-alpine

# Ustawiamy katalog roboczy w kontenerze na /opt/app, gdzie będziemy trzymać wynikowy plik JAR.
WORKDIR /opt/app

# Kopiujemy wynikowy plik JAR z wcześniejszego etapu budowania do kontenera.
COPY --from=builder /opt/app/target/*.jar /opt/app/app.jar

# Otwieramy port 8080, na którym aplikacja będzie nasłuchiwać.
EXPOSE 8080

# Ustawiamy punkt wejścia, aby uruchomić aplikację Java (plik JAR) po starcie kontenera.
ENTRYPOINT ["java", "-jar", "/opt/app/app.jar"]
