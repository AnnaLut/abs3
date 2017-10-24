

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIU_ACCOUNT67.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIU_ACCOUNT67 ***

  CREATE OR REPLACE TRIGGER BARS.TIU_ACCOUNT67 
  BEFORE INSERT OR UPDATE OF  kv, nbs, nls, tip  ON accounts  FOR EACH ROW
 WHEN (new.acc<>0   ) DECLARE
   NLS_ varchar2(15);
BEGIN
 If :new.nls like '0000%' and :new.nbs is null then
    RETURN;
 end if;
  -- �������� �� ���������� ������ � ������ �����
  begin
     select to_number(:new.nls) into nls_ from dual;
  EXCEPTION WHEN OTHERS THEN
     raise_application_error(-(20000+111),'���������� ������ � ������ �����',TRUE);
  end;
  -- �������� �� ������ ������ 6, 7 ��.
  if :new.kv<>980 and substr(:new.nbs,1,1) in ('6','7') then
     raise_application_error(-(20000+222),'������ � ��.6,7 ��. kv='||:new.kv,TRUE);
  end if;
  -- �������� �� ����� ������ �����
  if length(:new.nls) < 5 then
     raise_application_error(-(20000+333),'����� ������ ����� ����� 5 ��',TRUE);
  end if;
  if vkrzn(substr(F_OURMFO,1,5),:new.nls)<>:new.nls
  then
     raise_application_error(-(20000+444),'��.�����.������� � �����',TRUE);
  end if;

  -- ��� ����� 8999
  if :new.nbs = '8999' then
     :new.tip := 'LIM';
  end if;

END tiu_account67;
/
ALTER TRIGGER BARS.TIU_ACCOUNT67 ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIU_ACCOUNT67.sql =========*** End *
PROMPT ===================================================================================== 
