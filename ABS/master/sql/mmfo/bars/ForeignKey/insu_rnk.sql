

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/INSU_RNK.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_INSU_RNK_RNK ***
begin   
 execute immediate '
  ALTER TABLE BARS.INSU_RNK ADD CONSTRAINT FK_INSU_RNK_RNK FOREIGN KEY (RNK)
	  REFERENCES BARS.CUSTOMER (RNK) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_INSU_RNK_RNKI ***
begin   
 execute immediate '
  ALTER TABLE BARS.INSU_RNK ADD CONSTRAINT FK_INSU_RNK_RNKI FOREIGN KEY (RNKI)
	  REFERENCES BARS.CUSTOMER (RNK) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_INSU_RNK_VID ***
begin   
 execute immediate '
  ALTER TABLE BARS.INSU_RNK ADD CONSTRAINT FK_INSU_RNK_VID FOREIGN KEY (VID)
	  REFERENCES BARS.INSU_VID (INSU) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_INSURNK_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.INSU_RNK ADD CONSTRAINT FK_INSURNK_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/INSU_RNK.sql =========*** End ***
PROMPT ===================================================================================== 
