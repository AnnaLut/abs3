

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/PFU/Sequence/S_PFU_EPP_LINE_GUARDIAN.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_PFU_EPP_LINE_GUARDIAN ***

begin execute immediate'
   CREATE SEQUENCE  PFU.S_PFU_EPP_LINE_GUARDIAN  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE';
exception when others then  
  if sqlcode = -00955 then null;   else raise; end if;   
end;
/



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/PFU/Sequence/S_PFU_EPP_LINE_GUARDIAN.sql =========*** End 
PROMPT ===================================================================================== 
