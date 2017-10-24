

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CASH_LIMITS_ATM.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CASH_LIMITS_ATM ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CASH_LIMITS_ATM'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CASH_LIMITS_ATM'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CASH_LIMITS_ATM'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CASH_LIMITS_ATM ***
begin 
  execute immediate '
  CREATE TABLE BARS.CASH_LIMITS_ATM 
   (	ACC NUMBER(38,0), 
	LIM_DATE DATE, 
	LIM_CURRENT NUMBER(24,0) DEFAULT 0, 
	LIM_MAX NUMBER(24,0) DEFAULT 0
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CASH_LIMITS_ATM ***
 exec bpa.alter_policies('CASH_LIMITS_ATM');


COMMENT ON TABLE BARS.CASH_LIMITS_ATM IS 'Ліміти банкоматів';
COMMENT ON COLUMN BARS.CASH_LIMITS_ATM.ACC IS 'Рахунок банкомату';
COMMENT ON COLUMN BARS.CASH_LIMITS_ATM.LIM_DATE IS 'Дата встановлення ліміту';
COMMENT ON COLUMN BARS.CASH_LIMITS_ATM.LIM_CURRENT IS 'Ліміт банкомату поточний';
COMMENT ON COLUMN BARS.CASH_LIMITS_ATM.LIM_MAX IS 'Ліміт банкомату максимальний';




PROMPT *** Create  constraint PK_CASHLIMITSATM ***
begin   
 execute immediate '
  ALTER TABLE BARS.CASH_LIMITS_ATM ADD CONSTRAINT PK_CASHLIMITSATM PRIMARY KEY (ACC, LIM_DATE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CASHLIMITSATM_ACC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CASH_LIMITS_ATM MODIFY (ACC CONSTRAINT CASHLIMITSATM_ACC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CASHLIMITSATM_LIMDAT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CASH_LIMITS_ATM MODIFY (LIM_DATE CONSTRAINT CASHLIMITSATM_LIMDAT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CASHLIMITSATM_LIMCUR_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CASH_LIMITS_ATM MODIFY (LIM_CURRENT CONSTRAINT CASHLIMITSATM_LIMCUR_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CASHLIMITSATM_LIMMAX_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CASH_LIMITS_ATM MODIFY (LIM_MAX CONSTRAINT CASHLIMITSATM_LIMMAX_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CASHLIMITSATM ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CASHLIMITSATM ON BARS.CASH_LIMITS_ATM (ACC, LIM_DATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CASH_LIMITS_ATM ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CASH_LIMITS_ATM to ABS_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on CASH_LIMITS_ATM to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CASH_LIMITS_ATM to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CASH_LIMITS_ATM to RPBN001;
grant SELECT                                                                 on CASH_LIMITS_ATM to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CASH_LIMITS_ATM.sql =========*** End *
PROMPT ===================================================================================== 
