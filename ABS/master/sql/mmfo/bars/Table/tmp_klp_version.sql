

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_KLP_VERSION.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_KLP_VERSION ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_KLP_VERSION ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_KLP_VERSION 
   (	RNK NUMBER, 
	VERSION VARCHAR2(15), 
	FILEE NUMBER(1,0), 
	KF VARCHAR2(6)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_KLP_VERSION ***
 exec bpa.alter_policies('TMP_KLP_VERSION');


COMMENT ON TABLE BARS.TMP_KLP_VERSION IS '';
COMMENT ON COLUMN BARS.TMP_KLP_VERSION.RNK IS '';
COMMENT ON COLUMN BARS.TMP_KLP_VERSION.VERSION IS '';
COMMENT ON COLUMN BARS.TMP_KLP_VERSION.FILEE IS '';
COMMENT ON COLUMN BARS.TMP_KLP_VERSION.KF IS '';




PROMPT *** Create  constraint SYS_C00119331 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_KLP_VERSION MODIFY (KF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_KLP_VERSION ***
grant SELECT                                                                 on TMP_KLP_VERSION to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_KLP_VERSION to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_KLP_VERSION.sql =========*** End *
PROMPT ===================================================================================== 
