

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/SOCIAL_CONTRACTS.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_SOCIALCONTR_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.SOCIAL_CONTRACTS ADD CONSTRAINT FK_SOCIALCONTR_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SOCIALCONTR_CUSTOMER ***
begin   
 execute immediate '
  ALTER TABLE BARS.SOCIAL_CONTRACTS ADD CONSTRAINT FK_SOCIALCONTR_CUSTOMER FOREIGN KEY (RNK)
	  REFERENCES BARS.CUSTOMER (RNK) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SOCIALCONTR_SOCIALDPTTYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.SOCIAL_CONTRACTS ADD CONSTRAINT FK_SOCIALCONTR_SOCIALDPTTYPES FOREIGN KEY (TYPE_ID)
	  REFERENCES BARS.SOCIAL_DPT_TYPES (TYPE_ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SOCIALCONTR_SOCIALAGENCY ***
begin   
 execute immediate '
  ALTER TABLE BARS.SOCIAL_CONTRACTS ADD CONSTRAINT FK_SOCIALCONTR_SOCIALAGENCY FOREIGN KEY (AGENCY_ID)
	  REFERENCES BARS.SOCIAL_AGENCY (AGENCY_ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/SOCIAL_CONTRACTS.sql =========***
PROMPT ===================================================================================== 
