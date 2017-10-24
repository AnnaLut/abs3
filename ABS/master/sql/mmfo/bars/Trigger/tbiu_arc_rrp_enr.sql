

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBIU_ARC_RRP_ENR.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBIU_ARC_RRP_ENR ***

  CREATE OR REPLACE TRIGGER BARS.TBIU_ARC_RRP_ENR 
  BEFORE INSERT OR UPDATE ON "BARS"."ARC_RRP"
  REFERENCING FOR EACH ROW
    WHEN (
NEW.vob=90 and
        NEW.fn_b is null and NEW.fn_a is null and
        NEW.ref  is not null
      ) DECLARE
   BLK_ int :=555;

/* ������� �� ����� ���-��� �� ������������� �����������, ������������ ��� :
   1) �������� REC � ��������� ������� ENR_FILE,
      �� ������� ������ � ���������    ENR_fn  ����� ��������� ����� ������
      � ������������ � ������������ �� ENR
   2) ������������� �������������� ��������� ������� �������� ��-������, �.�.
      ��� �������������� ������������� ��� ������ � ��� �� ��������� ENR_fn
*/

BEGIN
   if INSERTING then

      UPDATE enr_file
         set recD=decode( :NEW.ref, REFD, :NEW.rec, recd ),
             recK=decode( :NEW.ref, REFK, :NEW.rec, reck )
       where mfo=:NEW.MFOB and :NEW.ref in (REFD,REFK)
         and REFD is not null and REFK is not null;

      If SQL%rowcount = 1 then  :NEW.blk := BLK_;  end if;

   ELSIF UPDATING and nvl(:OLD.blk,0)=BLK_
                  and     :NEW.blk   =0
                  and nvl(:NEW.SOS,0)<>3   then
         :NEW.blk := BLK_;
   end if;

END tbiu_ARC_RRP_ENR;


/
ALTER TRIGGER BARS.TBIU_ARC_RRP_ENR ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBIU_ARC_RRP_ENR.sql =========*** En
PROMPT ===================================================================================== 
