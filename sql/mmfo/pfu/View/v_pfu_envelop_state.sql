

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/PFU/View/V_PFU_ENVELOP_STATE.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  view V_PFU_ENVELOP_STATE ***

  CREATE OR REPLACE FORCE VIEW PFU.V_PFU_ENVELOP_STATE ("STATE", "STATE_NAME") AS 
  SELECT 'NEW' state, '�����' state_name FROM dual
   union all
   SELECT 'CHECKED' state, '���������' state_name FROM dual
   union all
   SELECT 'MATCH_SEND' state, '��������� ����������' state_name FROM dual;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/PFU/View/V_PFU_ENVELOP_STATE.sql =========*** End
PROMPT ===================================================================================== 
