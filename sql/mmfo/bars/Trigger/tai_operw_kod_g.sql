

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAI_OPERW_KOD_G.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAI_OPERW_KOD_G ***

  CREATE OR REPLACE TRIGGER BARS.TAI_OPERW_KOD_G 
  before insert or update ON BARS.OPERW  for each row
      WHEN (
new.tag like 'KOD_G'
      ) declare
l_tt oper.tt%type;
l_sos oper.sos%type;
 procedure set_oper(p_ref oper.ref%type, p_drec oper.d_rec%type)
  is
   begin
     update oper set d_rec=case when d_rec is null then '#nœ'||p_drec||'#' else d_rec||'nœ'||p_drec||'#' end  where ref=p_ref;
  end set_oper;

  procedure set_operw(p_ref operw.ref%type, p_val operw.value%type)
   is
    pragma autonomous_transaction;
   begin

       update operw set value='œ'||p_val where ref=p_ref and tag='n    ';

     if sql%rowcount=0 then
         insert into operw(ref, tag, value) values (p_ref, 'n    ', 'œ'||p_val);
        end if;

        commit;
        exception
            when DUP_VAL_ON_INDEX then null;
   end;

begin

  select tt, sos into l_tt, l_sos from oper where ref=:new.ref;

  if l_tt='C14' and l_sos!=5 then
    if(updating) then
    set_operw(:new.ref, :new.value);
  else
    insert into operw(ref, tag, value) values (:new.ref, 'n    ', 'œ'||:new.value);
  end if;
    set_oper (:new.ref, :new.value);

  end if;

end TAI_OPERW_KOD_G;


/
ALTER TRIGGER BARS.TAI_OPERW_KOD_G DISABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAI_OPERW_KOD_G.sql =========*** End
PROMPT ===================================================================================== 
