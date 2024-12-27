
<h1><img src="https://github.com/mehah/otclient/blob/main/data/images/clienticon.png?raw=true" width="32" alt="logo"/> OTClient - Redemption</h1>

[![Discord Shield](https://discordapp.com/api/guilds/888062548082061433/widget.png?style=shield)](https://discord.gg/HZN8yJJSyC)
[![Build - Ubuntu](https://github.com/mehah/otclient/actions/workflows/build-ubuntu.yml/badge.svg)](https://github.com/mehah/otclient/actions/workflows/build-ubuntu.yml)
[![Build - Windows](https://github.com/mehah/otclient/actions/workflows/build-windows.yml/badge.svg)](https://github.com/mehah/otclient/actions/workflows/build-windows.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)




## 📋 Spis treści

1. ![Logo](https://raw.githubusercontent.com/mehah/otclient/main/src/otcicon.ico)  [Czym jest OTClient - Redemption?](#whatisotclient)
2. 🚀 [Funkcje](#features)
6. <img height="16" src="https://raw.githubusercontent.com/github/explore/80688e429a7d4ef2fca1e82350fe8e3517d3494d/topics/android/android.png" alt="Android"> [Projekt mobilny](#themobileproject)
3. 🔨 [Kompilowanie](#compiling)
4. 🐳 [Docker](#docker)
5. 🩺 [Potrzebujesz pomocy?](#need-help?)
6. 📑 [Błędy?](#bugs)
7. ❤️  [Dalszy rozwój](#roadmap)
8. 💯 [Wspierane protokoły](#supportprotocol)
9. ©️  [Licencja](#license)
10. ❤️ [Współtwórcy](#contributors)

## <a name="whatisotclient">![Logo](https://raw.githubusercontent.com/mehah/otclient/main/src/otcicon.ico)  Czym jest OTClient?</a>

OTClient - Redemption to alternatywny klient gry Tibia, przeznaczony do użytku z serwerami OT. Jego celem jest zapewnienie pełnej funkcjonalności i elastyczności, dlatego wykorzystuje skrypty .lua do obsługi wszystkich funkcji interfejsu gry oraz pliki konfiguracyjne .otui - podobne do .css celem projektowania interfejsu klienta. OTClient - Redemption działa w oparciu o system modułowy, co oznacza, że każda funkcjonalność jest oddzielnym modułem, co daje użytkownikom możliwość łatwej modyfikacji i dostosowywania wszystkich jego elementów. Użytkownicy mogą również tworzyć nowe mody oraz moduły i rozszerzać interfejs gry według własnych potrzeb. OTClient jest napisany w C++20 i intensywnie skryptowany w LUA.

Możesz stworzyć własnego klienta aby połączyć się z Forgottenserver lub Canary.

> \[!NOTE]
>
>OTClient - Redemption bazuje na [edubart/otclient](https://github.com/edubart/otclient) Rev: [2.760](https://github.com/edubart/otclient/commit/fc39ee4adba8e780a2820bfda66fc942d74cedf4)

## <a name="features">🚀 Funkcje</a>
Oprócz elastyczności w zakresie skryptów, OTClient - Redemption oferuje wiele innych funkcji, które umożliwiają tworzenie nowych elementów po stronie klienta, które wcześniej były niemożliwe. Należą do nich: system dźwiękowy, efekty graficzne z użyciem shaderów, system modułów/dodatków, animowane tekstury, personalizowany interfejs użytkownika, przezroczystość, obsługa wielu języków, terminal .lua w grze oraz silnik OpenGL 2.0 ES, który umożliwia portowanie na platformy mobilne. OTClient - Redemption jest również na tyle elastyczny, że pozwala na tworzenie narzędzi do Tibii, takich jak edytory map, wyłącznie przy użyciu skryptów, ponieważ nie został zaprojektowany tylko jako klient, lecz jako połączenie Frameworka i API Tibii.


- <details>
  <summary>Szczegóły optymalizacji w odniesieniu do OTClient autorstwa edubart:</summary>


  - C++20 (v17, budowa Unity i tryb manifestu (vcpkg.json)) w wersji x32 i x64

  - <details>
    <summary>Asynchroniczne ładowanie tekstur</summary>

      - **i ) Opis:** Dzięki temu plik .spr nie jest buforowany, a w konsekwencji zużycie pamięci RAM jest mniejsze.

      - **ii ) Przykład:**


      https://github.com/kokekanon/otclient.readme/assets/114332266/f3b7916a-d6ed-46f5-b516-30421de4616d


    </details>

  - <details>
    <summary>Wielowątkowość</summary>

      -**i ) Opis:**

    [Główny Wątek]
    - Dźwięk
    - Cząsteczki
    - Ładowanie tekstur (plików)
    - Obsługa okien (klawiatura, mysz, ...)
    - Generowanie tekstur

    [Drugi Wątek]
    - Połączenie
    - Wydarzenia (g_dispatcher)
    - Zbieranie informacji o tym co ma być wygenerowane na mapie

    [Trzeci Wątek]
    - Zbieranie informacji o tym co ma być wygenerowane w interfejsie.


      - **ii ) Schemat:**
      ![multinucleo](https://github.com/kokekanon/otclient.readme/assets/114332266/95fb15ac-553f-4eca-937d-8c8f49990f3e)

    </details>

  - <details>
    <summary>Mniejsze zużycie pamięci</summary>

      - **i ) Opis:**
        ```async autoreload
        highlightingPtr to stackPos
        new async dispatcher (using bs thread_pool)
        optimized updateChildrenIndexStates & updateLayout
        removed ThingTypePtr
        scoped object to raw pointer
        shaderPtr to shaderId
        oraz inne optymalizacje
        ```


    </details>

  - <details>
    <summary>-   Nowy system oświetlenia z przyciemnianiem</summary>

      - **i ) Przykład:**


      https://github.com/kokekanon/otclient.readme/assets/114332266/de8ffd14-af8c-4cc0-b5b1-2e166243bffc


    </details>

  - Ulepszenie systemu chodzenia


  -   Obsługuje sekwencyjne pakiety i kompresję

  - Wsparcie (Tibia 13)

  - <details>
    <summary>Ulepszenie UIWidgets</summary>

      - **i ) Opis:**<br><br>
      [UIWidget] Ulepszony algorytm interfejsu użytkownika przyniósł lepszą wydajność w dodawaniu, usuwaniu i przestawianiu widgetów. Można zauważyć te poprawki w module walki.<br><br>
   



      - **ii ) Przykład:**


      https://github.com/kokekanon/otclient.readme/assets/114332266/eed1464a-ae4d-4cd6-9f22-c719b4f09766


    </details>
  - <details>
    <summary>Wymuszona optymalizacja efektów</summary>

      - **i ) Opis:** Unika generowania efektów w określonych sytuacjach.

    </details>
    
  - Zaktualizowane biblioteki


</details>

- <details>
   <summary>Automatyczne przeładowanie modułów</summary>

   Activate `g_modules.enableAutoReload()`  ([init.lua](https://github.com/mehah/otclient/blob/main/init.lua#L114))


   https://github.com/kokekanon/otclient.readme/assets/114332266/0c382d93-6217-4efa-8f22-b51844801df4


</details>


- <details>
   <summary>System dodatkowych efektów do tworzenia aur, skrzydeł itp.</summary>

    - Kompatybilny z .Apng
      - ThingCategoryEffect
      - ThingCategoryCreature 
      - ThingExternalTexture: to grafiki w Png lub Apng

    - [Wiki](https://github.com/mehah/otclient/wiki/Tutorial-Attached-Effects)  

    - Przykład kodu:
    (code sample: [effects.lua](https://github.com/mehah/otclient/blob/main/modules/game_attachedeffects/effects.lua), [code test](https://github.com/mehah/otclient/blob/main/modules/game_attachedeffects/attachedeffects.lua#L1))
    - Przykładowe ustawienia specyficzne dla lookType X   [outfit_618.lua](https://github.com/mehah/otclient/blob/main/modules/game_attachedeffects/configs/outfit_618.lua)

      - Masz AttachdEffect X, który ma standardowy offset, lecz w daemonie wszystko jest zniekształcone, więc używasz ThingConfig, aby dostosować efekt specjalnie do pożądanego typu wyglądu.

</details>

| <img src="https://github.com/kokekanon/OTredemption-Picture-NODELETE/blob/main/Picture/Attached%20Effect/Creature/001_Bone.gif?raw=true" width="200" alt="Haskanoid Video" style="max-width:200px;"> | <img src="https://github.com/kokekanon/OTredemption-Picture-NODELETE/blob/main/Picture/Attached%20Effect/Creature/002_aura.gif?raw=true" width="200" alt="Peoplemon by Alex Stuart" style="max-width: 200px;"> | <img src="https://github.com/kokekanon/OTredemption-Picture-NODELETE/blob/main/Picture/Attached%20Effect/Creature/003_particula.gif?raw=true" width="250" alt="Space Invaders" style="max-width: 250px;"> |
|-------------------------------------------|---------------|-------------------------|
| Osadzony efekt ThingCategory | Osadzony efekt Texture(Png) | <center> Cząsteczki </center> |


-   Cieniowanie gruntu
-   Podświetlenie celu kursora (naciśnij Shift, aby wybrać dowolny obiekt)
-   Tryb widoku gruntu (Normalny, Zanikający, Zablokowany, Zawsze widoczny, Zawsze widoczny z przezroczystością)
-   Opcja efektów unoszących się
-   Przebudowany system chodzenia
-   Wsparcie dla większej liczby przycisków myszy, na przykład 4 i 5
- <details>
   <summary>System kontrolera modułów</summary>

   bezpieczniejszy sposób na tworzenie modułów, bez potrzeby usuwania powiązania klawiszy, rozłączania zdarzeń czy niszczenia widżetów.

    ([Code example](https://github.com/mehah/otclient/blob/cache-for-all/modules/game_minimap/minimap.lua))

</details>

- Wsparcie klientów 12.85 ~ 12.92, 13.00 ~ 13.40 (protobuf)
- Market został przepisany i jest kompatybilny z TFS oraz Canary
- Asynchroniczne ładowanie tekstur
- <details>
    <summary>Opcje trybu wygładzania krawędzi</summary>
  - note : (Note: Styl Smooth Retro zużywa więcej zasobów GPU)
  
  - **i ) Przykład**
       ![vvff](https://github.com/kokekanon/otclient.readme/assets/114332266/5a411525-7d5a-4b16-8bb6-2c6462152d39)

     

</details>

- <details>
   <summary> Wsparcie Negative Offset (.dat)  </summary>
  
  - Kompatybilny z [ObjectBuilderV0.5.5](https://github.com/punkice3407/ObjectBuilder/releases/tag/v0.5.5)
  
   - Należy aktywować funkcję:

      g_game.enableFeature(GameNegativeOffset)
     
   - Przykład

   https://github.com/kokekanon/otclient.readme/assets/114332266/16aaa78b-fc55-4c6e-ae63-7c4063c5b032


</details>

- <details>
   <summary>Informacje o stworzeniach w UIWidget</summary>
   
  - By aktywować: [setup.otml](https://github.com/mehah/otclient/blob/e2c5199e52bd86f573c9bb582d7548cfe7a8b026/data/setup.otml#L20)
  - Styl: [modules/game_creatureinformation](https://github.com/mehah/otclient/tree/main/modules/game_creatureinformation)
  - Uwaga: W porównaniu do bezpośredniego programowania z użyciem Draw Pool występuje spadek wydajności o około ~20%. Testy przeprowadzono z 60 potworami atakującymi się nawzajem.

  https://github.com/kokekanon/otclient.readme/assets/114332266/c2567f3f-136e-4e11-964f-3ade89c0056b


</details>

- Drawpool 3
- Widżet kratki [Wiki](https://github.com/mehah/otclient/wiki/Tutorial-Attached-Effects)

| <img src="https://github.com/kokekanon/OTredemption-Picture-NODELETE/blob/main/Picture/Attached%20Effect/Tile/001_attachedeffect.gif?raw=true" width="250" alt="Haskanoid Video" style="max-width:250px;"> | <img src="https://github.com/kokekanon/OTredemption-Picture-NODELETE/blob/main/Picture/Attached%20Effect/Tile/002_widget.png?raw=true" width="200" alt="Peoplemon by Alex Stuart" style="max-width: 200px;"> | <img src="https://github.com/kokekanon/OTredemption-Picture-NODELETE/raw/main/Picture/Attached%20Effect/Tile/003_particulas.gif?raw=true" width="310" alt="Space Invaders" style="max-width: 310px;"> |
|-------------------------------------------|---------------|-------------------------|
|<center>Osadzony efekt na kratce</center> | <center> Widżet kratki </center>| <center>Cząsteczki na kratce</center> |


- <details>
   <summary>Wsparcie dla składni HTML/CSS</summary>
  
  https://github.com/user-attachments/assets/9f20814f-0aed-4b70-8852-334ac745ec11

  https://github.com/user-attachments/assets/3ac8473c-8e90-4639-b815-ef183c7e2adf
  
  Przykład modułu:
   - [Shader](https://github.com/mehah/otclient/tree/main/modules/game_shaders)
   - [Blessing](https://github.com/mehah/otclient/pull/825)
</details>

- Wsparcie DirectX

- <details>
   <summary>Garbage Collection </summary>
  <br>
  Garbage collection jest mechanizmem używanym w wielu miejscach (lua, texture, drawpool, thingtype). Służy zarządzaniu pamięcią. Jego zadaniem jest identyfikowanie obiektów, które nie są już używane i usuwanie ich z pamięci aby zwolnić zasoby.
</details>



##### 🙋 Społeczność (Funkcje)
- Wsparcie klienta mobilnego [@tuliomagalhaes](https://github.com/tuliomagalhaes) & [@BenDol](https://github.com/BenDol) & [@SkullzOTS](https://github.com/SkullzOTS) 

| <img src="https://github.com/kokekanon/OTredemption-Picture-NODELETE/blob/main/Picture/Android/001_ingame.png?raw=true" width="200" alt="Haskanoid Video" style="max-width:200px;"> | <img src="https://github.com/kokekanon/OTredemption-Picture-NODELETE/blob/main/Picture/Android/001_interface.png?raw=true" width="200" alt="Peoplemon by Alex Stuart" style="max-width: 200px;"> | <img src="https://github.com/kokekanon/OTredemption-Picture-NODELETE/blob/main/Picture/Android/003_patrikq.jpg?raw=true" width="270" alt="Space Invaders" style="max-width: 270px;"> |
|-------------------------------------------|---------------|-------------------------|
| Interfejs | Zagęszczenie Pikseli | Joystick (patrykq) |

- Wsparcie Tibia 12.85/protobuf by [@Nekiro](https://github.com/nekiro)


- <details>
   <summary>Wsparcie Discord RPC by @SkullzOTS (Nie współpracuje z CMAKE).</summary>

  - autorstwa [@SkullzOTS](https://github.com/SkullzOTS)

  - By aktywować przejdź do [config.h](https://github.com/mehah/otclient/blob/main/src/framework/config.h#L43), ustaw 1 w ENABLE_DISCORD_RPC i skonfiguruj pozostałe definicje.

  - Do obejrzenia krok po kroku na [YouTube](https://www.youtube.com/watch?v=zCHYtRlD58g)

</details>

| <img src="https://github.com/kokekanon/OTredemption-Picture-NODELETE/blob/main/Picture/Discord/001.png?raw=true" width="200" alt="Haskanoid Video" style="max-width:200px;"> | <img src="https://github.com/kokekanon/OTredemption-Picture-NODELETE/blob/main/Picture/Discord/002_ingame.png?raw=true" width="200" alt="Peoplemon by Alex Stuart" style="max-width: 200px;"> | <img src="https://github.com/kokekanon/OTredemption-Picture-NODELETE/blob/main/Picture/Discord/003_future.png?raw=true" width="200" alt="Space Invaders" style="max-width: 200px;"> |
|-------------------------------------------|---------------|-------------------------|
| Przykładowy Interfejs | Przykład w grze | W przyszłości discord-game-sdk  |


- Action Bar autorstwa [@DipSet](https://github.com/Dip-Set1)
- Dostęp do elementów podrzędnych widgetu przy pomocy widget.childId autorstwa [@Hugo0x1337](https://github.com/Hugo0x1337)
- Poprawka systemu cieniowania (CTRL + Y) autorstwa [@FreshyPeshy](https://github.com/FreshyPeshy)

| <img src="https://github.com/kokekanon/OTredemption-Picture-NODELETE/blob/main/Picture/Shader/001_creature.gif?raw=true" width="200" alt="Haskanoid Video" style="max-width:200px;"> | <img src="https://github.com/kokekanon/OTredemption-Picture-NODELETE/blob/main/Picture/Shader/003_map.gif?raw=true" width="200" alt="Peoplemon by Alex Stuart" style="max-width: 200px;"> | <img src="https://github.com/kokekanon/OTredemption-Picture-NODELETE/blob/main/Picture/Shader/002_mount.gif?raw=true" width="200" alt="Space Invaders" style="max-width: 200px;"> |
|-------------------------------------------|---------------|-------------------------|
| Stworzenia | Mapy | Wierzchowca|

- Przebudowany moduł walki autorstwa [@andersonfaaria](https://github.com/andersonfaaria)

- Health&Mana Circle autorstwa [@EgzoT](https://github.com/EgzoT), [@GustavoBlaze](https://github.com/GustavoBlaze), [@Tekadon58](https://github.com/Tekadon58) ([GITHUB Project](https://github.com/EgzoT/-OTClient-Mod-health_and_mana_circle))
- Motyw Tibia 1.2 autorstwa Zews ([Forum Thread](https://otland.net/threads/otc-tibia-theme-v1-2.230988/))
- Dodana opcja ADJUST_CREATURE_INFORMATION_BASED_ON_CROP_SIZE w [config.h](https://github.com/mehah/otclient/blob/main/data/setup.otml#L24) autorstwa [@SkullzOTS](https://github.com/SkullzOTS)
- <details>
   <summary>System szyfrowania autorstwa @Mrpox (Uwaga: Ta implementacja jest niebezpieczna.)</summary>
   
   autorstwa [@Mrpox](https://github.com/Mrpox)
    - By aktywować przejdź do  [config.h](https://github.com/mehah/otclient/blob/main/src/framework/config.h#L33), ustaw 1 w ENABLE_ENCRYPTION i zmień hasło w ENCRYPTION_PASSWORD
  - Aby aktywować szyfrowanie flagą "--encrypt" zmień ENABLE_ENCRYPTION_BUILDER na 1 (autorstwa [@TheMaoci](https://github.com/TheMaoci)). Umożliwia usunięcie kodu tworzącego zaszyfrowane pliki z wersji produkcyjnej.
  - Aby wymusić szyfrowanie użyj flagi "--encrypt SET_YOUR_PASSWORD_HERE" i nie zapomnij zmienić hasła!
  - Możesz również pominąć dodawanie hasła do polecenia --encrypt, zostanie ono automatycznie pobrane z pliku [config.h](https://github.com/mehah/otclient/blob/main/src/framework/config.h#L38) (autorstwa [@TheMaoci](https://github.com/TheMaoci))

</details>

- Wsparcie HTTP/HTTPS/WS/WSS. autorstwa [@alfuveam](https://github.com/alfuveam)
- <details>
   <summary>Automatyczna aktualizacja klienta</summary>

  - autorstwa [@conde2](https://github.com/conde2)
  - Wklej folder API do swojego folderu www (https://github.com/mehah/otclient/tree/main/tools/api)
  - Tworzy folder nazwany "files" w twoim folderze www i wkleja pliki init.lua, modules, data oraz exe.
  - Odkomentuj i zmień tą linię. (https://github.com/mehah/otclient/blob/main/init.lua#L6)


</details>

- <details>
   <summary>Kolorowy tekst</summary>

  - autorstwa [@conde2](https://github.com/conde2)
  - widget:setColoredText("{Colored text, #ff00ff} normal text")

</details>


- <details>
   <summary>Wsparcie dla kodów QR, z automatycznym generowaniem z ciągu znaków.</summary>

  - autorstwa [@conde2](https://github.com/conde2)
  ```
  UIQrCode: 
  code-border: 2
  code: Hail OTClient Redemption - Conde2 Dev
  ```

</details>
  
- <details>
   <summary>Ikony pisania</summary>

  - autorstwa [@SkullzOTS](https://github.com/SkullzOTS)
  - By aktywować przejdź do [setup.otml](https://github.com/mehah/otclient/blob/main/data/setup.otml) i ustaw draw-typing: true

</details>
<p align="center">
 <img src="https://github.com/kokekanon/OTredemption-Picture-NODELETE/blob/main/Picture/typing%20ico/001.gif?raw=true" width="200" alt="Haskanoid Video" style="max-width:200px;"> 

</p>

- <details>
   <summary>Płynne chodzenie na wzniesieniach</summary>

  - autorstwa [@SkullzOTS](https://github.com/SkullzOTS)
  - Zobacz funkcję: [Gyazo](https://i.gyazo.com/af0ed0f15a9e4d67bd4d0b2847bd6be7.gif)
  - By aktywować przejdź do [modules/game_features/features.lua](https://github.com/mehah/otclient/blob/main/modules/game_features/features.lua#L5), i odkomentuj linię 5 (g_game.enableFeature(GameSmoothWalkElevation)).

</details>
<p align="center">
 <img src="https://github.com/kokekanon/OTredemption-Picture-NODELETE/blob/main/Picture/smooth/001_smooth.gif?raw=true" width="200" alt="Haskanoid Video" style="max-width:200px;"> 

</p>

- Debugger Lua dla VSCode [zobacz wiki](https://github.com/mehah/otclient/wiki/Lua-Debugging-(VSCode)) [@BenDol](https://github.com/BenDol)
- Poradnik używania klienta w TFS [zobacz wiki](https://github.com/mehah/otclient/wiki/Tutorial-to-Use-OTC-in-TFS-main)

- Dźwięk 3D i efekty dźwiękowe! autorstwa [@Codinablack](https://github.com/codinablack)


| Przykład 1 | Przykład 2 | Przykład 3 |
|---------|---------|---------|
| <video src="https://github.com/kokekanon/otclient.readme/assets/114332266/4547907a-8eb9-42f5-b445-901cb5270509" width="200" controls></video> | <video src="https://github.com/kokekanon/otclient.readme/assets/114332266/0bb4739f-e902-4370-85dc-e796564aac8e" width="200" controls></video> | <video src="https://github.com/kokekanon/otclient.readme/assets/114332266/95db3fa1-a793-4ab7-86a3-e21a8543a23c" width="200" controls></video> |






- <details>
   <summary>Wygląd bazowany na Tibia 13</summary>

  - autorstwa [@marcosvf132](https://github.com/marcosvf132)
  - Game_shop v8
  - Minimap WorldTime

    - tfs c++(old): 
    - `void ProtocolGame::sendWorldTime()`
    - tfs lua(new) : 
    - `function Player.sendWorldTime(self, time)`
    - Canary: 
    - `void ProtocolGame::sendTibiaTime(int32_t time)`

  - Okno Outfit kompatybilne z attachEffect , cieniami.
    - Canary : 
    - 1.4.2 : 
      - https://github.com/kokekanon/TFS-1.4.2-Compatible-Aura-Effect-Wings-Shader-MEHAH/commit/77f80d505b01747a7c519e224d11c124de157a8f
    - Downgrade :
      - https://github.com/kokekanon/forgottenserver-downgrade/pull/2
      - https://github.com/kokekanon/forgottenserver-downgrade/pull/7
      - https://github.com/kokekanon/forgottenserver-downgrade/pull/9
  - Kalendarz
  - client_bottommenu (aktywuj tablicę "Services.status" w init.lua).

  Dodaj to w  
  `./otclient/tools/api/status.php` in your
  `C:/UniServerZ/www/api/` 

  jeśli nie działa, aktywuj **curl**:



  ![image](https://github.com/Nottinghster/otclient/assets/114332266/99ad2ce7-d70f-47f4-aa19-083140fb5814)

  ![image](https://github.com/Nottinghster/otclient/assets/114332266/84349388-a458-4eb5-b1d6-cce5693cfd5a)


</details>


| <img src="https://github.com/kokekanon/OTredemption-Picture-NODELETE/blob/main/Picture/Layout%2013/001_interface.png?raw=true" width="300" alt="Haskanoid Video" style="max-width:300px;"> | <img src="https://github.com/kokekanon/OTredemption-Picture-NODELETE/blob/main/Picture/Layout%2013/002_ingame.png?raw=true" width="300" alt="Peoplemon by Alex Stuart" style="max-width: 300px;"> |
|-------------------------------------------|---------------|
|<center> Interface </center> | <center>In-game</center> |
- Śledzenie nasycenia autorstwa [@Reyaleman](https://github.com/reyaleman)
- Błogosławieństwo  
- Zrzut ekranu  
- Najlepsze wyniki  
- Sklep (kompatybilny z 13.32 - 13.40)  
- QuickLoot  
- Grupy VIP

- <details>
   <summary>Przeglądarkowy klient</summary>

  - autorstwa [@OTArchive](https://github.com/OTArchive)
  - wiki: https://github.com/OTArchive/otclient-web/wiki/Guia-%E2%80%90-OTClient-Redemption-Web
  
  - https://github.com/user-attachments/assets/e8ab58c7-1be3-4c76-bc6d-bd831e846826

</details>

##### 💸 Wsparcie  (Funkcje)
- Bot V8  ([@luanluciano93](https://github.com/luanluciano93), [@SkullzOTS](https://github.com/SkullzOTS), [@kokekanon](https://github.com/kokekanon), [@FranciskoKing](https://github.com/FranciskoKing), [@Kizuno18](https://github.com/Kizuno18))
  - Zaadoptowany w 85%
  - By aktywować, należy usunąć flagę BOT_PROTECTION.
  - [VS Solution](https://github.com/mehah/otclient/blob/68e4e1b94c2041bd235441244156e6477058250c/vc17/settings.props#L9) / [CMAKE](https://github.com/mehah/otclient/blob/68e4e1b94c2041bd235441244156e6477058250c/src/CMakeLists.txt#L13)

- Cieniowanie z boforem ramki  ([@SkullzOTS](https://github.com/SkullzOTS), [@Mryukiimaru](https://github.com/Mryukiimaru), [@JeanTheOne](https://github.com/JeanTheOne), [@KizaruHere](https://github.com/KizaruHere))

| <img src="https://github.com/kokekanon/OTredemption-Picture-NODELETE/blob/main/Picture/Shader/Framebuffer/001_creature.gif?raw=true" width="200" alt="Haskanoid Video" style="max-width:200px;"> | <img src="https://github.com/kokekanon/OTredemption-Picture-NODELETE/blob/main/Picture/Shader/Framebuffer/002_items.gif?raw=true" width="200" alt="Peoplemon by Alex Stuart" style="max-width: 200px;"> | <img src="https://github.com/kokekanon/OTredemption-Picture-NODELETE/blob/main/Picture/Shader/Framebuffer/003_UICreature.gif?raw=true" width="110" alt="Space Invaders" style="max-width: 110px;"> |
|-------------------------------------------|---------------|-------------------------|
| <center>Creature.</center> |<center> Items</center> |<center> UICreature </center> |

- Pełna Cyclopedia ([@luanluciano93](https://github.com/luanluciano93), [@kokekanon](https://github.com/kokekanon), [@MUN1Z](https://github.com/MUN1Z) ,[@qatari](https://github.com/qatari) )

##### [OTClient V8](https://github.com/OTCv8) (Funkcje)
- System oświetlenia
- Cieniowanie gruntu
- Wyszukiwanie drogi
- Moduł sklepu
- Moduł wyglądu
- Placeholder
- UIGraph
- Przypisywanie klawiszy
  
## <a name="themobileproject"><img height="32" src="https://raw.githubusercontent.com/github/explore/80688e429a7d4ef2fca1e82350fe8e3517d3494d/topics/android/android.png" alt="Android"> Klient mobilny</a>
Projekt klienta mobilnego
To jest fork OTClienta edubarta. Celem tego forka jest opracowanie działającego otclienta na urządzenia mobilne.

Cele do wykonania:
- [x] Kompilacja pod Android
- [ ] Kompilacja pod  Apple
- [ ] Adaptacja interfejsu używając istniejącego kodu

Aktualne poradniki kompilacji:
* [Kompilacja pod Android](https://github.com/mehah/otclient/wiki/Compiling-on-Android)


## <a name="compiling">🔨 Kompilacja</a>

[Jeśli jesteś zainteresowany kompilacją własnego OTC - Redemption, przejdź do wiki.](https://github.com/mehah/otclient/wiki)



## <a name="docker">🐳 Docker</a>

Aby zbudować aplikację do produkcji, uruchom następujące polecenie:

1.  Aby zbudować obraz:
```bash
docker build -t mehah/otclient .
```
2.  Aby uruchomić zbudowany obraz:

```sh
# Wylacz kontrole dostepu dla serwera X.
xhost +

# Uruchom obraz z wymaganymi powiazaniami do urzadzen hosta i woluminow.
docker run -it --rm \
  --env DISPLAY \
  --volume /tmp/.X11-unix:/tmp/.X11-unix \
  --device /dev/dri \
  --device /dev/snd mehah/otclient /bin/bash

# Włacz kontrole dostepu dla serwera X.
xhost -
```



## <a name="need-help?">🩺 Potrzebna pomoc?</a>

Spróbuj zapytać na [discord](https://discord.gg/HZN8yJJSyC)

## <a name="bugs">📑 Błędy?</a>

Znalazłeś błąd? Proszę utwórz zgłoszenie w naszym [dziale błędów](https://github.com/mehah/otclient/issues)

> \[!TIP]
>
> jeśli używasz Nostalrius 7.2, Nekiro TFS-1.5-Downgrades-7.72 lub jakiegokolwiek protokołu poniżej 8.60,  a podczas chodzenia **szarpie**, ustaw:
[force-new-walking-formula: true](https://github.com/mehah/otclient/blob/cf7badda978de88cb3724615688e3d9da2ff4207/data/setup.otml#L21) w setup.otml
>
> W starszych protokołach animacja elementów może być za szybka, zmień wartość parametru [item-ticks-per-frame] z 75 na 500 (https://github.com/mehah/otclient/blob/cf7badda978de88cb3724615688e3d9da2ff4207/data/setup.otml#L32)  w setup.otml

## <a name="roadmap">❤️ Cele</a>

| Do wykonania            	| Status                            	| PR   	|
|-----------------------	|-----------------------------------	|------	|
| Kompatybilność z Androidem 	| ![](https://geps.dev/progress/50) 	| [Branch](https://github.com/mehah/otclient/tree/mobile-working) 	|
| Wygląd chowańców       	| ![](https://geps.dev/progress/30) 	| [#39](https://github.com/Nottinghster/otclient/pull/39) 	|
| Koło Przeznaczenia            	| ![](https://geps.dev/progress/1) 	| None	|
| Forge            	| ![](https://geps.dev/progress/1) 	| None	|
| Analizer              	| ![](https://geps.dev/progress/10)   |  [#802](https://github.com/mehah/otclient/pull/802)    	|
| Rozszerzony nowy motyw | ![](https://geps.dev/progress/0)   |   None   	|
| Dźwięki Tibia 13 | ![](https://geps.dev/progress/0)   |   None   	|

## <a name="supportprotocol">💯 Wsparcie wersji</a>


| Protokół/Wersja   	| Opis                 	| Wymagana Funkcja                                    	| Kompatybilność 	|
|---------------------	|-----------------------------	|-----------------------------------------------------	|---------------	|
| TFS <br> (7.72)      	| Downgrade nekiro /<br> Nostalrius 	|                  [force-new-walking-formula: true](https://github.com/mehah/otclient/blob/cf7badda978de88cb3724615688e3d9da2ff4207/data/setup.otml#L21)        <br>   [item-ticks-per-frame: 75](https://github.com/mehah/otclient/blob/cf7badda978de88cb3724615688e3d9da2ff4207/data/setup.otml#L32)                          	| ✅            	|
| TFS 0.4 <br> (8.6)       	| Fir3element                	|  [item-ticks-per-frame: 75](https://github.com/mehah/otclient/blob/cf7badda978de88cb3724615688e3d9da2ff4207/data/setup.otml#L32)                                 	| ✅             	|
| TFS 1.5  <br> (8.0 / 8.60) 	| Downgrade nekiro / <br>MillhioreBT     	| [force-new-walking-formula: true](https://github.com/mehah/otclient/blob/cf7badda978de88cb3724615688e3d9da2ff4207/data/setup.otml#L21)        <br>   [item-ticks-per-frame: 75](https://github.com/mehah/otclient/blob/cf7badda978de88cb3724615688e3d9da2ff4207/data/setup.otml#L32)        	| ✅             	|
| TFS 1.4.2 <br> (10.98)   	| Release Otland              	|                                              	| ✅             	|
| TFS 1.6  <br>(13.10)     	| Main repo <br> otland (2024)     	| [Zobacz wiki](https://github.com/mehah/otclient/wiki/Tutorial-to-Use-OTC-in-TFS-main) 	| ✅             	|
| Canary 13.21        	| OpenTibiaBr               	| [Assets , Enable HTTP login and port 80](https://docs.opentibiabr.com/opentibiabr/projects/otclient-redemption#how-to-connect-on-canary-with-otclient-redemption)            	| ✅             	|
| Canary 13.32        	| OpenTibiaBr              	| [Assets ,  Enable HTTP login and port 80](https://docs.opentibiabr.com/opentibiabr/projects/otclient-redemption#how-to-connect-on-canary-with-otclient-redemption)           	| ✅             	|
| Canary 13.40        	| OpenTibiaBr              	| [Assets ,  Enable HTTP login and port 80](https://docs.opentibiabr.com/opentibiabr/projects/otclient-redemption#how-to-connect-on-canary-with-otclient-redemption)           	| ✅             	|




## <a name="license">©️ Licencja</a>

OTClient jest udostępniany na licencji MIT. [MIT License](http://opensource.org/licenses/MIT). Oznacza to, że masz prawo do robienia, co chcesz, zarówno w kontekście komercyjnym, jak i niekomercyjnym, oraz możesz tworzyć wersje zamknięte lub otwarte.

## <a name="contributors">❤️ Współtwórcy</a>

Jeśli jesteś zainteresowany wspieraniem projektu, kliknij w [link](https://www.paypal.com/donate/?business=CV9D5JF8E46LY&no_recurring=0&item_name=Thank+you+very+much+for+your+donation.&currency_code=BRL), każda kwota to wielka pomoc, dziękuję.
