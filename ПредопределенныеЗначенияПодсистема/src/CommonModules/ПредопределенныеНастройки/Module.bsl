Функция Значение(ИмяНастройки, ВызыватьИсключение = Ложь) Экспорт
	
	Возврат ПредопределенныеНастройкиПовтИсп.Значение(ИмяНастройки, ВызыватьИсключение);
	
КонецФункции

Функция РезультатЗначениеИзЗапроса(ИмяНастройки) Экспорт
	
	Запрос = Новый Запрос;
	Запрос.Текст =
	"ВЫБРАТЬ РАЗРЕШЕННЫЕ
	|	ПредопределенныеНастройки.Параметр КАК Параметр,
	|	ПредопределенныеНастройки.МногострочныйПараметр КАК МногострочныйПараметр,
	|	ПредопределенныеНастройки.СоставнойПараметр КАК СоставнойПараметр,
	|	ПредопределенныеНастройки.Хранилище КАК Хранилище
	|ИЗ
	|	Справочник.ПредопределенныеНастройки КАК ПредопределенныеНастройки
	|ГДЕ
	|	ПредопределенныеНастройки.Ссылка = &Ссылка
	|	И ПредопределенныеНастройки.МногострочныйПараметр = ЛОЖЬ
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	ПредопределенныеНастройки.Значение,
	|	ПредопределенныеНастройки.Ссылка.МногострочныйПараметр,
	|	NULL,
	|	NULL
	|ИЗ
	|	Справочник.ПредопределенныеНастройки.Параметры КАК ПредопределенныеНастройки
	|ГДЕ
	|	ПредопределенныеНастройки.Ссылка = &Ссылка
	|	И ПредопределенныеНастройки.Ссылка.МногострочныйПараметр = ИСТИНА";
	

	Ссылка = ПредопределенныеНастройкиПовтИсп.СсылкаПредопределенногоЭлемента(ИмяНастройки);

	
	Запрос.УстановитьПараметр("Ссылка", Ссылка);
	
	Попытка
		
		РезультатЗначение = Запрос.Выполнить();
		
	Исключение
			
			Сообщение = БазоваяФункциональностьКлиентСервер.ПодставитьПараметрыВСтроку(
				НСтр("ru ='Передано отсутствующее наименование предопределенной настройки ""%1""'"),
				ИмяНастройки);
			ВызватьИсключение Сообщение;
			
	КонецПопытки;
	
	Возврат РезультатЗначение;
	
КонецФункции

Процедура ЗаполнениеПредопределенныхЭлементов(ТаблицаОписанияПредопределенныхНастроек = Неопределено) Экспорт
	
	Если ТаблицаОписанияПредопределенныхНастроек = Неопределено Тогда 
		ИнициализироватьТаблицуПредопределенныхНастроек(ТаблицаОписанияПредопределенныхНастроек);
	КонецЕсли;
	
	ТаблицаОтсутствующихНастроекВБазе = ОтсутствующиеНастройкиВБазе(ТаблицаОписанияПредопределенныхНастроек);
	
	ОбновитьНастройкиВБазе(ТаблицаОтсутствующихНастроекВБазе);
	
КонецПроцедуры

Процедура ОбновитьНастройкиВБазе(ТаблицаНастроекВБазе) Экспорт
	
	Для Каждого СтрокаНастройки Из ТаблицаНастроекВБазе Цикл
		
		    ЭлементПоИдентификатору = Справочники.ПредопределенныеНастройки.ПолучитьСсылку(СтрокаНастройки.Идентификатор);
	        Если БазоваяФункциональность.СсылкаСуществует(ЭлементПоИдентификатору) Тогда
	        	НайденныйЭлемент = ЭлементПоИдентификатору; 
	        Иначе 
	        	НайденныйЭлемент = Справочники.ПредопределенныеНастройки.НайтиПоРеквизиту("ИмяНастройки", СтрокаНастройки.ИмяНастройки);
	        КонецЕсли;
	        
	        Если НайденныйЭлемент = Справочники.ПредопределенныеНастройки.ПустаяСсылка() Тогда 
		    	Элемент = Справочники.ПредопределенныеНастройки.СоздатьЭлемент();
	        Иначе
	        	Элемент = НайденныйЭлемент.ПолучитьОбъект();
	        КонецЕсли;
        

            Элемент.УстановитьСсылкуНового(ЭлементПоИдентификатору);
            
            
            Элемент.ИмяНастройки = СтрокаНастройки.ИмяНастройки;
            Элемент.МногострочныйПараметр = СтрокаНастройки.МногострочныйПараметр;
            Элемент.Записать();
	КонецЦикла;
	
	
КонецПроцедуры

Функция ОтсутствующиеНастройкиВБазе(ТаблицаОписанияПредопределенныхНастроек) Экспорт
	
	ТаблицаНовыхНастроек = ТаблицаПредопределенныхНастроек(); 
	
	Для Каждого СтрокаНастройки Из ТаблицаОписанияПредопределенныхНастроек Цикл
		
        Элемент = Справочники.ПредопределенныеНастройки.ПолучитьСсылку(СтрокаНастройки.Идентификатор);
        Если Не БазоваяФункциональность.СсылкаСуществует(Элемент) Тогда
        	Элемент = Справочники.ПредопределенныеНастройки.НайтиПоРеквизиту("ИмяНастройки", СтрокаНастройки.ИмяНастройки);        	
        КонецЕсли;
        
        Если ЗначениеЗаполнено(Элемент) = Ложь Тогда
        	НоваяНастройка = ТаблицаНовыхНастроек.Добавить();
        	ЗаполнитьЗначенияСвойств(НоваяНастройка, СтрокаНастройки);
        КонецЕсли;
        
	КонецЦикла;
	 
	Возврат ТаблицаНовыхНастроек;
	
КонецФункции

Процедура ИнициализироватьТаблицуПредопределенныхНастроек(ТаблицаОписанияПредопределенныхНастроек) Экспорт
	
	ТаблицаОписанияПредопределенныхНастроек = ТаблицаПредопределенныхНастроек();
	ЗаполнитьТаблицуПредопределенныхНастроек(ТаблицаОписанияПредопределенныхНастроек);
	ПредопределенныеНастройкиПереопределяемый.ПриЗаполненииТаблицыПредопределенныхНастроек(ТаблицаОписанияПредопределенныхНастроек);
	
КонецПроцедуры

Процедура ЗаполнитьТаблицуПредопределенныхНастроек(ТаблицаОписанияПредопределенныхНастроек) Экспорт

	
КонецПроцедуры

// Функция возвращает таблицу значений с предопределенными настройками.
// Таблица содержит следующие колонки:
//   - Идентификатор: Строка - уникальный идентификатор настройки.
//   - ИмяНастройки: Строка - наименование настройки.
//   - МногострочныйПараметр: Булево - признак многострочности параметра.
//   - ЗначенияПараметров: Массив - массив возможных значений параметра.
//
// Возвращаемое значение:
//   ТаблицаЗначений - таблица с колонками:
//     * Идентификатор (Строка),
//     * ИмяНастройки (Строка),
//     * МногострочныйПараметр (Булево),
//     * ЗначенияПараметров (Массив).
Функция ТаблицаПредопределенныхНастроек() Экспорт

    ТаблицаНастроек = Новый ТаблицаЗначений;
    ТаблицаНастроек.Колонки.Добавить("Идентификатор", Новый ОписаниеТипов("УникальныйИдентификатор"));
    ТаблицаНастроек.Колонки.Добавить("ИмяНастройки", Новый ОписаниеТипов("Строка"));
    ТаблицаНастроек.Колонки.Добавить("МногострочныйПараметр", Новый ОписаниеТипов("Булево"));
    ТаблицаНастроек.Колонки.Добавить("ЗначенияПараметров", Новый ОписаниеТипов("Массив"));
	
	Возврат ТаблицаНастроек;
	
КонецФункции