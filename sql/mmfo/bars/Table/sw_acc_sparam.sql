

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SW_ACC_SPARAM.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SW_ACC_SPARAM ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SW_ACC_SPARAM'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''SW_ACC_SPARAM'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''SW_ACC_SPARAM'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SW_ACC_SPARAM ***
begin 
  execute immediate '
  CREATE TABLE BARS.SW_ACC_SPARAM 
   (	ACC NUMBER(38,0), 
	USE4MT950 NUMBER(1,0) DEFAULT 0, 
	USE4MT900 NUMBER(1,0) DEFAULT 0, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SW_ACC_SPARAM ***
 exec bpa.alter_policies('SW_ACC_SPARAM');


COMMENT ON TABLE BARS.SW_ACC_SPARAM IS 'SWT. Спецпараметры счетов для модуля SWIFT';
COMMENT ON COLUMN BARS.SW_ACC_SPARAM.ACC IS 'Идентификатор счета';
COMMENT ON COLUMN BARS.SW_ACC_SPARAM.USE4MT950 IS 'Признак использования для выписки МТ950';
COMMENT ON COLUMN BARS.SW_ACC_SPARAM.USE4MT900 IS 'Признак использования для уведомления МТ900/МТ910';
COMMENT ON COLUMN BARS.SW_ACC_SPARAM.KF IS '';




PROMPT *** Create  constraint CC_SWACCSPARAM_USE4MT950 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_ACC_SPARAM ADD CONSTRAINT CC_SWACCSPARAM_USE4MT950 CHECK (use4mt950 in (0, 1)) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWACCSPARAM_USE4MT900 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_ACC_SPARAM ADD CONSTRAINT CC_SWACCSPARAM_USE4MT900 CHECK (use4mt950 in (0, 1)) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWACCSPARAM_ACC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_ACC_SPARAM MODIFY (ACC CONSTRAINT CC_SWACCSPARAM_ACC_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWACCSPARAM_USE4MT950_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_ACC_SPARAM MODIFY (USE4MT950 CONSTRAINT CC_SWACCSPARAM_USE4MT950_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWACCSPARAM_USE4MT900_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_ACC_SPARAM MODIFY (USE4MT900 CONSTRAINT CC_SWACCSPARAM_USE4MT900_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWACCSPARAM_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_ACC_SPARAM MODIFY (KF CONSTRAINT CC_SWACCSPARAM_KF_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_SWACCSPARAM ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_ACC_SPARAM ADD CONSTRAINT PK_SWACCSPARAM PRIMARY KEY (ACC)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SWACCSPARAM ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SWACCSPARAM ON BARS.SW_ACC_SPARAM (ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SW_ACC_SPARAM ***
grant DELETE,INSERT,SELECT,UPDATE                                            on SW_ACC_SPARAM   to BARS013;
grant SELECT                                                                 on SW_ACC_SPARAM   to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on SW_ACC_SPARAM   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SW_ACC_SPARAM   to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on SW_ACC_SPARAM   to CUST001;
grant SELECT                                                                 on SW_ACC_SPARAM   to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SW_ACC_SPARAM   to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to SW_ACC_SPARAM ***

  CREATE OR REPLACE PUBLIC SYNONYM SW_ACC_SPARAM FOR BARS.SW_ACC_SPARAM;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SW_ACC_SPARAM.sql =========*** End ***
PROMPT ===================================================================================== 
