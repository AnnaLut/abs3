

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_REF.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_REF ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_REF ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_REF 
   (	RNK NUMBER, 
	REF NUMBER, 
	NEXTVISA NUMBER, 
	ISP NUMBER, 
	BRANCH VARCHAR2(30)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_REF ***
 exec bpa.alter_policies('TMP_REF');


COMMENT ON TABLE BARS.TMP_REF IS '';
COMMENT ON COLUMN BARS.TMP_REF.RNK IS '';
COMMENT ON COLUMN BARS.TMP_REF.REF IS '';
COMMENT ON COLUMN BARS.TMP_REF.NEXTVISA IS '';
COMMENT ON COLUMN BARS.TMP_REF.ISP IS '';
COMMENT ON COLUMN BARS.TMP_REF.BRANCH IS '';




PROMPT *** Create  constraint TMP_REF_PK ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_REF ADD CONSTRAINT TMP_REF_PK PRIMARY KEY (REF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_TMP_REF ***
begin   
 execute immediate '
  CREATE INDEX BARS.XPK_TMP_REF ON BARS.TMP_REF (REF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_REF ***
grant SELECT                                                                 on TMP_REF         to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_REF         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_REF.sql =========*** End *** =====
PROMPT ===================================================================================== 
