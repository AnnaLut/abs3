

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/INS_TARIFF_PERIODS.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_TARIFFPRDS_TID_TARIFFS ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_TARIFF_PERIODS ADD CONSTRAINT FK_TARIFFPRDS_TID_TARIFFS FOREIGN KEY (TARIFF_ID, KF)
	  REFERENCES BARS.INS_TARIFFS (ID, KF) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/INS_TARIFF_PERIODS.sql =========*
PROMPT ===================================================================================== 
