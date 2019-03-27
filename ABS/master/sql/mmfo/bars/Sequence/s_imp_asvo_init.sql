

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/IMP_ASVO_INIT.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  sequence IMP_ASVO_INIT ***

begin 
  execute immediate '
  CREATE SEQUENCE  BARS.IMP_ASVO_INIT  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE
';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/IMP_ASVO_INIT.sql =========*** End 
PROMPT ===================================================================================== 

