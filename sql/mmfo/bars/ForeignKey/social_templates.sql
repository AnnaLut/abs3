

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/SOCIAL_TEMPLATES.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_SOCTEMPLATES_DOCSCHEME ***
begin   
 execute immediate '
  ALTER TABLE BARS.SOCIAL_TEMPLATES ADD CONSTRAINT FK_SOCTEMPLATES_DOCSCHEME FOREIGN KEY (TEMPLATE_ID)
	  REFERENCES BARS.DOC_SCHEME (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SOCTEMPLATES_SOCIALDPTTYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.SOCIAL_TEMPLATES ADD CONSTRAINT FK_SOCTEMPLATES_SOCIALDPTTYPES FOREIGN KEY (TYPE_ID)
	  REFERENCES BARS.SOCIAL_DPT_TYPES (TYPE_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SOCTEMPLATES_DPTVIDDFLAGS ***
begin   
 execute immediate '
  ALTER TABLE BARS.SOCIAL_TEMPLATES ADD CONSTRAINT FK_SOCTEMPLATES_DPTVIDDFLAGS FOREIGN KEY (FLAG_ID)
	  REFERENCES BARS.DPT_VIDD_FLAGS (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/SOCIAL_TEMPLATES.sql =========***
PROMPT ===================================================================================== 
