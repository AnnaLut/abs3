

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/PARAMS_VALIDATION.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_PARAMSVALIDATION_TAG ***
begin   
 execute immediate '
  ALTER TABLE BARS.PARAMS_VALIDATION ADD CONSTRAINT FK_PARAMSVALIDATION_TAG FOREIGN KEY (TAG)
	  REFERENCES BARS.OP_FIELD (TAG) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/PARAMS_VALIDATION.sql =========**
PROMPT ===================================================================================== 
