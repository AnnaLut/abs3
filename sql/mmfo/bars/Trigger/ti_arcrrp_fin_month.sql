

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TI_ARCRRP_FIN_MONTH.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TI_ARCRRP_FIN_MONTH ***

  CREATE OR REPLACE TRIGGER BARS.TI_ARCRRP_FIN_MONTH 
  AFTER INSERT ON "BARS"."ARC_RRP"
  REFERENCING FOR EACH ROW
    WHEN (
new.kv=980 and new.fn_a like '$A%'
      ) declare
  l_mfo_b     banks.mfo%type;
begin
  --
  -- ������� ������ ��� ���������� �������� �� �������� �� 3 ������
  -- �� ��� �����, ����� �������� ���
  --
  select mfo into l_mfo_b from banks
  where mfo=:new.mfob and
    (    mfo=gl.kf                    -- �� ���
      or (mfop=gl.kf and kodn=6)      -- �� ���. ��������� ���������
      or mfop in                      -- �� �������� ���������� ����������
         (select mfo from banks
         where mfop=gl.kf and kodn=6)
    );
exception when no_data_found then
  raise_application_error(-20000, '\0977 - ���������� ���������� �� �������� ��������� ��� �����', TRUE);
end;


/
ALTER TRIGGER BARS.TI_ARCRRP_FIN_MONTH DISABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TI_ARCRRP_FIN_MONTH.sql =========***
PROMPT ===================================================================================== 
