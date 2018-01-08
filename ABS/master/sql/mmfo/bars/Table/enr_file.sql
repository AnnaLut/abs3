

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ENR_FILE.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ENR_FILE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ENR_FILE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''ENR_FILE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ENR_FILE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ENR_FILE ***
begin 
  execute immediate '
  CREATE TABLE BARS.ENR_FILE 
   (	NPP NUMBER(*,0), 
	MFO VARCHAR2(12), 
	REFD NUMBER(*,0), 
	REFK NUMBER(*,0), 
	FILE_NAME VARCHAR2(12), 
	REF_PROT NUMBER(*,0), 
	RECD NUMBER(*,0), 
	RECK NUMBER(*,0), 
	OTM NUMBER DEFAULT 1
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ENR_FILE ***
 exec bpa.alter_policies('ENR_FILE');


COMMENT ON TABLE BARS.ENR_FILE IS '';
COMMENT ON COLUMN BARS.ENR_FILE.NPP IS '';
COMMENT ON COLUMN BARS.ENR_FILE.MFO IS '';
COMMENT ON COLUMN BARS.ENR_FILE.REFD IS '';
COMMENT ON COLUMN BARS.ENR_FILE.REFK IS '';
COMMENT ON COLUMN BARS.ENR_FILE.FILE_NAME IS '';
COMMENT ON COLUMN BARS.ENR_FILE.REF_PROT IS '';
COMMENT ON COLUMN BARS.ENR_FILE.RECD IS '';
COMMENT ON COLUMN BARS.ENR_FILE.RECK IS '';
COMMENT ON COLUMN BARS.ENR_FILE.OTM IS '';




PROMPT *** Create  constraint XPK_ENR_FILE ***
begin   
 execute immediate '
  ALTER TABLE BARS.ENR_FILE ADD CONSTRAINT XPK_ENR_FILE PRIMARY KEY (REF_PROT, NPP)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_ENR_FILE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_ENR_FILE ON BARS.ENR_FILE (REF_PROT, NPP) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ENR_FILE ***
grant SELECT                                                                 on ENR_FILE        to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on ENR_FILE        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ENR_FILE        to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on ENR_FILE        to START1;
grant SELECT                                                                 on ENR_FILE        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ENR_FILE.sql =========*** End *** ====
PROMPT ===================================================================================== 
