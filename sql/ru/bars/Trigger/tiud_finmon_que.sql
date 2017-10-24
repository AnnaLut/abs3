

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIUD_FINMON_QUE.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIUD_FINMON_QUE ***

  CREATE OR REPLACE TRIGGER BARS.TIUD_FINMON_QUE 
    AFTER INSERT OR UPDATE OR DELETE ON FINMON_QUE
    FOR EACH ROW
-- Отслеживание событий изменения очереди экспорта в реестр Финансового
-- Мониторинга
DECLARE
    ID_       NUMBER(38);
    USERID_    NUMBER(38);
    USERNAME_  VARCHAR2(50);
    MODTYPE_   VARCHAR2(1);
    MODVALUE_  VARCHAR2(1000);
    NAME_      VARCHAR2(35);
    SUBST_     CONSTANT VARCHAR2(1) := CHR(255);
BEGIN
    USERID_ := USER_ID();
    BEGIN
        SELECT FIO INTO USERNAME_ FROM STAFF WHERE ID = USERID_;
    EXCEPTION WHEN NO_DATA_FOUND THEN
        USERNAME_ := 'UNKNOWN';
    END;

    IF    INSERTING THEN
        ID_ := :NEW.ID;
        MODTYPE_ := 'I';
    ELSIF DELETING OR (UPDATING AND :NEW.STATUS = 'B' AND :NEW.STATUS <> :OLD.STATUS) THEN
        ID_ := :OLD.ID;
        MODTYPE_ := 'D';
    ELSE
        ID_ := :NEW.ID;
        MODVALUE_ := '' ;
        IF :NEW.STATUS = :OLD.STATUS THEN
            MODTYPE_ := 'A';
        ELSE
            IF NVL(:NEW.OPR_VID2, SUBST_) = NVL(:OLD.OPR_VID2, SUBST_) AND
               NVL(:NEW.OPR_VID3, SUBST_) = NVL(:OLD.OPR_VID3, SUBST_) AND
               NVL(:NEW.COMM_VID2,SUBST_) = NVL(:OLD.COMM_VID2,SUBST_) AND
               NVL(:NEW.COMM_VID3,SUBST_) = NVL(:OLD.COMM_VID3,SUBST_) AND
               NVL(:NEW.OPR_VID1, SUBST_) = NVL(:OLD.OPR_VID1, SUBST_) AND
               NVL(:NEW.MONITOR_MODE,  0) = NVL(:OLD.MONITOR_MODE, 0 ) THEN
                 IF :NEW.STATUS = 'D' THEN
                     MODTYPE_ := 'P';
                 ELSE
                     MODTYPE_ := 'S';
                 END IF;
            ELSE
                 MODTYPE_ := 'F';
            END IF;
            SELECT name INTO NAME_ FROM finmon_que_status
            WHERE status=:OLD.STATUS ;
            MODVALUE_ := 'СТАТУС-''' || NAME_ || '''' ;
        END IF;

        IF NVL(:NEW.MONITOR_MODE,  0) <> NVL(:OLD.MONITOR_MODE, 0 ) AND
           :OLD.MONITOR_MODE is not null THEN
          NAME_ := '' ;
          IF :OLD.MONITOR_MODE = 0 THEN
            NAME_ := 'по МФО' ;
          ELSIF :OLD.MONITOR_MODE = 1 THEN
            NAME_ := 'сторона А' ;
          ELSIF :OLD.MONITOR_MODE = 2 THEN
            NAME_ := 'сторона Б' ;
          ELSIF :OLD.MONITOR_MODE = 3 THEN
            NAME_ := 'обидва' ;
          END IF;
          MODVALUE_:= Trim(MODVALUE_ || ' ' ||
            'РЕЖИМ МОНIТОРИНГУ-''' || NAME_ || '''' ) ;
        END IF;
        IF NVL(:NEW.OPR_VID2, SUBST_) <> NVL(:OLD.OPR_VID2, SUBST_) AND
           :OLD.OPR_VID2 is not null THEN
          MODVALUE_ := Trim( MODVALUE_|| ' ' ||
            'ОБОВ''ЯЗКОВИЙ МОНIТОРИНГ-''' || :OLD.OPR_VID2 || '''' ) ;
        END IF;
        IF NVL(:NEW.COMM_VID2,SUBST_) <> NVL(:OLD.COMM_VID2,SUBST_) AND
           :OLD.COMM_VID2 is not null THEN
          MODVALUE_ := Trim(MODVALUE_|| ' ' ||
            'КОМЕНТАР ОБОВ''ЯЗК. МОНIТОРИНГУ-''' || :OLD.COMM_VID2 || '''' ) ;
        END IF;
        IF NVL(:NEW.OPR_VID3, SUBST_) <> NVL(:OLD.OPR_VID3, SUBST_) AND
           :OLD.OPR_VID3 is not null THEN
          MODVALUE_ := Trim(MODVALUE_|| ' ' ||
            'ВНУТРIШНIЙ МОНIТОРИНГ-''' || :OLD.OPR_VID3 || '''' ) ;
        END IF;
        IF NVL(:NEW.COMM_VID3,SUBST_) <> NVL(:OLD.COMM_VID3,SUBST_) AND
           :OLD.COMM_VID3 is not null THEN
          MODVALUE_ := Trim(MODVALUE_|| ' ' ||
            'КОМЕНТАР ВНУТР. МОНIТОРИНГУ-''' || :OLD.COMM_VID3 || '''' ) ;
        END IF;
        IF NVL(:NEW.OPR_VID1, SUBST_) <> NVL(:OLD.OPR_VID1, SUBST_) AND
           :OLD.OPR_VID1 is not null THEN
          MODVALUE_ := Trim( MODVALUE_|| ' ' ||
            'КОД ВИДУ ФIН. ОПЕРАЦII-''' || :OLD.OPR_VID1 || '''' ) ;
        END IF;

    END IF;

    INSERT INTO FINMON_QUE_MODIFICATION (ID, MOD_DATE, MOD_TYPE, USER_ID, USER_NAME, MOD_VALUE)
    VALUES (ID_, SYSDATE, MODTYPE_, USERID_, USERNAME_, MODVALUE_);

END;
/
ALTER TRIGGER BARS.TIUD_FINMON_QUE ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIUD_FINMON_QUE.sql =========*** End
PROMPT ===================================================================================== 
