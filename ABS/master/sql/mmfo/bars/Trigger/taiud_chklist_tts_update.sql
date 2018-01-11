

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAIUD_CHKLIST_TTS_UPDATE.sql =======
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAIUD_CHKLIST_TTS_UPDATE ***

  CREATE OR REPLACE TRIGGER BARS.TAIUD_CHKLIST_TTS_UPDATE 
after insert or delete or update
of TT,  IDCHK,  PRIORITY,  F_BIG_AMOUNT,  SQLVAL,  F_IN_CHARGE,  FLAGS
ON BARS.CHKLIST_TTS
for each row

declare
  
  l_rec  BARS.CHKLIST_TTS_UPDATE%rowtype;
  ---
  procedure SAVE_CHANGES
  is
  begin

    if ( l_rec.CHGACTION = 'DELETING' )
    then
       l_rec.TT :=  :old.tt;
       l_rec.IDCHK := :old.IDCHK;
       l_rec.PRIORITY := :old.PRIORITY;
       l_rec.F_BIG_AMOUNT:=  :old.F_BIG_AMOUNT;
       l_rec.SQLVAL  := :old.SQLVAL;
       l_rec.F_IN_CHARGE  := :old.F_IN_CHARGE;
       l_rec.FLAGS := :old.FLAGS;
      
    else
       l_rec.TT :=  :new.tt;
       l_rec.IDCHK := :new.IDCHK;
       l_rec.PRIORITY := :new.PRIORITY;
       l_rec.F_BIG_AMOUNT:=  :new.F_BIG_AMOUNT;
       l_rec.SQLVAL  := :new.SQLVAL;
       l_rec.F_IN_CHARGE  := :new.F_IN_CHARGE;
       l_rec.FLAGS := :new.FLAGS;
    end if;
    l_rec.IDUPD         := bars_sqnc.get_nextval('s_chklist_tts_update');
    l_rec.EFFECTDATE    := COALESCE(gl.bd, trunc(sysdate));
    l_rec.DONEBY        := gl.aUID;
    l_rec.CHGDATE       := sysdate;
    l_rec.MACHINE:= sys_context('bars_global', 'host_name');
    l_rec.IP:=sys_context('USERENV', 'IP_ADDRESS');
    l_rec.OSUSERS:=sys_context('USERENV', 'OS_USER') ;

    insert into BARS.CHKLIST_TTS_UPDATE values l_rec;

  end SAVE_CHANGES;
  ---
begin

  case
    when inserting
    then

      l_rec.CHGACTION := 'INSERTING';
      SAVE_CHANGES;

    when deleting
    then

      l_rec.CHGACTION := 'DELETING';
      SAVE_CHANGES;

    when updating
    then

      case
        when (:old.tt <> :new.tt or :old.idchk <> :new.idchk)
        
        then

          -- породжуємо в історії запис про видалення
          l_rec.CHGACTION := 'DELETING';
          SAVE_CHANGES;

          -- породжуємо в історії запис про вставку
          l_rec.CHGACTION := 'INSERTING';
          SAVE_CHANGES;

        when (    
                :old.PRIORITY <> :new.PRIORITY OR (:old.PRIORITY IS NULL AND :new.PRIORITY IS NOT NULL) OR (:old.PRIORITY IS NOT NULL AND :new.PRIORITY IS NULL)
              or :old.F_BIG_AMOUNT <> :new.F_BIG_AMOUNT OR (:old.F_BIG_AMOUNT IS NULL AND :new.F_BIG_AMOUNT IS NOT NULL) OR (:old.F_BIG_AMOUNT IS NOT NULL AND :new.F_BIG_AMOUNT IS NULL)
              or :old.SQLVAL <> :new.SQLVAL OR (:old.SQLVAL IS NULL AND :new.SQLVAL IS NOT NULL) OR (:old.SQLVAL IS NOT NULL AND :new.SQLVAL IS NULL)
              or :old.F_IN_CHARGE <> :new.F_IN_CHARGE OR (:old.F_IN_CHARGE IS NULL AND :new.F_IN_CHARGE IS NOT NULL) OR (:old.F_IN_CHARGE IS NOT NULL AND :new.F_IN_CHARGE IS NULL)
              or :old.FLAGS <> :new.FLAGS OR (:old.FLAGS IS NULL AND :new.FLAGS IS NOT NULL) OR (:old.FLAGS IS NOT NULL AND :new.FLAGS IS NULL)
             )

        then 
          l_rec.CHGACTION := 'UPDATING';
          SAVE_CHANGES;
        else
          Null;
      end case;
    else
      null;
  end case;

end TAIUD_CHKLIST_TTS_UPDATE;
/
ALTER TRIGGER BARS.TAIUD_CHKLIST_TTS_UPDATE ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAIUD_CHKLIST_TTS_UPDATE.sql =======
PROMPT ===================================================================================== 
