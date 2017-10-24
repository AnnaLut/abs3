CREATE OR REPLACE TRIGGER TBI_COMPEN_PARAMS_DATA
before insert on compen_params_data
for each row
  declare
    l_cnt pls_integer;
begin
 if :new.is_enable = 1 then
   select count(*) into l_cnt
   from compen_params_data p
   where p.is_enable = 1 and p.par = :new.par
     and (:new.date_from between p.date_from and p.date_to or :new.date_to between p.date_from and p.date_to);
   if l_cnt > 0 then
     raise_application_error(-20123,'Вже існує параметр, який перетинається з періодом дії');
   end if;    
 end if;  

 if (:new.id is null) then
     select s_compen_params_data_id.nextval into :new.id from dual;
 end if;
end;
/