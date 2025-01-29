Функция Значение(ИмяНастройки, ВызыватьИсключение = Ложь) Экспорт
	
	УстановитьПривилегированныйРежим(Истина);
	
	СсылкаПредопределенногоЗначения = СсылкаПредопределеннойНастройки(ИмяНастройки);
	
	РезультатЗначение = ПредопределенныеНастройки.РезультатЗначениеИзЗапроса(ИмяНастройки, ВызыватьИсключение);
	
	Если РезультатЗначение.Пустой() Тогда
		Возврат РезультатДляОтсутствующейНастройки(ИмяНастройки, ВызыватьИсключение);
	КонецЕсли;
	
	ВыборкаЗначение = РезультатЗначение.Выбрать();
	ВыборкаЗначение.Следующий();
	
	ЗначениеЗаполнено = Ложь;
	
	Если ВыборкаЗначение.МногострочныйПараметр Тогда
		
		Результат = Новый Массив;
		Результат.Добавить(ВыборкаЗначение.Параметр);
		
		Пока ВыборкаЗначение.Следующий() Цикл
			Результат.Добавить(ВыборкаЗначение.Параметр);
		КонецЦикла;		
		
		ЗначениеЗаполнено = Результат.Количество() <> 0;
		
	ИначеЕсли ВыборкаЗначение.СоставнойПараметр Тогда
		
		Результат = ВыборкаЗначение.Хранилище.Получить();
		ЗначениеЗаполнено = Результат <> Неопределено;
		
	Иначе
		
		Результат = ВыборкаЗначение.Параметр;
		ЗначениеЗаполнено = Результат <> Неопределено;
		
	КонецЕсли;
	
	Если НЕ ЗначениеЗаполнено Тогда
		
		Результат = РезультатДляОтсутствующейНастройки(ИмяНастройки, ВызыватьИсключение);
	
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции

Функция РезультатДляОтсутствующейНастройки(ИмяНастройки, ВызыватьИсключение) Экспорт
		
			Если ВызыватьИсключение Тогда
				Сообщение = БазоваяФункциональностьКлиентСервер.ПодставитьПараметрыВСтроку(
					НСтр("ru ='Передано отсутствующее наименование предопределенной настройки ""%1""'"),
					ИмяНастройки);
				ВызватьИсключение Сообщение;
			Иначе
				Возврат ПредопределенноеЗначение("Справочник.ПредопределенныеНастройки.ПустаяСсылка");
			КонецЕсли;
		
КонецФункции


Функция СсылкаПредопределеннойНастройки(ИмяНастройки) Экспорт
	
	Возврат Справочники.ПредопределенныеНастройки.НайтиПоРеквизиту("ИмяНастройки", ИмяНастройки);
	
КонецФункции


