

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/RNKP_KOD.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_RNKP_KOD_KODK ***
begin   
 execute immediate '
  ALTER TABLE BARS.RNKP_KOD ADD CONSTRAINT FK_RNKP_KOD_KODK FOREIGN KEY (KODK)
	  REFERENCES BARS.KOD_CLI (KOD_CLI) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_RNKP_KOD_KODU ***
begin   
 execute immediate '
  ALTER TABLE BARS.RNKP_KOD ADD CONSTRAINT FK_RNKP_KOD_KODU FOREIGN KEY (KODU)
	  REFERENCES BARS.ORG_PFU (KOD_UPF) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_RNKP_KOD_RNK ***
begin   
 execute immediate '
  ALTER TABLE BARS.RNKP_KOD ADD CONSTRAINT FK_RNKP_KOD_RNK FOREIGN KEY (RNK)
	  REFERENCES BARS.CUSTOMER (RNK) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/RNKP_KOD.sql =========*** End ***
PROMPT ===================================================================================== 
