

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAUD_CIM_PARAMS.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAUD_CIM_PARAMS ***

  CREATE OR REPLACE TRIGGER BARS.TAUD_CIM_PARAMS 
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
ALTER TRIGGER BARS.TAUD_CIM_PARAMS ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAUD_CIM_PARAMS.sql =========*** End
PROMPT ===================================================================================== 
