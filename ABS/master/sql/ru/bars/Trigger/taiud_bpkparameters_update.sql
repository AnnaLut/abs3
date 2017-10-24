

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAIUD_BPKPARAMETERS_UPDATE.sql =====
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAIUD_BPKPARAMETERS_UPDATE ***

  CREATE OR REPLACE TRIGGER BARS.TAIUD_BPKPARAMETERS_UPDATE 
after insert or update or delete on BARS.BPK_PARAMETERS
for each row
declare
  l_rec  BPK_PARAMETERS_UPDATE%rowtype;
begin

  if deleting
  then

    l_rec.CHGACTION := 'D';

    l_rec.ND        := :old.ND;
    l_rec.TAG       := :old.TAG;
    l_rec.VALUE     := :old.VALUE;

  else

    if updating
    then

      if ( (:old.ND != :new.ND)
           OR
           (:old.TAG != :new.TAG)
           OR
           (:old.VALUE          != :new.VALUE) or
           (:old.VALUE is Null AND :new.VALUE is Not Null) or
           (:new.VALUE is Null AND :old.VALUE is Not Null)
         )
      then
        l_rec.CHGACTION := 'U';
      end if;

    else
      l_rec.CHGACTION := 'I';
    end if;

    l_rec.ND        := :new.ND;
    l_rec.TAG       := :new.TAG;
    l_rec.VALUE     := :new.VALUE;

  end if;

  If (l_rec.CHGACTION Is Not Null)
  then

    l_rec.IDUPD        := S_BPK_PARAMETERS_UPDATE.NextVal;
    l_rec.CHGDATE      := sysdate;
    l_rec.DONEBY       := gl.aUID;
    l_rec.GLOBAL_BDATE := glb_bankdate;
    l_rec.EFFECTDATE   := COALESCE(gl.bd, glb_bankdate);

    insert into BARS.BPK_PARAMETERS_UPDATE
    values l_rec;

  End If;

end TAIUD_BPKPARAMETERS_UPDATE;
/
ALTER TRIGGER BARS.TAIUD_BPKPARAMETERS_UPDATE ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAIUD_BPKPARAMETERS_UPDATE.sql =====
PROMPT ===================================================================================== 
