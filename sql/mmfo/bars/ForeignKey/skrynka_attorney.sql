

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/SKRYNKA_ATTORNEY.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_SKR_ATTORN_REF_CUSTOMER ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ATTORNEY ADD CONSTRAINT FK_SKR_ATTORN_REF_CUSTOMER FOREIGN KEY (RNK)
	  REFERENCES BARS.CUSTOMER (RNK) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ATTORN_REF_SKRYNKA_ND ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ATTORNEY ADD CONSTRAINT FK_ATTORN_REF_SKRYNKA_ND FOREIGN KEY (ND)
	  REFERENCES BARS.SKRYNKA_ND (ND) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SKRYNKAATTORNEY_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ATTORNEY ADD CONSTRAINT FK_SKRYNKAATTORNEY_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SKRYNKAATTORNEY_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ATTORNEY ADD CONSTRAINT FK_SKRYNKAATTORNEY_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/SKRYNKA_ATTORNEY.sql =========***
PROMPT ===================================================================================== 
