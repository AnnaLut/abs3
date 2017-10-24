
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_acc_type.sql =========*** Run ***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_ACC_TYPE (p_nbs varchar2 ) return varchar2 is
begin

  if p_nbs in ('8027') then return 'SP '; end if;
  if p_nbs in ('8028') then return 'SPN'; end if;
  if p_nbs in ('2607','2627') then return 'SN '; end if;
  if substr(p_nbs,4,1) = '6' then return 'DSK'; end if;
  if substr(p_nbs,4,1) = '7' then return 'SP '; end if;
  if substr(p_nbs,4,1) = '8' then return 'SN '; end if;
  if substr(p_nbs,4,1) = '9' then return 'SPN'; end if;

  return 'SS ';


end;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_acc_type.sql =========*** End ***
 PROMPT ===================================================================================== 
 