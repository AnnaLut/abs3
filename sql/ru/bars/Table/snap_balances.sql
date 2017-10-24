

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SNAP_BALANCES.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SNAP_BALANCES ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SNAP_BALANCES ***
begin 
  execute immediate '
  CREATE TABLE BARS.SNAP_BALANCES 
   (	FDAT DATE, 
	ACC NUMBER(*,0), 
	RNK NUMBER(*,0), 
	OST NUMBER(24,0), 
	DOS NUMBER(24,0), 
	KOS NUMBER(24,0), 
	OSTQ NUMBER(24,0), 
	DOSQ NUMBER(24,0), 
	KOSQ NUMBER(24,0), 
	CALDT_ID NUMBER GENERATED ALWAYS AS (TO_NUMBER(TO_CHAR(FDAT,''j''))-2447892) VIRTUAL VISIBLE 
   ) PCTFREE 0 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 COMPRESS BASIC 
  TABLESPACE BRSACCM 
  PARTITION BY RANGE (FDAT) INTERVAL (NUMTODSINTERVAL(1,''DAY'')) 
 (PARTITION P2013  VALUES LESS THAN (TO_DATE('' 2012-12-31 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN'')) SEGMENT CREATION DEFERRED 
  PCTFREE 0 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 COMPRESS BASIC LOGGING 
  TABLESPACE BRSACCM ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SNAP_BALANCES ***
 exec bpa.alter_policies('SNAP_BALANCES');


COMMENT ON TABLE BARS.SNAP_BALANCES IS '';
COMMENT ON COLUMN BARS.SNAP_BALANCES.FDAT IS '';
COMMENT ON COLUMN BARS.SNAP_BALANCES.ACC IS '';
COMMENT ON COLUMN BARS.SNAP_BALANCES.RNK IS '';
COMMENT ON COLUMN BARS.SNAP_BALANCES.OST IS '';
COMMENT ON COLUMN BARS.SNAP_BALANCES.DOS IS '';
COMMENT ON COLUMN BARS.SNAP_BALANCES.KOS IS '';
COMMENT ON COLUMN BARS.SNAP_BALANCES.OSTQ IS '';
COMMENT ON COLUMN BARS.SNAP_BALANCES.DOSQ IS '';
COMMENT ON COLUMN BARS.SNAP_BALANCES.KOSQ IS '';
COMMENT ON COLUMN BARS.SNAP_BALANCES.CALDT_ID IS '';




PROMPT *** Create  constraint SYS_C002644400 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SNAP_BALANCES MODIFY (KOSQ NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002644399 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SNAP_BALANCES MODIFY (DOSQ NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002644398 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SNAP_BALANCES MODIFY (OSTQ NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002644397 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SNAP_BALANCES MODIFY (KOS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002644396 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SNAP_BALANCES MODIFY (DOS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002644395 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SNAP_BALANCES MODIFY (OST NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002644394 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SNAP_BALANCES MODIFY (RNK NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002644393 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SNAP_BALANCES MODIFY (ACC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002644392 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SNAP_BALANCES MODIFY (FDAT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_SNAP_BALANCES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_SNAP_BALANCES ON BARS.SNAP_BALANCES (FDAT, ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255  LOCAL
 (PARTITION P2013 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSACCM ) ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SNAP_BALANCES ***
grant DELETE,INSERT,SELECT,UPDATE                                            on SNAP_BALANCES   to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SNAP_BALANCES.sql =========*** End ***
PROMPT ===================================================================================== 
