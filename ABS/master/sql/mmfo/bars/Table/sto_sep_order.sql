

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/STO_SEP_ORDER.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to STO_SEP_ORDER ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''STO_SEP_ORDER'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''STO_SEP_ORDER'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''STO_SEP_ORDER'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table STO_SEP_ORDER ***
begin 
  execute immediate '
  CREATE TABLE BARS.STO_SEP_ORDER 
   (	ID NUMBER(10,0), 
	REGULAR_AMOUNT NUMBER(22,2), 
	RECEIVER_MFO VARCHAR2(6 CHAR), 
	RECEIVER_ACCOUNT VARCHAR2(34 CHAR), 
	RECEIVER_NAME VARCHAR2(300 CHAR), 
	RECEIVER_EDRPOU VARCHAR2(12 CHAR), 
	PURPOSE VARCHAR2(4000), 
	SEND_SMS CHAR(1)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to STO_SEP_ORDER ***
 exec bpa.alter_policies('STO_SEP_ORDER');


COMMENT ON TABLE BARS.STO_SEP_ORDER IS '';
COMMENT ON COLUMN BARS.STO_SEP_ORDER.ID IS '';
COMMENT ON COLUMN BARS.STO_SEP_ORDER.REGULAR_AMOUNT IS '';
COMMENT ON COLUMN BARS.STO_SEP_ORDER.RECEIVER_MFO IS '';
COMMENT ON COLUMN BARS.STO_SEP_ORDER.RECEIVER_ACCOUNT IS '';
COMMENT ON COLUMN BARS.STO_SEP_ORDER.RECEIVER_NAME IS '';
COMMENT ON COLUMN BARS.STO_SEP_ORDER.RECEIVER_EDRPOU IS '';
COMMENT ON COLUMN BARS.STO_SEP_ORDER.PURPOSE IS '';
COMMENT ON COLUMN BARS.STO_SEP_ORDER.SEND_SMS IS '';




PROMPT *** Create  constraint SYS_C006170 ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_SEP_ORDER MODIFY (ID NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006171 ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_SEP_ORDER MODIFY (RECEIVER_MFO NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006172 ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_SEP_ORDER MODIFY (RECEIVER_ACCOUNT NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006173 ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_SEP_ORDER MODIFY (RECEIVER_NAME NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006174 ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_SEP_ORDER MODIFY (RECEIVER_EDRPOU NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_STO_SEP_ORDER ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_SEP_ORDER ADD CONSTRAINT PK_STO_SEP_ORDER PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_STO_SEP_ORDER ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_STO_SEP_ORDER ON BARS.STO_SEP_ORDER (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  STO_SEP_ORDER ***
grant SELECT                                                                 on STO_SEP_ORDER   to BARSREADER_ROLE;
grant SELECT                                                                 on STO_SEP_ORDER   to BARSUPL;
grant SELECT                                                                 on STO_SEP_ORDER   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on STO_SEP_ORDER   to SBON;
grant SELECT                                                                 on STO_SEP_ORDER   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/STO_SEP_ORDER.sql =========*** End ***
PROMPT ===================================================================================== 
