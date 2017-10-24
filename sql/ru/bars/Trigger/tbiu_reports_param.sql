

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBIU_REPORTS_PARAM.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBIU_REPORTS_PARAM ***

  CREATE OR REPLACE TRIGGER BARS.TBIU_REPORTS_PARAM 

  before insert or update of param, form on reports

  for each row

 WHEN (

new.form = 'frm_UniReport'

      ) declare

  l_fmt varchar2(100) := substr(:new.param,

                                instr(:new.param, ',', 1, 1) + 1,

                                instr(:new.param, ',', 1, 2) -

                                instr(:new.param, ',', 1, 1) - 1);

  l_cnt number;

begin

  select count(*)

    into l_cnt

    from rep_types rt

   where to_char(rt.typeid) = l_fmt;

  if (l_cnt = 0) then

    raise_application_error(-20000,

                            'Формат друку звіту відсутній у довіднику форматів rep_types',

                            true);

  end if;

end;

/
ALTER TRIGGER BARS.TBIU_REPORTS_PARAM DISABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBIU_REPORTS_PARAM.sql =========*** 
PROMPT ===================================================================================== 
