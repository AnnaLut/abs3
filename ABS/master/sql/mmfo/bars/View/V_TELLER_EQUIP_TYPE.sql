
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/view/v_teller_equip_type.sql =========*** Ru
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FORCE VIEW BARS.V_TELLER_EQUIP_TYPE ("CODE", "NAME") AS 
  select 'A' code, 'Активне обладнання, потребує роботу з веб-сервісами' name from dual
union
select 'M','Пасивне обладнання, всі операції виконуються вручну' from dual
;
 show err;
 
PROMPT *** Create  grants  V_TELLER_EQUIP_TYPE ***
grant FLASHBACK,SELECT                                                       on V_TELLER_EQUIP_TYPE to WR_REFREAD;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/view/v_teller_equip_type.sql =========*** En
 PROMPT ===================================================================================== 
 