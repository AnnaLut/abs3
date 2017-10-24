

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAIUD_REZPROTOCOL_UPDATE.sql =======
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAIUD_REZPROTOCOL_UPDATE ***

  CREATE OR REPLACE TRIGGER BARS.TAIUD_REZPROTOCOL_UPDATE 
after insert or update or delete on BARS.REZ_PROTOCOL
for each row
declare
  l_rec  REZ_PROTOCOL_UPDATE%rowtype;
begin

  if deleting
  then

    l_rec.CHGACTION := 'D';

    l_rec.DAT       := :old.DAT;
    l_rec.DAT_BANK  := :old.DAT_BANK;
    l_rec.USERID    := :old.USERID;
    l_rec.BRANCH    := :old.BRANCH;
    l_rec.KF        := sys_context('bars_context','user_mfo');

  else

    if updating
    then

      if (:old.DAT <> :new.DAT)
      then -- якщо зм≥нюЇтьс€ поле, що входить в PRIMARY KEY породжуЇмо записи про видаленн€
           -- та про вставку дл€ правильного в≥дображенн€ при вивантаженн≥ даних до DWH

        l_rec.CHGACTION    := 'D';
        l_rec.EFFECTDATE   := COALESCE(gl.bd, glb_bankdate);
        l_rec.GLOBAL_BDATE := glb_bankdate;
        l_rec.CHGDATE      := sysdate;
        l_rec.DONEBY       := gl.aUID;
        l_rec.USERID       := :old.USERID;
        l_rec.DAT          := :old.DAT;
        l_rec.DAT_BANK     := :old.DAT_BANK;
        l_rec.BRANCH       := :old.BRANCH;
        l_rec.KF           := sys_context('bars_context','user_mfo');
        l_rec.IDUPD        := bars_sqnc.get_nextval('s_rez_protocol_update', l_rec.KF);

        insert into BARS.REZ_PROTOCOL_UPDATE
        values l_rec;

        l_rec.CHGACTION := 'I';

      else

        l_rec.CHGACTION := 'U';
        -- збер≥гаЇм вс≥ оновленн€ без перев≥рки чи щось зм≥нилос€
      end if;

    else -- inserting
      l_rec.CHGACTION := 'I';
    end if;

    l_rec.DAT       := :new.DAT;
    l_rec.DAT_BANK  := :new.DAT_BANK;
    l_rec.USERID    := :new.USERID;
    l_rec.BRANCH    := :new.BRANCH;
    l_rec.KF        := sys_context('bars_context','user_mfo');

  end if;

  If (l_rec.CHGACTION Is Not Null)
  then

    l_rec.EFFECTDATE   := COALESCE(gl.bd, glb_bankdate);
    l_rec.GLOBAL_BDATE := glb_bankdate;
    l_rec.CHGDATE      := sysdate;
    l_rec.DONEBY       := gl.aUID;
    l_rec.KF           := sys_context('bars_context','user_mfo');
    l_rec.IDUPD        := bars_sqnc.get_nextval('s_rez_protocol_update', l_rec.KF);

    insert into BARS.REZ_PROTOCOL_UPDATE
    values l_rec;

  End If;

end;
/
ALTER TRIGGER BARS.TAIUD_REZPROTOCOL_UPDATE ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAIUD_REZPROTOCOL_UPDATE.sql =======
PROMPT ===================================================================================== 
