

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TD_BE_LIBS.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TD_BE_LIBS ***

  CREATE OR REPLACE TRIGGER BARS.TD_BE_LIBS 
  BEFORE UPDATE OR DELETE ON BE_LIBS
FOR EACH ROW
DECLARE
  INS_DATE_ DATE;
BEGIN
  --Триггер ведения истории библиотек эталона БД
  --Версия 1.6

  SELECT SYSDATE INTO INS_DATE_ FROM DUAL;

  INSERT INTO BE_LIBS_ARC
    (PATH_NAME,DESCR,FILE_DATE,FILE_SIZE,VERSION,LINKS,CRITICAL,STATUS,INS_DATE,INS_USER,CHECK_SUM,
    INS_DATE_ORI,INS_USER_ORI)
  VALUES
    (:OLD.PATH_NAME,:OLD.DESCR,:OLD.FILE_DATE,:OLD.FILE_SIZE,:OLD.VERSION,:OLD.LINKS,:OLD.CRITICAL,
     2,INS_DATE_,:OLD.INS_USER,:OLD.CHECK_SUM,:OLD.INS_DATE,:OLD.INS_USER);

  INSERT INTO BE_LIBS_BODY_ARC ( PATH_NAME,INS_DATE,FILE_BODY )
  SELECT PATH_NAME,INS_DATE_,FILE_BODY FROM BE_LIBS_BODY
  WHERE PATH_NAME=:OLD.PATH_NAME;

  IF DELETING THEN
    DELETE FROM BE_LIBS_BODY WHERE PATH_NAME=:OLD.PATH_NAME;
  END IF;
END;
/
ALTER TRIGGER BARS.TD_BE_LIBS ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TD_BE_LIBS.sql =========*** End *** 
PROMPT ===================================================================================== 
