

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/STO_PAYMENT_DOCUMENT_LINK.sql ========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to STO_PAYMENT_DOCUMENT_LINK ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''STO_PAYMENT_DOCUMENT_LINK'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''STO_PAYMENT_DOCUMENT_LINK'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''STO_PAYMENT_DOCUMENT_LINK'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table STO_PAYMENT_DOCUMENT_LINK ***
begin 
  execute immediate '
  CREATE TABLE BARS.STO_PAYMENT_DOCUMENT_LINK 
   (	PAYMENT_ID NUMBER(10,0), 
	DOCUMENT_ID NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to STO_PAYMENT_DOCUMENT_LINK ***
 exec bpa.alter_policies('STO_PAYMENT_DOCUMENT_LINK');


COMMENT ON TABLE BARS.STO_PAYMENT_DOCUMENT_LINK IS '';
COMMENT ON COLUMN BARS.STO_PAYMENT_DOCUMENT_LINK.PAYMENT_ID IS '';
COMMENT ON COLUMN BARS.STO_PAYMENT_DOCUMENT_LINK.DOCUMENT_ID IS '';




PROMPT *** Create  constraint FK_PM_DOC_LINK_REF_PAYM ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_PAYMENT_DOCUMENT_LINK ADD CONSTRAINT FK_PM_DOC_LINK_REF_PAYM FOREIGN KEY (PAYMENT_ID)
	  REFERENCES BARS.STO_PAYMENT (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006796 ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_PAYMENT_DOCUMENT_LINK MODIFY (PAYMENT_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006797 ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_PAYMENT_DOCUMENT_LINK MODIFY (DOCUMENT_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/STO_PAYMENT_DOCUMENT_LINK.sql ========
PROMPT ===================================================================================== 
