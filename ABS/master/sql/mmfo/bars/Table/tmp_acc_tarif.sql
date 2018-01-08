

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_ACC_TARIF.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_ACC_TARIF ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_ACC_TARIF ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_ACC_TARIF 
   (	ACC NUMBER, 
	KOD NUMBER, 
	TAR NUMBER, 
	PR NUMBER(20,4), 
	SMIN NUMBER, 
	SMAX NUMBER, 
	OST_AVG NUMBER, 
	BDATE DATE, 
	EDATE DATE, 
	NDOK_RKO NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_ACC_TARIF ***
 exec bpa.alter_policies('TMP_ACC_TARIF');


COMMENT ON TABLE BARS.TMP_ACC_TARIF IS '';
COMMENT ON COLUMN BARS.TMP_ACC_TARIF.ACC IS '';
COMMENT ON COLUMN BARS.TMP_ACC_TARIF.KOD IS '';
COMMENT ON COLUMN BARS.TMP_ACC_TARIF.TAR IS '';
COMMENT ON COLUMN BARS.TMP_ACC_TARIF.PR IS '';
COMMENT ON COLUMN BARS.TMP_ACC_TARIF.SMIN IS '';
COMMENT ON COLUMN BARS.TMP_ACC_TARIF.SMAX IS '';
COMMENT ON COLUMN BARS.TMP_ACC_TARIF.OST_AVG IS '';
COMMENT ON COLUMN BARS.TMP_ACC_TARIF.BDATE IS '';
COMMENT ON COLUMN BARS.TMP_ACC_TARIF.EDATE IS '';
COMMENT ON COLUMN BARS.TMP_ACC_TARIF.NDOK_RKO IS '';




PROMPT *** Create  constraint SYS_C006316 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ACC_TARIF MODIFY (ACC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006317 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ACC_TARIF MODIFY (KOD NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_ACC_TARIF ***
grant SELECT                                                                 on TMP_ACC_TARIF   to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_ACC_TARIF   to BARS_DM;
grant SELECT                                                                 on TMP_ACC_TARIF   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_ACC_TARIF.sql =========*** End ***
PROMPT ===================================================================================== 
