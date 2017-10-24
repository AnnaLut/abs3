

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/FINMON/Trigger/TR_FM_SEQUENCE.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TR_FM_SEQUENCE ***

  CREATE OR REPLACE TRIGGER FINMON.TR_FM_SEQUENCE 
INSTEAD OF INSERT OR UPDATE OR DELETE ON FINMON.SEQUENCE FOR EACH ROW
DECLARE
FILEA_N_ NUMBER;
FILEA_DATE_ DATE;
FILEU_N_ NUMBER;
FILEU_DATE_ DATE;
FILED_N_ NUMBER;
FILED_DATE_ DATE;
FILEN_N_ NUMBER;
FILEN_DATE_ DATE;
FILEE_N_ NUMBER;
FILEE_DATE_ DATE;
FILE1_N_ NUMBER;
FILE1_DATE_ DATE;
FILE3_N_ NUMBER;
FILE3_DATE_ DATE;
FILE7_N_ NUMBER;
FILE7_DATE_ DATE;
FILE0_N_ NUMBER;
FILE0_DATE_ DATE;
--!!!!!!!!!!!!!!!!!!!!!!!!
FILEF_N_ NUMBER;
FILEF_DATE_ DATE;
FILEH_N_ NUMBER;
FILEH_DATE_ DATE;
FILEK_N_ NUMBER;
FILEK_DATE_ DATE;
FILEL_N_ NUMBER;
FILEL_DATE_ DATE;
--!!!!!!!!!!!!!!!!!!!!!!!!
ID_FILE_OUT_ NUMBER;
ID_FILE_IN_ NUMBER;
ID_BANK_ NUMBER;
ID_OPER_ NUMBER;
ID_USERS_ NUMBER;
ID_REQUEST_ NUMBER;
ID_PERSON_ NUMBER;
ID_DECISION_ NUMBER;
ID_PERSON_BANK_ NUMBER;
KL_ID_ NUMBER;
KL_ID_DATE_ DATE;
BRANCH_ID_ VARCHAR2(15);
IS_ACTIVE_ NUMBER;
BEGIN
    IF (DBMS_REPUTIL.FROM_REMOTE = FALSE AND DBMS_SNAPSHOT.I_AM_A_REFRESH = FALSE) THEN

        IF (INSERTING OR UPDATING) THEN

            IF (:NEW.BRANCH_ID != GET_BRANCH_ID) THEN
                RAISE_APPLICATION_ERROR(-20100, 'CANNOT MODIFY DATA FOR BRANCH(ES)');
            END IF;

        ELSE

            IF (:OLD.BRANCH_ID != GET_BRANCH_ID) THEN
                RAISE_APPLICATION_ERROR(-20100, 'CANNOT MODIFY DATA FOR BRANCH(ES)');
            END IF;

        END IF;

        --RAISE_APPLICATION_ERROR(-2001, '????!!!');
        IF DELETING THEN
            DELETE FROM SEQUENCE_FILE_PARAMS WHERE BRANCH_ID = :OLD.BRANCH_ID;
            DELETE FROM BRANCH_SEQUENCE WHERE BRANCH_ID = :OLD.BRANCH_ID;
        END IF;
        IF INSERTING THEN
            IF (:NEW.FILEA_N IS NULL) THEN FILEA_N_ := 1;
                                      ELSE FILEA_N_ := :NEW.FILEA_N;
            END IF;
            IF (:NEW.FILEA_DATE IS NULL) THEN FILEA_DATE_ := TRUNC(SYSDATE);
                                         ELSE FILEA_DATE_ := :NEW.FILEA_DATE;
            END IF;
            IF (:NEW.FILEU_N IS NULL) THEN FILEU_N_ := 1;
                                      ELSE FILEU_N_ := :NEW.FILEU_N;
            END IF;
            IF (:NEW.FILEU_DATE IS NULL) THEN FILEU_DATE_ := TRUNC(SYSDATE);
                                         ELSE FILEU_DATE_ := :NEW.FILEU_DATE;
            END IF;
            IF (:NEW.FILED_N IS NULL) THEN FILED_N_ := 1;
                                      ELSE FILED_N_ := :NEW.FILED_N;
            END IF;
            IF (:NEW.FILED_DATE IS NULL) THEN FILED_DATE_ := TRUNC(SYSDATE);
                                         ELSE FILED_DATE_ := :NEW.FILED_DATE;
            END IF;
            IF (:NEW.FILEN_N IS NULL) THEN FILEN_N_ := 1;
                                      ELSE FILEN_N_ := :NEW.FILEN_N;
            END IF;
            IF (:NEW.FILEN_DATE IS NULL) THEN FILEN_DATE_ := TRUNC(SYSDATE);
                                         ELSE FILEN_DATE_ := :NEW.FILEN_DATE;
            END IF;
            IF (:NEW.FILEE_N IS NULL) THEN FILEE_N_ := 1;
                                      ELSE FILEE_N_ := :NEW.FILEE_N;
            END IF;
            IF (:NEW.FILEE_DATE IS NULL) THEN FILEE_DATE_ := TRUNC(SYSDATE);
                                         ELSE FILEE_DATE_ := :NEW.FILEE_DATE;
            END IF;
            IF (:NEW.FILE1_N IS NULL) THEN FILE1_N_ := 1;
                                      ELSE FILE1_N_ := :NEW.FILE1_N;
            END IF;
            IF (:NEW.FILE1_DATE IS NULL) THEN FILE1_DATE_ := TRUNC(SYSDATE);
                                         ELSE FILE1_DATE_ := :NEW.FILE1_DATE;
            END IF;
            IF (:NEW.FILE3_N IS NULL) THEN FILE3_N_ := 1;
                                      ELSE FILE3_N_ := :NEW.FILE3_N;
            END IF;
            IF (:NEW.FILE3_DATE IS NULL) THEN FILE3_DATE_ := TRUNC(SYSDATE);
                                         ELSE FILE3_DATE_ := :NEW.FILE3_DATE;
            END IF;
            IF (:NEW.FILE7_N IS NULL) THEN FILE7_N_ := 1;
                                      ELSE FILE7_N_ := :NEW.FILE7_N;
            END IF;
            IF (:NEW.FILE7_DATE IS NULL) THEN FILE7_DATE_ := TRUNC(SYSDATE);
                                         ELSE FILE7_DATE_ := :NEW.FILE7_DATE;
            END IF;
            IF (:NEW.FILE0_N IS NULL) THEN FILE0_N_ := 1;
                                      ELSE FILE0_N_ := :NEW.FILE0_N;
            END IF;
            IF (:NEW.FILE0_DATE IS NULL) THEN FILE0_DATE_ := TRUNC(SYSDATE);
                             ELSE FILE0_DATE_ := :NEW.FILE0_DATE;
            END IF;
            --!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
            IF (:NEW.FILEF_N IS NULL) THEN FILEF_N_ := 1;
                                      ELSE FILE0_N_ := :NEW.FILEF_N;
            END IF;
            IF (:NEW.FILEF_DATE IS NULL) THEN FILEF_DATE_ := TRUNC(SYSDATE);
                             ELSE FILEF_DATE_ := :NEW.FILEF_DATE;
            END IF;
            IF (:NEW.FILEH_N IS NULL) THEN FILEH_N_ := 1;
                                      ELSE FILEH_N_ := :NEW.FILEH_N;
            END IF;
            IF (:NEW.FILEH_DATE IS NULL) THEN FILEH_DATE_ := TRUNC(SYSDATE);
                             ELSE FILEH_DATE_ := :NEW.FILEH_DATE;
            END IF;
            IF (:NEW.FILEK_N IS NULL) THEN FILEK_N_ := 1;
                                      ELSE FILEK_N_ := :NEW.FILEK_N;
            END IF;
            IF (:NEW.FILEK_DATE IS NULL) THEN FILEK_DATE_ := TRUNC(SYSDATE);
                             ELSE FILEK_DATE_ := :NEW.FILEK_DATE;
            END IF;
            IF (:NEW.FILEL_N IS NULL) THEN FILEL_N_ := 1;
                                      ELSE FILEL_N_ := :NEW.FILEL_N;
            END IF;
            IF (:NEW.FILEL_DATE IS NULL) THEN FILEL_DATE_ := TRUNC(SYSDATE);
                             ELSE FILEL_DATE_ := :NEW.FILEL_DATE;
            END IF;
            --!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
            IF (:NEW.ID_FILE_OUT IS NULL) THEN ID_FILE_OUT_ := 1;
                                          ELSE ID_FILE_OUT_ := :NEW.ID_FILE_OUT;
            END IF;
            IF (:NEW.ID_FILE_IN IS NULL) THEN ID_FILE_IN_ := 1;
                                         ELSE ID_FILE_IN_ := :NEW.ID_FILE_IN;
            END IF;
            IF (:NEW.ID_BANK IS NULL) THEN ID_BANK_ := 1;
                                      ELSE ID_BANK_ := :NEW.ID_BANK;
            END IF;
            IF (:NEW.ID_OPER IS NULL) THEN ID_OPER_ := 1;
                                      ELSE ID_OPER_ := :NEW.ID_OPER;
            END IF;
            IF (:NEW.ID_USERS IS NULL) THEN ID_USERS_ := 1;
                                       ELSE ID_USERS_ := :NEW.ID_USERS;
            END IF;
            IF (:NEW.ID_REQUEST IS NULL) THEN ID_REQUEST_ := 1;
                                         ELSE ID_REQUEST_ := :NEW.ID_REQUEST;
            END IF;
            IF (:NEW.ID_PERSON IS NULL) THEN ID_PERSON_ := 1;
                                        ELSE ID_PERSON_ := :NEW.ID_PERSON;
            END IF;
            IF (:NEW.ID_DECISION IS NULL) THEN ID_DECISION_ := 1;
                                        ELSE ID_DECISION_ := :NEW.ID_DECISION;
            END IF;
            IF (:NEW.ID_PERSON_BANK IS NULL) THEN ID_PERSON_BANK_ := 1;
                                             ELSE ID_PERSON_BANK_ := :NEW.ID_PERSON_BANK;
            END IF;
            IF (:NEW.KL_ID IS NULL) THEN KL_ID_ := 1;
                                    ELSE KL_ID_ := :NEW.KL_ID;
            END IF;
            IF (:NEW.KL_ID_DATE IS NULL) THEN KL_ID_DATE_ := TRUNC(SYSDATE);
                                         ELSE KL_ID_DATE_ := :NEW.KL_ID_DATE;
            END IF;
            IF (:NEW.BRANCH_ID IS NULL) THEN
                SELECT NVL((SELECT MAX(TO_NUMBER(BRANCH_ID))
                  FROM FINMON.BRANCH_SEQUENCE), 0)
                  INTO BRANCH_ID_
                  FROM DUAL;
            ELSE BRANCH_ID_ := :NEW.BRANCH_ID;
            END IF;
            IF (:NEW.IS_ACTIVE IS NULL) THEN IS_ACTIVE_ := 1;
                                        ELSE IS_ACTIVE_ := :NEW.IS_ACTIVE;
            END IF;

            INSERT INTO FINMON.BRANCH_SEQUENCE(ID_FILE_OUT, ID_FILE_IN, ID_BANK, ID_OPER, ID_USERS, ID_REQUEST,
                                               ID_PERSON, ID_PERSON_BANK, KL_ID, KL_ID_DATE, BRANCH_ID, IS_ACTIVE)
            VALUES(ID_FILE_OUT_, ID_FILE_IN_, ID_BANK_, ID_OPER_, ID_USERS_, ID_REQUEST_,
                   ID_PERSON_, ID_PERSON_BANK_, KL_ID_, KL_ID_DATE_, BRANCH_ID_, IS_ACTIVE_);

            INSERT INTO SEQUENCE_FILE_PARAMS(BRANCH_ID, PAR, VAL, COMM) VALUES(BRANCH_ID_, 'FILEA_N', FILEA_N_, '');
            INSERT INTO SEQUENCE_FILE_PARAMS(BRANCH_ID, PAR, VAL, COMM) VALUES(BRANCH_ID_, 'FILEA_DATE', TO_CHAR(FILEA_DATE_, 'YYYY-MM-DD'), '');
            INSERT INTO SEQUENCE_FILE_PARAMS(BRANCH_ID, PAR, VAL, COMM) VALUES(BRANCH_ID_, 'FILEU_N', FILEU_N_, '');
            INSERT INTO SEQUENCE_FILE_PARAMS(BRANCH_ID, PAR, VAL, COMM) VALUES(BRANCH_ID_, 'FILEU_DATE', TO_CHAR(FILEU_DATE_, 'YYYY-MM-DD'), '');
            INSERT INTO SEQUENCE_FILE_PARAMS(BRANCH_ID, PAR, VAL, COMM) VALUES(BRANCH_ID_, 'FILED_N', FILED_N_, '');
            INSERT INTO SEQUENCE_FILE_PARAMS(BRANCH_ID, PAR, VAL, COMM) VALUES(BRANCH_ID_, 'FILED_DATE', TO_CHAR(FILED_DATE_, 'YYYY-MM-DD'), '');
            INSERT INTO SEQUENCE_FILE_PARAMS(BRANCH_ID, PAR, VAL, COMM) VALUES(BRANCH_ID_, 'FILEN_N', FILEN_N_, '');
            INSERT INTO SEQUENCE_FILE_PARAMS(BRANCH_ID, PAR, VAL, COMM) VALUES(BRANCH_ID_, 'FILEN_DATE', TO_CHAR(FILEN_DATE_, 'YYYY-MM-DD'), '');
            INSERT INTO SEQUENCE_FILE_PARAMS(BRANCH_ID, PAR, VAL, COMM) VALUES(BRANCH_ID_, 'FILEE_N', FILEE_N_, '');
            INSERT INTO SEQUENCE_FILE_PARAMS(BRANCH_ID, PAR, VAL, COMM) VALUES(BRANCH_ID_, 'FILEE_DATE', TO_CHAR(FILEE_DATE_, 'YYYY-MM-DD'), '');
            INSERT INTO SEQUENCE_FILE_PARAMS(BRANCH_ID, PAR, VAL, COMM) VALUES(BRANCH_ID_, 'FILE1_N', FILE1_N_, '');
            INSERT INTO SEQUENCE_FILE_PARAMS(BRANCH_ID, PAR, VAL, COMM) VALUES(BRANCH_ID_, 'FILE1_DATE', TO_CHAR(FILE1_DATE_, 'YYYY-MM-DD'), '');
            INSERT INTO SEQUENCE_FILE_PARAMS(BRANCH_ID, PAR, VAL, COMM) VALUES(BRANCH_ID_, 'FILE3_N', FILE3_N_, '');
            INSERT INTO SEQUENCE_FILE_PARAMS(BRANCH_ID, PAR, VAL, COMM) VALUES(BRANCH_ID_, 'FILE3_DATE', TO_CHAR(FILE3_DATE_, 'YYYY-MM-DD'), '');
            INSERT INTO SEQUENCE_FILE_PARAMS(BRANCH_ID, PAR, VAL, COMM) VALUES(BRANCH_ID_, 'FILE7_N', FILE7_N_, '');
            INSERT INTO SEQUENCE_FILE_PARAMS(BRANCH_ID, PAR, VAL, COMM) VALUES(BRANCH_ID_, 'FILE7_DATE', TO_CHAR(FILE7_DATE_, 'YYYY-MM-DD'), '');
            INSERT INTO SEQUENCE_FILE_PARAMS(BRANCH_ID, PAR, VAL, COMM) VALUES(BRANCH_ID_, 'FILE0_N', FILE0_N_, '');
            INSERT INTO SEQUENCE_FILE_PARAMS(BRANCH_ID, PAR, VAL, COMM) VALUES(BRANCH_ID_, 'FILE0_DATE', TO_CHAR(FILE0_DATE_, 'YYYY-MM-DD'), '');
            --!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
            INSERT INTO SEQUENCE_FILE_PARAMS(BRANCH_ID, PAR, VAL, COMM) VALUES(BRANCH_ID_, 'FILEF_N', FILEF_N_, '');
            INSERT INTO SEQUENCE_FILE_PARAMS(BRANCH_ID, PAR, VAL, COMM) VALUES(BRANCH_ID_, 'FILEF_DATE', TO_CHAR(FILEF_DATE_, 'YYYY-MM-DD'), '');
            INSERT INTO SEQUENCE_FILE_PARAMS(BRANCH_ID, PAR, VAL, COMM) VALUES(BRANCH_ID_, 'FILEH_N', FILEH_N_, '');
            INSERT INTO SEQUENCE_FILE_PARAMS(BRANCH_ID, PAR, VAL, COMM) VALUES(BRANCH_ID_, 'FILEH_DATE', TO_CHAR(FILEH_DATE_, 'YYYY-MM-DD'), '');
            INSERT INTO SEQUENCE_FILE_PARAMS(BRANCH_ID, PAR, VAL, COMM) VALUES(BRANCH_ID_, 'FILEK_N', FILEK_N_, '');
            INSERT INTO SEQUENCE_FILE_PARAMS(BRANCH_ID, PAR, VAL, COMM) VALUES(BRANCH_ID_, 'FILEK_DATE', TO_CHAR(FILEK_DATE_, 'YYYY-MM-DD'), '');
            INSERT INTO SEQUENCE_FILE_PARAMS(BRANCH_ID, PAR, VAL, COMM) VALUES(BRANCH_ID_, 'FILEL_N', FILEL_N_, '');
            INSERT INTO SEQUENCE_FILE_PARAMS(BRANCH_ID, PAR, VAL, COMM) VALUES(BRANCH_ID_, 'FILEL_DATE', TO_CHAR(FILEL_DATE_, 'YYYY-MM-DD'), '');
            --!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
            INSERT INTO SEQUENCE_FILE_PARAMS(BRANCH_ID, PAR, VAL, COMM) VALUES(BRANCH_ID_, 'ID_DECISION', ID_DECISION_, '');

        END IF;
        IF UPDATING THEN
            IF :NEW.FILEA_N != :OLD.FILEA_N THEN
                begin
                    INSERT INTO SEQUENCE_FILE_PARAMS(BRANCH_ID, PAR, VAL, COMM) VALUES(:NEW.BRANCH_ID, 'FILEA_N', :NEW.FILEA_N, '');
                exception WHEN OTHERS THEN
                    UPDATE SEQUENCE_FILE_PARAMS SET VAL = :NEW.FILEA_N WHERE BRANCH_ID = :NEW.BRANCH_ID AND PAR = 'FILEA_N';
                end;
            END IF;
            IF :NEW.FILEA_DATE != :OLD.FILEA_DATE THEN
                begin
                    INSERT INTO SEQUENCE_FILE_PARAMS(BRANCH_ID, PAR, VAL, COMM) VALUES(:NEW.BRANCH_ID, 'FILEA_DATE', TO_CHAR(:NEW.FILEA_DATE, 'YYYY-MM-DD'), '');
                exception WHEN OTHERS THEN
                    UPDATE SEQUENCE_FILE_PARAMS SET VAL = TO_CHAR(:NEW.FILEA_DATE, 'YYYY-MM-DD') WHERE BRANCH_ID = :NEW.BRANCH_ID AND PAR = 'FILEA_DATE';
                end;
            END IF;
            IF :NEW.FILEU_N != :OLD.FILEU_N THEN
                begin
                    INSERT INTO SEQUENCE_FILE_PARAMS(BRANCH_ID, PAR, VAL, COMM) VALUES(:NEW.BRANCH_ID, 'FILEU_N', :NEW.FILEU_N, '');
                exception WHEN OTHERS THEN
                    UPDATE SEQUENCE_FILE_PARAMS SET VAL = :NEW.FILEU_N WHERE BRANCH_ID = :NEW.BRANCH_ID AND PAR = 'FILEU_N';
                end;
            END IF;
            IF :NEW.FILEU_DATE != :OLD.FILEU_DATE THEN
                begin
                    INSERT INTO SEQUENCE_FILE_PARAMS(BRANCH_ID, PAR, VAL, COMM) VALUES(:NEW.BRANCH_ID, 'FILEU_DATE', TO_CHAR(:NEW.FILEU_DATE, 'YYYY-MM-DD'), '');
                exception WHEN OTHERS THEN
                    UPDATE SEQUENCE_FILE_PARAMS SET VAL = TO_CHAR(:NEW.FILEU_DATE, 'YYYY-MM-DD') WHERE BRANCH_ID = :NEW.BRANCH_ID AND PAR = 'FILEU_DATE';
                end;
            END IF;
            IF :NEW.FILED_N != :OLD.FILED_N THEN
                begin
                    INSERT INTO SEQUENCE_FILE_PARAMS(BRANCH_ID, PAR, VAL, COMM) VALUES(:NEW.BRANCH_ID, 'FILED_N', :NEW.FILED_N, '');
                exception WHEN OTHERS THEN
                    UPDATE SEQUENCE_FILE_PARAMS SET VAL = :NEW.FILED_N WHERE BRANCH_ID = :NEW.BRANCH_ID AND PAR = 'FILED_N';
                end;
            END IF;
            IF :NEW.FILED_DATE != :OLD.FILED_DATE THEN
                begin
                    INSERT INTO SEQUENCE_FILE_PARAMS(BRANCH_ID, PAR, VAL, COMM) VALUES(:NEW.BRANCH_ID, 'FILED_DATE', TO_CHAR(:NEW.FILED_DATE, 'YYYY-MM-DD'), '');
                exception WHEN OTHERS THEN
                    UPDATE SEQUENCE_FILE_PARAMS SET VAL = TO_CHAR(:NEW.FILED_DATE, 'YYYY-MM-DD') WHERE BRANCH_ID = :NEW.BRANCH_ID AND PAR = 'FILED_DATE';
                end;
            END IF;
            IF :NEW.FILEN_N != :OLD.FILEN_N THEN
                begin
                    INSERT INTO SEQUENCE_FILE_PARAMS(BRANCH_ID, PAR, VAL, COMM) VALUES(:NEW.BRANCH_ID, 'FILEN_N', :NEW.FILEN_N, '');
                exception WHEN OTHERS THEN
                    UPDATE SEQUENCE_FILE_PARAMS SET VAL = :NEW.FILEN_N WHERE BRANCH_ID = :NEW.BRANCH_ID AND PAR = 'FILEN_N';
                end;
            END IF;
            IF :NEW.FILEN_DATE != :OLD.FILEN_DATE THEN
                begin
                    INSERT INTO SEQUENCE_FILE_PARAMS(BRANCH_ID, PAR, VAL, COMM) VALUES(:NEW.BRANCH_ID, 'FILEN_DATE', TO_CHAR(:NEW.FILEN_DATE, 'YYYY-MM-DD'), '');
                exception WHEN OTHERS THEN
                    UPDATE SEQUENCE_FILE_PARAMS SET VAL = TO_CHAR(:NEW.FILEN_DATE, 'YYYY-MM-DD') WHERE BRANCH_ID = :NEW.BRANCH_ID AND PAR = 'FILEN_DATE';
                end;
            END IF;
            IF :NEW.FILEE_N != :OLD.FILEE_N THEN
                begin
                    INSERT INTO SEQUENCE_FILE_PARAMS(BRANCH_ID, PAR, VAL, COMM) VALUES(:NEW.BRANCH_ID, 'FILEE_N', :NEW.FILEE_N, '');
                exception WHEN OTHERS THEN
                    UPDATE SEQUENCE_FILE_PARAMS SET VAL = :NEW.FILEE_N WHERE BRANCH_ID = :NEW.BRANCH_ID AND PAR = 'FILEE_N';
                end;
            END IF;
            IF :NEW.FILEE_DATE != :OLD.FILEE_DATE THEN
                begin
                    INSERT INTO SEQUENCE_FILE_PARAMS(BRANCH_ID, PAR, VAL, COMM) VALUES(:NEW.BRANCH_ID, 'FILEE_DATE', TO_CHAR(:NEW.FILEE_DATE, 'YYYY-MM-DD'), '');
                exception WHEN OTHERS THEN
                    UPDATE SEQUENCE_FILE_PARAMS SET VAL = TO_CHAR(:NEW.FILEE_DATE, 'YYYY-MM-DD') WHERE BRANCH_ID = :NEW.BRANCH_ID AND PAR = 'FILEE_DATE';
                end;
            END IF;
            IF :NEW.FILE1_N != :OLD.FILE1_N THEN
                begin
                    INSERT INTO SEQUENCE_FILE_PARAMS(BRANCH_ID, PAR, VAL, COMM) VALUES(:NEW.BRANCH_ID, 'FILE1_N', :NEW.FILE1_N, '');
                exception WHEN OTHERS THEN
                    UPDATE SEQUENCE_FILE_PARAMS SET VAL = :NEW.FILE1_N WHERE BRANCH_ID = :NEW.BRANCH_ID AND PAR = 'FILE1_N';
                end;
            END IF;
            IF :NEW.FILE1_DATE != :OLD.FILE1_DATE THEN
                begin
                    INSERT INTO SEQUENCE_FILE_PARAMS(BRANCH_ID, PAR, VAL, COMM) VALUES(:NEW.BRANCH_ID, 'FILE1_DATE', TO_CHAR(:NEW.FILE1_DATE, 'YYYY-MM-DD'), '');
                exception WHEN OTHERS THEN
                    UPDATE SEQUENCE_FILE_PARAMS SET VAL = TO_CHAR(:NEW.FILE1_DATE, 'YYYY-MM-DD') WHERE BRANCH_ID = :NEW.BRANCH_ID AND PAR = 'FILE1_DATE';
                end;
            END IF;
            IF :NEW.FILE3_N != :OLD.FILE3_N THEN
                begin
                    INSERT INTO SEQUENCE_FILE_PARAMS(BRANCH_ID, PAR, VAL, COMM) VALUES(:NEW.BRANCH_ID, 'FILE3_N', :NEW.FILE3_N, '');
                exception WHEN OTHERS THEN
                    UPDATE SEQUENCE_FILE_PARAMS SET VAL = :NEW.FILE3_N WHERE BRANCH_ID = :NEW.BRANCH_ID AND PAR = 'FILE3_N';
                end;
            END IF;
            IF :NEW.FILE3_DATE != :OLD.FILE3_DATE THEN
                begin
                    INSERT INTO SEQUENCE_FILE_PARAMS(BRANCH_ID, PAR, VAL, COMM) VALUES(:NEW.BRANCH_ID, 'FILE3_DATE', TO_CHAR(:NEW.FILE3_DATE, 'YYYY-MM-DD'), '');
                exception WHEN OTHERS THEN
                    UPDATE SEQUENCE_FILE_PARAMS SET VAL = TO_CHAR(:NEW.FILE3_DATE, 'YYYY-MM-DD') WHERE BRANCH_ID = :NEW.BRANCH_ID AND PAR = 'FILE3_DATE';
                end;
            END IF;
            IF :NEW.FILE7_N != :OLD.FILE7_N THEN
                begin
                    INSERT INTO SEQUENCE_FILE_PARAMS(BRANCH_ID, PAR, VAL, COMM) VALUES(:NEW.BRANCH_ID, 'FILE7_N', :NEW.FILE7_N, '');
                exception WHEN OTHERS THEN
                    UPDATE SEQUENCE_FILE_PARAMS SET VAL = :NEW.FILE7_N WHERE BRANCH_ID = :NEW.BRANCH_ID AND PAR = 'FILE7_N';
                end;
            END IF;
            IF :NEW.FILE7_DATE != :OLD.FILE7_DATE THEN
                begin
                    INSERT INTO SEQUENCE_FILE_PARAMS(BRANCH_ID, PAR, VAL, COMM) VALUES(:NEW.BRANCH_ID, 'FILE7_DATE', TO_CHAR(:NEW.FILE7_DATE, 'YYYY-MM-DD'), '');
                exception WHEN OTHERS THEN
                    UPDATE SEQUENCE_FILE_PARAMS SET VAL = TO_CHAR(:NEW.FILE7_DATE, 'YYYY-MM-DD') WHERE BRANCH_ID = :NEW.BRANCH_ID AND PAR = 'FILE7_DATE';
                end;
            END IF;
            IF :NEW.FILE0_N != :OLD.FILE0_N THEN
                begin
                    INSERT INTO SEQUENCE_FILE_PARAMS(BRANCH_ID, PAR, VAL, COMM) VALUES(:NEW.BRANCH_ID, 'FILE0_N', :NEW.FILE0_N, '');
                exception WHEN OTHERS THEN
                    UPDATE SEQUENCE_FILE_PARAMS SET VAL = :NEW.FILE0_N WHERE BRANCH_ID = :NEW.BRANCH_ID AND PAR = 'FILE0_N';
                end;
            END IF;
            IF :NEW.FILE0_DATE != :OLD.FILE0_DATE THEN
                begin
                    INSERT INTO SEQUENCE_FILE_PARAMS(BRANCH_ID, PAR, VAL, COMM) VALUES(:NEW.BRANCH_ID, 'FILE0_DATE', TO_CHAR(:NEW.FILE0_DATE, 'YYYY-MM-DD'), '');
                exception WHEN OTHERS THEN
                    UPDATE SEQUENCE_FILE_PARAMS SET VAL = TO_CHAR(:NEW.FILE0_DATE, 'YYYY-MM-DD') WHERE BRANCH_ID = :NEW.BRANCH_ID AND PAR = 'FILE0_DATE';
                end;
            END IF;
            --!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
            IF :NEW.FILEF_N != :OLD.FILEF_N THEN
                begin
                    INSERT INTO SEQUENCE_FILE_PARAMS(BRANCH_ID, PAR, VAL, COMM) VALUES(:NEW.BRANCH_ID, 'FILEF_N', :NEW.FILEF_N, '');
                exception WHEN OTHERS THEN
                    UPDATE SEQUENCE_FILE_PARAMS SET VAL = :NEW.FILEF_N WHERE BRANCH_ID = :NEW.BRANCH_ID AND PAR = 'FILEF_N';
                end;
            END IF;
            IF :NEW.FILEF_DATE != :OLD.FILEF_DATE THEN
                begin
                    INSERT INTO SEQUENCE_FILE_PARAMS(BRANCH_ID, PAR, VAL, COMM) VALUES(:NEW.BRANCH_ID, 'FILEF_DATE', TO_CHAR(:NEW.FILEF_DATE, 'YYYY-MM-DD'), '');
                exception WHEN OTHERS THEN
                    UPDATE SEQUENCE_FILE_PARAMS SET VAL = TO_CHAR(:NEW.FILEF_DATE, 'YYYY-MM-DD') WHERE BRANCH_ID = :NEW.BRANCH_ID AND PAR = 'FILEF_DATE';
                end;
            END IF;
            IF :NEW.FILEH_N != :OLD.FILEH_N THEN
                begin
                    INSERT INTO SEQUENCE_FILE_PARAMS(BRANCH_ID, PAR, VAL, COMM) VALUES(:NEW.BRANCH_ID, 'FILEH_N', :NEW.FILEH_N, '');
                exception WHEN OTHERS THEN
                    UPDATE SEQUENCE_FILE_PARAMS SET VAL = :NEW.FILEH_N WHERE BRANCH_ID = :NEW.BRANCH_ID AND PAR = 'FILEH_N';
                end;
            END IF;
            IF :NEW.FILEH_DATE != :OLD.FILEH_DATE THEN
                begin
                    INSERT INTO SEQUENCE_FILE_PARAMS(BRANCH_ID, PAR, VAL, COMM) VALUES(:NEW.BRANCH_ID, 'FILEH_DATE', TO_CHAR(:NEW.FILEH_DATE, 'YYYY-MM-DD'), '');
                exception WHEN OTHERS THEN
                    UPDATE SEQUENCE_FILE_PARAMS SET VAL = TO_CHAR(:NEW.FILEH_DATE, 'YYYY-MM-DD') WHERE BRANCH_ID = :NEW.BRANCH_ID AND PAR = 'FILEH_DATE';
                end;
            END IF;
            IF :NEW.FILEK_N != :OLD.FILEK_N THEN
                begin
                    INSERT INTO SEQUENCE_FILE_PARAMS(BRANCH_ID, PAR, VAL, COMM) VALUES(:NEW.BRANCH_ID, 'FILEK_N', :NEW.FILEK_N, '');
                exception WHEN OTHERS THEN
                    UPDATE SEQUENCE_FILE_PARAMS SET VAL = :NEW.FILEK_N WHERE BRANCH_ID = :NEW.BRANCH_ID AND PAR = 'FILEK_N';
                end;
            END IF;
            IF :NEW.FILEK_DATE != :OLD.FILEK_DATE THEN
                begin
                    INSERT INTO SEQUENCE_FILE_PARAMS(BRANCH_ID, PAR, VAL, COMM) VALUES(:NEW.BRANCH_ID, 'FILEK_DATE', TO_CHAR(:NEW.FILEK_DATE, 'YYYY-MM-DD'), '');
                exception WHEN OTHERS THEN
                    UPDATE SEQUENCE_FILE_PARAMS SET VAL = TO_CHAR(:NEW.FILEK_DATE, 'YYYY-MM-DD') WHERE BRANCH_ID = :NEW.BRANCH_ID AND PAR = 'FILEK_DATE';
                end;
            END IF;
            IF :NEW.FILEL_N != :OLD.FILEL_N THEN
                begin
                    INSERT INTO SEQUENCE_FILE_PARAMS(BRANCH_ID, PAR, VAL, COMM) VALUES(:NEW.BRANCH_ID, 'FILEL_N', :NEW.FILEL_N, '');
                exception WHEN OTHERS THEN
                    UPDATE SEQUENCE_FILE_PARAMS SET VAL = :NEW.FILEL_N WHERE BRANCH_ID = :NEW.BRANCH_ID AND PAR = 'FILEL_N';
                end;
            END IF;
            IF :NEW.FILEL_DATE != :OLD.FILEL_DATE THEN
                begin
                    INSERT INTO SEQUENCE_FILE_PARAMS(BRANCH_ID, PAR, VAL, COMM) VALUES(:NEW.BRANCH_ID, 'FILEL_DATE', TO_CHAR(:NEW.FILEL_DATE, 'YYYY-MM-DD'), '');
                exception WHEN OTHERS THEN
                    UPDATE SEQUENCE_FILE_PARAMS SET VAL = TO_CHAR(:NEW.FILEL_DATE, 'YYYY-MM-DD') WHERE BRANCH_ID = :NEW.BRANCH_ID AND PAR = 'FILEL_DATE';
                end;
            END IF;
            --!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
            IF :NEW.ID_DECISION != :OLD.ID_DECISION THEN
                begin
                    INSERT INTO SEQUENCE_FILE_PARAMS(BRANCH_ID, PAR, VAL, COMM) VALUES(:NEW.BRANCH_ID, 'ID_DECISION', :NEW.ID_DECISION, '');
                exception WHEN OTHERS THEN
                    UPDATE SEQUENCE_FILE_PARAMS SET VAL = :NEW.ID_DECISION WHERE BRANCH_ID = :NEW.BRANCH_ID AND PAR = 'ID_DECISION';
                end;
            END IF;
            --------------------------------------------------------------------------------
            IF (:NEW.ID_FILE_OUT    != :OLD.ID_FILE_OUT)OR
               (:NEW.ID_FILE_IN     != :OLD.ID_FILE_IN)OR
               (:NEW.ID_BANK        != :OLD.ID_BANK)OR
               (:NEW.ID_OPER        != :OLD.ID_OPER)OR
               (:NEW.ID_USERS       != :OLD.ID_USERS)OR
               (:NEW.ID_REQUEST     != :OLD.ID_REQUEST)OR
               (:NEW.ID_PERSON      != :OLD.ID_PERSON)OR
               (:NEW.ID_PERSON_BANK != :OLD.ID_PERSON_BANK)OR
               (:NEW.KL_ID          != :OLD.KL_ID)OR
               (:NEW.KL_ID_DATE     != :OLD.KL_ID_DATE)OR
               (:NEW.IS_ACTIVE      != :OLD.IS_ACTIVE)THEN
                UPDATE BRANCH_SEQUENCE SET ID_FILE_OUT    = :NEW.ID_FILE_OUT,
                                           ID_FILE_IN     = :NEW.ID_FILE_IN,
                                           ID_BANK        = :NEW.ID_BANK,
                                           ID_OPER        = :NEW.ID_OPER,
                                           ID_USERS       = :NEW.ID_USERS,
                                           ID_REQUEST     = :NEW.ID_REQUEST,
                                           ID_PERSON      = :NEW.ID_PERSON,
                                           ID_PERSON_BANK = :NEW.ID_PERSON_BANK,
                                           KL_ID          = :NEW.KL_ID,
                                           KL_ID_DATE     = :NEW.KL_ID_DATE,
                                           IS_ACTIVE      = :NEW.IS_ACTIVE
                 WHERE BRANCH_ID = :NEW.BRANCH_ID;
            END IF;
            --------------------------------------------------------------------------------
        END IF;
    ELSIF (DBMS_REPUTIL.FROM_REMOTE = TRUE) THEN
          NULL;
    END IF;
END;
/
ALTER TRIGGER FINMON.TR_FM_SEQUENCE ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/FINMON/Trigger/TR_FM_SEQUENCE.sql =========*** En
PROMPT ===================================================================================== 
