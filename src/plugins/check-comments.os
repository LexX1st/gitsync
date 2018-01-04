#Использовать logos

Перем ВерсияПлагина;
Перем Лог;
Перем КомандыПлагина;
Перем ВызватьОшибку;
Перем ДополнительныеПочтовыеАдреса;
Перем ОтправитьСообщение;

Функция ОписаниеПлагина() Экспорт

	Возврат Новый Структура("Версия, Лог, ИмяПакета", ВерсияПлагина, Лог, ИмяПлагина());

КонецФункции // Информация() Экспорт


Процедура ПриАктивизацииПлагина(СтандартныйОбработчик) Экспорт

	Обработчик = СтандартныйОбработчик;

КонецПроцедуры

Процедура ПриРегистрацииКомандыПриложения(ИмяКоманды, КлассРеализации, Парсер) Экспорт

	Лог.Отладка("Ищю команду <%1> в списке поддерживаемых", ИмяКоманды);
	Если КомандыПлагина.Найти(ИмяКоманды) = Неопределено Тогда
		Возврат;
	КонецЕсли;

	Лог.Отладка("Устанавливаю дополнительные параметры для команды %1", ИмяКоманды);

	ВызватьОшибку = КлассРеализации.Опция("C error-comment", Ложь, "[*check-comments] флаг вызова ошибки при отсутствии текста комментария").Флаговый();

КонецПроцедуры

Процедура ПриПолученииПараметров(ПараметрыКоманды, ДополнительныеПараметры) Экспорт

	ВызватьОшибку = ПараметрыКоманды["--error-comment"];

	Если ВызватьОшибку = Неопределено Тогда
		ВызватьОшибку = Ложь;
	КонецЕсли;

КонецПроцедуры

Процедура ПередОбработкойВерсииХранилища(СтрокаВерсии, СледующаяВерсия) Экспорт

	Если ПустаяСтрока(СтрокаВерсии.Комментарий) Тогда
		СтрокаОшибки = СтрШаблон("Нашли следующую версию <%1> от автора <%2>, а комментарий не задан!", СледующаяВерсия, СтрокаВерсии.Автор);
		Лог.КритичнаяОшибка(СтрокаОшибки);

		Если ВызватьОшибку Тогда

			ВызватьИсключение СтрокаОшибки;

		КонецЕсли;

	КонецЕсли;

КонецПроцедуры

Функция ИмяПлагина()
	возврат "check-comments";
КонецФункции // ИмяПлагина()

Процедура Инициализация()

	ВерсияПлагина = "1.0.0";
	Лог = Логирование.ПолучитьЛог("oscript.app.gitsync_plugins_"+ СтрЗаменить(ИмяПлагина(),"-", "_"));
	КомандыПлагина = Новый Массив;
	КомандыПлагина.Добавить("sync");

КонецПроцедуры

Инициализация();
