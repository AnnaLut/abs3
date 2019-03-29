
BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''PRVN_ITOG_F'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M''); 
               bpa.alter_policy_info(''PRVN_ITOG_F'', ''WHOLE'' , null, ''E'', ''E'', ''E'');   
               null;
           end; 
          '; 
END; 
/

   PROMPT *** Create  table PRVN_ITOG_F ***
begin 
  execute immediate '
  CREATE TABLE BARS.PRVN_ITOG_F 
   (KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
    FDAT       DATE,
    KV         NUMBER,
    SDF        NUMBER,
    SDFQ       NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  tablespace brssmld ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/
PROMPT *** ALTER_POLICIES to PRVN_ITOG_F ***
 exec bpa.alter_policies('PRVN_ITOG_F');

PROMPT *** Create  constraint PK_PRVN_ITOG_F ***
begin   
 execute immediate '
  ALTER TABLE BARS.PRVN_ITOG_F ADD CONSTRAINT PK_PRVN_ITOG_F PRIMARY KEY (FDAT,KV)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

PROMPT *** Create  index PK_PRVN_ITOG_F ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_PRVN_ITOG_F ON BARS.PRVN_ITOG_F (FDAT, KV) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

PROMPT *** Create  grants  PRVN_ITOG_F ***
grant SELECT                                                                 on PRVN_ITOG_F      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on PRVN_ITOG_F      to RCC_DEAL;
grant SELECT                                                                 on PRVN_ITOG_F      to START1;





                
