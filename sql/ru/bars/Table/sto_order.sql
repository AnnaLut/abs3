

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/STO_ORDER.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to STO_ORDER ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''STO_ORDER'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''STO_ORDER'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table STO_ORDER ***
begin 
  execute immediate '
  CREATE TABLE BARS.STO_ORDER 
   (	ID NUMBER(38,0), 
	ORDER_TYPE_ID NUMBER(5,0), 
	PAYER_ACCOUNT_ID NUMBER(38,0), 
	PRODUCT_ID NUMBER(38,0), 
	START_DATE DATE, 
	STOP_DATE DATE, 
	PAYMENT_FREQUENCY NUMBER(5,0), 
	HOLIDAY_SHIFT NUMBER(5,0), 
	CANCEL_DATE DATE, 
	PRIORITY NUMBER(5,0), 
	STATE NUMBER(5,0), 
	USER_ID NUMBER(38,0), 
	BRANCH VARCHAR2(30 CHAR), 
	KF VARCHAR2(6 CHAR), 
	REGISTRATION_DATE DATE, 
	SEND_SMS CHAR(1)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to STO_ORDER ***
 exec bpa.alter_policies('STO_ORDER');


COMMENT ON TABLE BARS.STO_ORDER IS '';
COMMENT ON COLUMN BARS.STO_ORDER.ID IS '';
COMMENT ON COLUMN BARS.STO_ORDER.ORDER_TYPE_ID IS '';
COMMENT ON COLUMN BARS.STO_ORDER.PAYER_ACCOUNT_ID IS '';
COMMENT ON COLUMN BARS.STO_ORDER.PRODUCT_ID IS '';
COMMENT ON COLUMN BARS.STO_ORDER.START_DATE IS '';
COMMENT ON COLUMN BARS.STO_ORDER.STOP_DATE IS '';
COMMENT ON COLUMN BARS.STO_ORDER.PAYMENT_FREQUENCY IS '';
COMMENT ON COLUMN BARS.STO_ORDER.HOLIDAY_SHIFT IS '';
COMMENT ON COLUMN BARS.STO_ORDER.CANCEL_DATE IS '';
COMMENT ON COLUMN BARS.STO_ORDER.PRIORITY IS '';
COMMENT ON COLUMN BARS.STO_ORDER.STATE IS '';
COMMENT ON COLUMN BARS.STO_ORDER.USER_ID IS '';
COMMENT ON COLUMN BARS.STO_ORDER.BRANCH IS '';
COMMENT ON COLUMN BARS.STO_ORDER.KF IS '';
COMMENT ON COLUMN BARS.STO_ORDER.REGISTRATION_DATE IS '';
COMMENT ON COLUMN BARS.STO_ORDER.SEND_SMS IS '';




PROMPT *** Create  constraint FK_STO_ORDE_REFERENCE_STO_TYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_ORDER ADD CONSTRAINT FK_STO_ORDE_REFERENCE_STO_TYPE FOREIGN KEY (ORDER_TYPE_ID)
	  REFERENCES BARS.STO_TYPE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_STO_ORDE_REFERENCE_STAFF$BA ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_ORDER ADD CONSTRAINT FK_STO_ORDE_REFERENCE_STAFF$BA FOREIGN KEY (USER_ID)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_STO_ORDE_REFERENCE_STO_PROD ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_ORDER ADD CONSTRAINT FK_STO_ORDE_REFERENCE_STO_PROD FOREIGN KEY (PRODUCT_ID)
	  REFERENCES BARS.STO_PRODUCT (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_STO_ORDER ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_ORDER ADD CONSTRAINT PK_STO_ORDER PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002755357 ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_ORDER MODIFY (PRIORITY NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002755356 ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_ORDER MODIFY (START_DATE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002755355 ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_ORDER MODIFY (PAYER_ACCOUNT_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002755354 ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_ORDER MODIFY (ORDER_TYPE_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002755353 ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_ORDER MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_STO_ORDER ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_STO_ORDER ON BARS.STO_ORDER (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index STO_ORDER_IDX ***
begin   
 execute immediate '
  CREATE INDEX BARS.STO_ORDER_IDX ON BARS.STO_ORDER (PAYER_ACCOUNT_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  STO_ORDER ***
grant SELECT                                                                 on STO_ORDER       to BARSUPL;
grant SELECT                                                                 on STO_ORDER       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on STO_ORDER       to BARS_DM;
grant SELECT                                                                 on STO_ORDER       to SBON;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/STO_ORDER.sql =========*** End *** ===
PROMPT ===================================================================================== 
