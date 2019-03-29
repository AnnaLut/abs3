
BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''PRVN_ITOG_R'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M''); 
               bpa.alter_policy_info(''PRVN_ITOG_R'', ''WHOLE'' , null, ''E'', ''E'', ''E'');   
               null;
           end; 
          '; 
END; 
/

   PROMPT *** Create  table PRVN_ITOG_R ***
begin 
  execute immediate '
  CREATE TABLE BARS.PRVN_ITOG_R 
   (KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
    FDAT       DATE,
    FDAT1      DATE,
    KV         NUMBER,
    BV         NUMBER,
    BVQ        NUMBER,
    REZ23      NUMBER,
    REZQ23     NUMBER,
    REZ        NUMBER,
    REZQ       NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  tablespace brssmld ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/
PROMPT *** ALTER_POLICIES to PRVN_ITOG_R ***
 exec bpa.alter_policies('PRVN_ITOG_R');

PROMPT *** Create  constraint PK_PRVN_ITOG_R ***
begin   
 execute immediate '
  ALTER TABLE BARS.PRVN_ITOG_R ADD CONSTRAINT PK_PRVN_ITOG_R PRIMARY KEY (FDAT,KV)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

PROMPT *** Create  index PK_PRVN_ITOG_R ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_PRVN_ITOG_R ON BARS.PRVN_ITOG_R (FDAT, KV) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

PROMPT *** Create  grants  PRVN_ITOG_R ***
grant SELECT                                                                 on PRVN_ITOG_R      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on PRVN_ITOG_R      to RCC_DEAL;
grant SELECT                                                                 on PRVN_ITOG_R      to START1;





                
