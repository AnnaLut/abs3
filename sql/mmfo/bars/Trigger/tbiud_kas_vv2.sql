

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBIUD_KAS_VV2.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBIUD_KAS_VV2 ***

  CREATE OR REPLACE TRIGGER BARS.TBIUD_KAS_VV2 
  INSTEAD OF UPDATE ON BARS.KAS_VV2 REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
declare
  dat2_   date;
begin
  KASZ.PDAT2(2, :new.DAT2, :new.s, dat2_);

  insert into  KAS_Z( idz, DAT1, SOS, BRANCH, VID, kodv, KV, DAT2,idu, kol )
  select s_KAS_Z.nextval, sysdate, 0, :new.branch, 2, :new.kodv, :new.kv,
         DAT2_, GL.AuID, :new.s
  from dual;

end tbiud_KAS_vv2;


/
ALTER TRIGGER BARS.TBIUD_KAS_VV2 ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBIUD_KAS_VV2.sql =========*** End *
PROMPT ===================================================================================== 
