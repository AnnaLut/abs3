

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/SW_REG_DIRS.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_SWREGDIRS_CUSTOMER ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_REG_DIRS ADD CONSTRAINT FK_SWREGDIRS_CUSTOMER FOREIGN KEY (RNK)
	  REFERENCES BARS.CUSTOMER (RNK) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SWREGDIRS_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_REG_DIRS ADD CONSTRAINT FK_SWREGDIRS_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/SW_REG_DIRS.sql =========*** End 
PROMPT ===================================================================================== 
