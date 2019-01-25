
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/view/v_teller_need_req_dict.sql =========***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FORCE VIEW BARS.V_TELLER_NEED_REQ_DICT ("CODE", "NAME") AS 
  select 'IN', '�������� � ���������� ������' from dual
union
select 'OUT','�������� � ������� ������' from dual
union
select 'ALL','�������� � ���������� �� ������� ������' from dual
union
select 'NONE','�������� �����������' from dual
;
 show err;
 
PROMPT *** Create  grants  V_TELLER_NEED_REQ_DICT ***
grant FLASHBACK,SELECT                                                       on V_TELLER_NEED_REQ_DICT to WR_REFREAD;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/view/v_teller_need_req_dict.sql =========***
 PROMPT ===================================================================================== 
 