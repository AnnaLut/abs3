

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/INSU_ACC.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_INSU_ACC_RNKI ***
begin   
 execute immediate '
  ALTER TABLE BARS.INSU_ACC ADD CONSTRAINT FK_INSU_ACC_RNKI FOREIGN KEY (RNKI)
	  REFERENCES BARS.CUSTOMER (RNK) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_INSU_ACC_VID ***
begin   
 execute immediate '
  ALTER TABLE BARS.INSU_ACC ADD CONSTRAINT FK_INSU_ACC_VID FOREIGN KEY (VID)
	  REFERENCES BARS.INSU_VID (INSU) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_INSUACC_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.INSU_ACC ADD CONSTRAINT FK_INSUACC_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_INSUACC_ACCOUNTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.INSU_ACC ADD CONSTRAINT FK_INSUACC_ACCOUNTS FOREIGN KEY (KF, ACC)
	  REFERENCES BARS.ACCOUNTS (KF, ACC) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/INSU_ACC.sql =========*** End ***
PROMPT ===================================================================================== 
