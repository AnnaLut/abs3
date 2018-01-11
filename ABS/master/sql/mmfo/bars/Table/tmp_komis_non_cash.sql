

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_KOMIS_NON_CASH.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_KOMIS_NON_CASH ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_KOMIS_NON_CASH ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_KOMIS_NON_CASH 
   (	REF NUMBER(38,0), 
	KF VARCHAR2(6)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_KOMIS_NON_CASH ***
 exec bpa.alter_policies('TMP_KOMIS_NON_CASH');


COMMENT ON TABLE BARS.TMP_KOMIS_NON_CASH IS '';
COMMENT ON COLUMN BARS.TMP_KOMIS_NON_CASH.REF IS '';
COMMENT ON COLUMN BARS.TMP_KOMIS_NON_CASH.KF IS '';




PROMPT *** Create  constraint SYS_C00138976 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_KOMIS_NON_CASH MODIFY (REF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00138977 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_KOMIS_NON_CASH MODIFY (KF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_KOMIS_NON_CASH ***
grant SELECT                                                                 on TMP_KOMIS_NON_CASH to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_KOMIS_NON_CASH.sql =========*** En
PROMPT ===================================================================================== 
