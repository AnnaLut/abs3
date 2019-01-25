PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TELLER_ATM_STATUS.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TELLER_ATM_STATUS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TELLER_ATM_STATUS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TELLER_ATM_STATUS ***
begin 
  execute immediate '
  CREATE TABLE BARS.TELLER_ATM_STATUS 
   (	EQUIP_CODE NUMBER, 
	EQUIP_IP VARCHAR2(25), 
	WORK_DATE DATE, 
	AMOUNT SYS.XMLTYPE , 
	LAST_USER VARCHAR2(50), 
	LAST_DT DATE, 
	STATUS NUMBER, 
	STATUS_DESC VARCHAR2(1000), 
	OCCUPY_USER VARCHAR2(100), 
	AMOUNT_TIME DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND 
 XMLTYPE COLUMN AMOUNT STORE AS SECUREFILE BINARY XML (
  TABLESPACE BRSDYND ENABLE STORAGE IN ROW CHUNK 8192
  NOCACHE LOGGING  NOCOMPRESS  KEEP_DUPLICATES ) ALLOW NONSCHEMA DISALLOW ANYSCHEMA ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TELLER_ATM_STATUS ***
 exec bpa.alter_policies('TELLER_ATM_STATUS');


COMMENT ON TABLE BARS.TELLER_ATM_STATUS IS '';
COMMENT ON COLUMN BARS.TELLER_ATM_STATUS.EQUIP_CODE IS '';
COMMENT ON COLUMN BARS.TELLER_ATM_STATUS.EQUIP_IP IS '';
COMMENT ON COLUMN BARS.TELLER_ATM_STATUS.WORK_DATE IS '';
COMMENT ON COLUMN BARS.TELLER_ATM_STATUS.AMOUNT IS '';
COMMENT ON COLUMN BARS.TELLER_ATM_STATUS.LAST_USER IS '';
COMMENT ON COLUMN BARS.TELLER_ATM_STATUS.LAST_DT IS '';
COMMENT ON COLUMN BARS.TELLER_ATM_STATUS.STATUS IS '';
COMMENT ON COLUMN BARS.TELLER_ATM_STATUS.STATUS_DESC IS '';
COMMENT ON COLUMN BARS.TELLER_ATM_STATUS.OCCUPY_USER IS '';
COMMENT ON COLUMN BARS.TELLER_ATM_STATUS.AMOUNT_TIME IS '';




PROMPT *** Create  constraint PK_TELLER_ATM ***
begin   
 execute immediate '
  ALTER TABLE BARS.TELLER_ATM_STATUS ADD CONSTRAINT PK_TELLER_ATM PRIMARY KEY (EQUIP_IP, WORK_DATE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_TELLER_ATM ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_TELLER_ATM ON BARS.TELLER_ATM_STATUS (EQUIP_IP, WORK_DATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TELLER_ATM_STATUS.sql =========*** End
PROMPT ===================================================================================== 
