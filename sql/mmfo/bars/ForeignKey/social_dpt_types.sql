

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/SOCIAL_DPT_TYPES.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_SOCIALDPTTYPES_TIPS ***
begin   
 execute immediate '
  ALTER TABLE BARS.SOCIAL_DPT_TYPES ADD CONSTRAINT FK_SOCIALDPTTYPES_TIPS FOREIGN KEY (ACC_TYPE)
	  REFERENCES BARS.TIPS (TIP) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SOCIALDPTTYPES_DPTVIDD ***
begin   
 execute immediate '
  ALTER TABLE BARS.SOCIAL_DPT_TYPES ADD CONSTRAINT FK_SOCIALDPTTYPES_DPTVIDD FOREIGN KEY (DPT_VIDD)
	  REFERENCES BARS.DPT_VIDD (VIDD) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/SOCIAL_DPT_TYPES.sql =========***
PROMPT ===================================================================================== 
