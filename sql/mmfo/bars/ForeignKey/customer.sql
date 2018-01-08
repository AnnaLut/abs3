

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/CUSTOMER.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_CUSTOMER_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER ADD CONSTRAINT FK_CUSTOMER_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CUSTOMER_ISE ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER ADD CONSTRAINT FK_CUSTOMER_ISE FOREIGN KEY (ISE)
	  REFERENCES BARS.ISE (ISE) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CUSTOMER_FS ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER ADD CONSTRAINT FK_CUSTOMER_FS FOREIGN KEY (FS)
	  REFERENCES BARS.FS (FS) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CUSTOMER_PRINSIDER ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER ADD CONSTRAINT FK_CUSTOMER_PRINSIDER FOREIGN KEY (PRINSIDER)
	  REFERENCES BARS.PRINSIDER (PRINSIDER) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CUSTOMER_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER ADD CONSTRAINT FK_CUSTOMER_STAFF FOREIGN KEY (ISP)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CUSTOMER_TOBO ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER ADD CONSTRAINT FK_CUSTOMER_TOBO FOREIGN KEY (TOBO)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CUSTOMER_SPK050 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER ADD CONSTRAINT FK_CUSTOMER_SPK050 FOREIGN KEY (K050)
	  REFERENCES BARS.SP_K050 (K050) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CUSTOMER_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER ADD CONSTRAINT FK_CUSTOMER_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CUSTOMER_CUSTTYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER ADD CONSTRAINT FK_CUSTOMER_CUSTTYPE FOREIGN KEY (CUSTTYPE)
	  REFERENCES BARS.CUSTTYPE (CUSTTYPE) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CUSTOMER_CUSTOMER ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER ADD CONSTRAINT FK_CUSTOMER_CUSTOMER FOREIGN KEY (RNKP)
	  REFERENCES BARS.CUSTOMER (RNK) DISABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CUSTOMER_OE ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER ADD CONSTRAINT FK_CUSTOMER_OE FOREIGN KEY (OE)
	  REFERENCES BARS.OE (OE) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CUSTOMER_STMT ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER ADD CONSTRAINT FK_CUSTOMER_STMT FOREIGN KEY (STMT)
	  REFERENCES BARS.STMT (STMT) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CUSTOMER_SPRREG ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER ADD CONSTRAINT FK_CUSTOMER_SPRREG FOREIGN KEY (C_REG, C_DST)
	  REFERENCES BARS.SPR_REG (C_REG, C_DST) DISABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CUSTOMER_TGR ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER ADD CONSTRAINT FK_CUSTOMER_TGR FOREIGN KEY (TGR)
	  REFERENCES BARS.TGR (TGR) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CUSTOMER_CODCAGENT ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER ADD CONSTRAINT FK_CUSTOMER_CODCAGENT FOREIGN KEY (CODCAGENT)
	  REFERENCES BARS.CODCAGENT (CODCAGENT) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CUSTOMER_COUNTRY ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER ADD CONSTRAINT FK_CUSTOMER_COUNTRY FOREIGN KEY (COUNTRY)
	  REFERENCES BARS.COUNTRY (COUNTRY) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CUSTOMER_VED ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER ADD CONSTRAINT FK_CUSTOMER_VED FOREIGN KEY (VED)
	  REFERENCES BARS.VED (VED) DISABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CUSTOMER_SED ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER ADD CONSTRAINT FK_CUSTOMER_SED FOREIGN KEY (SED)
	  REFERENCES BARS.SED (SED) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/CUSTOMER.sql =========*** End ***
PROMPT ===================================================================================== 
