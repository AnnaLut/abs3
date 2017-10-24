

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BANKS$BASE_LUCK.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BANKS$BASE_LUCK ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BANKS$BASE_LUCK ***
begin 
  execute immediate '
  CREATE TABLE BARS.BANKS$BASE_LUCK 
   (	MFO VARCHAR2(12), 
	SAB CHAR(4), 
	NB VARCHAR2(38), 
	KODG NUMBER(3,0), 
	BLK NUMBER(1,0), 
	MFOU VARCHAR2(12), 
	SSP NUMBER(1,0), 
	NMO CHAR(1)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BANKS$BASE_LUCK ***
 exec bpa.alter_policies('BANKS$BASE_LUCK');


COMMENT ON TABLE BARS.BANKS$BASE_LUCK IS '';
COMMENT ON COLUMN BARS.BANKS$BASE_LUCK.MFO IS '';
COMMENT ON COLUMN BARS.BANKS$BASE_LUCK.SAB IS '';
COMMENT ON COLUMN BARS.BANKS$BASE_LUCK.NB IS '';
COMMENT ON COLUMN BARS.BANKS$BASE_LUCK.KODG IS '';
COMMENT ON COLUMN BARS.BANKS$BASE_LUCK.BLK IS '';
COMMENT ON COLUMN BARS.BANKS$BASE_LUCK.MFOU IS '';
COMMENT ON COLUMN BARS.BANKS$BASE_LUCK.SSP IS '';
COMMENT ON COLUMN BARS.BANKS$BASE_LUCK.NMO IS '';




PROMPT *** Create  constraint SYS_C0097880 ***
begin   
 execute immediate '
  ALTER TABLE BARS.BANKS$BASE_LUCK MODIFY (NB NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0097879 ***
begin   
 execute immediate '
  ALTER TABLE BARS.BANKS$BASE_LUCK MODIFY (SAB NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0097878 ***
begin   
 execute immediate '
  ALTER TABLE BARS.BANKS$BASE_LUCK MODIFY (MFO NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BANKS$BASE_LUCK.sql =========*** End *
PROMPT ===================================================================================== 
