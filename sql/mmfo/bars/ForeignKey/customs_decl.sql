

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/CUSTOMS_DECL.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_CUSTOMASDECL_CIMBRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMS_DECL ADD CONSTRAINT FK_CUSTOMASDECL_CIMBRANCH FOREIGN KEY (CIM_BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CUSTOMSDECL_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMS_DECL ADD CONSTRAINT FK_CUSTOMSDECL_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CUSTOMSDECL_ZAGMC ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMS_DECL ADD CONSTRAINT FK_CUSTOMSDECL_ZAGMC FOREIGN KEY (KF, FN, DAT)
	  REFERENCES BARS.ZAG_MC (KF, FN, DAT) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/CUSTOMS_DECL.sql =========*** End
PROMPT ===================================================================================== 
