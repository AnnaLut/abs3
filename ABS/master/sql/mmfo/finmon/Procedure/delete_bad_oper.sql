

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/FINMON/Procedure/DELETE_BAD_OPER.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  procedure DELETE_BAD_OPER ***

  CREATE OR REPLACE PROCEDURE FINMON.DELETE_BAD_OPER (CUR_OPER_ID VARCHAR2)
IS
   I                NUMERIC;
   MAX_KL_ID        VARCHAR2 (9);
   IS_MAX_ID        VARCHAR2 (9);
   MAX_OPER_ID      VARCHAR2 (9);
   MAX_OPER_KL_ID   VARCHAR2 (9);
   CUR_OPER_KL_ID   VARCHAR2 (9);
   ERM              VARCHAR2 (80);
   ERN CONSTANT     POSITIVE := 666;
   ERR EXCEPTION;
BEGIN
   i := 0;

   SELECT   TO_NUMBER (KL_ID) INTO MAX_KL_ID FROM FINMON.SEQUENCE;

   SELECT   MAX (TO_NUMBER (ID))
     INTO   MAX_OPER_ID
     FROM   FINMON.OPER
    WHERE   BRANCH_ID = get_BRANCH_ID;

   SELECT   TO_NUMBER (KL_ID)
     INTO   MAX_OPER_KL_ID
     FROM   FINMON.OPER
    WHERE   BRANCH_ID = get_BRANCH_ID AND ID = MAX_OPER_ID;

   SELECT   TO_NUMBER (KL_ID)
     INTO   CUR_OPER_KL_ID
     FROM   FINMON.OPER
    WHERE   BRANCH_ID = get_BRANCH_ID AND ID = CUR_OPER_ID;

   --Проверяем что у нас не нарушена целостность списка !!!
   IF TO_NUMBER (MAX_KL_ID) != TO_NUMBER (MAX_OPER_KL_ID)
   THEN
      ERM := 'FATAL ERROR! FINMON.OPER.KL_ID != FINMON.SEQUENCE.KL_ID!';
      RAISE ERR;
   END IF;

   --Теперь проверим что у нас нет документов которые мы ужо умудрились отправить
   SELECT   MAX (TO_NUMBER (ID))
     INTO   IS_MAX_ID
     FROM   FINMON.OPER
    WHERE   ID > CUR_OPER_ID AND STATUS > 0 AND BRANCH_ID = get_BRANCH_ID;

   IF IS_MAX_ID != NULL
   THEN
      ERM :=
         'FATAL ERROR! Есть документы, которые были отправленны в банк. №'
         + IS_MAX_ID;
      RAISE ERR;
   END IF;

   IF (MAX_OPER_ID = CUR_OPER_ID)
   THEN
      BEGIN
         DELETE FROM   FINMON.PERSON_OPER
               WHERE   OPER_ID = CUR_OPER_ID AND BRANCH_ID = get_BRANCH_ID;

         DELETE FROM   FINMON.OPER_NOTES
               WHERE   OPER_ID = CUR_OPER_ID AND BRANCH_ID = get_BRANCH_ID;

         DELETE FROM   FINMON.OPER
               WHERE   ID = CUR_OPER_ID AND BRANCH_ID = get_BRANCH_ID;
      END;
   ELSE
      BEGIN
         FOR C
         IN (SELECT   o.id,
                      NVL (p.OPER_ID, -1) P_OPER_ID,
                      p.PERSON_ID,
                      p.CL_TYPE,
                      DOC_OSN,
                      p.PBANK_ID,
                      p.ACCOUNT,
                      NVL (n.OPER_ID, -1) N_OPER_ID,
                      n.NOTES,
                      n.HOLD_REF_NUM,
                      n.HOLD_REF_DATE,
                      n.HOLD_REF_BODY
               FROM         oper o
                         LEFT JOIN
                            finmon.person_oper p
                         ON (p.OPER_ID = o.ID AND p.BRANCH_ID = o.BRANCH_ID)
                      LEFT JOIN
                         finmon.OPER_NOTES n
                      ON (n.OPER_ID = o.ID AND p.BRANCH_ID = o.BRANCH_ID)
              WHERE   o.id = MAX_OPER_ID AND o.BRANCH_ID = get_BRANCH_ID)
         LOOP
            IF I = 0
            THEN
               DELETE FROM   FINMON.PERSON_OPER
                     WHERE   OPER_ID = CUR_OPER_ID
                             AND BRANCH_ID = get_BRANCH_ID;

               DELETE FROM   FINMON.PERSON_OPER
                     WHERE   OPER_ID = MAX_OPER_ID
                             AND BRANCH_ID = get_BRANCH_ID;

               DELETE FROM   FINMON.OPER_NOTES
                     WHERE   OPER_ID = CUR_OPER_ID
                             AND BRANCH_ID = get_BRANCH_ID;

               DELETE FROM   FINMON.OPER_NOTES
                     WHERE   OPER_ID = MAX_OPER_ID
                             AND BRANCH_ID = get_BRANCH_ID;

               DELETE FROM   FINMON.OPER
                     WHERE   ID = CUR_OPER_ID AND BRANCH_ID = get_BRANCH_ID;

               UPDATE   FINMON.OPER
                  SET   KL_ID = CUR_OPER_KL_ID, ID = CUR_OPER_ID
                WHERE   ID = MAX_OPER_ID AND BRANCH_ID = get_BRANCH_ID;

               IF (C.N_OPER_ID != -1)
               THEN
                  INSERT INTO OPER_NOTES (OPER_ID,
                                          NOTES,
                                          HOLD_REF_NUM,
                                          HOLD_REF_DATE,
                                          HOLD_REF_BODY)
                    VALUES   (CUR_OPER_ID,
                              C.NOTES,
                              C.HOLD_REF_NUM,
                              C.HOLD_REF_DATE,
                              C.HOLD_REF_BODY);
               END IF;
            END IF;

            IF (C.P_OPER_ID != -1)
            THEN
               INSERT INTO FINMON.PERSON_OPER (OPER_ID,
                                               PERSON_ID,
                                               CL_TYPE,
                                               DOC_OSN,
                                               PBANK_ID,
                                               ACCOUNT)
                 VALUES   (CUR_OPER_ID,
                           C.PERSON_ID,
                           C.CL_TYPE,
                           C.DOC_OSN,
                           C.PBANK_ID,
                           C.ACCOUNT);
            END IF;

            I := I + 1;
         END LOOP;
      END;
   END IF;

   IF CUR_OPER_KL_ID IS NOT NULL
   THEN
      UPDATE   FINMON.SEQUENCE
         SET   ID_OPER = (TO_NUMBER (ID_OPER) - 1),
               KL_ID = (TO_NUMBER (KL_ID) - 1);
   END IF;
EXCEPTION
   WHEN ERR
   THEN
      RAISE_APPLICATION_ERROR (- (20000 + ERN), '\' || ERM, TRUE);
   WHEN OTHERS
   THEN
      RAISE_APPLICATION_ERROR (- (20000 + ERN), SQLERRM, TRUE);
END;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/FINMON/Procedure/DELETE_BAD_OPER.sql =========***
PROMPT ===================================================================================== 
