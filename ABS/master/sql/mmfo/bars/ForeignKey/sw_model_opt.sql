

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/SW_MODEL_OPT.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_SWMODELOPT_SWOPT ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_MODEL_OPT ADD CONSTRAINT FK_SWMODELOPT_SWOPT FOREIGN KEY (OPT)
	  REFERENCES BARS.SW_OPT (OPT) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SWMODELOPT_SWMODEL ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_MODEL_OPT ADD CONSTRAINT FK_SWMODELOPT_SWMODEL FOREIGN KEY (MT, NUM)
	  REFERENCES BARS.SW_MODEL (MT, NUM) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/SW_MODEL_OPT.sql =========*** End
PROMPT ===================================================================================== 
