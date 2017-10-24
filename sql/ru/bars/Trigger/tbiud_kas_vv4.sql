

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBIUD_KAS_VV4.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBIUD_KAS_VV4 ***

  CREATE OR REPLACE TRIGGER BARS.TBIUD_KAS_VV4 
  INSTEAD OF UPDATE ON KAS_vv4 REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
declare
  dat2_   date;
begin
  KASZ.PDAT2(4, :new.DAT2, :new.s, dat2_);

  insert into  KAS_Z( idz, DAT1, SOS, BRANCH, VID, kodv, KV, DAT2, idu, kol )
  select s_KAS_Z.nextval, sysdate, 0, :new.branch, 4, :new.kodv,
         gl.baseval, DAT2_, GL.AuID, :new.s
  from dual;

end tbiud_KAS_vv4;
/
ALTER TRIGGER BARS.TBIUD_KAS_VV4 ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBIUD_KAS_VV4.sql =========*** End *
PROMPT ===================================================================================== 
