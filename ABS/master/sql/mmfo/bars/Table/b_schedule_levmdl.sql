

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/B_SCHEDULE_LEVMDL.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to B_SCHEDULE_LEVMDL ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table B_SCHEDULE_LEVMDL ***
begin 
  execute immediate '
  CREATE TABLE BARS.B_SCHEDULE_LEVMDL 
   (	IDL NUMBER, 
	NAMEL VARCHAR2(150)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to B_SCHEDULE_LEVMDL ***
 exec bpa.alter_policies('B_SCHEDULE_LEVMDL');


COMMENT ON TABLE BARS.B_SCHEDULE_LEVMDL IS 'Ўтатний розклад. ”правл≥нн€ (р≥вень 2).';
COMMENT ON COLUMN BARS.B_SCHEDULE_LEVMDL.IDL IS '';
COMMENT ON COLUMN BARS.B_SCHEDULE_LEVMDL.NAMEL IS '';




PROMPT *** Create  constraint CC_BSHEDLEVMDL_IDL_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.B_SCHEDULE_LEVMDL ADD CONSTRAINT CC_BSHEDLEVMDL_IDL_NN CHECK (IDL IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_BSHEDLEVMDL ***
begin   
 execute immediate '
  ALTER TABLE BARS.B_SCHEDULE_LEVMDL ADD CONSTRAINT PK_BSHEDLEVMDL PRIMARY KEY (IDL)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_BSHEDLEVMDL_IDL ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_BSHEDLEVMDL_IDL ON BARS.B_SCHEDULE_LEVMDL (IDL) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  B_SCHEDULE_LEVMDL ***
grant SELECT                                                                 on B_SCHEDULE_LEVMDL to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on B_SCHEDULE_LEVMDL to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on B_SCHEDULE_LEVMDL to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on B_SCHEDULE_LEVMDL to START1;
grant SELECT                                                                 on B_SCHEDULE_LEVMDL to UPLD;
grant FLASHBACK,SELECT                                                       on B_SCHEDULE_LEVMDL to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/B_SCHEDULE_LEVMDL.sql =========*** End
PROMPT ===================================================================================== 
