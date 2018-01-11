

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/GRT_DEALS.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_GRTDEALS_GRTTYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.GRT_DEALS ADD CONSTRAINT FK_GRTDEALS_GRTTYPES FOREIGN KEY (GRT_TYPE_ID)
	  REFERENCES BARS.GRT_TYPES (TYPE_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_GRTDEALS_GRTPLACES ***
begin   
 execute immediate '
  ALTER TABLE BARS.GRT_DEALS ADD CONSTRAINT FK_GRTDEALS_GRTPLACES FOREIGN KEY (GRT_PLACE_ID)
	  REFERENCES BARS.GRT_PLACES (PLACE_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_GRTDEALS_CUSTOMER ***
begin   
 execute immediate '
  ALTER TABLE BARS.GRT_DEALS ADD CONSTRAINT FK_GRTDEALS_CUSTOMER FOREIGN KEY (DEAL_RNK)
	  REFERENCES BARS.CUSTOMER (RNK) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_GRTDEALS_GRTUNITS ***
begin   
 execute immediate '
  ALTER TABLE BARS.GRT_DEALS ADD CONSTRAINT FK_GRTDEALS_GRTUNITS FOREIGN KEY (GRT_UNIT)
	  REFERENCES BARS.GRT_UNITS (UNIT_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_GRTDEALS_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.GRT_DEALS ADD CONSTRAINT FK_GRTDEALS_STAFF FOREIGN KEY (STAFF_ID)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_GRTDEALS_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.GRT_DEALS ADD CONSTRAINT FK_GRTDEALS_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_GRTDEALS_TABVAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.GRT_DEALS ADD CONSTRAINT FK_GRTDEALS_TABVAL FOREIGN KEY (GRT_SUM_CURCODE)
	  REFERENCES BARS.TABVAL$GLOBAL (KV) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_GRTDEALS_FREQ ***
begin   
 execute immediate '
  ALTER TABLE BARS.GRT_DEALS ADD CONSTRAINT FK_GRTDEALS_FREQ FOREIGN KEY (CHK_FREQ)
	  REFERENCES BARS.FREQ (FREQ) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_GRTDEALS_GRTDEALSTATUSES ***
begin   
 execute immediate '
  ALTER TABLE BARS.GRT_DEALS ADD CONSTRAINT FK_GRTDEALS_GRTDEALSTATUSES FOREIGN KEY (STATUS_ID)
	  REFERENCES BARS.GRT_DEAL_STATUSES (STATUS_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_GRTDEALS_GRTSUBJECTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.GRT_DEALS ADD CONSTRAINT FK_GRTDEALS_GRTSUBJECTS FOREIGN KEY (GRT_SUBJ_ID)
	  REFERENCES BARS.GRT_SUBJECTS (SUBJ_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/GRT_DEALS.sql =========*** End **
PROMPT ===================================================================================== 
