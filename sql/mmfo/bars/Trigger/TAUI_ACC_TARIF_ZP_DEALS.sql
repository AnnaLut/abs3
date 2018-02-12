create or replace trigger taui_acc_tarif_zp_deals
   after update or insert
   on bars.acc_tarif
   for each row
declare
begin
   for c in (select *
               from zp_deals
              where sos = 5 and kod_tarif = :new.kod and acc_2909 = :new.acc)
   loop
      update zp_deals
         set sos = 3,
             comm_reject ='Відбулася зміна індивідуального тарифу - '|| :new.kod
       where id = c.id;        
   end loop;
end;
/     
       