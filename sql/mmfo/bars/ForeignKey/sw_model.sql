

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/SW_MODEL.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_SWMODEL_SWMT ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_MODEL ADD CONSTRAINT FK_SWMODEL_SWMT FOREIGN KEY (MT)
	  REFERENCES BARS.SW_MT (MT) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SWMODEL_SWSEQ ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_MODEL ADD CONSTRAINT FK_SWMODEL_SWSEQ FOREIGN KEY (SEQ)
	  REFERENCES BARS.SW_SEQ (SEQ) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SWMODEL_SWTAG ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_MODEL ADD CONSTRAINT FK_SWMODEL_SWTAG FOREIGN KEY (TAG)
	  REFERENCES BARS.SW_TAG (TAG) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SWMODEL_SWOPT ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_MODEL ADD CONSTRAINT FK_SWMODEL_SWOPT FOREIGN KEY (OPT)
	  REFERENCES BARS.SW_OPT (OPT) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/SW_MODEL.sql =========*** End ***
PROMPT ===================================================================================== 
