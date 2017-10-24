

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DEMAND_FILIALES.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DEMAND_FILIALES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DEMAND_FILIALES'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DEMAND_FILIALES'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''DEMAND_FILIALES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DEMAND_FILIALES ***
begin 
  execute immediate '
  CREATE TABLE BARS.DEMAND_FILIALES 
   (	CODE VARCHAR2(5), 
	NAME VARCHAR2(31), 
	CITY VARCHAR2(15), 
	STREET VARCHAR2(27), 
	MFO NUMBER(*,0), 
	CLIENT_0 VARCHAR2(7), 
	CLIENT_1 VARCHAR2(7), 
	ABVR_NAME VARCHAR2(27), 
	CHANGE_DATE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DEMAND_FILIALES ***
 exec bpa.alter_policies('DEMAND_FILIALES');


COMMENT ON TABLE BARS.DEMAND_FILIALES IS '';
COMMENT ON COLUMN BARS.DEMAND_FILIALES.CODE IS '';
COMMENT ON COLUMN BARS.DEMAND_FILIALES.NAME IS '';
COMMENT ON COLUMN BARS.DEMAND_FILIALES.CITY IS '';
COMMENT ON COLUMN BARS.DEMAND_FILIALES.STREET IS '';
COMMENT ON COLUMN BARS.DEMAND_FILIALES.MFO IS '';
COMMENT ON COLUMN BARS.DEMAND_FILIALES.CLIENT_0 IS '';
COMMENT ON COLUMN BARS.DEMAND_FILIALES.CLIENT_1 IS '';
COMMENT ON COLUMN BARS.DEMAND_FILIALES.ABVR_NAME IS '';
COMMENT ON COLUMN BARS.DEMAND_FILIALES.CHANGE_DATE IS '';




PROMPT *** Create  constraint PK_DEMANDFILIALES ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEMAND_FILIALES ADD CONSTRAINT PK_DEMANDFILIALES PRIMARY KEY (CODE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DEMANDFILIALES_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEMAND_FILIALES MODIFY (NAME CONSTRAINT CC_DEMANDFILIALES_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DEMANDFILIALES_MFO_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEMAND_FILIALES MODIFY (MFO CONSTRAINT CC_DEMANDFILIALES_MFO_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DEMANDFILIALES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DEMANDFILIALES ON BARS.DEMAND_FILIALES (CODE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_DEMANFILIALES ***
begin   
 execute immediate '
  CREATE INDEX BARS.I_DEMANFILIALES ON BARS.DEMAND_FILIALES (MFO) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DEMAND_FILIALES ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DEMAND_FILIALES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DEMAND_FILIALES to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on DEMAND_FILIALES to DEMAND;
grant DELETE,INSERT,SELECT,UPDATE                                            on DEMAND_FILIALES to OBPC;
grant SELECT                                                                 on DEMAND_FILIALES to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DEMAND_FILIALES to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on DEMAND_FILIALES to WR_REFREAD;



PROMPT *** Create SYNONYM  to DEMAND_FILIALES ***

  CREATE OR REPLACE PUBLIC SYNONYM DEMAND_FILIALES FOR BARS.DEMAND_FILIALES;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DEMAND_FILIALES.sql =========*** End *
PROMPT ===================================================================================== 
