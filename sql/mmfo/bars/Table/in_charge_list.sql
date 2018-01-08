

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/IN_CHARGE_LIST.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to IN_CHARGE_LIST ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''IN_CHARGE_LIST'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''IN_CHARGE_LIST'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''IN_CHARGE_LIST'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table IN_CHARGE_LIST ***
begin 
  execute immediate '
  CREATE TABLE BARS.IN_CHARGE_LIST 
   (	IN_CHARGE NUMBER(38,0), 
	CHARGE_NAME VARCHAR2(30)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to IN_CHARGE_LIST ***
 exec bpa.alter_policies('IN_CHARGE_LIST');


COMMENT ON TABLE BARS.IN_CHARGE_LIST IS 'Виды ЭЦП на визах';
COMMENT ON COLUMN BARS.IN_CHARGE_LIST.IN_CHARGE IS 'Код вида ЭЦП';
COMMENT ON COLUMN BARS.IN_CHARGE_LIST.CHARGE_NAME IS 'Наименование вида ЭЦП';




PROMPT *** Create  constraint PK_INCHARGE ***
begin   
 execute immediate '
  ALTER TABLE BARS.IN_CHARGE_LIST ADD CONSTRAINT PK_INCHARGE PRIMARY KEY (IN_CHARGE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INCHARGE_INCHARGE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.IN_CHARGE_LIST MODIFY (IN_CHARGE CONSTRAINT CC_INCHARGE_INCHARGE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INCHARGE_CHARGENAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.IN_CHARGE_LIST MODIFY (CHARGE_NAME CONSTRAINT CC_INCHARGE_CHARGENAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_INCHARGE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_INCHARGE ON BARS.IN_CHARGE_LIST (IN_CHARGE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  IN_CHARGE_LIST ***
grant DELETE,INSERT,SELECT,UPDATE                                            on IN_CHARGE_LIST  to ABS_ADMIN;
grant SELECT                                                                 on IN_CHARGE_LIST  to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on IN_CHARGE_LIST  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on IN_CHARGE_LIST  to BARS_DM;
grant SELECT                                                                 on IN_CHARGE_LIST  to START1;
grant SELECT                                                                 on IN_CHARGE_LIST  to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on IN_CHARGE_LIST  to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/IN_CHARGE_LIST.sql =========*** End **
PROMPT ===================================================================================== 
