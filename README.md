#### BBQ 
Ruby on Rails приложение для создания событий, приглашения друзей на мероприятие, для общения внутри мероприятия, для отправки информации о мероприятии, размещения фотографий.

**Запуск программы**

*Скопируйте репозиторий:*
```
git clone git@github.com:esromanycheva/bbq2.git
```

*Войдите в папку с программой:*
```
cd ./bbq2
```

*Установите библиотеки:*
```
bundle install
```

*Выполните команду:* 
```
EDITOR=vim rails credentials:edit
```
*и в файле credentials.yml заполните все ключи из credentials.yml.sample*

 
*Запустите миграции:*
```
rails db:migrate
```

*Соберите js файлы:*
```
yarn install
```
*Установить imagemagick:*
```
sudo apt-get install libmagickwand-dev imagemagick
```
*Запустите сервер:*
```
rails s
```

#### Реализованный функционал:
- Интернационализация (ru, en), i18n
- Мероприятия: создание, редактирование, удаление
- Отображение места мероприятия на Яндекс карте
- Пин-код для события
- Комментарии для события
- Подписки на событие
- Отправка почты (gmail)
- Загрузка фотографий (mightmagic, lightbox2)
- Хранение фотографий в Yandex Cloud
- Аутентификация (Devise)

#### Шпаргалка:

*В консоли:*
Посмотреть сопоставление Измерений и Норм
```
VahMet.unscoped.includes(:vah_norm).pluck(:id, :norm_name, :datetime, 'vah_norms.name', 'vah_norms.start_time', 'vah_norms.range_date')
```

Проверить check_sum у измерения
```
VahMet.find(707).vah_met_sites.pluck(:check_sum).uniq
```