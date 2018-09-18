begin
delete from sw_dictionary_status_mt192;

insert into sw_dictionary_status_mt192(id, name, description) values('DUPL','Дублікат платежу','Платіж є дублікатом іншого платежу.');
insert into sw_dictionary_status_mt192(id, name, description) values('AGNT','Невірний агент','Невірний агент у робочому процесі платежу.');
insert into sw_dictionary_status_mt192(id, name, description) values('CURR','Невірна валюта','Невірна валюта платежу.');
insert into sw_dictionary_status_mt192(id, name, description) values('CUST','Замовлене клієнтом','Анулювання замовлене боржником.');
insert into sw_dictionary_status_mt192(id, name, description) values('UPAY','Необґрунтований платіж','Платіж не є обґрунтованим.');
insert into sw_dictionary_status_mt192(id, name, description) values('CUTA','Анулювання після неможливості виконання','Було замовлене анулювання, оскільки був одержаний запит про розслідування, та виправлення неможливе.');
insert into sw_dictionary_status_mt192(id, name, description) values('TECH','Технічна проблема','Запит про анулювання внаслідок технічних проблем, що призвели до помилкової транзакції.');
insert into sw_dictionary_status_mt192(id, name, description) values('FRAD','Злочинне походження','Запит про анулювання внаслідок транзакції, яка може мати злочинне походження.');
insert into sw_dictionary_status_mt192(id, name, description) values('COVR','Покриття анульоване або повернуте','Платіж з покриття був або повернутий, або анульований.');
insert into sw_dictionary_status_mt192(id, name, description) values('AMNT','Невірна сума','Невірна сума платежу.');
end;
/
commit
/

begin
delete from sw_dictionary_status_mt196;


Insert into BARS.SW_DICTIONARY_STATUS_MT196
   (ID, NAME, DESCRIPTION)
 Values
   ('CNCL', 'Анульований', 'Кінцева відповідь, яка підтверджує анулювання платежу згідно з запитом та ініціювання повернення кош');
Insert into BARS.SW_DICTIONARY_STATUS_MT196
   (ID, NAME, DESCRIPTION)
 Values
   ('PDCR', 'Незавершений', 'Проміжний статус, що підтверджує наявність запиту gSRP, але потрібна додаткова робота для надіслання');
Insert into BARS.SW_DICTIONARY_STATUS_MT196
   (ID, NAME, DESCRIPTION)
 Values
   ('PDCR/INDM', 'Потрібна компенсація за анулювання', 'Потрібна компенсація за анулювання');
Insert into BARS.SW_DICTIONARY_STATUS_MT196
   (ID, NAME, DESCRIPTION)
 Values
   ('PDCR/PTNA', 'Переданий наступному агенту', 'Анулювання було передане наступному агенту в ланцюгу платежу');
Insert into BARS.SW_DICTIONARY_STATUS_MT196
   (ID, NAME, DESCRIPTION)
 Values
   ('PDCR/RQDA', 'Потребує повноважень з дебетування', 'Потрібні повноваження кредитора для повернення платежу.');
Insert into BARS.SW_DICTIONARY_STATUS_MT196
   (ID, NAME, DESCRIPTION)
 Values
   ('RJCR', 'Відхилений', 'Кінцева відповідь – відхилення запиту «Зупинення та відкликання». У цьому випадку потрібно вказати д');
Insert into BARS.SW_DICTIONARY_STATUS_MT196
   (ID, NAME, DESCRIPTION)
 Values
   ('RJCR/AC04', 'Номер рахунку закритий', 'Зазначений номер рахунку закритий в облікових книгах одержувача');
Insert into BARS.SW_DICTIONARY_STATUS_MT196
   (ID, NAME, DESCRIPTION)
 Values
   ('RJCR/AGNT', 'Надсилається, коли анулювання не можна забезпечити', 'Надсилається, коли анулювання не можна забезпечити через відмову агента анулювати платіж');
Insert into BARS.SW_DICTIONARY_STATUS_MT196
   (ID, NAME, DESCRIPTION)
 Values
   ('RJCR/AM04', 'Сума коштів недостатня', 'Сума коштів, наявних для покриття суми, зазначеної в повідомленні, недостатня.');
Insert into BARS.SW_DICTIONARY_STATUS_MT196
   (ID, NAME, DESCRIPTION)
 Values
   ('RJCR/ARDT', 'Анулювання не приймається', 'Анулювання не приймається, оскільки транзакція вже повернута.');
Insert into BARS.SW_DICTIONARY_STATUS_MT196
   (ID, NAME, DESCRIPTION)
 Values
   ('RJCR/CUST', 'Анулювання не можна забезпечити', 'Надсилається, коли анулювання не можна забезпечити у зв''язку з рішенням клієнта (Кредитора)');
Insert into BARS.SW_DICTIONARY_STATUS_MT196
   (ID, NAME, DESCRIPTION)
 Values
   ('RJCR/INDM', 'Потрібна компенсація за анулювання', 'Потрібна компенсація за анулювання.');
Insert into BARS.SW_DICTIONARY_STATUS_MT196
   (ID, NAME, DESCRIPTION)
 Values
   ('RJCR/LEGL', 'Не можна забезпечити з регуляторних причин', 'Надсилається, коли анулювання не можна забезпечити з регуляторних причин');
Insert into BARS.SW_DICTIONARY_STATUS_MT196
   (ID, NAME, DESCRIPTION)
 Values
   ('RJCR/NOAS', 'Немає відповіді кінцевого одержувача', 'Немає відповіді кінцевого одержувача (на запит про анулювання)');
Insert into BARS.SW_DICTIONARY_STATUS_MT196
   (ID, NAME, DESCRIPTION)
 Values
   ('RJCR/NOOR', 'Первинна транзакція ніколи не була одержана', 'Первинна транзакція (яку треба анулювати) ніколи не була одержана');

end;
/
commit
/
