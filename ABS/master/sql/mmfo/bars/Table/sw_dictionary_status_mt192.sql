begin
bars_policy_adm.alter_policy_info('sw_dictionary_status_mt192', 'FILIAL', null, 'E', 'E','E');
bars_policy_adm.alter_policy_info('sw_dictionary_status_mt192', 'WHOLE', null, null,null,null);
end;
/


begin
execute immediate 'create table sw_dictionary_status_mt192(id varchar2(20), name varchar2(50), description varchar2(100))';
exception when others then if(sqlcode=-955) then null; else raise; end if;
end;
/

begin
execute immediate 'ALTER TABLE BARS.SW_DICTIONARY_STATUS_MT192 ADD 
CONSTRAINT PK_SW_DICTIONARY_STATUS_MT192
 PRIMARY KEY (ID)
 ENABLE
 VALIDATE';
exception when others then if(sqlcode=-2260) then null; else raise; end if;
end;
/ 


begin
bars_policy_adm.alter_policies('sw_dictionary_status_mt192');
end;
/
commit
/

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

