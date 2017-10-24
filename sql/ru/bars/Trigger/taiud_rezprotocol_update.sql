

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

  else

    if updating
    then

      if (:old.DAT <> :new.DAT)
      then -- ���� ��������� ����, �� ������� � PRIMARY KEY ��������� ������ ��� ���������
           -- �� ��� ������� ��� ����������� ����������� ��� ����������� ����� �� DWH

        l_rec.IDUPD        := S_REZ_PROTOCOL_UPDATE.NextVal;
        l_rec.CHGACTION    := 'D';
        l_rec.EFFECTDATE   := COALESCE(gl.bd, glb_bankdate);
        l_rec.GLOBAL_BDATE := glb_bankdate;
        l_rec.CHGDATE      := sysdate;
        l_rec.DONEBY       := gl.aUID;
        l_rec.USERID       := :old.USERID;
        l_rec.DAT          := :old.DAT;
        l_rec.DAT_BANK     := :old.DAT_BANK;
        l_rec.BRANCH       := :old.BRANCH;

        insert into BARS.REZ_PROTOCOL_UPDATE
        values l_rec;

        l_rec.CHGACTION := 'I';

      else

        l_rec.CHGACTION := 'U';
        -- ������� �� ��������� ��� �������� �� ���� ��������
      end if;

    else -- inserting
      l_rec.CHGACTION := 'I';
    end if;

    l_rec.DAT       := :new.DAT;
    l_rec.DAT_BANK  := :new.DAT_BANK;
    l_rec.USERID    := :new.USERID;
    l_rec.BRANCH    := :new.BRANCH;

  end if;

  If (l_rec.CHGACTION Is Not Null)
  then

    l_rec.IDUPD        := S_REZ_PROTOCOL_UPDATE.NextVal;
    l_rec.EFFECTDATE   := COALESCE(gl.bd, glb_bankdate);
    l_rec.GLOBAL_BDATE := glb_bankdate;
    l_rec.CHGDATE      := sysdate;
    l_rec.DONEBY       := gl.aUID;

    insert into BARS.REZ_PROTOCOL_UPDATE
    values l_rec;

  End If;

end;
/
ALTER TRIGGER BARS.TAIUD_REZPROTOCOL_UPDATE ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAIUD_REZPROTOCOL_UPDATE.sql =======
PROMPT ===================================================================================== 
