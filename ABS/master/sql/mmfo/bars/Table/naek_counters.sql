

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NAEK_COUNTERS.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NAEK_COUNTERS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NAEK_COUNTERS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''NAEK_COUNTERS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''NAEK_COUNTERS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NAEK_COUNTERS ***
begin 
  execute immediate '
  CREATE TABLE BARS.NAEK_COUNTERS 
   (	RNK NUMBER(*,0), 
	DAT DATE, 
	CNT NUMBER(*,0)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to NAEK_COUNTERS ***
 exec bpa.alter_policies('NAEK_COUNTERS');


COMMENT ON TABLE BARS.NAEK_COUNTERS IS '';
COMMENT ON COLUMN BARS.NAEK_COUNTERS.RNK IS '';
COMMENT ON COLUMN BARS.NAEK_COUNTERS.DAT IS '';
COMMENT ON COLUMN BARS.NAEK_COUNTERS.CNT IS '';




PROMPT *** Create  constraint CC_NAEKCOUNTERS_RNK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NAEK_COUNTERS MODIFY (RNK CONSTRAINT CC_NAEKCOUNTERS_RNK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NAEKCOUNTERS_DAT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NAEK_COUNTERS MODIFY (DAT CONSTRAINT CC_NAEKCOUNTERS_DAT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NAEKCOUNTERS_CNT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NAEK_COUNTERS MODIFY (CNT CONSTRAINT CC_NAEKCOUNTERS_CNT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_NAEKCOUNTERS ***
begin   
 execute immediate '
  ALTER TABLE BARS.NAEK_COUNTERS ADD CONSTRAINT PK_NAEKCOUNTERS PRIMARY KEY (RNK)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_NAEKCOUNTERS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_NAEKCOUNTERS ON BARS.NAEK_COUNTERS (RNK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  NAEK_COUNTERS ***
grant SELECT                                                                 on NAEK_COUNTERS   to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on NAEK_COUNTERS   to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on NAEK_COUNTERS   to START1;
grant SELECT                                                                 on NAEK_COUNTERS   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NAEK_COUNTERS.sql =========*** End ***
PROMPT ===================================================================================== 
