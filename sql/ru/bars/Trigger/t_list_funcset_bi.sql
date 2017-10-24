

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/T_LIST_FUNCSET_BI.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  trigger T_LIST_FUNCSET_BI ***

  CREATE OR REPLACE TRIGGER BARS.T_LIST_FUNCSET_BI 
BEFORE
INSERT ON List_FuncSet
FOR EACH ROW
    




DECLARE
        newid NUMBER(38);
    BEGIN
        SELECT S_List_FuncSet_PK.NEXTVAL
        INTO newid FROM DUAL;
        :new.Rec_Id := newid;
    END;

/
ALTER TRIGGER BARS.T_LIST_FUNCSET_BI ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/T_LIST_FUNCSET_BI.sql =========*** E
PROMPT ===================================================================================== 
