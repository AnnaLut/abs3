declare
  e_tab_not_exists       exception;
  pragma exception_init( e_tab_not_exists, -00942 );
begin
      execute immediate 'drop table CIM_CREDIT_BORROWER';
    exception
      when e_tab_not_exists
      then null;
end;
/
declare
  e_tab_not_exists       exception;
  pragma exception_init( e_tab_not_exists, -00942 );
begin
      execute immediate 'drop table CIM_CREDIT_PERCENT';
    exception
      when e_tab_not_exists
      then null;
end;
/

declare
  e_tab_not_exists       exception;
  pragma exception_init( e_tab_not_exists, -00942 );
begin
      execute immediate 'drop table CIM_CREDIT_F503_PURPOSE';
    exception
      when e_tab_not_exists
      then null;
end;
/

declare
  e_tab_not_exists       exception;
  pragma exception_init( e_tab_not_exists, -00942 );
begin
      execute immediate 'drop table cim_credit_reorganization';
    exception
      when e_tab_not_exists
      then null;
end;
/


--Не забути скрипти перествореня таблиць з Table та fill_table

/* ВИД 
   ПОЗИЧАЛЬНИККА
*/
begin
    begin
    execute immediate 'alter table CIM_CONTRACTS_CREDIT rename column borrower to BORROWER_OLD';
    exception
      when others then null;
    end;

    begin
    execute immediate 'alter table CIM_CONTRACTS_CREDIT add borrower varchar2(2)';
    exception
      when others then null;
    end;


    execute immediate 'comment on column CIM_CONTRACTS_CREDIT.borrower is ''Вид позичальника''';

end;
/

    update CIM_CONTRACTS_CREDIT set borrower = case when BORROWER_OLD = 10 then 'A' when  BORROWER_OLD = 11 then 'B'  else to_char(BORROWER_OLD) end;  
/

begin
  execute immediate 'comment on column CIM_CONTRACTS_CREDIT.borrower_old is ''Видалити в майбутньому''';
end;
/

begin
    begin
    execute immediate 'alter table cim_f503 rename column p0100 to p0100_OLD';
    exception
      when others then null;
    end;

    begin
    execute immediate 'alter table cim_f503 add p0100 varchar2(2)';
    exception
      when others then null;
    end;


    execute immediate 'comment on column cim_f503.p0100 is ''Вид позичальника''';

end;
/

    update cim_f503 set p0100 = case when p0100_OLD = 10 then 'A' when  p0100_OLD = 11 then 'B'  else to_char(p0100_OLD) end;  
/

begin
  execute immediate 'comment on column cim_f503.p0100_OLD is ''Видалити в майбутньому''';
end;
/

begin
    begin
    execute immediate 'alter table cim_f504 rename column p010 to p010_OLD';
    exception
      when others then null;
    end;

    begin
    execute immediate 'alter table cim_f504 add p010 varchar2(2)';
    exception
      when others then null;
    end;


    execute immediate 'comment on column cim_f504.p010 is ''Вид позичальника''';

end;
/

    update cim_f504 set p010 = case when p010_OLD = 10 then 'A' when  p010_OLD = 11 then 'B'  else to_char(p010_OLD) end;  
/

begin
  execute immediate 'comment on column cim_f504.p010_OLD is ''Видалити в майбутньому''';
end;
/

/* Код типу 
   процентної ставки 
*/
begin
    begin
    execute immediate 'alter table CIM_CONTRACTS_CREDIT rename column percent_nbu_type to percent_nbu_type_OLD';
    exception
      when others then null;
    end;

    begin
    execute immediate 'alter table CIM_CONTRACTS_CREDIT add percent_nbu_type varchar2(2)';
    exception
      when others then null;
    end;


    execute immediate 'comment on column CIM_CONTRACTS_CREDIT.percent_nbu_type is ''Код типу макс. процентної ставки''';

end;
/

    update CIM_CONTRACTS_CREDIT set percent_nbu_type = case when percent_nbu_type_OLD = 1 then '3' else to_char(percent_nbu_type_OLD) end;  
/

begin
  execute immediate 'comment on column CIM_CONTRACTS_CREDIT.percent_nbu_type_OLD is ''Видалити в майбутньому''';
end;
/

begin
    begin
    execute immediate 'alter table CIM_CONTRACTS_CREDIT rename column f503_percent_type to f503_percent_type_OLD';
    exception
      when others then null;
    end;

    begin
    execute immediate 'alter table CIM_CONTRACTS_CREDIT add f503_percent_type varchar2(2)';
    exception
      when others then null;
    end;


    execute immediate 'comment on column CIM_CONTRACTS_CREDIT.f503_percent_type is ''Код типу процентної ставки''';

end;
/

    update CIM_CONTRACTS_CREDIT set f503_percent_type = case when f503_percent_type_OLD = 1 then '3' else to_char(f503_percent_type_OLD) end;  
/

begin
  execute immediate 'comment on column CIM_CONTRACTS_CREDIT.f503_percent_type_OLD is ''Видалити в майбутньому''';
end;
/

/* Код цілі використання кредиту
*/
begin
    begin
    execute immediate 'alter table cim_f503 rename column p9600 to p9600_OLD';
    exception
      when others then null;
    end;

    begin
    execute immediate 'alter table cim_f503 add p9600 varchar2(2)';
    exception
      when others then null;
    end;


    execute immediate 'comment on column cim_f503.p9600 is ''Ціль використання кредиту''';

end;
/

    update cim_f503 set p9600 = to_char(p9600_OLD);  
/

begin
  execute immediate 'comment on column cim_f503.p9600_OLD is ''Видалити в майбутньому''';
end;
/

begin
    begin
    execute immediate 'alter table cim_f504 rename column p960 to p960_OLD';
    exception
      when others then null;
    end;

    begin
    execute immediate 'alter table cim_f504 add p960 varchar2(2)';
    exception
      when others then null;
    end;


    execute immediate 'comment on column cim_f504.p960 is ''Ціль використання кредиту''';

end;
/

    update cim_f504 set p960 = to_char(p960_OLD);  
/

begin
  execute immediate 'comment on column cim_f504.p960_OLD is ''Видалити в майбутньому''';
end;
/


/* Код ознаки кредиту F045
*/
begin
    begin
    execute immediate 'alter table cim_f503 rename column M to M_OLD';
    exception
      when others then null;
    end;

    begin
    execute immediate 'alter table cim_f503 add M varchar2(2)';
    exception
      when others then null;
    end;


    execute immediate 'comment on column cim_f503.M is ''Код ознаки кредиту F045''';

end;
/

    update cim_f503 set M = to_char(M_OLD);  
/

begin
  execute immediate 'comment on column cim_f503.M_OLD is ''Видалити в майбутньому''';
end;
/

begin
    begin
    execute immediate 'alter table cim_f504 rename column M to M_OLD';
    exception
      when others then null;
    end;

    begin
    execute immediate 'alter table cim_f504 add M varchar2(2)';
    exception
      when others then null;
    end;


    execute immediate 'comment on column cim_f504.M is ''Код ознаки кредиту''';

end;
/

    update cim_f504 set M = to_char(M_OLD);  
/

begin
  execute immediate 'comment on column cim_f504.M_OLD is ''Видалити в майбутньому''';
end;
/

/* Код типу реорганізації F070
*/
begin
    begin
    execute immediate 'alter table cim_f503 rename column p3200 to p3200_OLD';
    exception
      when others then null;
    end;

    begin
    execute immediate 'alter table cim_f503 add p3200 varchar2(2)';
    exception
      when others then null;
    end;


    execute immediate 'comment on column cim_f503.p3200 is ''Код типу реорганізації F070''';

end;
/

    update cim_f503 set p3200 = to_char(p3200_OLD);  
/

begin
  execute immediate 'comment on column cim_f503.p3200_OLD is ''Видалити в майбутньому''';
end;
/

begin
    begin
    execute immediate 'alter table cim_f504 rename column p320 to p320_OLD';
    exception
      when others then null;
    end;

    begin
    execute immediate 'alter table cim_f504 add p320 varchar2(2)';
    exception
      when others then null;
    end;


    execute immediate 'comment on column cim_f504.p320 is ''Код типу реорганізації F070''';

end;
/

    update cim_f504 set p320 = to_char(p320_OLD);  
/

begin
  execute immediate 'comment on column cim_f504.p320_OLD is ''Видалити в майбутньому''';
end;
/

/* Довідник Тип процентної ставки 
*/
begin
    begin
    execute immediate 'alter table cim_f503 rename column p0400 to p0400_OLD';
    exception
      when others then null;
    end;

    begin
    execute immediate 'alter table cim_f503 add p0400 varchar2(2)';
    exception
      when others then null;
    end;


    execute immediate 'comment on column cim_f503.p0400 is ''Тип процентної ставки ''';

end;
/

    update cim_f503 set p0400 = to_char(p0400_OLD);  
/

begin
  execute immediate 'comment on column cim_f503.p0400_OLD is ''Видалити в майбутньому''';
end;
/

begin
    begin
    execute immediate 'alter table cim_f504 rename column p040 to p040_OLD';
    exception
      when others then null;
    end;

    begin
    execute immediate 'alter table cim_f504 add p040 varchar2(2)';
    exception
      when others then null;
    end;


    execute immediate 'comment on column cim_f504.p040 is ''Тип процентної ставки''';

end;
/

    update cim_f504 set p040 = to_char(p040_OLD);  
/

begin
  execute immediate 'comment on column cim_f504.p040_OLD is ''Видалити в майбутньому''';
end;
/

