# Ohjelmointikielten suorituskykyvertailu
### C# vs. PowerShell tiedostojen käsittelyssä

## Mikä?
Tämän repositorion tarkoituksena on tehdä koe, jolla saadaan vertailtua C#:n ja PowerShellin suorituskykyä.

Kokeen toimintamalli on suurten tekstitiedostojen luku ja rivien käsittely.

Alla olevissa ohjeissa kerrotaan kuinka tämän voi ladata ja suorittaa omalla Windows-tietokoneella.

## Ohjeet

1. Lataa repositorio koneelle ja pura tiedostot kansioon C:\Temp

2. Käynnistä PowerShell ja aja komento ".\C:\Temp\outputFileCreator.ps1"
    - Tämä muodostaa viisi tekstitiedostoa sijaintiin C:\Temp

    ![Kuva esimerkkitiedostoista](/img/example_output_files.PNG)

3. Kun tiedostot on muodostettu, voit ajaa molemmat tiedostoja käsittelevät skriptit

4. C#-skripti pitää ensin kääntää .exe-muotoon. Tähän voi käyttää csc.exeä, joka on Microsoftin tekemä C#-kääntäjä. Jos csc:tä ei löydy, se tulee mukana .Net framework -asennuksissa.
Kun csc.exe löytyy Windowsista, käännöksen voi tehdä näin:
```csc fileSeparator.cs```
Tämän jälkeen on muodostunut C:\Temp\fileSeparator.exe -tiedosto, jonka voi ajaa normaalisti.

5. C# skriptin voi käännöksen jälkeen ajaa. Skripti ei ajon jälkeen jää "pauselle". Jos .exe-tiedostoa tuplaklikkaa, skripti ajaa ja välittömästi poistuu ajon jälkeen. Tästä syystä kannattaa avata vaikkapa komentorivi, selata kansioon C:\Temp ja ajaa fileSeparator.exe
```
cd c:\temp
fileSeparator.exe
```

![C# skriptin ajo](/img/Skripti_cs.PNG)

6. Tämän jälkeen voi ajaa PowerShell-skriptin. Avaa PowerShell ja selaa kansioon ja aja PowerShell-skripti:
```
cd c:\temp
.\fileSeparator.ps1
```

![PowerShell-skriptin ajo](/img/Skripti_ps1.PNG)

7. Tämän jälkeen skriptit on ajettu ja molemmat ovat muodostaneet output-tiedostonsa sijaintiin C:\Temp:

![Laptop output-tiedostot](/img/example_laptop_files.PNG)
![Others output-tiedostot](/img/example_others_files.PNG)