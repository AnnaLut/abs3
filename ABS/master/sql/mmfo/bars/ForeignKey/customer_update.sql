

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/CUSTOMER_UPDATE.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_CUSTOMERUPD_ISE ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_UPDATE ADD CONSTRAINT FK_CUSTOMERUPD_ISE FOREIGN KEY (ISE)
	  REFERENCES BARS.ISE (ISE) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CUSTOMERUPD_FS ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_UPDATE ADD CONSTRAINT FK_CUSTOMERUPD_FS FOREIGN KEY (FS)
	  REFERENCES BARS.FS (FS) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CUSTOMERUPD_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_UPDATE ADD CONSTRAINT FK_CUSTOMERUPD_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CUSTOMERUPDATE_TOBO ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_UPDATE ADD CONSTRAINT FK_CUSTOMERUPDATE_TOBO FOREIGN KEY (TOBO)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CUSTOMERUPD_CUSTTYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_UPDATE ADD CONSTRAINT FK_CUSTOMERUPD_CUSTTYPE FOREIGN KEY (CUSTTYPE)
	  REFERENCES BARS.CUSTTYPE (CUSTTYPE) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CUSTOMERUPD_OE ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_UPDATE ADD CONSTRAINT FK_CUSTOMERUPD_OE FOREIGN KEY (OE)
	  REFERENCES BARS.OE (OE) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CUSTOMERUPD_STMT ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_UPDATE ADD CONSTRAINT FK_CUSTOMERUPD_STMT FOREIGN KEY (STMT)
	  REFERENCES BARS.STMT (STMT) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CUSTOMERUPD_SPRREG ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_UPDATE ADD CONSTRAINT FK_CUSTOMERUPD_SPRREG FOREIGN KEY (C_REG, C_DST)
	  REFERENCES BARS.SPR_REG (C_REG, C_DST) DISABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CUSTOMERUPD_CODCAGENT ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_UPDATE ADD CONSTRAINT FK_CUSTOMERUPD_CODCAGENT FOREIGN KEY (CODCAGENT)
	  REFERENCES BARS.CODCAGENT (CODCAGENT) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CUSTOMERUPD_COUNTRY ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_UPDATE ADD CONSTRAINT FK_CUSTOMERUPD_COUNTRY FOREIGN KEY (COUNTRY)
	  REFERENCES BARS.COUNTRY (COUNTRY) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CUSTOMERUPD_VED ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_UPDATE ADD CONSTRAINT FK_CUSTOMERUPD_VED FOREIGN KEY (VED)
	  REFERENCES BARS.VED (VED) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CUSTOMERUPD_SED ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_UPDATE ADD CONSTRAINT FK_CUSTOMERUPD_SED FOREIGN KEY (SED)
	  REFERENCES BARS.SED (SED) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CUSTOMERUPD_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_UPDATE ADD CONSTRAINT FK_CUSTOMERUPD_STAFF FOREIGN KEY (ISP)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CUSTOMERUPD_TGR ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_UPDATE ADD CONSTRAINT FK_CUSTOMERUPD_TGR FOREIGN KEY (TGR)
	  REFERENCES BARS.TGR (TGR) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CUSTOMERUPD_CUSTOMER ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_UPDATE ADD CONSTRAINT FK_CUSTOMERUPD_CUSTOMER FOREIGN KEY (RNK)
	  REFERENCES BARS.CUSTOMER (RNK) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CUSTOMERUPD_PRINSIDER ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_UPDATE ADD CONSTRAINT FK_CUSTOMERUPD_PRINSIDER FOREIGN KEY (PRINSIDER)
	  REFERENCES BARS.PRINSIDER (PRINSIDER) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/CUSTOMER_UPDATE.sql =========*** 
PROMPT ===================================================================================== 
