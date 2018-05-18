--Зміна відповідно до п.3.1. опису заявки COBUSUPABS-6353
SET DEFINE OFF;
begin
  update int_metr t
     set t.name = '% річн.від факт.зал.заборгованості'
   where t.metr = 0;
end;
/
commit;