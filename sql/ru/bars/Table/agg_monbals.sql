

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/AGG_MONBALS.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to AGG_MONBALS ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table AGG_MONBALS ***
begin 
  execute immediate '
  CREATE TABLE BARS.AGG_MONBALS 
   (	FDAT DATE, 
	ACC NUMBER(*,0), 
	RNK NUMBER(*,0), 
	OST NUMBER(24,0), 
	DOS NUMBER(24,0), 
	KOS NUMBER(24,0), 
	OSTQ NUMBER(24,0), 
	DOSQ NUMBER(24,0), 
	KOSQ NUMBER(24,0), 
	CRDOS NUMBER(24,0) DEFAULT 0, 
	CRDOSQ NUMBER(24,0) DEFAULT 0, 
	CRKOS NUMBER(24,0) DEFAULT 0, 
	CRKOSQ NUMBER(24,0) DEFAULT 0, 
	CUDOS NUMBER(24,0) DEFAULT 0, 
	CUDOSQ NUMBER(24,0) DEFAULT 0, 
	CUKOS NUMBER(24,0) DEFAULT 0, 
	CUKOSQ NUMBER(24,0) DEFAULT 0, 
	CALDT_ID NUMBER GENERATED ALWAYS AS (TO_NUMBER(TO_CHAR(FDAT,''j''))-2447892) VIRTUAL VISIBLE 
   ) PCTFREE 0 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 COMPRESS BASIC 
  TABLESPACE BRSACCM 
  PARTITION BY RANGE (FDAT) INTERVAL (NUMTODSINTERVAL(1,''DAY'')) 
 (PARTITION P2013  VALUES LESS THAN (TO_DATE('' 2012-12-31 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN'')) SEGMENT CREATION IMMEDIATE 
  PCTFREE 0 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 COMPRESS BASIC LOGGING 
  TABLESPACE BRSACCM ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to AGG_MONBALS ***
 exec bpa.alter_policies('AGG_MONBALS');


COMMENT ON TABLE BARS.AGG_MONBALS IS '';
COMMENT ON COLUMN BARS.AGG_MONBALS.FDAT IS '';
COMMENT ON COLUMN BARS.AGG_MONBALS.ACC IS '';
COMMENT ON COLUMN BARS.AGG_MONBALS.RNK IS '';
COMMENT ON COLUMN BARS.AGG_MONBALS.OST IS '';
COMMENT ON COLUMN BARS.AGG_MONBALS.DOS IS '';
COMMENT ON COLUMN BARS.AGG_MONBALS.KOS IS '';
COMMENT ON COLUMN BARS.AGG_MONBALS.OSTQ IS '';
COMMENT ON COLUMN BARS.AGG_MONBALS.DOSQ IS '';
COMMENT ON COLUMN BARS.AGG_MONBALS.KOSQ IS '';
COMMENT ON COLUMN BARS.AGG_MONBALS.CRDOS IS '';
COMMENT ON COLUMN BARS.AGG_MONBALS.CRDOSQ IS '';
COMMENT ON COLUMN BARS.AGG_MONBALS.CRKOS IS '';
COMMENT ON COLUMN BARS.AGG_MONBALS.CRKOSQ IS '';
COMMENT ON COLUMN BARS.AGG_MONBALS.CUDOS IS '';
COMMENT ON COLUMN BARS.AGG_MONBALS.CUDOSQ IS '';
COMMENT ON COLUMN BARS.AGG_MONBALS.CUKOS IS '';
COMMENT ON COLUMN BARS.AGG_MONBALS.CUKOSQ IS '';
COMMENT ON COLUMN BARS.AGG_MONBALS.CALDT_ID IS '';




PROMPT *** Create  constraint SYS_C002644418 ***
begin   
 execute immediate '
  ALTER TABLE BARS.AGG_MONBALS MODIFY (KOSQ NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002644417 ***
begin   
 execute immediate '
  ALTER TABLE BARS.AGG_MONBALS MODIFY (DOSQ NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002644416 ***
begin   
 execute immediate '
  ALTER TABLE BARS.AGG_MONBALS MODIFY (OSTQ NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002644415 ***
begin   
 execute immediate '
  ALTER TABLE BARS.AGG_MONBALS MODIFY (KOS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002644414 ***
begin   
 execute immediate '
  ALTER TABLE BARS.AGG_MONBALS MODIFY (DOS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002644413 ***
begin   
 execute immediate '
  ALTER TABLE BARS.AGG_MONBALS MODIFY (OST NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002644412 ***
begin   
 execute immediate '
  ALTER TABLE BARS.AGG_MONBALS MODIFY (RNK NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002644411 ***
begin   
 execute immediate '
  ALTER TABLE BARS.AGG_MONBALS MODIFY (ACC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002644410 ***
begin   
 execute immediate '
  ALTER TABLE BARS.AGG_MONBALS MODIFY (FDAT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_AGG_MONBALS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_AGG_MONBALS ON BARS.AGG_MONBALS (FDAT, ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255  LOCAL
 (PARTITION P2013 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSACCM ) ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  AGG_MONBALS ***
grant SELECT                                                                 on AGG_MONBALS     to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on AGG_MONBALS     to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/AGG_MONBALS.sql =========*** End *** =
PROMPT ===================================================================================== 
