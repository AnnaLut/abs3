

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TEMP_BALANCES.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TEMP_BALANCES ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TEMP_BALANCES ***
begin 
  execute immediate '
  CREATE TABLE BARS.TEMP_BALANCES 
   (	FDAT DATE, 
	ACC NUMBER(*,0), 
	RNK NUMBER(*,0), 
	OST NUMBER(24,0), 
	DOS NUMBER(24,0), 
	KOS NUMBER(24,0), 
	OSTQ NUMBER(24,0), 
	DOSQ NUMBER(24,0), 
	KOSQ NUMBER(24,0)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TEMP_BALANCES ***
 exec bpa.alter_policies('TEMP_BALANCES');


COMMENT ON TABLE BARS.TEMP_BALANCES IS '';
COMMENT ON COLUMN BARS.TEMP_BALANCES.FDAT IS '';
COMMENT ON COLUMN BARS.TEMP_BALANCES.ACC IS '';
COMMENT ON COLUMN BARS.TEMP_BALANCES.RNK IS '';
COMMENT ON COLUMN BARS.TEMP_BALANCES.OST IS '';
COMMENT ON COLUMN BARS.TEMP_BALANCES.DOS IS '';
COMMENT ON COLUMN BARS.TEMP_BALANCES.KOS IS '';
COMMENT ON COLUMN BARS.TEMP_BALANCES.OSTQ IS '';
COMMENT ON COLUMN BARS.TEMP_BALANCES.DOSQ IS '';
COMMENT ON COLUMN BARS.TEMP_BALANCES.KOSQ IS '';




PROMPT *** Create  constraint SYS_C002644405 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TEMP_BALANCES MODIFY (DOS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002644404 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TEMP_BALANCES MODIFY (OST NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002644403 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TEMP_BALANCES MODIFY (RNK NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002644402 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TEMP_BALANCES MODIFY (ACC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002644401 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TEMP_BALANCES MODIFY (FDAT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002644409 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TEMP_BALANCES MODIFY (KOSQ NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002644408 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TEMP_BALANCES MODIFY (DOSQ NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002644407 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TEMP_BALANCES MODIFY (OSTQ NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002644406 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TEMP_BALANCES MODIFY (KOS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TEMP_BALANCES.sql =========*** End ***
PROMPT ===================================================================================== 
