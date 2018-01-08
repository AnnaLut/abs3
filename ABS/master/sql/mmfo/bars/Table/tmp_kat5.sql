

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_KAT5.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_KAT5 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_KAT5 ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_KAT5 
   (	ND NUMBER(*,0), 
	TAG VARCHAR2(5), 
	TXT VARCHAR2(4000), 
	KF VARCHAR2(6)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_KAT5 ***
 exec bpa.alter_policies('TMP_KAT5');


COMMENT ON TABLE BARS.TMP_KAT5 IS '';
COMMENT ON COLUMN BARS.TMP_KAT5.ND IS '';
COMMENT ON COLUMN BARS.TMP_KAT5.TAG IS '';
COMMENT ON COLUMN BARS.TMP_KAT5.TXT IS '';
COMMENT ON COLUMN BARS.TMP_KAT5.KF IS '';




PROMPT *** Create  constraint SYS_C006318 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_KAT5 MODIFY (ND NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006319 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_KAT5 MODIFY (TAG NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006320 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_KAT5 MODIFY (KF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_KAT5 ***
grant SELECT                                                                 on TMP_KAT5        to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_KAT5.sql =========*** End *** ====
PROMPT ===================================================================================== 
