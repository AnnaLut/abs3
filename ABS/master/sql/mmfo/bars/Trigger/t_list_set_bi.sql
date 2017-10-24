

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/T_LIST_SET_BI.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  trigger T_LIST_SET_BI ***

  CREATE OR REPLACE TRIGGER BARS.T_LIST_SET_BI 
BEFORE
INSERT ON List_Set
FOR EACH ROW
DECLARE
        newid NUMBER(38);
BEGIN
  if :new.id is null then
    SELECT S_List_Set_PK.NEXTVAL INTO newid FROM DUAL;
    :new.Id := newid;
  end if;
END;




/
ALTER TRIGGER BARS.T_LIST_SET_BI ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/T_LIST_SET_BI.sql =========*** End *
PROMPT ===================================================================================== 
