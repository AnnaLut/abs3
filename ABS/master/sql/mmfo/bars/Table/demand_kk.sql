

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DEMAND_KK.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DEMAND_KK ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DEMAND_KK'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DEMAND_KK'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''DEMAND_KK'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DEMAND_KK ***
begin 
  execute immediate '
  CREATE TABLE BARS.DEMAND_KK 
   (	KK VARCHAR2(1), 
	NAME VARCHAR2(64)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DEMAND_KK ***
 exec bpa.alter_policies('DEMAND_KK');


COMMENT ON TABLE BARS.DEMAND_KK IS '';
COMMENT ON COLUMN BARS.DEMAND_KK.KK IS '';
COMMENT ON COLUMN BARS.DEMAND_KK.NAME IS '';




PROMPT *** Create  constraint PK_DEMANDKK ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEMAND_KK ADD CONSTRAINT PK_DEMANDKK PRIMARY KEY (KK)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DEMANDKK_KK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEMAND_KK MODIFY (KK CONSTRAINT CC_DEMANDKK_KK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DEMANDKK_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEMAND_KK MODIFY (NAME CONSTRAINT CC_DEMANDKK_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DEMANDKK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DEMANDKK ON BARS.DEMAND_KK (KK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DEMAND_KK ***
grant SELECT                                                                 on DEMAND_KK       to BARSUPL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DEMAND_KK       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DEMAND_KK       to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on DEMAND_KK       to DEMAND;
grant DELETE,INSERT,SELECT,UPDATE                                            on DEMAND_KK       to OBPC;
grant SELECT                                                                 on DEMAND_KK       to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DEMAND_KK       to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on DEMAND_KK       to WR_REFREAD;



PROMPT *** Create SYNONYM  to DEMAND_KK ***

  CREATE OR REPLACE PUBLIC SYNONYM DEMAND_KK FOR BARS.DEMAND_KK;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DEMAND_KK.sql =========*** End *** ===
PROMPT ===================================================================================== 
