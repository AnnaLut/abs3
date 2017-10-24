

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAIUD_DPUDEALW_UPDATE.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAIUD_DPUDEALW_UPDATE ***

  CREATE OR REPLACE TRIGGER BARS.TAIUD_DPUDEALW_UPDATE 
after insert or update of value or delete on DPU_DEALW
for each row
declare
 l_rec   dpu_dealw_update%rowtype;
begin



  case
    when inserting then
      l_rec.chgaction := 1;
      l_rec.dpu_id    := :new.dpu_id;
      l_rec.tag       := :new.tag;
      l_rec.VALUE     := :new.value;
    when updating  then
      if (:new.value <> :old.value) then
        l_rec.chgaction := 2;
        l_rec.dpu_id    := :new.dpu_id;
        l_rec.tag       := :new.tag;
        l_rec.value     := :new.value;
      end if;
/*      (:old.custtype is null and :new.custtype is not null) or
         (:old.custtype is not null and :new.custtype is null) or :new.custtype <> :old.custtype */
    else -- deleting
      l_rec.chgaction := 3;
      l_rec.dpu_id    := :old.dpu_id;
      l_rec.tag       := :old.tag;
      l_rec.value     := :old.value;
  end case;

  If (l_rec.chgaction Is Not Null) then
    l_rec.bdate  := gl.bd;
    l_rec.doneby := gl.aUID;
    l_rec.kf     := sys_context('bars_context','user_mfo');

    select s_dpu_dealw_update.nextval, sysdate
      into l_rec.idupd, l_rec.chgdate
      from DUAL;

    insert into BARS.DPU_DEALW_UPDATE
    values l_rec;

  End If;

end;
/
ALTER TRIGGER BARS.TAIUD_DPUDEALW_UPDATE ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAIUD_DPUDEALW_UPDATE.sql =========*
PROMPT ===================================================================================== 
