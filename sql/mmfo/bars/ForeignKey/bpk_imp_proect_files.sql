

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/BPK_IMP_PROECT_FILES.sql ========
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_BPKIMPPROECTFILES_BPKPROD ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_IMP_PROECT_FILES ADD CONSTRAINT FK_BPKIMPPROECTFILES_BPKPROD FOREIGN KEY (PRODUCT_ID)
	  REFERENCES BARS.BPK_PRODUCT (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_BPKIMPPROECTFILES_FILIAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_IMP_PROECT_FILES ADD CONSTRAINT FK_BPKIMPPROECTFILES_FILIAL FOREIGN KEY (FILIAL)
	  REFERENCES BARS.DEMAND_FILIALES (CODE) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_BPKIMPPROECTFILES_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_IMP_PROECT_FILES ADD CONSTRAINT FK_BPKIMPPROECTFILES_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_BPKIMPPROECTFILES_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_IMP_PROECT_FILES ADD CONSTRAINT FK_BPKIMPPROECTFILES_STAFF FOREIGN KEY (ISP)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/BPK_IMP_PROECT_FILES.sql ========
PROMPT ===================================================================================== 
