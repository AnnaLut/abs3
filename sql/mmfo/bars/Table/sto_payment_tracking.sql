

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/STO_PAYMENT_TRACKING.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to STO_PAYMENT_TRACKING ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''STO_PAYMENT_TRACKING'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''STO_PAYMENT_TRACKING'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''STO_PAYMENT_TRACKING'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table STO_PAYMENT_TRACKING ***
begin 
  execute immediate '
  CREATE TABLE BARS.STO_PAYMENT_TRACKING 
   (	ID NUMBER(10,0), 
	PAYMENT_ID NUMBER(10,0), 
	STATE NUMBER(5,0), 
	COMMENT_TEXT VARCHAR2(4000), 
	SYS_TIME DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to STO_PAYMENT_TRACKING ***
 exec bpa.alter_policies('STO_PAYMENT_TRACKING');


COMMENT ON TABLE BARS.STO_PAYMENT_TRACKING IS '';
COMMENT ON COLUMN BARS.STO_PAYMENT_TRACKING.ID IS '';
COMMENT ON COLUMN BARS.STO_PAYMENT_TRACKING.PAYMENT_ID IS '';
COMMENT ON COLUMN BARS.STO_PAYMENT_TRACKING.STATE IS '';
COMMENT ON COLUMN BARS.STO_PAYMENT_TRACKING.COMMENT_TEXT IS '';
COMMENT ON COLUMN BARS.STO_PAYMENT_TRACKING.SYS_TIME IS '';




PROMPT *** Create  constraint PK_STO_PAYMENT_TRACKING ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_PAYMENT_TRACKING ADD CONSTRAINT PK_STO_PAYMENT_TRACKING PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006798 ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_PAYMENT_TRACKING MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006799 ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_PAYMENT_TRACKING MODIFY (PAYMENT_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006800 ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_PAYMENT_TRACKING MODIFY (STATE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006801 ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_PAYMENT_TRACKING MODIFY (SYS_TIME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_STO_PAYMENT_TRACKING ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_STO_PAYMENT_TRACKING ON BARS.STO_PAYMENT_TRACKING (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index STO_PAYMENT_IDX2 ***
begin   
 execute immediate '
  CREATE INDEX BARS.STO_PAYMENT_IDX2 ON BARS.STO_PAYMENT_TRACKING (PAYMENT_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  STO_PAYMENT_TRACKING ***
grant SELECT                                                                 on STO_PAYMENT_TRACKING to BARSREADER_ROLE;
grant SELECT                                                                 on STO_PAYMENT_TRACKING to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/STO_PAYMENT_TRACKING.sql =========*** 
PROMPT ===================================================================================== 
