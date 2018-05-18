

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_CCK_CC_LIM_COPY.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_CCK_CC_LIM_COPY ***

 


BEGIN
  execute_immediate('CREATE SEQUENCE  BARS.S_CCK_CC_LIM_COPY  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 60601 CACHE 20 NOORDER  NOCYCLE');
exception when others then
  if sqlcode=-00955 then
    null;
  end if;
END;
/

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_CCK_CC_LIM_COPY.sql =========*** E
PROMPT ===================================================================================== 
