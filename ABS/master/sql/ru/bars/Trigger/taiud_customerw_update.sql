

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAIUD_CUSTOMERW_UPDATE.sql =========
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAIUD_CUSTOMERW_UPDATE ***

  CREATE OR REPLACE TRIGGER BARS.TAIUD_CUSTOMERW_UPDATE 
AFTER INSERT OR UPDATE OR DELETE OF VALUE ON BARS.CUSTOMERW
for each row
declare
  l_rec  CUSTOMERW_UPDATE%rowtype;
begin

  if deleting
  then

    l_rec.CHGACTION := 3;

    l_rec.rnk       := :old.rnk;
    l_rec.tag       := trim(:old.tag);
    l_rec.value     := null;
    l_rec.isp       := :old.isp;

  else

    if updating
    then

      if ( (:old.RNK != :new.RNK)
           OR
           (:old.TAG != :new.TAG)
           OR
           (:old.VALUE          != :new.VALUE) or
           (:old.VALUE is Null AND :new.VALUE is Not Null) or
           (:new.VALUE is Null AND :old.VALUE is Not Null)
         )
      then
        l_rec.CHGACTION := 2;
      end if;

    else -- inserting
      l_rec.CHGACTION := 1;
    end if;

    l_rec.rnk         := :new.rnk;
    l_rec.tag         := trim(:new.tag);
    l_rec.value       := :new.value;
    l_rec.isp         := :new.isp;

  end if;

  If (l_rec.CHGACTION Is Not Null)
  then

    l_rec.IDUPD      := BARS.S_CUSTOMERW_UPDATE.NextVal;
    l_rec.EFFECTDATE := COALESCE(gl.bd, glb_bankdate);
    l_rec.CHGDATE    := sysdate;
    l_rec.DONEBY     := user_name;

    insert into BARS.CUSTOMERW_UPDATE
    values l_rec;

  End If;

end;
/
ALTER TRIGGER BARS.TAIUD_CUSTOMERW_UPDATE ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAIUD_CUSTOMERW_UPDATE.sql =========
PROMPT ===================================================================================== 
