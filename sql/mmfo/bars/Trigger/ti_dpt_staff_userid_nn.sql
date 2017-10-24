

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TI_DPT_STAFF_USERID_NN.sql =========
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TI_DPT_STAFF_USERID_NN ***

  CREATE OR REPLACE TRIGGER BARS.TI_DPT_STAFF_USERID_NN 
BEFORE INSERT ON DPT_STAFF
FOR EACH ROW
BEGIN
  -- �������, ����������� �������� DPT_STAFF.BRANCH �� ���� �������� DPT_STAFF.USERID
  IF ((:NEW.USERID IS NOT NULL) AND (:NEW.BRANCH IS NULL)) THEN
    SELECT BRANCH
      INTO :NEW.BRANCH
      FROM STAFF$BASE
     WHERE ID=:NEW.USERID;
  END IF;
END;


/
ALTER TRIGGER BARS.TI_DPT_STAFF_USERID_NN ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TI_DPT_STAFF_USERID_NN.sql =========
PROMPT ===================================================================================== 
