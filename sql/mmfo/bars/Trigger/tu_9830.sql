

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TU_9830.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TU_9830 ***

  CREATE OR REPLACE TRIGGER BARS.TU_9830 
   BEFORE UPDATE OF OSTC
   ON ACCOUNTS
   REFERENCING FOR EACH ROW
  WHEN (
OLD.nbs='9830' AND NEW.ostc<OLD.ostc AND NEW.pap=1
      ) DECLARE

/* �������������� ������� ��������� ����� ( ������� CH_1 ) �� �������� ���
   ���������:
   1) ���� � ������ �� ����� ����� �������� �� ������ 9830*
      - �������������� ��������� ���� � ��������� CH_1
*/
 nRef_ int;  nPap_ int;
BEGIN
 begin
   select ref1 into nRef_ from ch_1 where ref1=gl.aREF and rownum=1;
 EXCEPTION WHEN NO_DATA_FOUND THEN
   begin
     select min(ids) into nPap_ from ch_1s where s9830=:OLD.nls;
   EXCEPTION WHEN NO_DATA_FOUND THEN null;
   end;
   INSERT into CH_1(S,KV,ids,ref1, mfo) values
     (:OLD.ostc-:NEW.ostc, :OLD.KV,nPap_,gl.aREF, gl.aMFO );
 end;
END tu_9830;



/
ALTER TRIGGER BARS.TU_9830 ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TU_9830.sql =========*** End *** ===
PROMPT ===================================================================================== 
