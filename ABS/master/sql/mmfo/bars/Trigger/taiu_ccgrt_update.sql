

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAIU_CCGRT_UPDATE.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAIU_CCGRT_UPDATE ***

  CREATE OR REPLACE TRIGGER BARS.TAIU_CCGRT_UPDATE 
after insert or delete or update of ND,GRT_DEAL_ID
 on bars.cc_grt for each row
declare
  -- ver. 12.12.2016
   l_rec    CC_GRT_UPDATE%rowtype;
  ---
  procedure SAVE_CHANGES
  is
    l_old_key varchar2(38);
  begin

    if ( l_rec.CHGACTION = 'D' )
    then        l_rec.nd := :old.nd;  l_rec.grt_deal_id := :old.grt_deal_id;
    else        l_rec.nd := :new.nd;  l_rec.grt_deal_id := :new.grt_deal_id;
    end if;

    bars_sqnc.split_key(l_rec.nd, l_old_key, l_rec.KF);
    l_rec.IDUPD         := bars_sqnc.get_nextval('s_ccgrt_update', l_rec.KF);
    l_rec.EFFECTDATE    := COALESCE(gl.bd, glb_bankdate);
    l_rec.DONEBY        := user_id; --gl.aUID(NUMBER);	user_name(VARCHAR2);
    l_rec.CHGDATE       := sysdate;
    insert into BARS.CC_GRT_UPDATE values l_rec;

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
        when ( :old.ND <> :new.ND OR :old.GRT_DEAL_ID <> :new.GRT_DEAL_ID ) -- !!! analize changing PRIMARY KEY - columns
        then -- При зміні значеннь полів, що входять в PRIMARY KEY (для правильного відображення при вивантаженні даних до DWH)

          -- породжуємо в історії запис про видалення
          l_rec.CHGACTION := 'D';
          SAVE_CHANGES;

          -- породжуємо в історії запис про вставку
          l_rec.CHGACTION := 'I';
          SAVE_CHANGES;
        else
          Null;
      end case;
    else
      null;
  end case;
end;
/
ALTER TRIGGER BARS.TAIU_CCGRT_UPDATE ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAIU_CCGRT_UPDATE.sql =========*** E
PROMPT ===================================================================================== 
