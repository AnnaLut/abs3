

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAID_REFERENCES.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAID_REFERENCES ***

  CREATE OR REPLACE TRIGGER BARS.TAID_REFERENCES 
   AFTER DELETE OR INSERT
   ON bars.references
   REFERENCING NEW AS NEW OLD AS OLD
   FOR EACH ROW
DECLARE
   job_    BINARY_INTEGER;
   what_   VARCHAR2 (32767);
BEGIN
   IF INSERTING
   THEN
      what_ :=
            'bars.web_refbooks_privileges(''GRANT'','
         || TO_CHAR (:NEW.tabid)
         || ');';
   ELSIF DELETING
   THEN
      what_ :=
            'bars.web_refbooks_privileges(''REVOKE'','
         || TO_CHAR (:OLD.tabid)
         || ');';
   END IF;
   -- создаем job
   SYS.DBMS_JOB.submit (job => job_, what => what_, next_date => SYSDATE);
END;
/
ALTER TRIGGER BARS.TAID_REFERENCES ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAID_REFERENCES.sql =========*** End
PROMPT ===================================================================================== 
