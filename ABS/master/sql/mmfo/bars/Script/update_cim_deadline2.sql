/*
Ходаковська Діна Валентинівна
кому мені, Анна, Дехнич
Доброго ранку!
Сергій, прошу терміново  з 07.02.2019р. (сьогодні) змінити контрольний строк з дата+365 днів на дата+364 дні - підстава : постанова НБУ від 06.02.2019р. №35
*/

begin
Insert into cim_contract_deadlines
   (DEADLINE, COMMENTS)
 Values
   ('364', 'Строком на 364 днів');
exception when dup_val_on_index then
null;
end;
/

begin
update cim_contract_deadlines set DELETE_DATE = to_date('07022019','DDMMYYYY')  where DEADLINE = 365;
end;
/

declare
begin
 update cim_contracts_trade 
 set deadline = 364
 where deadline = 365;
 dbms_output.put_line('Оновлено контрольний строк в cim_contracts_trade  '|| SQL%ROWCOUNT); 
end;
/


declare
begin
    update cim_payments_bound set deadline = 364 where deadline = 365;
  dbms_output.put_line('Оновлено контрольний строк для платежів count '||SQL%ROWCOUNT );

    update cim_fantoms_bound set deadline = 364 where deadline = 365;
  dbms_output.put_line('Оновлено контрольний строк для фантомів count '||SQL%ROWCOUNT );

    update cim_vmd_bound set deadline = 364 where deadline = 365;
  dbms_output.put_line('Оновлено контрольний строк для МД count '||SQL%ROWCOUNT );

    update cim_act_bound set deadline = 364 where deadline = 365;
  dbms_output.put_line('Оновлено контрольний строк для Актів count '||SQL%ROWCOUNT );
end;  
/

commit;
/