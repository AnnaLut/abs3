

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/B_SCHEDULE_SUBDIV_USER.sql =========**
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to B_SCHEDULE_SUBDIV_USER ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table B_SCHEDULE_SUBDIV_USER ***
begin 
  execute immediate '
  CREATE TABLE BARS.B_SCHEDULE_SUBDIV_USER 
   (	IDD NUMBER, 
	IDU NUMBER, 
	CHIEF NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to B_SCHEDULE_SUBDIV_USER ***
 exec bpa.alter_policies('B_SCHEDULE_SUBDIV_USER');


COMMENT ON TABLE BARS.B_SCHEDULE_SUBDIV_USER IS '';
COMMENT ON COLUMN BARS.B_SCHEDULE_SUBDIV_USER.IDD IS '';
COMMENT ON COLUMN BARS.B_SCHEDULE_SUBDIV_USER.IDU IS '';
COMMENT ON COLUMN BARS.B_SCHEDULE_SUBDIV_USER.CHIEF IS 'ќзнака кер≥вника -1';




PROMPT *** Create  constraint CC_BSCHEDSUBDIVU_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.B_SCHEDULE_SUBDIV_USER ADD CONSTRAINT CC_BSCHEDSUBDIVU_NN CHECK (IDU IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_BSCHEDSUBDIVU ***
begin   
 execute immediate '
  ALTER TABLE BARS.B_SCHEDULE_SUBDIV_USER ADD CONSTRAINT PK_BSCHEDSUBDIVU PRIMARY KEY (IDU)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index CC_BSCHEDSUBDIVU_NN ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.CC_BSCHEDSUBDIVU_NN ON BARS.B_SCHEDULE_SUBDIV_USER (IDU) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  B_SCHEDULE_SUBDIV_USER ***
grant DELETE,INSERT,SELECT,UPDATE                                            on B_SCHEDULE_SUBDIV_USER to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on B_SCHEDULE_SUBDIV_USER to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on B_SCHEDULE_SUBDIV_USER to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/B_SCHEDULE_SUBDIV_USER.sql =========**
PROMPT ===================================================================================== 
