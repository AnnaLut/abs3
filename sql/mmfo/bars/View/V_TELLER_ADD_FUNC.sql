
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/view/v_teller_add_func.sql =========*** Run 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FORCE VIEW BARS.V_TELLER_ADD_FUNC ("OP_NAME", "FUNC_NAME") AS 
  select '5.�������� ��� (������)' as op_name, 'teller_soap_api.ResetOperationNormal' as func_name
  from dual
union
select '6.�������� ��� (�����)', 'teller_soap_api.ResetOperationAdmin'
  from dual
union
select '3.���������� ������', 'teller_soap_api.CountOperation'
from dual
union
select '4.��������� ���������', 'teller_soap_api.EndCountOperation'
from dual
union
select '7.���������������� ���', 'teller_soap_api.RebootATm'
from dual
union
select '8.��������� ���', 'teller_soap_api.PowerOFFATM'
from dual
union
select '1.���� ���������� �� ���', 'teller_soap_api.user_reconnect'
from dual
union
select '2.�������� ���', 'teller_soap_api.ReleaseATM'
from dual
union
select '9.������� ��� ��������� ���','teller_soap_api.InventoryCount'
from dual
/*union
select '98.�������� ����+','teller_tools.Reg_sbon'
from dual*/
union
select '98.�������������� ���','teller_tools.reset_atm_fault'
from dual
order by 1
;
 show err;
 
PROMPT *** Create  grants  V_TELLER_ADD_FUNC ***
grant SELECT                                                                 on V_TELLER_ADD_FUNC to IBMESB;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/view/v_teller_add_func.sql =========*** End 
 PROMPT ===================================================================================== 
 