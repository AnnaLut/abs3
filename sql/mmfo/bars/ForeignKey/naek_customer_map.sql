

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/NAEK_CUSTOMER_MAP.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_NAEKCUSTMAP_CUSTOMER ***
begin   
 execute immediate '
  ALTER TABLE BARS.NAEK_CUSTOMER_MAP ADD CONSTRAINT FK_NAEKCUSTMAP_CUSTOMER FOREIGN KEY (RNK)
	  REFERENCES BARS.CUSTOMER (RNK) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_NAEKCUSTOMERMAP_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.NAEK_CUSTOMER_MAP ADD CONSTRAINT FK_NAEKCUSTOMERMAP_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_NAEKCUSTMAP_ECOUNTERS ***
begin   
 execute immediate '
  ALTER TABLE BARS.NAEK_CUSTOMER_MAP ADD CONSTRAINT FK_NAEKCUSTMAP_ECOUNTERS FOREIGN KEY (KF, ECODE)
	  REFERENCES BARS.NAEK_ECOUNTERS (KF, ECODE) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/NAEK_CUSTOMER_MAP.sql =========**
PROMPT ===================================================================================== 
