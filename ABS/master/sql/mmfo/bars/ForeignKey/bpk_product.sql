

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/BPK_PRODUCT.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_BPKPRODUCT_DEMANDACCTYPE2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_PRODUCT ADD CONSTRAINT FK_BPKPRODUCT_DEMANDACCTYPE2 FOREIGN KEY (TYPE, CARD_TYPE)
	  REFERENCES BARS.DEMAND_ACC_TYPE (TYPE, CARD_TYPE) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_BPKPRODUCT_DEMANDKK ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_PRODUCT ADD CONSTRAINT FK_BPKPRODUCT_DEMANDKK FOREIGN KEY (KK)
	  REFERENCES BARS.DEMAND_KK (KK) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_BPKPRODUCT_TABVAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_PRODUCT ADD CONSTRAINT FK_BPKPRODUCT_TABVAL FOREIGN KEY (KV)
	  REFERENCES BARS.TABVAL$GLOBAL (KV) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_BPKPRODUCT_BPKNBS ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_PRODUCT ADD CONSTRAINT FK_BPKPRODUCT_BPKNBS FOREIGN KEY (NBS, OB22)
	  REFERENCES BARS.BPK_NBS (NBS, OB22) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/BPK_PRODUCT.sql =========*** End 
PROMPT ===================================================================================== 
