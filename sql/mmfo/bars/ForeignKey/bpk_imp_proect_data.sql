

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/BPK_IMP_PROECT_DATA.sql =========
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_BPKIMPPROECTDATA_CUSTOMER ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_IMP_PROECT_DATA ADD CONSTRAINT FK_BPKIMPPROECTDATA_CUSTOMER FOREIGN KEY (RNK)
	  REFERENCES BARS.CUSTOMER (RNK) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/BPK_IMP_PROECT_DATA.sql =========
PROMPT ===================================================================================== 
