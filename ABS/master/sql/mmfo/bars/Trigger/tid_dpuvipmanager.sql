

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TID_DPUVIPMANAGER.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TID_DPUVIPMANAGER ***

  CREATE OR REPLACE TRIGGER BARS.TID_DPUVIPMANAGER 
INSTEAD OF INSERT OR DELETE ON V_DPU_VIP_MANAGER
FOR EACH ROW
DECLARE
  l_val  params$base.val%type;
  l_tmp  params$base.val%type;
BEGIN

  If sys_context('bars_context', 'user_mfo') != f_ourmfo_g Then
     raise_application_error(-20000, 'Вам запрещено модифицировать представление PARAMS', true);
  end if;

  select val
    into l_val
    from params$base
   where par = 'DPU_VIP_MANAGER';

  IF INSERTING THEN

    If (l_val is NULL) or (SubStr(l_val, length(l_val), 1) = ',') then
      l_val := l_val || to_char(:new.id);
    Else
      l_val := l_val ||','|| to_char(:new.id);
    End If;

  ELSIF DELETING THEN
    -- в середині
    l_tmp := replace(l_val, ','||to_char(:old.id)||',', ',' );
    if l_tmp != l_val then
      l_val := nvl(l_tmp, l_val);
    end if;
    -- на початку
    l_tmp := replace(l_val, to_char(:old.id)||',' );
    if l_tmp != l_val then
      l_val := l_tmp;
    end if;
    -- в кінці
    l_tmp := replace(l_val, ','||to_char(:old.id) );
    if l_tmp != l_val then
      l_val := l_tmp;
    end if;

  END IF;

  update params$base
     set val = l_val
   where par = 'DPU_VIP_MANAGER';

END;


/
ALTER TRIGGER BARS.TID_DPUVIPMANAGER ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TID_DPUVIPMANAGER.sql =========*** E
PROMPT ===================================================================================== 
