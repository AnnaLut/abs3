

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_RNK_REKV.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_RNK_REKV ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_RNK_REKV ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_RNK_REKV 
   (	RNK NUMBER(38,0), 
	LIM_KASS NUMBER(24,0), 
	ADR_ALT VARCHAR2(70), 
	NOM_DOG VARCHAR2(10), 
	KF VARCHAR2(6)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_RNK_REKV ***
 exec bpa.alter_policies('TMP_RNK_REKV');


COMMENT ON TABLE BARS.TMP_RNK_REKV IS '';
COMMENT ON COLUMN BARS.TMP_RNK_REKV.RNK IS '';
COMMENT ON COLUMN BARS.TMP_RNK_REKV.LIM_KASS IS '';
COMMENT ON COLUMN BARS.TMP_RNK_REKV.ADR_ALT IS '';
COMMENT ON COLUMN BARS.TMP_RNK_REKV.NOM_DOG IS '';
COMMENT ON COLUMN BARS.TMP_RNK_REKV.KF IS '';




PROMPT *** Create  constraint SYS_C00119336 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_RNK_REKV MODIFY (KF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00119335 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_RNK_REKV MODIFY (RNK NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_RNK_REKV.sql =========*** End *** 
PROMPT ===================================================================================== 
