

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/MC_COUNT.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to MC_COUNT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''MC_COUNT'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''MC_COUNT'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''MC_COUNT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table MC_COUNT ***
begin 
  execute immediate '
  CREATE TABLE BARS.MC_COUNT 
   (	MFO VARCHAR2(6), 
	MC_DATE DATE, 
	MC_NUM NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to MC_COUNT ***
 exec bpa.alter_policies('MC_COUNT');


COMMENT ON TABLE BARS.MC_COUNT IS '';
COMMENT ON COLUMN BARS.MC_COUNT.MFO IS '';
COMMENT ON COLUMN BARS.MC_COUNT.MC_DATE IS '';
COMMENT ON COLUMN BARS.MC_COUNT.MC_NUM IS '';




PROMPT *** Create  constraint XPK_MC_COUNT ***
begin   
 execute immediate '
  ALTER TABLE BARS.MC_COUNT ADD CONSTRAINT XPK_MC_COUNT PRIMARY KEY (MFO)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_MC_COUNT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_MC_COUNT ON BARS.MC_COUNT (MFO) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  MC_COUNT ***
grant SELECT                                                                 on MC_COUNT        to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on MC_COUNT        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on MC_COUNT        to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on MC_COUNT        to START1;
grant SELECT                                                                 on MC_COUNT        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/MC_COUNT.sql =========*** End *** ====
PROMPT ===================================================================================== 
