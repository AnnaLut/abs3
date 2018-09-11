

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIUD_VIP_FLAGS.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIUD_VIP_FLAGS ***

  CREATE OR REPLACE TRIGGER BARS.TIUD_VIP_FLAGS 
after insert or delete or update of 
MFO,            
RNK,            
VIP,            
KVIP,           
DATBEG,         
DATEND,         
COMMENTS,       
CM_FLAG,        
CM_TRY,         
FIO_MANAGER,   
PHONE_MANAGER , 
MAIL_MANAGER,  
ACCOUNT_MANAGER
ON BARS.vip_flags
for each row
declare
  l_rec  vip_flags_arc%rowtype;
  ---
  procedure SAVE_CHANGES
  is
  begin

    if ( l_rec.VID = 'D' )
    then
        l_rec.MFO := :old.MFO;  
        l_rec.RNK := :old.RNK; 
        l_rec.VIP := :old.VIP; 
        l_rec.KVIP := :old.KVIP; 
        l_rec.DATBEG := :old.DATBEG; 
        l_rec.DATEND := :old.DATEND; 
        l_rec.COMMENTS := :old.COMMENTS;
        l_rec.CM_FLAG := :old.CM_FLAG; 
        l_rec.CM_TRY := :old.CM_TRY;
        l_rec.FIO_MANAGER := :old.FIO_MANAGER; 
        l_rec.PHONE_MANAGER := :old.PHONE_MANAGER;
        l_rec.MAIL_MANAGER := :old.MAIL_MANAGER; 
        l_rec.ACCOUNT_MANAGER := :old.ACCOUNT_MANAGER;
    else
        l_rec.MFO := :new.MFO;  
        l_rec.RNK := :new.RNK; 
        l_rec.VIP := :new.VIP; 
        l_rec.KVIP := :new.KVIP; 
        l_rec.DATBEG := :new.DATBEG; 
        l_rec.DATEND := :new.DATEND; 
        l_rec.COMMENTS := :new.COMMENTS;
        l_rec.CM_FLAG := :new.CM_FLAG; 
        l_rec.CM_TRY := :new.CM_TRY;
        l_rec.FIO_MANAGER := :new.FIO_MANAGER; 
        l_rec.PHONE_MANAGER := :new.PHONE_MANAGER;
        l_rec.MAIL_MANAGER := :new.MAIL_MANAGER; 
        l_rec.ACCOUNT_MANAGER := :new.ACCOUNT_MANAGER;
    end if;
    l_rec.IDUPD         := bars_sqnc.get_nextval('s_vip_flags_arc'); 
    l_rec.EFFECTDATE    := COALESCE(gl.bd, glb_bankdate);
    l_rec.GLOBAL_BDATE  := glb_bankdate;
    l_rec.IDU           := gl.auid;
    l_rec.fdat          := sysdate;
    l_rec.kf            := l_rec.MFO;
    insert into BARS.vip_flags_arc values l_rec;

  end SAVE_CHANGES;
  ---
begin

  case
    when inserting
    then

      l_rec.VID := 'I';
      SAVE_CHANGES;

    when deleting
    then

      l_rec.VID := 'D';
      SAVE_CHANGES;

    when updating
    then

      case
        when (:old.mfo <> :new.mfo or :old.rnk <> :new.rnk ) -- !!! analize changing PRIMARY KEY - columns
        then -- При зміні значеннь полів, що входять в PRIMARY KEY (для правильного відображення)

          -- породжуємо в історії запис про видалення
          l_rec.VID := 'D';
          SAVE_CHANGES;

          -- породжуємо в історії запис про вставку
          l_rec.VID := 'I';
          SAVE_CHANGES;

        when (
                   :old.VIP <> :new.VIP OR (:old.VIP IS NULL AND :new.VIP IS NOT NULL) OR (:old.VIP IS NOT NULL AND :new.VIP IS NULL)
                OR :old.KVIP <> :new.KVIP OR (:old.KVIP IS NULL AND :new.KVIP IS NOT NULL) OR (:old.KVIP IS NOT NULL AND :new.KVIP IS NULL)
                OR :old.DATBEG <> :new.DATBEG OR (:old.DATBEG IS NULL AND :new.DATBEG IS NOT NULL) OR (:old.DATBEG IS NOT NULL AND :new.DATBEG IS NULL)
                OR :old.DATEND <> :new.DATEND OR (:old.DATEND IS NULL AND :new.DATEND IS NOT NULL) OR (:old.DATEND IS NOT NULL AND :new.DATEND IS NULL)
                OR :old.COMMENTS <> :new.COMMENTS OR (:old.COMMENTS IS NULL AND :new.COMMENTS IS NOT NULL) OR (:old.COMMENTS IS NOT NULL AND :new.COMMENTS IS NULL)
                OR :old.CM_FLAG <> :new.CM_FLAG OR (:old.CM_FLAG IS NULL AND :new.CM_FLAG IS NOT NULL) OR (:old.CM_FLAG IS NOT NULL AND :new.CM_FLAG IS NULL)
                OR :old.CM_TRY <> :new.CM_TRY OR (:old.CM_TRY IS NULL AND :new.CM_TRY IS NOT NULL) OR (:old.CM_TRY IS NOT NULL AND :new.CM_TRY IS NULL)
                OR :old.FIO_MANAGER <> :new.FIO_MANAGER OR (:old.FIO_MANAGER IS NULL AND :new.FIO_MANAGER IS NOT NULL) OR (:old.FIO_MANAGER IS NOT NULL AND :new.FIO_MANAGER IS NULL)
                OR :old.PHONE_MANAGER <> :new.PHONE_MANAGER OR (:old.PHONE_MANAGER IS NULL AND :new.PHONE_MANAGER IS NOT NULL) OR (:old.PHONE_MANAGER IS NOT NULL AND :new.PHONE_MANAGER IS NULL)
                OR :old.MAIL_MANAGER <> :new.MAIL_MANAGER OR (:old.MAIL_MANAGER IS NULL AND :new.MAIL_MANAGER IS NOT NULL) OR (:old.MAIL_MANAGER IS NOT NULL AND :new.MAIL_MANAGER IS NULL)
                OR :old.ACCOUNT_MANAGER <> :new.ACCOUNT_MANAGER OR (:old.ACCOUNT_MANAGER IS NULL AND :new.ACCOUNT_MANAGER IS NOT NULL) OR (:old.ACCOUNT_MANAGER IS NOT NULL AND :new.ACCOUNT_MANAGER IS NULL)
            )
        then -- При зміні значеннь полів, що НЕ входять в PRIMARY KEY
          -- протоколюємо внесені зміни
          l_rec.VID := 'U';
          SAVE_CHANGES;

        else
          Null;
      end case;

    else
      null;
  end case;

end TIUD_vip_flags;
/
ALTER TRIGGER BARS.TIUD_VIP_FLAGS ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIUD_VIP_FLAGS.sql =========*** End 
PROMPT ===================================================================================== 
