
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/view/v_teller_equip_type.sql =========*** Ru
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FORCE VIEW BARS.V_TELLER_EQUIP_TYPE ("CODE", "NAME") AS 
  select 'A' code, '������� ����������, ������� ������ � ���-��������' name from dual
union
select 'M','������� ����������, �� �������� ����������� ������' from dual
;
 show err;
 
PROMPT *** Create  grants  V_TELLER_EQUIP_TYPE ***
grant FLASHBACK,SELECT                                                       on V_TELLER_EQUIP_TYPE to WR_REFREAD;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/view/v_teller_equip_type.sql =========*** En
 PROMPT ===================================================================================== 
 