# Ruutu-lataaja

Ohjelman avulla saat ladattua mieleisesi videon Ruudusta, myös Ruutu+-videot. Videoformaatti on oletuksena mp4.
Ohjelma toimii komentokehotteen kautta ja näin ollen myös videoiden latauskin. 

**EDIT 2.3.2020!:** Ruutu+ -videoita saa ladattua ainoastaan voimassa olevan Ruutu+ -tilauksen avulla.   
**EDIT 1.3.2021:** Ruutu+ -videoissa tarvitaan henk.koht. token joka lisätään manuaalisesti koodiin, sitten lataukset lähtee. Pahoittelut niille joille jäänyt epäselväksi että vaikka olette kirjautuneena sivustolle, niin ei lataus toimikaan.

Supla on nyt myös tuettuna. Lataus toimii samalla tavalla kuin Ruudustakin, eli liitä podcastin osoite lataajaan, anna tiedostolle nimi ja lataus alkaa. Formaatti on podcasteille mp3.     
**EDIT 19.1.2023:** Suplan podcastit eivät ole toimineet muutamaan kuukauteen johtuen osoitemuutoksista.

**EDIT 1.3.2021:** Äänikirjojen lataukseen on olemassa ohjelma, vaaditaan Supla+ -tunnus sekä hieman lähdekoodin tuntemista, lisätietoja yv:llä.

Pienet asennusohjeet:

- Kun olet ladannut paketin, pura ja siirrä zip-kansion sisältö (Ruutu-kansio) kokonaisuudessaan käyttäjänimesi alle, eli "C:\Users\Käyttäjänimi\ ",
yksinkertaisemmin: paina Windows-painiketta, valitse käyttäjänimesi ja liitä kansio muiden kansioiden joukkoon.
- Avaa Ruutu-kansio ja näet Ruutu-tiedoston. Luo siitä pikakuvake työpöydälle jonka jälkeen on helpompi avata ohjelma kun haluat ladata videoita.
- Avaa ja suorita ohjelma kun windows sitä kysyy. 
- Kun on ohjelma auki, kopioi haluamasi videon koko osoite ja liitä ohjelmaan, sen jälkeen paina Enter. Jos jotain menee pieleen, näet virheilmoituksen.
- Anna videolle nimi, vältä ääkkösiä tässä vaiheessa, videon valmistuttua voit muokata virallisemman nimen. Sen jälkeen paina uudestaan Enter ja lataus alkaa. 
- Latauksen päätyttyä ilmestyy kysely, haluatko aloittaa uuden latauksen vai ei. Jos valitset ei, ikkuna sulkeutuu. Lataamasi video sijaitsee samassa paikassa mihin kansio siirrettiin, eli "C:\Users\Käyttäjänimi\videon_nimi.mp4"

FFmpeg on zip-paketin mukana mutta saat sen ladattua myös täältä jos se puuttuu:  [FFmpeg](https://github.com/BtbN/FFmpeg-Builds/releases)


<b><font size="8">Lataa paketti:</font></b> [Ruutu-lataaja](https://github.com/untoor/Ruutu-lataaja/releases)

This program helps you to download videos from Ruutu. Videoformat is mp4 by default.

Supla is now supported. Download happens same way as Ruutu. Add the podcast address to address-field, give name for the file and podcast is starting to download. Format is mp3.

Installing guide:

- When you've been downloaded zip-file, extract it and move its folder (Ruutu-folder) to under your username, "C:\Users\USERNAME\ ".
- Open Ruutu-folder and you see Ruutu-file. Create desktop-icon from it so its easier to open it later, when you need it.
- Open and start program when windows asks it.
- After opening, copy video-address and paste it to program, after that press Enter. If something went wrong, you see error message.
- Give name to your video, don't use scandinavian vowels, after download is ready, you can change the name whatever you like. Then press Enter and  download starts.
- After download is ready, there comes question that do you want to download new video or not. If not, window closes. Downloaded video hang same place were we moved Ruutu-folder, "C:\Users\USERNAME\video_name.mp4"
