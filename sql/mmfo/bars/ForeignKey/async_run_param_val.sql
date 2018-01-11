

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/ASYNC_RUN_PARAM_VAL.sql =========
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_ASNPRVAL_RUN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ASYNC_RUN_PARAM_VAL ADD CONSTRAINT FK_ASNPRVAL_RUN FOREIGN KEY (RUN_ID)
	  REFERENCES BARS.ASYNC_RUN (RUN_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ASNPRVL_PRM ***
begin   
 execute immediate '
  ALTER TABLE BARS.ASYNC_RUN_PARAM_VAL ADD CONSTRAINT FK_ASNPRVL_PRM FOREIGN KEY (PARAM_ID)
	  REFERENCES BARS.ASYNC_PARAM (PARAM_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/ASYNC_RUN_PARAM_VAL.sql =========
PROMPT ===================================================================================== 
