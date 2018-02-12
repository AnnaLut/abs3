PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_CC_SWTRACE.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_CC_SWTRACE ***

begin 
  execute immediate '
  CREATE SEQUENCE  BARS.S_CC_SWTRACE
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 20';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
	end; 
/


PROMPT *** Create  grants  S_CC_SWTRACE ***
grant SELECT                                                                 on S_CC_SWTRACE to BARS_ACCESS_DEFROLE;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_CC_SWTRACE.sql =========*** End 
PROMPT ===================================================================================== 
