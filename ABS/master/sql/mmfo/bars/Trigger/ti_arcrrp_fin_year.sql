

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TI_ARCRRP_FIN_YEAR.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TI_ARCRRP_FIN_YEAR ***

  CREATE OR REPLACE TRIGGER BARS.TI_ARCRRP_FIN_YEAR 
   AFTER INSERT
   ON "BARS"."ARC_RRP"
   REFERENCING FOR EACH ROW
 WHEN (
new.kv=980 and new.fn_a like '$A%' and new.kf='300465'
      ) declare
  l_mfo_b     banks.mfo%type;
begin
      --
      -- ������� ������ ��� ���������� �������� �� �������� �� 3 ������
      -- ����� �������� �� ��� � ������������
      --
      select mfo into l_mfo_b from banks
      where mfo=:new.mfob and (
        mfo like '8%'                   -- �� ������������
        or substr(sab,3,1)='H'          -- �� ���������� ���
        or mfo=gl.kf                    -- �� ���
        or (mfop=gl.kf and kodn=6)      -- �� ���. ��������� ���������
        or mfop in                      -- �� �������� ���������� ����������
          (select mfo from banks
           where mfop=gl.kf and kodn=6)
      );
     exception when no_data_found then
       raise_application_error(-20000, '\0978 - ��������� ������ �� ��� ��������, �� ����������� ��� �� ������������', TRUE);

end;
/
ALTER TRIGGER BARS.TI_ARCRRP_FIN_YEAR DISABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TI_ARCRRP_FIN_YEAR.sql =========*** 
PROMPT ===================================================================================== 
