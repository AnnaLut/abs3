

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBIUD_KAS_VV1.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBIUD_KAS_VV1 ***

  CREATE OR REPLACE TRIGGER BARS.TBIUD_KAS_VV1 
  INSTEAD OF UPDATE ON BARS.KAS_VV1 REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
declare
  dat2_   date;
begin
  KASZ.PDAT2   (1,:new.DAT2, :new.S, dat2_);
  KASZ.CEL_MON (  :new.kv,   :new.S*100   );

  insert into  KAS_Z( idz, DAT1, SOS, BRANCH, VID, KV, DAT2, idu, S )
  select s_KAS_Z.nextval, sysdate, 0, :new.branch, 1, :new.kv, DAT2_,GL.AuID,
         :new.s
  from dual;

end tbiud_KAS_vv1;
/
ALTER TRIGGER BARS.TBIUD_KAS_VV1 ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBIUD_KAS_VV1.sql =========*** End *
PROMPT ===================================================================================== 
