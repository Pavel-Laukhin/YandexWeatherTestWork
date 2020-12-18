# YandexWeatherTestWork

## The test task

Start screen - a table with a list of 10 cities (be sure to show the temperature, city name and current weather conditions). You can make this list editable if you want. There should be a SearchBar above the table, in which the user can search for cities of interest. When clicking on a cell, the user is taken to the detailed information screen.

Detailed Information Screen - after entering a city in the SearchBar, the application should display a screen that will display detailed information about the selected city. The design and what information needs to be displayed is up to you.

API link - https://yandex.ru/dev/weather/doc/dg/concepts/about-docpage/

## Result (after 2 days of work)

### Functionality:

1. You can view detailed information about cities.
1. You can search for new cities.
1. You can add new cities.
1. You can delete cities (swipe one at a time or delete several at once in edit mode).
1. An activity indicator is displayed while the information is being loaded. Even if you quickly jump to the detailed information window BEFORE it has time to load data from the server.
1. The app shows a message box if the city is not found.

### My notes about what else could be done and improved + bugs I found:

1. Add the possibility to move cells.
1. Add a swipe down refresher to update the information (test a lot of refreshes, in case there suddenly will be some race condition).
1. Make sure that the activity indicators do not disappear at the same time.
1. Add the weekly forecast to the detailed information window.
1. FIX THE BUG: After deleting a city and adding a new one: the old icon is superimposed on the new one.
1. FIX THE BUG: When searching for new cities, the weather icon in the center of the view is not displayed. But after adding a city, when you search for the same city again, the icon is displayed normally.
1. Move the contents of the DetailViewController to a separate view so that you can reuse it later.
1. Move the setWindDescription and conditionDescription methods to separate enumerations in separate files.
1. Improve the color palette of the application.
1. Add random motivating expressions to the detail screen. Something like "There is no bad weather!", "There is no bad weather, there is poorly matched clothes!", etc.

-----

## Тестовое задание

Стартовый экран – таблица со списком из 10 городов (обязательно показать температуру, название города и текущие погодные условия). При желании можно сделать этот список редактируемым. Над таблицей есть SearchBar, в нем пользователь может искать интересующие его города. При нажатии на ячейку пользователь попадает на экран подробной информации,

Экран подробной информации – после ввода города в SearchBar, приложение должно отобразить экран на котором будет подробная информация о выбранном городе. Дизайн и какую информацию необходимо отображать – решайте вы сами. 

Ссылка на API – https://yandex.ru/dev/weather/doc/dg/concepts/about-docpage/

## Результат (после 2-х дней работы)

### Функционал:

1. Можно смотреть детальную информацию по городам.
1. Можно искать новые города.
1. Можно добавлять новые города.
1. Можно удалять города (свайпом по одному или сразу несколько в режиме редактирования).
1. Во время загрузки информации отображается индикатор активности. В том числе, если быстро перейти в окно детальной информации ДО того, как она успела загрузиться с сервера.
1. Приложение показывает окно сообщения, если город не найден.

### Мои заметки насчет того, что еще можно было бы сделать и улучшить + обнаруженые мною баги:

1. Добавить перемещение ячеек.
1. Добавить рефрешер свайпом вниз для обновления информации (протестировать множество рефрешей, вдруг случится какой-нибудь race condition).
1. Сделать так, чтобы индикаторы активности не исчезали одновременно.
1. Добавить недельный прогноз в окно детальной информации.
1. ИСПРАВИТЬ БАГ: После удаления города и добавления нового: иконка старого накладывается на иконку нового.
1. ИСПРАВИТЬ БАГ: При поиске новых городов иконка погоды в центре вьюхи не показывается. Но после добавления города при повторном поиске этого же города иконка показывается нормально.
1. Из DetailViewController содержимое вынести в отдельную вьюху, чтобы можно было потом переиспользовать.
1. Перенести методы setWindDescription и conditionDescription в отдельные энамы в отдельные файлы.
1. Улучшить цветовую палитру приложения.
1. Добавить рандомные мотивирующие выражения на детальный экран. Из серии "У природы нет плохой погоды", "Не бывает плохой погоды, бывает плохо подобранная одежда" и т.п.
