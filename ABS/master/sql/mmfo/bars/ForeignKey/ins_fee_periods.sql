

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/INS_FEE_PERIODS.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_FEEPRDS_FID_FEES ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_FEE_PERIODS ADD CONSTRAINT FK_FEEPRDS_FID_FEES FOREIGN KEY (FEE_ID, KF)
	  REFERENCES BARS.INS_FEES (ID, KF) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/INS_FEE_PERIODS.sql =========*** 
PROMPT ===================================================================================== 
