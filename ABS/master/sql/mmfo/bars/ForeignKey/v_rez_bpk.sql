

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/V_REZ_BPK.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_VREZBPK_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.V_REZ_BPK ADD CONSTRAINT FK_VREZBPK_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_VREZBPK_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.V_REZ_BPK ADD CONSTRAINT FK_VREZBPK_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/V_REZ_BPK.sql =========*** End **
PROMPT ===================================================================================== 
