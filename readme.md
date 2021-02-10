![](./docs/images/media/image1.jpeg){width="0.6375in"
height="1.2416666666666667in"}

**Óbudai Egyetem**

\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_

**Bánki Donát Gépész és Biztonságtechnikai Mérnöki Kar**

**Szabaduló szoba vezérlő szoftver tervezése**

> **OE-BGK** Hallgató neve: **Kovács Árpád**
>
> **2021.** Hallgató törzskönyvi száma: **/KVI**

![](./docs/images/media/image2.jpeg){width="0.6375in"
height="1.2416666666666667in"} **Óbudai Egyetem**

\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_

**Bánki Donát Gépész és Biztonságtechnikai Mérnöki Kar**

**HALLGATÓI NYILATKOZAT**

Alulírott hallgató kijelentem, hogy a szakdolgozat saját munkám
eredménye, a felhasznált szakirodalmat és eszközöket azonosíthatóan
közöltem. Az elkészült szakdolgozatban található eredményeket az egyetem
és a feladatot kiíró intézmény saját céljára térítés nélkül
felhasználhatja, a titkosításra vonatkozó esetleges megkötések mellett.

Budapest, 2020.

> \...\...\...\...\...\...\...\...\...\...\...\...\...\...\...\.....
>
> hallgató aláírása

**Tartalomjegyzék**

[1. Bevezetés 4](#bevezetés)

[2. Szakirodalom elemző feldolgozása
5](#szakirodalom-elemző-feldolgozása)

[2.1 Hivatkozások 5](#hivatkozások)

[2.1.1 Hivatkozások sorrendje 6](#hivatkozások-sorrendje)

[3. Saját munka 7](#saját-munka)

[3.1 Rajzok, képek, diagramok, ábrák 7](#rajzok-képek-diagramok-ábrák)

[3.2 Képletek 8](#képletek)

[3.3 Felsorolás 10](#felsorolás)

[4. Összefoglalás 12](#összefoglalás)

[5. Idegen nyelvű tartalmi összefoglaló
13](#idegen-nyelvű-tartalmi-összefoglaló)

[6. Felhasznált irodalom vagy Irodalomjegyzék
14](#felhasznált-irodalom-vagy-irodalomjegyzék)

[7. Mellékletek 15](#mellékletek)

Bevezetés
=========

A feladat egy olyan szabaduló szoba vezérlés létrehozása, mellyel akár a
programot távolról is lehessen futattni. A programnak támogatnia kell,
az ESP32 mikrovezérlőt, valamint tartalmazza, ábrázolja, és engedélyezze
a szobák szoftverének szerkesztését.

A feladatot úgy kell megoldani, hogy Raspberry PI mikroszámítógépen is
futtatható legyen.

A dokumentum célja a diplomamunka dokumentálása és leírása, a
szakdolgozat fő célkitűzése volt, egy olyan szoftver készítése, mely a
szabaduló szobáknak a létrehozásában és menedzselésében segít. A
szoftvernek támogatnia kell, új szabaduló szobák létrehozását, ESP32
mikrovezérlő szoftverének vezérlését HTTP-protokolon valamint a szobát
fenntartó személyzet segítését, a csapatok nyomon követését, és utoljára
de nem utolsósorban a szobák programozását.

A feladat eredménye egy olyan alkalmazás létrejötte mely távolról is
engedi a felhasználónak, hogy távolról is dolgozhasson.

Szakirodalom elemző feldolgozása
================================

![ESP32 Hardware Specifications - ESP-WROOM-32
Chip](./docs/images/media/image3.jpeg){width="2.8333333333333335in"
height="2.332638888888889in"}

Hivatkozások
------------

![ESP32 Hardware Specifications - Reset Boot Buttons & LED
Indicators](./docs/images/media/image4.jpeg){width="2.6979166666666665in"
height="2.033333333333333in"}

![ESP32 Development Board
Pinout](./docs/images/media/image5.png){width="5.904861111111111in"
height="3.6458333333333335in"}

A szakdolgozat a hallgatók önálló munkájaként készül, forrásmunkák, a
tárgyhoz kapcsolódó szakirodalom természetesen felhasználható. A
dolgozatból mindenképpen ki kell tűnnie, hogy melyek azok a részek,
amelyek forrásmunkák felhasználásán alapultak. Ezért minden olyan
esetben utalni kell a forrásmunkára, amikor a dolgozatban szereplő
megállapítások, adatok nem a hallgatók önálló megállapításai,
felmérései, adatgyűjtései

![1KB 128x64 OLED Display RAM Memory
Map](./docs/images/media/image6.png){width="5.904861111111111in"
height="2.9069444444444446in"}

![128x64 Blue I2C OLED
Display](./docs/images/media/image7.jpeg){width="2.1770833333333335in"
height="2.1770833333333335in"}

alapján keletkeztek. Szó szerint átvett anyagrészeket idézőjelben, a
forrás megjelölésével kell szerepeltetni. A szakirodalomra való
hivatkozás úgy történik, hogy a dolgozat végén a felhasznált
forrásmunkákat sorszámozva közlik, és a szövegben csak a vonatkozó
irodalom sorszámot jelzik, szögletes zárójelben. Pl. A kérdés
megközelítése \[1\] szerint \.... A fejezetcímhez szakirodalmi
hivatkozást tenni nem szabad.

Eszköz regisztráció

Az eszközön lévő kód

+------------------------------------------------------+
| if(esp32\_pass==\"\")                                |
|                                                      |
| {                                                    |
|                                                      |
| JSONVar tmp1;                                        |
|                                                      |
| tmpaddress=web\_server+\"?ajax&esp32\_welcome=reg\"; |
|                                                      |
| Serial.println(tmpaddress);                          |
|                                                      |
| res=http\_sys(tmpaddress);                           |
|                                                      |
| tmp1=JSON.parse(res);                                |
|                                                      |
| Serial.println(JSON.stringify(tmp1));                |
|                                                      |
| configobj\[\"esp32pass\"\]=tmp1\[\"pass\"\];         |
|                                                      |
| Serial.println(JSON.stringify(configobj));           |
|                                                      |
| save\_config();                                      |
|                                                      |
| ESP.restart();}                                      |
|                                                      |
| }                                                    |
+------------------------------------------------------+

### Hivatkozások sorrendje

A Felhasznált irodalomban szereplő publikációkat nem betűrendi
sorrendbe, nem a megjelenés dátumának sorrendjében kell felsorolni,
hanem a szövegben történő hivatkozás sorrendje szerint. Tehát a
szövegben az első hivatkozás száma \[1\] és a dolgozat további részeiben
egymás után, ahogy következnek. Természetesen, ha a későbbiekben ismét
hivatkozni kell egy már számozott publikációra, megtehető.

https://github.com/google/blockly\[1\]

Saját munka
===========

A dolgozat további fejezeteiben kell összeállítani a Szakdolgozat
kiírásban felsorolt feladatokat, a Bevezetésben meghatározott
célkitűzésekkel összhangban. Terjedelemben az egész Szakdolgozat
legalább 50%-a legyen. A témától függően több fejezetre is bontható a
saját munka bemutatása, azonban sem a fejezetek, sem az alfejezetek
számát nem célszerű túlzottan megnövelni. A fejezetek címeit a kiírt
témának megfelelően kell megválasztani!

A szöveg szerkesztése legyen A4-es méretű oldalon: fent 4 cm, lent 2,5
cm, bal és jobb 2,5 mm, 1 cm kötésmargóval, Times New Roman
betűtípussal, 12 pontméretű betűvel, 1,5-es sortávolsággal. A szöveg
igazítása sorkizárt.

Rajzok, képek, diagramok, ábrák
-------------------------------

A rajzokat, táblázatokat és egyéb illusztrációkat a szöveg közben ott,
ahol szóba kerülnek, vagy mellékletként kell elhelyezni. A megjelenítés
a következőképpen történik.

[\[CHART\]]{.chart}

1\. ábra. Az ábra elhelyezés mintája \[6\]

Az ábrát (legyen az diagram, kép vagy rajz) középre szerkesztve,
ábraszámmal és megnevezéssel kell ellátni, amely a beállított margón nem
nyúlhat túl. Az ábra számára a szövegben hivatkozni kell (1. ábra). Ha
az ábra egy megjelent publikációból származik, tehát nem saját
készítésű, akkor a megfelelő szakirodalomra hivatkozni kell a minta
szerint.

A táblázatok szerkesztésénél az alábbi szempontokat kell figyelembe
venni. A táblázat középre szerkesztve, számmal és megnevezéssel ellátva.
Számozás és megnevezés a minta szerint történjen, jobb oldalra igazítva,
dőlt betűtípussal.

*1. táblázat: A táblázat elhelyezés mintája \[7\]*

  Szöveg legyen olvasható      Szöveg legyen olvasható      
  ------------------------- -- ------------------------- -- --
                                                            

A táblázat számára a szövegben hivatkozni kell (1. táblázat). Ha egy
megjelent publikációból származik, akkor a megfelelő szakirodalomra
hivatkozni kell a minta szerint. A táblázat szerkesztésénél ügyelni kell
arra, hogy a tartalma olvasható és átlátható legyen. Szkennelt ábrát és
táblázatot nem tartalmazhat a dolgozat, a hallgatónak kell
megszerkesztenie táblázatkezelő, rajzkészítő stb. programok segítségével
úgy, hogy jól láthatóak legyenek.

A nagyobb terjedelműeket a Mellékletek tartalmazzák melyek, ha
egységesen A4 formátumúak, akkor a dolgozattal együtt köthetőek, ha
nagyobb méretűek, akkor szabályosan összehajtva a hátsó borítólap belső
oldalán kialakított tasakba kell tenni.

Képletek
--------

Számítások elvégzéséhez vagy egyéb esetekben képletek megjelenítésére
kerülhet sor, melyet az alábbiak szerint kell megszerkeszteni. A képlet
kerüljön középre, irodalomhivatkozással és sorszámozással. Továbbá az
összefüggésben lévő elemeket meg kell nevezni mértékegységükkel
feltűntetve a minta szerint.

A képességindex számításánál alkalmazott összefüggés \[8\]:

$C_{x} = \frac{\text{FTH} - \text{ATH}}{6 \cdot \hat{\sigma}} = \frac{\text{TM}}{6 \cdot \hat{\sigma}}$
(3.1)

ahol: *C~x~*: képességindex (capability);

*FTH*: felső tűréshatár;

*ATH*: alsó tűréshatár;

*TM*: tűrésmező;

$\hat{\sigma}$: a folyamat elméleti szórásának becslése.

A szerkesztéshez Egyenletszerkesztő alkalmazását javasoljuk.

Az elméleti érdesség értéke a Brammertz-féle formula szerint \[13\]:

$R_{\text{eBr}} = \frac{f^{2}}{8 \cdot r_{\varepsilon}} + \frac{h_{\text{min}}}{2} \cdot (1 + \frac{r_{\varepsilon} \cdot h_{\text{min}}}{f^{2}})$(3.2)

$h_{\text{min}} = \text{84} \cdot v_{c}^{- 0,7} \cdot r_{n}^{0,\text{25}}$(3.3)

*ahol: R~eBr~:* elméleti érdesség \[μm\],

*f:* előtolás \[mm/ford\],

*r~ε~:* a lapka csúcssugara \[mm\],

*h~min~:* a leválasztható minimális forgács- vastagság \[μm\],

*v~c~:* forgácsolósebesség \[m/min\],

*r~n~:* éllekerekedés \[μm\].

![Wiring Connections for OLED Display Module with
ESP32](./docs/images/media/image8.png){width="5.416666666666667in"
height="2.2604166666666665in"}

A szerkesztéshez Egyenletszerkesztő alkalmazását javasoljuk.

A szövegben az összefüggésre (3.2) történő hivatkozás, hasonlóan az
ábrára, táblázatra való hivatkozáshoz történjen. A számozást
fejezetenként újra kell kezdeni.

+---------------------------------------------------------------------+
| Alias /escape\_room \"E:/Github/obudai\_diplomamunka/server\_part\" |
|                                                                     |
| \<Directory \"E:/Github/obudai\_diplomamunka/server\_part\"\>       |
|                                                                     |
| AllowOverride AuthConfig                                            |
|                                                                     |
| Require local                                                       |
|                                                                     |
| ErrorDocument 403 /error/XAMPP\_FORBIDDEN.html.var                  |
|                                                                     |
| \</Directory\>                                                      |
+---------------------------------------------------------------------+

Felsorolás
----------

A szakdolgozat szövege folyamatos, azonban felsorolás kismértékben, ahol
szükséges alkalmazható. A felsorolások szerkesztésénél ügyelni kell a
jelölésekre és a mondatjelekre. A felsorolás szerkezetileg egy mondat,
tehát van eleje, közepe és vége, melyeket írásjelekkel tudunk
meghatározni. Ennek megfelelően a helyesen megszerkesztett felsorolást
mutatja az alábbi példa.

A felsorolásnál alkalmazható jelölések szintenként:

-   gondolatjel;

    -   pontjel;

        -   négyszögjel.

Az egyes felsorolások végén pontosvessző van és a „gondolatok"
kisbetűvel kezdődnek. Az utolsó felsorolást ponttal zárjuk. Egy másik
példa szerint minden felsorolást külön mondatként kezelünk, ha azok nem
egy összefüggő gondolatot tükröznek. Ilyenkor csak az első szinten
alkalmazzuk a gondolatjelet.

Néhány kiegészítés a Szakdolgozat szerkesztéséhez:

-   A szakdolgozat terjedelme 40-70 oldal legyen (mellékletek nélkül
    értendő).

-   A szöveg szerkesztésekor ne használjuk idegenszavakat, kivéve ha
    nincs magyar megfelelője.

-   A helyesírási hibákra és a gépelési elütésekre fokozottan ügyeljünk,
    mert a hibás, nem magyaros, csúnyán szerkesztett dolgozattal értékes
    pontokat lehet veszteni a bírálatnál még akkor is, ha egyébként
    szakmailag kifogástalan a munka.

-   Fogalmazzunk egyszerű, de kerek, egész mondatokkal.

-   Ne tagoljuk a szöveget üres sorokkal vagy úgy, hogy minden mondat
    külön bekezdésben szerepel. Ez nem célszerű!

-   Az ábrákat, táblázatokat illusztrációként használjuk, melyek
    tartalmát a dolgozatban le kell írni.

Természetesen számokkal vagy betűkkel is jelölhetjük a felsorolást az
alábbiak szerint.

A szakdolgozat összeállításának szabályai bekötésnél:

a)  Az első oldal a SZAKDOLGOZAT címlap.

b)  A második oldal a Szakdolgozat kiírási lap, amely az Intézetigazgató
    által valamint a konzulens(ek) által aláírt.

c)  A harmadik oldalra kerül a Hallgatói nyilatkozat.

d)  Ezt követi a Tartalomjegyzék és a dolgozat többi fejezete a
    szerkesztés szerint.

Összefoglalás
=============

A dolgozat utolsó része a rövid tartalmi összefoglaló, mely minimum egy
oldal legyen, terjedelemben az egész Szakdolgozat maximum 5%-a lehet
(1500-2500 karakter). Tartalmazza a kitűzött célok, felvetett problémák
megoldását továbbá a következtetéseket. Térjen ki a gyakorlati
alkalmazhatóságra.

Idegen nyelvű tartalmi összefoglaló
===================================

Escape room management software which is based on ESP32, contains admin
user interface, and multiple features for easier setup, reset, and for
measuring time.

A magyar nyelvű összefoglalás idegen nyelven történő közlését
tartalmazza. Az idegen nyelvű tartalmi összefoglaló elkészítése
történhet: **angolul, németül, oroszul vagy franciául.**

Felhasznált irodalom vagy Irodalomjegyzék
=========================================

Példák az egyes publikációk megnevezésére.

[Könyv esetében: Szerző (vagy Szerkesztő): Cím. Kiadó. Hely, Évszám.
Oldalszám.]{.underline}

\[1\] M. Csizmadia Béla: Modell-alkotás. Nemzeti Tankönyvkiadó.
Budapest, 2003. p. 21-24.

[Szakcikk esetében: Szerző(k): Cím. Folyóirat megnevezése. Megjelenés
száma/dátuma. Oldalszám.]{.underline}

\[2\] Hervay Péter -- Csesznok Sándor: Marási környezet szimulációjának
alkalmazása az oktatásban. Gépgyártás XLVII. évfolyam, 2007. 2-3. szám
p. 15-17.

[Jegyzet esetében: Szerző (vagy Szerkesztő): Cím. Oktatási Intézmény.
Hely, Évszám. Oldalszám.]{.underline}

\[3\] Ambrusné dr. Alady Márta -- Galla Jánosné -- dr. Sipos Sándor: A
Gépgyártástechnológia alapjai. BMF jegyzet. Budapest, 1995. p. 50-55.

[CD-n megjelent publikáció esetében: Szerző (vagy Szerkesztő): Cím.
Publikáció (Konferencia) neve. Hely, Évszám. CD. ISBN szám.]{.underline}

\[4\] Miko, B.: Hybrid inteligence system for mold cost estination. VI.
International tools conference (ITC) 2007. Zlin, May 22-23, 2007. CD.
ISBN-978-80-7318-572-5

[Internetes publikáció esetében: Szerző (vagy Szerkesztő): Cím. Hely.
Évszám. Honlap elérhetősége.]{.underline}

\[5\] Dr. Szabó László: Forgácsolás, hegesztés. Miskolc 2000.

<http://mek.oszk.hu/01200/01200/html/html>

Mellékletek
===========

Minden mellékletet sorszámmal, megnevezéssel kell ellátni. A
szakdolgozat szövegi részében hivatkozni kell (1. sz. melléklet).

1\. sz. melléklet: Az alkatrész összeállítási rajza.

2\. sz. melléklet: A termékvisszahívás folyamata.

https://medium.com/\@fmacedoo/standalone-application-with-electron-react-and-sqlite-stack-9536a8b5a7b9

https://lastminuteengineers.com/oled-display-esp32-tutorial/

https://lastminuteengineers.com/multiple-ds18b20-esp32-web-server-tutorial/
