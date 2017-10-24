

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TS_NBU23_CCK_UL_KOR.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TS_NBU23_CCK_UL_KOR ***

  CREATE OR REPLACE TRIGGER BARS.TS_NBU23_CCK_UL_KOR BEFORE INSERT
ON Nbu23_Cck_Ul_Kor FOR EACH ROW
BEGIN
    :new."ID" := S_NBU23_CCK_UL_KOR.nextval;
END;
/
ALTER TRIGGER BARS.TS_NBU23_CCK_UL_KOR ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TS_NBU23_CCK_UL_KOR.sql =========***
PROMPT ===================================================================================== 
