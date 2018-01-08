

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NOTPORTFOLIO_NBS.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NOTPORTFOLIO_NBS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NOTPORTFOLIO_NBS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NOTPORTFOLIO_NBS ***
begin 
  execute immediate '
  CREATE TABLE BARS.NOTPORTFOLIO_NBS 
   (	NBS CHAR(4), 
	USERID NUMBER(38,0), 
	PORTFOLIO_CODE VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to NOTPORTFOLIO_NBS ***
 exec bpa.alter_policies('NOTPORTFOLIO_NBS');


COMMENT ON TABLE BARS.NOTPORTFOLIO_NBS IS '';
COMMENT ON COLUMN BARS.NOTPORTFOLIO_NBS.USERID IS '';
COMMENT ON COLUMN BARS.NOTPORTFOLIO_NBS.PORTFOLIO_CODE IS '';
COMMENT ON COLUMN BARS.NOTPORTFOLIO_NBS.NBS IS '';




PROMPT *** Create  constraint UK_NP_NBS ***
begin   
 execute immediate '
  ALTER TABLE BARS.NOTPORTFOLIO_NBS ADD CONSTRAINT UK_NP_NBS PRIMARY KEY (NBS)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_NP_NBS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_NP_NBS ON BARS.NOTPORTFOLIO_NBS (NBS) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  NOTPORTFOLIO_NBS ***
grant SELECT                                                                 on NOTPORTFOLIO_NBS to BARSREADER_ROLE;
grant SELECT                                                                 on NOTPORTFOLIO_NBS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NOTPORTFOLIO_NBS.sql =========*** End 
PROMPT ===================================================================================== 
