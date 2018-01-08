CREATE OR REPLACE TRIGGER BARS.Taud_cim_params
after update or delete
   on BARS.cim_params for each row
declare
begin
  insert into cim_params_update(par_name,
                              par_value,
                              global,
                              kf)
             values(:old.par_name,
                    :old.par_value,
                    :old.global,
                    :old.kf);                   
end;
/