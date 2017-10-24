

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/XRMSW_REGULAR_TRANS.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to XRMSW_REGULAR_TRANS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''XRMSW_REGULAR_TRANS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''XRMSW_REGULAR_TRANS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table XRMSW_REGULAR_TRANS ***
begin 
  execute immediate '
  CREATE TABLE BARS.XRMSW_REGULAR_TRANS 
   (	TRANSACTIONID VARCHAR2(30), 
	RNK NUMBER, 
	STARTDATE DATE, 
	FINISHDATE DATE, 
	FREQUENCY NUMBER, 
	KV NUMBER, 
	NLSA VARCHAR2(15), 
	OKPOB VARCHAR2(10), 
	NAMEB VARCHAR2(37), 
	MFOB VARCHAR2(6), 
	NLSB VARCHAR2(15), 
	HOLYDAY NUMBER(1,0), 
	SUM NUMBER, 
	PURPOSE VARCHAR2(160), 
	DPT_ID NUMBER, 
	AGR_ID NUMBER, 
	STATUSCODE NUMBER, 
	ERRORMESSAGE VARCHAR2(2000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to XRMSW_REGULAR_TRANS ***
 exec bpa.alter_policies('XRMSW_REGULAR_TRANS');


COMMENT ON TABLE BARS.XRMSW_REGULAR_TRANS IS '';
COMMENT ON COLUMN BARS.XRMSW_REGULAR_TRANS.TRANSACTIONID IS '';
COMMENT ON COLUMN BARS.XRMSW_REGULAR_TRANS.RNK IS '';
COMMENT ON COLUMN BARS.XRMSW_REGULAR_TRANS.STARTDATE IS '';
COMMENT ON COLUMN BARS.XRMSW_REGULAR_TRANS.FINISHDATE IS '';
COMMENT ON COLUMN BARS.XRMSW_REGULAR_TRANS.FREQUENCY IS '';
COMMENT ON COLUMN BARS.XRMSW_REGULAR_TRANS.KV IS '';
COMMENT ON COLUMN BARS.XRMSW_REGULAR_TRANS.NLSA IS '';
COMMENT ON COLUMN BARS.XRMSW_REGULAR_TRANS.OKPOB IS '';
COMMENT ON COLUMN BARS.XRMSW_REGULAR_TRANS.NAMEB IS '';
COMMENT ON COLUMN BARS.XRMSW_REGULAR_TRANS.MFOB IS '';
COMMENT ON COLUMN BARS.XRMSW_REGULAR_TRANS.NLSB IS '';
COMMENT ON COLUMN BARS.XRMSW_REGULAR_TRANS.HOLYDAY IS '';
COMMENT ON COLUMN BARS.XRMSW_REGULAR_TRANS.SUM IS '';
COMMENT ON COLUMN BARS.XRMSW_REGULAR_TRANS.PURPOSE IS '';
COMMENT ON COLUMN BARS.XRMSW_REGULAR_TRANS.DPT_ID IS '';
COMMENT ON COLUMN BARS.XRMSW_REGULAR_TRANS.AGR_ID IS '';
COMMENT ON COLUMN BARS.XRMSW_REGULAR_TRANS.STATUSCODE IS '';
COMMENT ON COLUMN BARS.XRMSW_REGULAR_TRANS.ERRORMESSAGE IS '';




PROMPT *** Create  constraint FK_XRMFREQUENCY ***
begin   
 execute immediate '
  ALTER TABLE BARS.XRMSW_REGULAR_TRANS ADD CONSTRAINT FK_XRMFREQUENCY FOREIGN KEY (FREQUENCY)
	  REFERENCES BARS.FREQ (FREQ) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_XRMREG_TRANSACTIONID ***
begin   
 execute immediate '
  ALTER TABLE BARS.XRMSW_REGULAR_TRANS ADD CONSTRAINT FK_XRMREG_TRANSACTIONID FOREIGN KEY (TRANSACTIONID)
	  REFERENCES BARS.XRMSW_AUDIT (TRANSACTIONID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003289893 ***
begin   
 execute immediate '
  ALTER TABLE BARS.XRMSW_REGULAR_TRANS MODIFY (PURPOSE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003289892 ***
begin   
 execute immediate '
  ALTER TABLE BARS.XRMSW_REGULAR_TRANS MODIFY (SUM NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003289891 ***
begin   
 execute immediate '
  ALTER TABLE BARS.XRMSW_REGULAR_TRANS MODIFY (HOLYDAY NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003289890 ***
begin   
 execute immediate '
  ALTER TABLE BARS.XRMSW_REGULAR_TRANS MODIFY (NLSB NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003289889 ***
begin   
 execute immediate '
  ALTER TABLE BARS.XRMSW_REGULAR_TRANS MODIFY (MFOB NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003289888 ***
begin   
 execute immediate '
  ALTER TABLE BARS.XRMSW_REGULAR_TRANS MODIFY (NAMEB NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003289887 ***
begin   
 execute immediate '
  ALTER TABLE BARS.XRMSW_REGULAR_TRANS MODIFY (OKPOB NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003289886 ***
begin   
 execute immediate '
  ALTER TABLE BARS.XRMSW_REGULAR_TRANS MODIFY (NLSA NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003289885 ***
begin   
 execute immediate '
  ALTER TABLE BARS.XRMSW_REGULAR_TRANS MODIFY (KV NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003289884 ***
begin   
 execute immediate '
  ALTER TABLE BARS.XRMSW_REGULAR_TRANS MODIFY (FREQUENCY NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003289883 ***
begin   
 execute immediate '
  ALTER TABLE BARS.XRMSW_REGULAR_TRANS MODIFY (FINISHDATE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003289882 ***
begin   
 execute immediate '
  ALTER TABLE BARS.XRMSW_REGULAR_TRANS MODIFY (STARTDATE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003289881 ***
begin   
 execute immediate '
  ALTER TABLE BARS.XRMSW_REGULAR_TRANS MODIFY (RNK NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  XRMSW_REGULAR_TRANS ***
grant SELECT                                                                 on XRMSW_REGULAR_TRANS to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/XRMSW_REGULAR_TRANS.sql =========*** E
PROMPT ===================================================================================== 
