

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/DPU_AGREEMENTS.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_DPUAGRMNTS_PRCUSER ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_AGREEMENTS ADD CONSTRAINT FK_DPUAGRMNTS_PRCUSER FOREIGN KEY (AGRMNT_PRCUSER)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPUAGRMNTS_FREQ ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_AGREEMENTS ADD CONSTRAINT FK_DPUAGRMNTS_FREQ FOREIGN KEY (FREQ)
	  REFERENCES BARS.FREQ (FREQ) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPUAGRMNTS_UNDOID ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_AGREEMENTS ADD CONSTRAINT FK_DPUAGRMNTS_UNDOID FOREIGN KEY (UNDO_ID)
	  REFERENCES BARS.DPU_AGREEMENTS (AGRMNT_ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPUAGRMNTS_DPUAGRMNTTYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_AGREEMENTS ADD CONSTRAINT FK_DPUAGRMNTS_DPUAGRMNTTYPES FOREIGN KEY (AGRMNT_TYPE)
	  REFERENCES BARS.DPU_AGREEMENT_TYPES (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPUAGRMNTS_DPUDEAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_AGREEMENTS ADD CONSTRAINT FK_DPUAGRMNTS_DPUDEAL FOREIGN KEY (DPU_ID)
	  REFERENCES BARS.DPU_DEAL (DPU_ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPUAGRMNTS_STOPID ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_AGREEMENTS ADD CONSTRAINT FK_DPUAGRMNTS_STOPID FOREIGN KEY (STOP_ID)
	  REFERENCES BARS.DPT_STOP (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPUAGRMNTS_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_AGREEMENTS ADD CONSTRAINT FK_DPUAGRMNTS_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPUAGRMNTS_CRUSER ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_AGREEMENTS ADD CONSTRAINT FK_DPUAGRMNTS_CRUSER FOREIGN KEY (AGRMNT_CRUSER)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/DPU_AGREEMENTS.sql =========*** E
PROMPT ===================================================================================== 
