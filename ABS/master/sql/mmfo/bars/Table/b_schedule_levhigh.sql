

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/B_SCHEDULE_LEVHIGH.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to B_SCHEDULE_LEVHIGH ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table B_SCHEDULE_LEVHIGH ***
begin 
  execute immediate '
  CREATE TABLE BARS.B_SCHEDULE_LEVHIGH 
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




PROMPT *** ALTER_POLICIES to B_SCHEDULE_LEVHIGH ***
 exec bpa.alter_policies('B_SCHEDULE_LEVHIGH');


COMMENT ON TABLE BARS.B_SCHEDULE_LEVHIGH IS 'Штатний розклад. Департаменти (рівень 1).';
COMMENT ON COLUMN BARS.B_SCHEDULE_LEVHIGH.IDL IS '';
COMMENT ON COLUMN BARS.B_SCHEDULE_LEVHIGH.NAMEL IS '';




PROMPT *** Create  constraint CC_BSHEDLEVHIGH_IDL_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.B_SCHEDULE_LEVHIGH ADD CONSTRAINT CC_BSHEDLEVHIGH_IDL_NN CHECK (IDL IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_BSHEDLEVHIGH ***
begin   
 execute immediate '
  ALTER TABLE BARS.B_SCHEDULE_LEVHIGH ADD CONSTRAINT PK_BSHEDLEVHIGH PRIMARY KEY (IDL)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_BSHEDLEVHIGH_IDL ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_BSHEDLEVHIGH_IDL ON BARS.B_SCHEDULE_LEVHIGH (IDL) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  B_SCHEDULE_LEVHIGH ***
grant SELECT                                                                 on B_SCHEDULE_LEVHIGH to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on B_SCHEDULE_LEVHIGH to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on B_SCHEDULE_LEVHIGH to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on B_SCHEDULE_LEVHIGH to START1;
grant SELECT                                                                 on B_SCHEDULE_LEVHIGH to UPLD;
grant FLASHBACK,SELECT                                                       on B_SCHEDULE_LEVHIGH to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/B_SCHEDULE_LEVHIGH.sql =========*** En
PROMPT ===================================================================================== 
