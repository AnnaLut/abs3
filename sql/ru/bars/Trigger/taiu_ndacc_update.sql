

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAIU_NDACC_UPDATE.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAIU_NDACC_UPDATE ***

  CREATE OR REPLACE TRIGGER BARS.TAIU_NDACC_UPDATE 
after insert or delete or update
of ND, ACC, KF
ON BARS.ND_ACC
for each row
declare
  l_rec  BARS.ND_ACC_UPDATE%rowtype;
  ---
  procedure SAVE_CHANGES
  is
  begin

    if ( l_rec.CHGACTION = 'D' )
    then
        l_rec.ND := :old.ND;  l_rec.ACC := :old.ACC;  l_rec.KF := :old.KF;
    else
        l_rec.ND := :new.ND;  l_rec.ACC := :new.ACC;  l_rec.KF := :new.KF;
    end if;
    l_rec.IDUPD         := s_NDACC_update.nextval;
    l_rec.EFFECTDATE    := COALESCE(gl.bd, glb_bankdate);
    l_rec.GLOBAL_BDATE  := glb_bankdate;    -- sysdate
    l_rec.DONEBY        := gl.aUID; --gl.aUID(NUMBER);	user_name(VARCHAR2);
    l_rec.CHGDATE       := sysdate;

    insert into BARS.ND_ACC_UPDATE values l_rec;

  end SAVE_CHANGES;
  ---
begin

  case
    when inserting
    then

      l_rec.CHGACTION := 'I';
      SAVE_CHANGES;

    when deleting
    then

      l_rec.CHGACTION := 'D';
      SAVE_CHANGES;

    when updating
    then
      case
        when (:old.ND <> :new.ND or :old.ACC <> :new.ACC or :old.KF <> :new.KF)
        then
             l_rec.CHGACTION := 'D';
             SAVE_CHANGES;

             l_rec.CHGACTION := 'I';
             SAVE_CHANGES;

        when (  :old.KF <> :new.KF )
        then
             l_rec.CHGACTION := 'U';
             SAVE_CHANGES;
        else
             Null;
      end case;

    else
         null;
  end case;

end TAIU_NDACC_UPDATE;
/
ALTER TRIGGER BARS.TAIU_NDACC_UPDATE ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAIU_NDACC_UPDATE.sql =========*** E
PROMPT ===================================================================================== 
