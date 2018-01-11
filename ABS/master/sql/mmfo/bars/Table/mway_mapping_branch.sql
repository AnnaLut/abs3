

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/MWAY_MAPPING_BRANCH.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to MWAY_MAPPING_BRANCH ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''MWAY_MAPPING_BRANCH'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''MWAY_MAPPING_BRANCH'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table MWAY_MAPPING_BRANCH ***
begin 
  execute immediate '
  CREATE TABLE BARS.MWAY_MAPPING_BRANCH 
   (	MFO VARCHAR2(8), 
	APPCODE VARCHAR2(8), 
	ROLECODE VARCHAR2(1)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to MWAY_MAPPING_BRANCH ***
 exec bpa.alter_policies('MWAY_MAPPING_BRANCH');


COMMENT ON TABLE BARS.MWAY_MAPPING_BRANCH IS '';
COMMENT ON COLUMN BARS.MWAY_MAPPING_BRANCH.MFO IS '';
COMMENT ON COLUMN BARS.MWAY_MAPPING_BRANCH.APPCODE IS '';
COMMENT ON COLUMN BARS.MWAY_MAPPING_BRANCH.ROLECODE IS '';




PROMPT *** Create  constraint SYS_C0035414 ***
begin   
 execute immediate '
  ALTER TABLE BARS.MWAY_MAPPING_BRANCH ADD PRIMARY KEY (MFO)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index SYS_C0035414 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.SYS_C0035414 ON BARS.MWAY_MAPPING_BRANCH (MFO) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  MWAY_MAPPING_BRANCH ***
grant SELECT                                                                 on MWAY_MAPPING_BRANCH to BARSREADER_ROLE;
grant SELECT                                                                 on MWAY_MAPPING_BRANCH to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/MWAY_MAPPING_BRANCH.sql =========*** E
PROMPT ===================================================================================== 
