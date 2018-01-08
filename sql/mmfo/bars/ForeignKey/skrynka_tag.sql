

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/SKRYNKA_TAG.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_SKRYNKA_TAG_TAG ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_TAG ADD CONSTRAINT FK_SKRYNKA_TAG_TAG FOREIGN KEY (TAG)
	  REFERENCES BARS.CC_TAG (TAG) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SKRYNKA_TAG_CUSTTYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_TAG ADD CONSTRAINT FK_SKRYNKA_TAG_CUSTTYPE FOREIGN KEY (CUSTTYPE)
	  REFERENCES BARS.CUSTTYPE (CUSTTYPE) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/SKRYNKA_TAG.sql =========*** End 
PROMPT ===================================================================================== 
