// Обработка создания, проверки и удаления предопределенных настроек для подсистемы ПредопределенныеЗначения.

// Процедура выполняется при создании формы на сервере.
// Параметры:
// - Отказ - логическое значение, указывающее на отмену действия. Если в процедуре установлено Истина, то стандартное действие будет прервано.
// - СтандартнаяОбработка - логическое значение, если Истина, то выполнится стандартная обработка события.
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	УстановитьНачальныеСтатусыПроверок();

КонецПроцедуры

#Область ОбработчикиКомандФормы


// Процедура вызывается при выполнении команды создания предопределенных настроек.
// Параметры:
// - Команда - объект, представляющий команду.
&НаКлиенте
Процедура СозданиеПредопределенныхНастроек(Команда)

	СозданиеПредопределенныхНастроекНаСервере();

КонецПроцедуры

// Процедура вызывается при выполнении команды удаления предопределенных настроек.
// Параметры:
// - Команда - объект, представляющий команду.
&НаКлиенте
Процедура УдалениеПредопределенныхНастроек(Команда)

	ОбновитьПовторноИспользуемыеЗначения();
    УдалениеПредопределенныхНастроекНаСервере();
    ОбновитьПовторноИспользуемыеЗначения();
    ПроверитьУдаленныеНастройки();

КонецПроцедуры

#КонецОбласти

#Область СерверныеМетоды

// Процедура выполняет создание предопределенных настроек на сервере.
&НаСервере
Процедура СозданиеПредопределенныхНастроекНаСервере()

    ОбновитьПовторноИспользуемыеЗначения();
	ТаблицаНастроек = ТаблицаПредопределенныхТестовыхНастроек();
    ПредопределенныеНастройки.ЗаполнениеПредопределенныхЭлементов(ТаблицаНастроек);
    ПроверитьСозданныеНастройки();

КонецПроцедуры

// Функция возвращает таблицу предопределенных тестовых настроек.
// Возвращаемое значение:
// ТаблицаЗначений - ТаблицаЗначений, содержащая информацию о предопределенных тестовых настройках.
&НаСервере
Функция ТаблицаПредопределенныхТестовыхНастроек()

    ТаблицаНастроек = ПредопределенныеНастройки.ТаблицаПредопределенныхНастроек();

    ДобавитьТестовуюСтроку(ТаблицаНастроек);
    //ДобавитьТестовоеБулево(ТаблицаНастроек);
    //ДобавитьТестовуюСтрокуНастройку(ТаблицаНастроек);
   // ДобавитьТестовыйМногострочный(ТаблицаНастроек);
    //ДобавитьТестовуюТаблицуЗначений(ТаблицаНастроек);
    //ДобавитьТестовыйМассив(ТаблицаНастроек);
   
    Возврат ТаблицаНастроек;

КонецФункции

&НаСервере
Процедура ДобавитьТестовуюСтроку(ТаблицаНастроек)
 
    ЗначениеПараметровМассив = Новый Массив;
    ЗначениеПараметровМассив.Добавить("Значение1");
    ЗначениеПараметровМассив.Добавить("Значение2");

    НоваяНастройка = ТаблицаНастроек.Добавить();
    НоваяНастройка.Идентификатор = Новый УникальныйИдентификатор("2f205348-2c73-46a8-98a6-851a40a12bbe");
    НоваяНастройка.ИмяНастройки = "ТестированиеСтроковогоЗначения";
    //НоваяНастройка.Хранилище = Перечисления.ValueStorage.Текстовый;
    НоваяНастройка.Содержание = "ДобавитьТестовуюСтроку";
    НоваяНастройка.Описание = "Пример содержания строки";
    //НоваяНастройка.ТипЗначения = Справочники.ПредопределенныеНастройки.НайтиПоРеквизиту("ИмяНастройки", "ПримерТипа");
    НоваяНастройка.Значение = "ДобавитьТестовуюСтроку";

КонецПроцедуры

// Процедура добавляет тестовое значение строкового типа в таблицу настроек
Процедура ДобавитьТестовоеЗначение(ТаблицаНастроек)
    НоваяНастройка = ТаблицаНастроек.Добавить();
    НоваяНастройка.Идентификатор = Новый УникальныйИдентификатор("1f205348-2c73-46a8-98a6-851a40a12bbe");
    НоваяНастройка.ИмяНастройки = "ТестированиеСтроковогоЗначения";
    НоваяНастройка.Хранилище = Перечисления.ValueStorage.Текстовый;
    НоваяНастройка.Содержание = "ДобавитьТестовуюСтроку";
    НоваяНастройка.Описание = "Пример содержания строки";
    НоваяНастройка.Значение = "ДобавитьТестовуюСтроку"; // Присваиваем строковое значение
    



    
КонецПроцедуры

&НаСервере
Процедура ДобавитьТестовоеБулево(ТаблицаНастроек)
    
    НоваяНастройка = ТаблицаНастроек.Добавить();
    НоваяНастройка.Идентификатор = Новый УникальныйИдентификатор("1f205348-2c73-46a8-98a6-851a40a12bbe");
    НоваяНастройка.ИмяНастройки = "ТестБулево";
    НоваяНастройка.Хранилище = Перечисления.ValueStorage.Логический;
    НоваяНастройка.Содержание = "Истина";
    НоваяНастройка.ТипЗначения = Справочники.ПредопределенныеНастройки.НайтиПоРеквизиту("ИмяНастройки", "ПримерТипаБулево");

КонецПроцедуры

&НаСервере
Процедура ДобавитьТестовуюСтрокуНастройку(ТаблицаНастроек)
    
    НоваяНастройка = ТаблицаНастроек.Добавить();
    НоваяНастройка.Идентификатор = Новый УникальныйИдентификатор("3f205348-2c73-46a8-98a6-851a40a12bbe");
    НоваяНастройка.ИмяНастройки = "ТестСтрока";
    НоваяНастройка.Хранилище = Перечисления.ValueStorage.Текстовый;
    НоваяНастройка.Содержание = "Пример строки";
    НоваяНастройка.ТипЗначения = Справочники.ПредопределенныеНастройки.НайтиПоРеквизиту("ИмяНастройки", "ПримерТипаСтрока");

КонецПроцедуры

&НаСервере
Процедура ДобавитьТестовыйМногострочный(ТаблицаНастроек)
    
    НоваяНастройка = ТаблицаНастроек.Добавить();
    НоваяНастройка.Идентификатор = Новый УникальныйИдентификатор("4f205348-2c73-46a8-98a6-851a40a12bbe");
    НоваяНастройка.ИмяНастройки = "ТестМногострочный";
    НоваяНастройка.Хранилище = Перечисления.ValueStorage.Текстовый;
    НоваяНастройка.Содержание = "Первая строка\r\nВторая строка";
    НоваяНастройка.ТипЗначения = Справочники.ПредопределенныеНастройки.НайтиПоРеквизиту("ИмяНастройки", "ПримерТипаМногострочный");

КонецПроцедуры

&НаСервере
Процедура ДобавитьТестовуюТаблицуЗначений(ТаблицаНастроек)
  
    ТаблицаЗначенийПример = Новый ТаблицаЗначений;
    ТаблицаЗначенийПример.Колонки.Добавить("Столбец1", Новый ОписаниеТипов("Число"));
    ТаблицаЗначенийПример.Колонки.Добавить("Столбец2", Новый ОписаниеТипов("Строка"));
    Строка = ТаблицаЗначенийПример.Добавить();
    Строка.Столбец1 = 1;
    Строка.Столбец2 = "Значение1";
    Строка = ТаблицаЗначенийПример.Добавить();
    Строка.Столбец1 = 2;
    Строка.Столбец2 = "Значение2";
    
    НоваяНастройка = ТаблицаНастроек.Добавить();
    НоваяНастройка.Идентификатор = Новый УникальныйИдентификатор("5f205348-2c73-46a8-98a6-851a40a12bbe");
    НоваяНастройка.ИмяНастройки = "ТестТаблицаЗначений";
    НоваяНастройка.Хранилище = Перечисления.ValueStorage.ТаблицаЗначений;

    НоваяНастройка.Содержание = ТаблицаЗначенийПример;
    НоваяНастройка.ТипЗначения = Справочники.ПредопределенныеНастройки.НайтиПоРеквизиту("ИмяНастройки", "ПримерТипаТаблицы");

КонецПроцедуры

&НаСервере
Процедура ДобавитьТестовыйМассив(ТаблицаНастроек)

    МассивПример = Новый Массив;
    МассивПример.Добавить(1);
    МассивПример.Добавить("Два");
    МассивПример.Добавить(3.14);

    НоваяНастройка = ТаблицаНастроек.Добавить();
    НоваяНастройка.Идентификатор = Новый УникальныйИдентификатор("6f205348-2c73-46a8-98a6-851a40a12bbe");
    НоваяНастройка.ИмяНастройки = "ТестМассив";
    НоваяНастройка.Хранилище = Перечисления.ValueStorage.Массив;

    НоваяНастройка.Содержание = МассивПример;
    НоваяНастройка.ТипЗначения = Справочники.ПредопределенныеНастройки.НайтиПоРеквизиту("ИмяНастройки", "ПримерТипаМассив");

КонецПроцедуры


// Процедура проверяет, были ли созданы предопределенные настройки.
&НаСервере
Процедура УстановитьНачальныеСтатусыПроверок()

 	Элементы.НастройкиСозданы.Картинка = БиблиотекаКартинок.ОформлениеКругПустой;
 	Элементы.НастройкиСозданы.Подсказка = НСтр("ru ='Проверка не производилась'");
	Элементы.НастройкиУдалены.Картинка = БиблиотекаКартинок.ОформлениеКругПустой;
 	Элементы.НастройкиУдалены.Подсказка = НСтр("ru ='Проверка не производилась'");

КонецПроцедуры

// Процедура проверяет, были ли созданы предопределенные настройки.
&НаСервере
Процедура ПроверитьСозданныеНастройки()

    НастройкиНайдены = Истина;
    ТаблицаНастроек = ТаблицаПредопределенныхТестовыхНастроек();
    
    Для Каждого Строка Из ТаблицаНастроек Цикл
        Настройка = ПредопределенныеНастройкиПовтИсп.СсылкаПредопределеннойНастройки(Строка.ИмяНастройки);
        Если Настройка = ПредопределенноеЗначение("Справочник.ПредопределенныеНастройки.ПустаяСсылка") Тогда
            НастройкиНайдены = Ложь;
        КонецЕсли;
    КонецЦикла;

    Если НастройкиНайдены Тогда 
        Элементы.НастройкиСозданы.Картинка = БиблиотекаКартинок.ОформлениеКругЗеленый;
        Элементы.НастройкиСозданы.Подсказка = НСтр("ru ='Тестовые настройки созданы'");
    Иначе
        Элементы.НастройкиСозданы.Картинка = БиблиотекаКартинок.ОформлениеКругКрасный;
        Элементы.НастройкиСозданы.Подсказка = НСтр("ru ='Тестовые настройки не найдены'");
    КонецЕсли;

КонецПроцедуры

// Процедура удаляет предопределенные настройки с сервера.
&НаСервере
Процедура УдалениеПредопределенныхНастроекНаСервере()

    ОбновитьПовторноИспользуемыеЗначения();
    ТаблицаНастроек = ТаблицаПредопределенныхТестовыхНастроек();

    Для Каждого Строка Из ТаблицаНастроек Цикл
        Настройка = ПредопределенныеНастройкиПовтИсп.СсылкаПредопределеннойНастройки(Строка.ИмяНастройки);
        Если ЗначениеЗаполнено(Настройка) И ТипЗнч(Настройка) = Тип("СправочникСсылка.ПредопределенныеНастройки") Тогда
            ОбъектНастройки = Настройка.ПолучитьОбъект();
            ОбъектНастройки.Удалить();
        КонецЕсли;
    КонецЦикла;

КонецПроцедуры

// Процедура проверяет, были ли удалены предопределенные настройки.
&НаСервере
Процедура ПроверитьУдаленныеНастройки()

    НастройкиУдалены = Истина;
    ТаблицаНастроек = ТаблицаПредопределенныхТестовыхНастроек();

    Для Каждого Строка Из ТаблицаНастроек Цикл
        Настройка = ПредопределенныеНастройки.Значение(Строка.ИмяНастройки);
        Если Настройка <> ПредопределенноеЗначение("Справочник.ПредопределенныеНастройки.ПустаяСсылка") Тогда
            НастройкиУдалены = Ложь;
        КонецЕсли;
    КонецЦикла;

    Если НастройкиУдалены Тогда 
        Элементы.НастройкиУдалены.Картинка = БиблиотекаКартинок.ОформлениеКругЗеленый;
        Элементы.НастройкиУдалены.Подсказка = НСтр("ru ='Тестовые настройки не обнаружены'");
    Иначе
        Элементы.НастройкиУдалены.Картинка = БиблиотекаКартинок.ОформлениеКругКрасный;
        Элементы.НастройкиУдалены.Подсказка = НСтр("ru ='Тестовые настройки найдены в базе'");
    КонецЕсли;

КонецПроцедуры
#КонецОбласти