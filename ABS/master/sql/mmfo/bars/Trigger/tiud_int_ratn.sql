

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIUD_INT_RATN.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIUD_INT_RATN ***

  CREATE OR REPLACE TRIGGER BARS.TIUD_INT_RATN 
after insert or delete or update of acc, id, bdat, ir, br, op
ON BARS.INT_RATN
for each row
 WHEN (
old.id<10 or new.id<10
      ) declare
  l_rec  INT_RATN_ARC%rowtype;
  ---
  procedure SAVE_CHANGES
  is
  begin

    if ( l_rec.VID = 'D' )
    then
        l_rec.ACC := :old.ACC;  l_rec.ID := :old.ID; l_rec.BDAT := :old.BDAT; l_rec.IR := :old.IR; l_rec.BR := :old.BR; l_rec.OP := :old.OP; l_rec.KF := :old.KF;
    else
        l_rec.ACC := :new.ACC;  l_rec.ID := :new.ID; l_rec.BDAT := :new.BDAT; l_rec.IR := :new.IR; l_rec.BR := :new.BR; l_rec.OP := :new.OP; l_rec.KF := :new.KF;
    end if;
    l_rec.IDUPD         := bars_sqnc.get_nextval('s_int_ratn_arc');
    l_rec.EFFECTDATE    := COALESCE(gl.bd, glb_bankdate);
    l_rec.GLOBAL_BDATE  := glb_bankdate;    -- sysdate
    l_rec.IDU           := gl.auid; --gl.aUID(NUMBER);    user_name(VARCHAR2);
    l_rec.fdat          := sysdate;

    insert into BARS.INT_RATN_ARC values l_rec;
    -- не понятно откуда идет удаление добавил лог COBUMMFO-9893
    logger.log_info(p_procedure_name => 'TIUD_INT_RATN'
                   ,p_log_message    => 'acc : ' || l_rec.acc || chr(10) ||
                                        'o   : ' || l_rec.VID || chr(10) ||
                                        dbms_utility.format_call_stack()
                   );    
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
        when (:old.acc <> :new.acc or :old.id <> :new.id or :old.bdat <> :new.bdat) -- !!! analize changing PRIMARY KEY - columns
        then -- При зміні значеннь полів, що входять в PRIMARY KEY (для правильного відображення при вивантаженні даних до DWH)

          -- породжуємо в історії запис про видалення
          l_rec.VID := 'D';
          SAVE_CHANGES;

          -- породжуємо в історії запис про вставку
          l_rec.VID := 'I';
          SAVE_CHANGES;

        when (
                   :old.IR <> :new.IR OR (:old.IR IS NULL AND :new.IR IS NOT NULL) OR (:old.IR IS NOT NULL AND :new.IR IS NULL)
                OR :old.BR <> :new.BR OR (:old.BR IS NULL AND :new.BR IS NOT NULL) OR (:old.BR IS NOT NULL AND :new.BR IS NULL)
                OR :old.OP <> :new.OP OR (:old.OP IS NULL AND :new.OP IS NOT NULL) OR (:old.OP IS NOT NULL AND :new.OP IS NULL)
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

end TIUD_INT_RATN;
/
ALTER TRIGGER BARS.TIUD_INT_RATN ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIUD_INT_RATN.sql =========*** End *
PROMPT ===================================================================================== 
