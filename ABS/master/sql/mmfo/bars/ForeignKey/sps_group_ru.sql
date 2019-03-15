

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/SPS_GROUP_RU.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_SPS_GROUP_RU_UNION_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.SPS_GROUP_RU ADD CONSTRAINT FK_SPS_GROUP_RU_UNION_ID FOREIGN KEY (UNION_ID)
    REFERENCES BARS.SPS_UNION (UNION_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0027275 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SPS_GROUP_RU ADD FOREIGN KEY (RU)
    REFERENCES BARS.MV_KF (KF) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/SPS_GROUP_RU.sql =========*** End
PROMPT ===================================================================================== 
