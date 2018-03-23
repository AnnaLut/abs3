-- добавляем поле K021 т.к. поле CUSTTYPE использовать под K021
-- в связи с расширением диапазона значений 
-- (кроме чисел и буквенные значения)

exec bc.home;


PROMPT *** ALTER table OTCN_F71_CUST add K021 ***
begin
    execute immediate 'ALTER TABLE BARS.OTCN_F71_CUST ADD K021 VARCHAR2(1)';
exception
    when others then null;
end;
/    


