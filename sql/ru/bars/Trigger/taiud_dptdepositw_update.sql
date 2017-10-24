

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAIUD_DPTDEPOSITW_UPDATE.sql =======
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAIUD_DPTDEPOSITW_UPDATE ***

  CREATE OR REPLACE TRIGGER BARS.TAIUD_DPTDEPOSITW_UPDATE 
after insert or update or delete on DPT_DEPOSITW
for each row
declare
 l_rec   dpt_depositw_update%rowtype;
begin

  case
    when inserting then
      l_rec.chgaction := 1;
      l_rec.dpt_id    := :new.dpt_id;
      l_rec.tag       := :new.tag;
      l_rec.VALUE     := :new.value;
    when updating  then
      if NOT (:new.value = :old.value) then
        l_rec.chgaction := 2;
        l_rec.dpt_id    := :new.dpt_id;
        l_rec.tag       := :new.tag;
        l_rec.value     := :new.value;
      end if;
    else -- deleting
      l_rec.chgaction := 3;
      l_rec.dpt_id    := :old.dpt_id;
      l_rec.tag       := :old.tag;
      l_rec.value     := :old.value;
  end case;

  If (l_rec.chgaction Is Not Null) then
    l_rec.chgdate := sysdate;
    l_rec.bdate   := gl.bd;
    l_rec.doneby  := gl.aUID;

    select S_DPT_DEPOSITW_UPDATE.nextval
      into l_rec.idupd
      from DUAL;

    insert into BARS.DPT_DEPOSITW_UPDATE
    values l_rec;

  End If;

end;
/
ALTER TRIGGER BARS.TAIUD_DPTDEPOSITW_UPDATE ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAIUD_DPTDEPOSITW_UPDATE.sql =======
PROMPT ===================================================================================== 
