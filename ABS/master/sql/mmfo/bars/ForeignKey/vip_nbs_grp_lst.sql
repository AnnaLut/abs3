

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/VIP_NBS_GRP_LST.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_VIPNBSGRPLST_PS ***
begin   
 execute immediate '
  ALTER TABLE BARS.VIP_NBS_GRP_LST ADD CONSTRAINT FK_VIPNBSGRPLST_PS FOREIGN KEY (R020)
	  REFERENCES BARS.PS (NBS) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_VIPNBSGRPLST_GROUPSACC ***
begin   
 execute immediate '
  ALTER TABLE BARS.VIP_NBS_GRP_LST ADD CONSTRAINT FK_VIPNBSGRPLST_GROUPSACC FOREIGN KEY (GRP_ID)
	  REFERENCES BARS.GROUPS_ACC (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/VIP_NBS_GRP_LST.sql =========*** 
PROMPT ===================================================================================== 
