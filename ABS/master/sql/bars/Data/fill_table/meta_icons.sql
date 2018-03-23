begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (156, ''EXECUTE'', ''Зеленая молния'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (157, ''CURRCONV'', ''Неттинг'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (105, ''FUNCTION'', ''Функція'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (1, ''txt'', ''Текст'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (2, ''save'', ''Зберегти'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (3, ''cancel'', ''Відмінити'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (4, ''plus'', ''додати'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (5, ''minus'', ''видалити'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (6, ''page'', ''Сторінка'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (7, ''download'', ''Скачати'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (8, ''document_view'', ''Перегляд документа'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (9, ''tar'', ''куб'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (10, ''printer'', ''Роздрукувати'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (11, ''ic-agreement-close'', ''Закрити угоду'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (12, ''ic-score-agreement-close'', ''Закрити угоду та її рахунки'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (13, ''ic-portfel'', ''Нарахувати %% по угоді'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (14, ''ic-suitcase-ush'', ''Нарахувати %% по портфелю (ГРН)'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (15, ''ic-suitcase-usd'', ''Нарахувати %% по портфелю (ВАЛ)'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (16, ''ic-compressed'', ''OSA: Прийом та стиснення'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (17, ''ic-what'', ''2) IRR: Формування проводок  по "НеВизнаним"'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (18, ''ic-z23'', ''3) Z23: *Пере-Формування Рез-НБУ-351'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (19, ''ic-river'', ''4) N23  Тільки Розподіл + Рівчачок для проводок '')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (20, ''ic-mak'', ''5) MAK Створити/Переглянути Макет проводок по "Резерв-МСФЗ"'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (21, ''ic-river-beck'', ''4.1 для ЦА =  Тільки ПЕРЕ-Розподіл ручних + Рівчачок'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (22, ''ic-report-error'', ''2902 - Звіт-помилки при формуванні резерву'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (23, ''ic-are'', ''6) ARE: Формування проводок по "jgkfnf"'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (24, ''ic-2'', ''7 ) #02 *Формування #02'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (25, ''ic-accounts-only-one'', ''8. Рахунки по одному договору
8. Рахунки по одному договору
8. Рахунки по одному договору
8. Рахунки по одному договору'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (26, ''ic-partners'', ''1. Партнери-Резиденти'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (27, ''ic-partners-no-rezedents'', ''2. Партнери не резиденти'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (28, ''ic-arhive-all'', ''3. Архів усіх угод'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (29, ''ic-search-prioritet'', ''4. Пошук строки по значенню поля'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (30, ''ic-filter'', ''5. Встановити фільтр'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (31, ''ic-teble-replay'', ''6. Перечитати записи в таблиці'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (32, ''ic-print-table'', ''7. Друк таблиці'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (33, ''ic-accounts-only-one-create'', ''9. Формування платежу по одному договору'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (34, ''ic-back-day'', ''10. Відкат сьогоднішньої угоди ROLLOVER'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (35, ''ic-prolongacia'', ''11. Пролонгація. Зміниити параметри угоди'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (36, ''ic-info-cheang'', ''12. Відомості про зміну в угоді'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (37, ''ic-bux-mod'', ''13. Перегляд бух. моделі угоди'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (38, ''ic-portfel'', ''14. Нарахування %% по портфелю'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (39, ''ic-new-dogovor'', ''15. Нові договори забезпечення на вибраний договір розміщення'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (40, ''ic-agreement-existing'', ''16. Існуючі договори забезпечення на обраний договір розміщення'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (41, ''ic-bind-document'', ''17. Зв''''язок договорів забезпечення та обраного договору  розміщення'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (42, ''ic-zalog-add-fun'', ''18. Прив''''язати операцію залогу'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (43, ''ic-unbind-document-dcp'', ''19. Відв''''язати залог ДЦП'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (44, ''ic-unbind-document'', ''20. Відв''''язати документ'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (45, ''ic-exit'', ''21. Завершити роботу та вийти'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (46, ''ic-create-SWIFT-mess'', ''22. Сформувати SWIFT повідомлення'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (47, ''ic-pogashenna'', ''23. Графік погашення'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (48, ''ic-overdue'', ''24. Винесення на прострочення'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (52, ''BF8_'', ''Кнопка Ф8. '')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (50, ''REFRESH'', ''Зеленая стрелка типа обновить'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (51, ''DETAILS'', ''Типа таблица из чёрточек. Обозначает - ДЕТАЛЬНЕЕ'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (53, ''BF9_'', ''Кнопка Ф9.'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (54, ''DELREC'', ''Красный крест. Обозначает удаление'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (55, ''OPEN'', ''Желтая папка. Открыть'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (56, ''A_SPEC'', ''Знак параграфа на сером фоне'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (57, ''A_INTS'', ''Знак процента с КРУГЛЫМИ нулями'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (58, ''APPLY'', ''Зелёная птичка. Подтвердить'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (59, ''Arr2tor'', ''Зелёная стрелка ВПРАВО'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (60, ''A_PROC'', ''Знак процента СХЕМАТИЧЕСКИ'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (61, ''DELETE'', ''Красный крестик на таблице'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (81, ''ATTACH'', ''Листочек со скрепкой. Эттач'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (82, ''ACCOUNTS'', ''Счеты. '')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (83, ''CHARTL'', ''График с цветными линиями. '')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (84, ''TUDASUDA'', ''Две разнонаправленные стрелки (влево-вправо)Дубль UPDOWN.BMP'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (85, ''UPDOWN'', ''Две разнонаправленные стрелки (влево-вправо)Дубль TUDASUDA.BMP'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (86, ''CHILDS'', ''Блок-схема из белых квадратиков. Сверху вниз.'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (87, ''HELP'', ''Зелёный вопросительный знак.'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (88, ''help2'', ''Белый вопросительный знак в СИНЕМ кругу'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (89, ''CURRCONV'', ''Два блина - желтый и коричневый. Стрелка из желтого в коричневый'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (90, ''SUMM'', ''Значок суммы. Е'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (91, ''SAVE'', ''Значок дискеты 3,25 дюйма'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (92, ''A_FINS'', ''Латинская С с тремя точками в типа таблице'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (93, ''LOOK'', ''Зелёные очки кота Базилио'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (94, ''BOOK'', ''Открытая книга'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (95, ''BOOKS'', ''Книги - зелёная, желтая, красная'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (96, ''EXCEL'', ''Значок Экселя от Майкрософт Офис'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (97, ''QUERY'', ''Изображение таблицы. Вопросительный знак справа.'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (98, ''BROWSE'', ''Вроде как табличка с заголовком'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (99, ''RETRIEVE'', ''Синий цилиндр с желтой стрелкой влево из него'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (100, ''USERS'', ''Цветные людишки)))'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (101, ''SWITCH'', ''Три таблички друг за другом'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (102, ''FRCENTER'', ''Выход из здания. Зеленая стрелка вправо'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (62, ''DISCARD'', ''Красный круг перечеркнутый. Стоянка запрещена'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (63, ''NEWREC'', ''Зелёный плюс.'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (64, ''PACH'', ''Желтый коробок (КУБ)'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (65, ''A_ACCS'', ''Ключ перевернутый вниз'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (66, ''DOC_DOWN'', ''зеленая стрелка вниз на фоне  чего-то'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (67, ''CUSTCLSD'', ''Красный крестик возле человеческой головы'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (68, ''ARR1TOR'', ''Красная стрелка направленная ВПРАВО'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (69, ''SELECT'', ''Курсор мыши (стрелка) направленный на таблицу'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (70, ''UNION'', ''Два значка табличек, обведённые красной рамкой'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (71, ''BACK'', ''Разворот налево - разрешен. Красная стрелка разворота налево'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (72, ''SEARCH'', ''Черный бинокль на белом фоне'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (73, ''FILTER'', ''Зелёная стрелка ВНИЗ пробивающая бетонную плиту'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (74, ''PRINT'', ''Что-то, похожее на матричный принтер'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (75, ''A_CLSD'', ''Красный крестик на фоне типа таблицы'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (76, ''A_LINK'', ''Две таблицы друг над другом и маленькая стрелка вверх'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (77, ''BF7_'', ''Кнопка Ф7'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (78, ''RELATION'', ''Два белых кубика со стрелкой с верхнего в нижний'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (79, ''FORMULA'', ''Кнопка ФУНКЦИЯ или формула. Латинское эф со скобками'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (80, ''INSERT'', ''Зелёный плюсик в левом углу на таблице. Инсерт'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (103, ''Arr1tou'', ''Красная стрелка вверх'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (104, ''Arr1tod'', ''Красная стрелка вниз'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (49, null, null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (106, ''REP_SOLO'', ''Поки викор як кнопку рахунки та ставки клієнта'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (108, ''LINK'', ''Скрепка'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (107, ''EDITG'', ''Зелёный карандаш'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (109, ''EDIT_X'', ''карандаш'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (110, ''LINKR'', ''Скрепка'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (111, ''DOC'', ''Документ'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (112, ''DOC_DOWN'', ''Документ стрелка вниз'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (113, ''DOC_IN'', ''Документ стрелка вправо'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (114, ''DOC_M1'', ''Документ стрелка сверху вниз'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (115, ''DOC_OUT'', ''Документ стрелка вправо'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (116, ''TOMAIL'', ''Конверт'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (117, ''APP1'', ''Красная галочка в кружку '')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (158, ''A_LIMS'', ''Красный триугольник'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (118, ''PRINT'', ''Печать синий принтер'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (165, ''FORWARD'', ''ASCEND'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (164, ''CREATE'', ''CREATE'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (163, ''SORT'', ''SORT'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (162, ''FRCENTER'', ''FRCENTER'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into meta_icons (ICON_ID, ICON_PATH, ICON_DESC)
values (161, ''CUSTBANK'', ''CUSTBANK'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

