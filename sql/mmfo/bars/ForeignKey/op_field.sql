

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/OP_FIELD.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_OPFIELD_SNR ***
begin   
 execute immediate '
  ALTER TABLE BARS.OP_FIELD ADD CONSTRAINT FK_OPFIELD_SNR FOREIGN KEY (VSPO_CHAR)
	  REFERENCES BARS.S_NR (K_RK) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_OPFIELD_METACOLTYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.OP_FIELD ADD CONSTRAINT FK_OPFIELD_METACOLTYPES FOREIGN KEY (TYPE)
	  REFERENCES BARS.META_COLTYPES (COLTYPE) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/OP_FIELD.sql =========*** End ***
PROMPT ===================================================================================== 
