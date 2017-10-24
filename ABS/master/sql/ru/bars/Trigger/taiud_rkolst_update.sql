

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAIUD_RKOLST_UPDATE.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAIUD_RKOLST_UPDATE ***

  CREATE OR REPLACE TRIGGER BARS.TAIUD_RKOLST_UPDATE 
after insert or update or delete on BARS.RKO_LST
for each row
declare
  l_rec  RKO_LST_UPDATE%rowtype;
begin

  if deleting
  then

    l_rec.CHGACTION := 'D';

    l_rec.ACC       := :old.ACC;
    l_rec.ACCD      := :old.ACCD;
    l_rec.DAT0A     := :old.DAT0A;
    l_rec.DAT0B     := :old.DAT0B;
    l_rec.S0        := :old.S0;
    l_rec.DAT1A     := :old.DAT1A;
    l_rec.DAT1B     := :old.DAT1B;
    l_rec.ACC1      := :old.ACC1;
    l_rec.DAT2A     := :old.DAT2A;
    l_rec.DAT2B     := :old.DAT2B;
    l_rec.ACC2      := :old.ACC2;
    l_rec.COMM      := :old.COMM;
    l_rec.KF        := :old.KF;
    l_rec.KOLDOK    := :old.KOLDOK;
    l_rec.SUMDOK    := :old.SUMDOK;
    l_rec.ND        := :old.ND;
    l_rec.CC_ID     := :old.CC_ID;
    l_rec.SDATE     := :old.SDATE;
    l_rec.SOS       := :old.SOS;

  else

    if updating
    then

      if ( (:old.ACC != :new.ACC)
           OR
           (:old.ACCD          != :new.ACCD) or
           (:old.ACCD is Null AND :new.ACCD is Not Null) or
           (:new.ACCD is Null AND :old.ACCD is Not Null)
           OR
           (:old.DAT0A          != :new.DAT0A) or
           (:old.DAT0A is Null AND :new.DAT0A is Not Null) or
           (:new.DAT0A is Null AND :old.DAT0A is Not Null)
           OR
           (:old.DAT0B          != :new.DAT0B) or
           (:old.DAT0B is Null AND :new.DAT0B is Not Null) or
           (:new.DAT0B is Null AND :old.DAT0B is Not Null)
           OR
           (:old.S0 != :new.S0)
           OR
           (:old.DAT1A          != :new.DAT1A) or
           (:old.DAT1A is Null AND :new.DAT1A is Not Null) or
           (:new.DAT1A is Null AND :old.DAT1A is Not Null)
           OR
           (:old.DAT1B          != :new.DAT1B) or
           (:old.DAT1B is Null AND :new.DAT1B is Not Null) or
           (:new.DAT1B is Null AND :old.DAT1B is Not Null)
           OR
           (:old.ACC1          != :new.ACC1) or
           (:old.ACC1 is Null AND :new.ACC1 is Not Null) or
           (:new.ACC1 is Null AND :old.ACC1 is Not Null)
           OR
           (:old.DAT2A          != :new.DAT2A) or
           (:old.DAT2A is Null AND :new.DAT2A is Not Null) or
           (:new.DAT2A is Null AND :old.DAT2A is Not Null)
           OR
           (:old.DAT2B          != :new.DAT2B) or
           (:old.DAT2B is Null AND :new.DAT2B is Not Null) or
           (:new.DAT2B is Null AND :old.DAT2B is Not Null)
           OR
           (:old.ACC2          != :new.ACC2) or
           (:old.ACC2 is Null AND :new.ACC2 is Not Null) or
           (:new.ACC2 is Null AND :old.ACC2 is Not Null)
           OR
           (:old.COMM          != :new.COMM) or
           (:old.COMM is Null AND :new.COMM is Not Null) or
           (:new.COMM is Null AND :old.COMM is Not Null)
           OR
           (:old.KF != :new.KF)
           OR
           (:old.KOLDOK != :new.KOLDOK)
           OR
           (:old.SUMDOK != :new.SUMDOK)
           OR
           (:old.ND != :new.ND)
           OR
           (:old.CC_ID          != :new.CC_ID) or
           (:old.CC_ID is Null AND :new.CC_ID is Not Null) or
           (:new.CC_ID is Null AND :old.CC_ID is Not Null)
           OR
           (:old.SDATE          != :new.SDATE) or
           (:old.SDATE is Null AND :new.SDATE is Not Null) or
           (:new.SDATE is Null AND :old.SDATE is Not Null)
           OR
           (:old.SOS != :new.SOS)
         )
      then
        l_rec.CHGACTION := 'U';
      end if;

    else
      l_rec.CHGACTION := 'I';
    end if;

    l_rec.ACC       := :new.ACC;
    l_rec.ACCD      := :new.ACCD;
    l_rec.DAT0A     := :new.DAT0A;
    l_rec.DAT0B     := :new.DAT0B;
    l_rec.S0        := :new.S0;
    l_rec.DAT1A     := :new.DAT1A;
    l_rec.DAT1B     := :new.DAT1B;
    l_rec.ACC1      := :new.ACC1;
    l_rec.DAT2A     := :new.DAT2A;
    l_rec.DAT2B     := :new.DAT2B;
    l_rec.ACC2      := :new.ACC2;
    l_rec.COMM      := :new.COMM;
    l_rec.KF        := :new.KF;
    l_rec.KOLDOK    := :new.KOLDOK;
    l_rec.SUMDOK    := :new.SUMDOK;
    l_rec.ND        := :new.ND;
    l_rec.CC_ID     := :new.CC_ID;
    l_rec.SDATE     := :new.SDATE;
    l_rec.SOS       := :new.SOS;

  end if;

  If (l_rec.CHGACTION Is Not Null)
  then

    l_rec.IDUPD        := S_RKO_LST_UPDATE.NextVal;
    l_rec.CHGDATE      := sysdate;
    l_rec.DONEBY       := gl.aUID;
    l_rec.GLOBAL_BDATE := glb_bankdate;
    l_rec.EFFECTDATE   := COALESCE(gl.bd, glb_bankdate);

    insert into BARS.RKO_LST_UPDATE
    values l_rec;

  End If;

end;
/
ALTER TRIGGER BARS.TAIUD_RKOLST_UPDATE ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAIUD_RKOLST_UPDATE.sql =========***
PROMPT ===================================================================================== 
