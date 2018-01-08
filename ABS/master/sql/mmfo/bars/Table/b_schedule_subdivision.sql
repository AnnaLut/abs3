

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/B_SCHEDULE_SUBDIVISION.sql =========**
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to B_SCHEDULE_SUBDIVISION ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''B_SCHEDULE_SUBDIVISION'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''B_SCHEDULE_SUBDIVISION'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table B_SCHEDULE_SUBDIVISION ***
begin 
  execute immediate '
  CREATE TABLE BARS.B_SCHEDULE_SUBDIVISION 
   (	IDD NUMBER, 
	IDLH NUMBER, 
	IDLM NUMBER, 
	IDLS_S NUMBER, 
	IDLS_D NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to B_SCHEDULE_SUBDIVISION ***
 exec bpa.alter_policies('B_SCHEDULE_SUBDIVISION');


COMMENT ON TABLE BARS.B_SCHEDULE_SUBDIVISION IS 'Штатний розклад. Підрозділи ( з описом вищих рівнів).';
COMMENT ON COLUMN BARS.B_SCHEDULE_SUBDIVISION.IDD IS '';
COMMENT ON COLUMN BARS.B_SCHEDULE_SUBDIVISION.IDLH IS '';
COMMENT ON COLUMN BARS.B_SCHEDULE_SUBDIVISION.IDLM IS '';
COMMENT ON COLUMN BARS.B_SCHEDULE_SUBDIVISION.IDLS_S IS '';
COMMENT ON COLUMN BARS.B_SCHEDULE_SUBDIVISION.IDLS_D IS '';




PROMPT *** Create  constraint PK_BSHEDSUBDIV_IDD ***
begin   
 execute immediate '
  ALTER TABLE BARS.B_SCHEDULE_SUBDIVISION ADD CONSTRAINT PK_BSHEDSUBDIV_IDD PRIMARY KEY (IDD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BSHEDSUBDIV_IDD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.B_SCHEDULE_SUBDIVISION MODIFY (IDD CONSTRAINT CC_BSHEDSUBDIV_IDD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_BSHEDSUBDIV_ID ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_BSHEDSUBDIV_ID ON BARS.B_SCHEDULE_SUBDIVISION (IDD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  B_SCHEDULE_SUBDIVISION ***
grant DELETE,INSERT,SELECT,UPDATE                                            on B_SCHEDULE_SUBDIVISION to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on B_SCHEDULE_SUBDIVISION to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on B_SCHEDULE_SUBDIVISION to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/B_SCHEDULE_SUBDIVISION.sql =========**
PROMPT ===================================================================================== 
