begin
Insert into PFU_EPP_LINE_STATE
   (ID, NAME)
 Values
   (1, 'Новий, Прийнятий');
Insert into PFU_EPP_LINE_STATE
   (ID, NAME)
 Values
   (2, 'Підтверджений, провалідований рядок');
Insert into PFU_EPP_LINE_STATE
   (ID, NAME)
 Values
   (3, 'Невідповідність формату даних, отриманих від ПФУ, або не заповнено обов’язкові поля');
Insert into PFU_EPP_LINE_STATE
   (ID, NAME)
 Values
   (7, 'Рахунок НЕ відкрито');
Insert into PFU_EPP_LINE_STATE
   (ID, NAME)
 Values
   (8, 'Рахунок відкрито');
Insert into PFU_EPP_LINE_STATE
   (ID, NAME)
 Values
   (12, 'Картку активовано ');
Insert into PFU_EPP_LINE_STATE
   (ID, NAME)
 Values
   (13, 'Активовано рахунок на РУ ');
Insert into PFU_EPP_LINE_STATE
   (ID, NAME)
 Values
   (14, 'Відправлено другу квитанцію в ПФУ ');
Insert into PFU_EPP_LINE_STATE
   (ID, NAME)
 Values
   (17, 'Блокировка карты сотрудником Контакт-центра');
Insert into PFU_EPP_LINE_STATE
   (ID, NAME)
 Values
   (18, 'Разблокировка карты сотрудником Контакт-центра');
Insert into PFU_EPP_LINE_STATE
   (ID, NAME)
 Values
   (19, 'Картка знищена ');
Insert into PFU_EPP_LINE_STATE
   (ID, NAME)
 Values
   (20, 'EPP відправлений на РУ');
Insert into PFU_EPP_LINE_STATE
   (ID, NAME)
 Values
   (24, 'Рахунок 2625 блоковано по дебету ');
Insert into PFU_EPP_LINE_STATE
   (ID, NAME)
 Values
   (25, 'Рахунок 2625 розблоковано по дебету');
 exception when dup_val_on_index then null;
end;
/
COMMIT;
/
