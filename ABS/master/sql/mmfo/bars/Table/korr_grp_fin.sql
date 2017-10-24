

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KORR_GRP_FIN.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KORR_GRP_FIN ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KORR_GRP_FIN'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KORR_GRP_FIN'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KORR_GRP_FIN'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KORR_GRP_FIN ***
begin 
  execute immediate '
  CREATE TABLE BARS.KORR_GRP_FIN 
   (	GRP NUMBER(*,0), 
	FIN NUMBER(*,0)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KORR_GRP_FIN ***
 exec bpa.alter_policies('KORR_GRP_FIN');


COMMENT ON TABLE BARS.KORR_GRP_FIN IS '';
COMMENT ON COLUMN BARS.KORR_GRP_FIN.GRP IS '';
COMMENT ON COLUMN BARS.KORR_GRP_FIN.FIN IS '';




PROMPT *** Create  constraint PK_KORR_GRP_FIN ***
begin   
 execute immediate '
  ALTER TABLE BARS.KORR_GRP_FIN ADD CONSTRAINT PK_KORR_GRP_FIN PRIMARY KEY (GRP)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_KORR_GRP_GRP ***
begin   
 execute immediate '
  ALTER TABLE BARS.KORR_GRP_FIN MODIFY (GRP CONSTRAINT CC_KORR_GRP_GRP NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_KORR_GRP_FIN ***
begin   
 execute immediate '
  ALTER TABLE BARS.KORR_GRP_FIN MODIFY (FIN CONSTRAINT CC_KORR_GRP_FIN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_KORR_GRP_FIN ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_KORR_GRP_FIN ON BARS.KORR_GRP_FIN (GRP) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  KORR_GRP_FIN ***
grant DELETE,INSERT,SELECT,UPDATE                                            on KORR_GRP_FIN    to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on KORR_GRP_FIN    to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KORR_GRP_FIN.sql =========*** End *** 
PROMPT ===================================================================================== 
