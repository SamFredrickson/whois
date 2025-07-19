# Поиск игрока среди госуадсртвенных организаций на проекте Evovle Role Play(https://github.com/SamFredrickson/whois/releases/download/v1.0.0/whois-release-1.0.0.rar)
Позволяет узнать в какой государственной организации состоит или состоял игрок и другую информацию
## Зависимости (установить перед запуском скрипта)
-   [CLEO 4](https://cleo.li)
-   [SAMPFUNCS v5.4.1 ](https://www.blast.hk/threads/17/) (для работы возможно потребуется установка [DirectX и Visual C++ Redistributable](https://www.dropbox.com/s/sgbnapzy66umupu/sampfuncs.zip?dl=1))
-   [Moonloader v026.5](https://www.blast.hk/threads/13305/)
-   [Effil](https://www.blast.hk/attachments/19493/) (скопировать из архива в каталог '**moonloader/lib/**')
## Установка
### Для пользователей
1. [Скачать](https://github.com/SamFredrickson/whois/releases/download/v1.0.0/whois-release-1.0.0.rar) архив с файлами скрипта
2. Распаковать скачанный архив в папку **moonloader** в корне игры
### Для разработчиков
1. Зайти в папку **moonloader** в корне игры
2. Склонировать проект командой:
    ```sh
    git clone https://github.com/SamFredrickson/whois
    ```
3. Перенести файл **whois.lua** в папку **moonloader**:
    ```sh
    cp whois/whois.lua .
    ```