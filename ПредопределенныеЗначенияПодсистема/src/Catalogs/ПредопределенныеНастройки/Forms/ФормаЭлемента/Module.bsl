
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	

		ОтобразитьСоставнойПараметр();

	
	УстановитьОграничениеТипа();
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	ПереключитьСтраницу();
КонецПроцедуры

&НаКлиенте
Процедура ПередЗаписью(Отказ, ПараметрыЗаписи)
	
	Если Отказ Тогда
		Возврат;
	КонецЕсли;
	
	Если Объект.ТипЗначения = ПредопределенноеЗначение("Перечисление.ТипыЗначенияПредопределенныхЗначений.Массив") Тогда
		
		Если Объект.Параметры.Количество() = 0 Тогда
			БазоваяФункциональностьКлиентСервер.СообщитьПользователю(
				НСтр("ru='Не заполнен список'"), Объект.Ссылка, "Параметры", "Объект", Отказ);
				
		Иначе
			ПередЗаписьюМногострочныйПараметр(Отказ);
		КонецЕсли;
	
	ИначеЕсли Объект.ТипЗначения = ПредопределенноеЗначение("Перечисление.ТипыЗначенияПредопределенныхЗначений.КлючЗначение") Тогда
		
		Если ТаблицаПараметры.Количество() = 0 Тогда
			БазоваяФункциональностьКлиентСервер.СообщитьПользователю(
				НСтр("ru='Не заполнена таблица параметров'"), , "ТаблицаПараметры", , Отказ);
				
		Иначе
			ПередЗаписьюСоставнойпараметр(Отказ);
		КонецЕсли;
	
	Иначе
		
		Если НЕ ЗначениеЗаполнено(Объект.Значение) Тогда
			БазоваяФункциональностьКлиентСервер.СообщитьПользователю(
				НСтр("ru='Не заполнен параметр'"), Объект.Ссылка, "Параметр", "Объект", Отказ);
		КонецЕсли;
			
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ПередЗаписьюНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	
	Если Отказ Тогда
		Возврат;
	КонецЕсли;
	
	Если Объект.ТипЗначения = ПредопределенноеЗначение("Перечисление.ТипыЗначенияПредопределенныхЗначений.КлючЗначение") Тогда
		ПередЗаписьюНаСервереСоставнойПараметр(ТекущийОбъект);
	КонецЕсли;
	
	Если НЕ Объект.ТипЗначения = ПредопределенноеЗначение("Перечисление.ТипыЗначенияПредопределенныхЗначений.Массив")  И ТекущийОбъект.Параметры.Количество() > 0 Тогда
		ТекущийОбъект.Параметры.Очистить();
	КонецЕсли;
	Если НЕ Объект.ТипЗначения = ПредопределенноеЗначение("Перечисление.ТипыЗначенияПредопределенныхЗначений.КлючЗначение")  Тогда
		ТекущийОбъект.Хранилище = Новый ХранилищеЗначения(Неопределено);
		ТаблицаПараметры.Очистить();
	КонецЕсли;
	Если Не Объект.ТипЗначения = ПредопределенноеЗначение("Перечисление.ТипыЗначенияПредопределенныхЗначений.Булево") 
		 И Не Объект.ТипЗначения = ПредопределенноеЗначение("Перечисление.ТипыЗначенияПредопределенныхЗначений.Дата")
		 И Не Объект.ТипЗначения = ПредопределенноеЗначение("Перечисление.ТипыЗначенияПредопределенныхЗначений.Строка") Тогда
		ТекущийОбъект.Значение = Неопределено;
	КонецЕсли;
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ПереключательПараметрПриИзменении(Элемент)
	
	Модифицированность = Истина;
	
	ПереключитьСтраницу();
	
КонецПроцедуры


&НаКлиенте
Процедура ТипЗначенияПриИзменении(Элемент)
	//TODO: Вставить содержимое обработчика
КонецПроцедуры
#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыПараметры

&НаКлиенте
Процедура ПараметрыПриНачалеРедактирования(Элемент, НоваяСтрока, Копирование)
	
	Если ЗначениеЗаполнено(Объект.ТипЗначения) Тогда
		Возврат;
	КонецЕсли;
	
	Если Объект.Параметры.Количество() > 1 Тогда
		МассивТипов = Новый Массив;
		МассивТипов.Добавить(ТипЗнч(Объект.Параметры.Получить(0).Значение));
		Элементы.ПараметрыЗначение.ОграничениеТипа = Новый ОписаниеТипов(МассивТипов);
		
	Иначе
		Элементы.ПараметрыЗначение.ОграничениеТипа = Новый ОписаниеТипов();
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура ПередЗаписьюМногострочныйПараметр(Отказ)
	
	Для Каждого СтрокаТаблицы Из Объект.Параметры Цикл
		Если НЕ ЗначениеЗаполнено(СтрокаТаблицы.Значение) Тогда
			Поле = БазоваяФункциональностьКлиентСервер.ПодставитьПараметрыВСтроку(
				"Параметры[%1].Значение", СтрокаТаблицы.НомерСтроки - 1);
			
			БазоваяФункциональностьКлиентСервер.СообщитьПользователю(
				НСтр("ru='Не заполнен элемент списка'"), Объект.Ссылка, Поле, "Объект", Отказ);
				
			Прервать;
		КонецЕсли;
	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте
Процедура ПередЗаписьюСоставнойпараметр(Отказ)
	
	Для Каждого СтрокаТаблицы Из ТаблицаПараметры Цикл
		Если НЕ ЗначениеЗаполнено(СтрокаТаблицы.Наименование) Тогда
			Поле = БазоваяФункциональностьКлиентСервер.ПодставитьПараметрыВСтроку(
				"ТаблицаПараметры[%1].Наименование", ТаблицаПараметры.Индекс(СтрокаТаблицы));
			
			БазоваяФункциональностьКлиентСервер.СообщитьПользователю(НСтр("ru='Не заполнено наименование параметра'"), , Поле, , Отказ);
			Прервать;
		КонецЕсли;
		
		Если НЕ ЗначениеЗаполнено(СтрокаТаблицы.Значение) Тогда
			Поле = БазоваяФункциональностьКлиентСервер.ПодставитьПараметрыВСтроку(
				"ТаблицаПараметры[%1].Значение", ТаблицаПараметры.Индекс(СтрокаТаблицы));
			
			БазоваяФункциональностьКлиентСервер.СообщитьПользователю(НСтр("ru='Не заполнено значение параметра'"), , Поле, , Отказ);
			Прервать;
		КонецЕсли;
		
		Попытка
			СтруктураПроверка = Новый Структура(СтрокаТаблицы.Наименование, СтрокаТаблицы.Значение);
			
		Исключение
			ТекстСообщения = НСтр("ru='Указано недопустимое наименование параметра.
				|Наименование должно соответствовать стандартам наименования переменных.'");
			
			Поле = БазоваяФункциональностьКлиентСервер.ПодставитьПараметрыВСтроку(
				"ТаблицаПараметры[%1].Наименование", ТаблицаПараметры.Индекс(СтрокаТаблицы));
			
			БазоваяФункциональностьКлиентСервер.СообщитьПользователю(ТекстСообщения, , Поле, , Отказ);
			Прервать;
		КонецПопытки;
		
		СтрокиДубли = ТаблицаПараметры.НайтиСтроки(Новый Структура("Наименование", СтрокаТаблицы.Наименование));
		Если СтрокиДубли.Количество() > 1 Тогда
			Поле = БазоваяФункциональностьКлиентСервер.ПодставитьПараметрыВСтроку(
				"ТаблицаПараметры[%1].Наименование", ТаблицаПараметры.Индекс(СтрокаТаблицы));
			БазоваяФункциональностьКлиентСервер.СообщитьПользователю(НСтр("ru='Дублирующееся наименование параметра'"), , Поле, , Отказ);
			Продолжить;
		КонецЕсли;
	КонецЦикла;
	
КонецПроцедуры

&НаСервере
Процедура ПередЗаписьюНаСервереСоставнойПараметр(ТекущийОбъект)
	
	Если ТекущийОбъект.ЭтоНовый() Тогда
		СтруктураХранилищаРанее = Новый Структура;
	Иначе
		СтруктураХранилищаРанее = ПредопределенныеНастройки.ЗначениеСлужебнойНастройки(ТекущийОбъект.Ссылка);
	КонецЕсли;
	
	СтруктураХранилища = Новый Структура;
	Для Каждого ЭлементСписка Из ТаблицаПараметры Цикл
		
		ЗначениеРанее = Неопределено;
		
		СтруктураХранилищаРанее.Свойство(ЭлементСписка.Наименование, ЗначениеРанее);
		
		Если ТипЗнч(ЗначениеРанее) = Тип("ТаблицаЗначений") Тогда
			СтруктураХранилища.Вставить(ЭлементСписка.Наименование, ЗначениеРанее);
			
		Иначе
			СтруктураХранилища.Вставить(ЭлементСписка.Наименование, ЭлементСписка.Значение);
		КонецЕсли; 
		
	КонецЦикла;
	
	ТекущийОбъект.Хранилище = Новый ХранилищеЗначения(СтруктураХранилища, Новый СжатиеДанных());
	
КонецПроцедуры

&НаКлиенте
Процедура ПереключитьСтраницу()
	
	Если Объект.ТипЗначения = ПредопределенноеЗначение("Перечисление.ТипыЗначенияПредопределенныхЗначений.Массив") Тогда
		НоваяСтраница = Элементы.СтраницаМассив;
		
	ИначеЕсли Объект.ТипЗначения = ПредопределенноеЗначение("Перечисление.ТипыЗначенияПредопределенныхЗначений.КлючЗначение") Тогда
		НоваяСтраница = Элементы.СтраницаСоставной;
		
	Иначе
		НоваяСтраница = Элементы.СтраницаПараметр;
	КонецЕсли;
	
	Если Элементы.ГруппаСтраницы.ТекущаяСтраница <> НоваяСтраница Тогда
		Элементы.ГруппаСтраницы.ТекущаяСтраница = НоваяСтраница;
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ОтобразитьСоставнойПараметр()
	
	ОбъектОбъект = РеквизитФормыВЗначение("Объект");
	ЗначениеХранилища = ОбъектОбъект.Хранилище.Получить();
	
	Если ТипЗнч(ЗначениеХранилища) = Тип("ТаблицаЗначений") Тогда
		
		ЭтоТаблицаЗначений = Истина;
		ОтобразитьТаблицуЗначения(ЗначениеХранилища);
		
	Иначе
		
		ОтобразитьСоответствие(ЗначениеХранилища);
		
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ОтобразитьСоответствие(ЗначениеХранилища)
	
	Если ЗначениеХранилища <> Неопределено Тогда
		Для Каждого КлючИЗначение Из ЗначениеХранилища Цикл
			СтрокаПараметр = ТаблицаПараметры.Добавить();
			СтрокаПараметр.Наименование = КлючИЗначение.Ключ;
			СтрокаПараметр.Значение = КлючИЗначение.Значение;
		КонецЦикла;
	КонецЕсли;
		
КонецПроцедуры

&НаСервере
Процедура ОтобразитьТаблицуЗначения(ЗначениеХранилища)
	
	ДобавляемыеРеквизиты = Новый Массив;
	ДобавляемыеРеквизиты.Добавить(Новый РеквизитФормы("ТаблицаНастройки", Новый ОписаниеТипов("ТаблицаЗначений")));
	
	Для Каждого Колонка Из ЗначениеХранилища.Колонки Цикл
		ДобавляемыеРеквизиты.Добавить(Новый РеквизитФормы(Колонка.Имя, Колонка.ТипЗначения, "ТаблицаНастройки", Колонка.Заголовок));
	КонецЦикла;
	
	ИзменитьРеквизиты(ДобавляемыеРеквизиты, Новый Массив);
	
	Элементы.ТаблицаПараметры.Видимость = Ложь;
	
	ТаблицаФормы = Элементы.Добавить("ТаблицаНастройки", Тип("ТаблицаФормы"), Элементы.СтраницаСоставной);
	ТаблицаФормы.ПутьКДанным = "ТаблицаНастройки";
	
	Для Каждого Колонка Из ЗначениеХранилища.Колонки Цикл
		ПолеВвода = Элементы.Добавить("ТаблицаНастройки" + Колонка.Имя, Тип("ПолеФормы"), Элементы.ТаблицаНастройки);
		ПолеВвода.Вид		  = ВидПоляФормы.ПолеВвода;
		ПолеВвода.ПутьКДанным = "ТаблицаНастройки." + Колонка.Имя;
		//ПолеВвода.ПутьКДанным = Колонка.Имя;
	КонецЦикла;
	
	Для Каждого СтрокаХранилища Из ЗначениеХранилища Цикл
		ЗаполнитьЗначенияСвойств(ЭтаФорма.ТаблицаНастройки.Добавить(), СтрокаХранилища);
	КонецЦикла;
	
КонецПроцедуры

&НаСервере
Процедура УстановитьОграничениеТипа()
	
	Если Объект.Ссылка.Пустая() Тогда
		Возврат;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти
