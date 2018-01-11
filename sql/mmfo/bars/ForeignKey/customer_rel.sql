

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/CUSTOMER_REL.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_CUSTOMERREL_CUSTOMER ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_REL ADD CONSTRAINT FK_CUSTOMERREL_CUSTOMER FOREIGN KEY (RNK)
	  REFERENCES BARS.CUSTOMER (RNK) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CUSTOMERREL_CUSTREL ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_REL ADD CONSTRAINT FK_CUSTOMERREL_CUSTREL FOREIGN KEY (REL_ID)
	  REFERENCES BARS.CUST_REL (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CUSTOMERREL_TRUSTEETYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_REL ADD CONSTRAINT FK_CUSTOMERREL_TRUSTEETYPE FOREIGN KEY (TYPE_ID)
	  REFERENCES BARS.TRUSTEE_TYPE (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CUSTOMERREL_TRUSTEEDOCTYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_REL ADD CONSTRAINT FK_CUSTOMERREL_TRUSTEEDOCTYPE FOREIGN KEY (DOCUMENT_TYPE_ID)
	  REFERENCES BARS.TRUSTEE_DOCUMENT_TYPE (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CUSTOMERREL_CUSTOMERBINDATA ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_REL ADD CONSTRAINT FK_CUSTOMERREL_CUSTOMERBINDATA FOREIGN KEY (SIGN_ID)
	  REFERENCES BARS.CUSTOMER_BIN_DATA (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/CUSTOMER_REL.sql =========*** End
PROMPT ===================================================================================== 
