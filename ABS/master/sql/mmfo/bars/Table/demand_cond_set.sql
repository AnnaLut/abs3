

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DEMAND_COND_SET.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DEMAND_COND_SET ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DEMAND_COND_SET'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DEMAND_COND_SET'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''DEMAND_COND_SET'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DEMAND_COND_SET ***
begin 
  execute immediate '
  CREATE TABLE BARS.DEMAND_COND_SET 
   (	CARD_TYPE NUMBER(1,0), 
	COND_SET NUMBER(38,0), 
	NAME VARCHAR2(8), 
	CURRENCY VARCHAR2(3), 
	C_VALIDITY NUMBER(*,0), 
	BL_10 VARCHAR2(1), 
	DEB_INTR NUMBER(6,2), 
	OLIM_INTR NUMBER(6,2), 
	CRED_INTR NUMBER(6,2), 
	LATE_INTR NUMBER(6,2), 
	CARD_FEE NUMBER(9,2), 
	CARD_FEE1 NUMBER(9,2), 
	NOTE VARCHAR2(1), 
	CHANGE_DATE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DEMAND_COND_SET ***
 exec bpa.alter_policies('DEMAND_COND_SET');


COMMENT ON TABLE BARS.DEMAND_COND_SET IS '';
COMMENT ON COLUMN BARS.DEMAND_COND_SET.CARD_TYPE IS '';
COMMENT ON COLUMN BARS.DEMAND_COND_SET.COND_SET IS '';
COMMENT ON COLUMN BARS.DEMAND_COND_SET.NAME IS '';
COMMENT ON COLUMN BARS.DEMAND_COND_SET.CURRENCY IS '';
COMMENT ON COLUMN BARS.DEMAND_COND_SET.C_VALIDITY IS '';
COMMENT ON COLUMN BARS.DEMAND_COND_SET.BL_10 IS '';
COMMENT ON COLUMN BARS.DEMAND_COND_SET.DEB_INTR IS '';
COMMENT ON COLUMN BARS.DEMAND_COND_SET.OLIM_INTR IS '';
COMMENT ON COLUMN BARS.DEMAND_COND_SET.CRED_INTR IS '';
COMMENT ON COLUMN BARS.DEMAND_COND_SET.LATE_INTR IS '';
COMMENT ON COLUMN BARS.DEMAND_COND_SET.CARD_FEE IS '';
COMMENT ON COLUMN BARS.DEMAND_COND_SET.CARD_FEE1 IS '';
COMMENT ON COLUMN BARS.DEMAND_COND_SET.NOTE IS '';
COMMENT ON COLUMN BARS.DEMAND_COND_SET.CHANGE_DATE IS '';




PROMPT *** Create  constraint PK_DEMANDCONDSET ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEMAND_COND_SET ADD CONSTRAINT PK_DEMANDCONDSET PRIMARY KEY (CARD_TYPE, COND_SET)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DEMANDCONDSET_CARDTYPE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEMAND_COND_SET MODIFY (CARD_TYPE CONSTRAINT CC_DEMANDCONDSET_CARDTYPE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DEMANDCONDSET_CONDSET_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEMAND_COND_SET MODIFY (COND_SET CONSTRAINT CC_DEMANDCONDSET_CONDSET_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DEMANDCONDSET ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DEMANDCONDSET ON BARS.DEMAND_COND_SET (CARD_TYPE, COND_SET) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DEMAND_COND_SET ***
grant SELECT                                                                 on DEMAND_COND_SET to BARSDWH_ACCESS_USER;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DEMAND_COND_SET to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DEMAND_COND_SET to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on DEMAND_COND_SET to DEMAND;
grant DELETE,INSERT,SELECT,UPDATE                                            on DEMAND_COND_SET to OBPC;
grant SELECT                                                                 on DEMAND_COND_SET to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DEMAND_COND_SET to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on DEMAND_COND_SET to WR_REFREAD;



PROMPT *** Create SYNONYM  to DEMAND_COND_SET ***

  CREATE OR REPLACE PUBLIC SYNONYM DEMAND_COND_SET FOR BARS.DEMAND_COND_SET;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DEMAND_COND_SET.sql =========*** End *
PROMPT ===================================================================================== 
