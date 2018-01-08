

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ACC_SOB.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ACC_SOB ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ACC_SOB'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''ACC_SOB'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''ACC_SOB'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ACC_SOB ***
begin 
  execute immediate '
  CREATE TABLE BARS.ACC_SOB 
   (	ACC NUMBER(38,0), 
	ID NUMBER(38,0), 
	ISP NUMBER(38,0), 
	FDAT DATE, 
	TXT VARCHAR2(4000), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 5 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ACC_SOB ***
 exec bpa.alter_policies('ACC_SOB');


COMMENT ON TABLE BARS.ACC_SOB IS 'Календарь событий счетов';
COMMENT ON COLUMN BARS.ACC_SOB.ACC IS 'Счет';
COMMENT ON COLUMN BARS.ACC_SOB.ID IS 'Идентификатор записи';
COMMENT ON COLUMN BARS.ACC_SOB.ISP IS 'Идентификатор пользователя';
COMMENT ON COLUMN BARS.ACC_SOB.FDAT IS 'Дата события';
COMMENT ON COLUMN BARS.ACC_SOB.TXT IS 'Событие';
COMMENT ON COLUMN BARS.ACC_SOB.KF IS '';




PROMPT *** Create  constraint PK_ACCSOB ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_SOB ADD CONSTRAINT PK_ACCSOB PRIMARY KEY (ACC, ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCSOB_FDAT ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_SOB ADD CONSTRAINT CC_ACCSOB_FDAT CHECK (fdat = trunc(fdat)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCSOB_ACC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_SOB MODIFY (ACC CONSTRAINT CC_ACCSOB_ACC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCSOB_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_SOB MODIFY (ID CONSTRAINT CC_ACCSOB_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCSOB_ISP_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_SOB MODIFY (ISP CONSTRAINT CC_ACCSOB_ISP_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCSOB_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_SOB MODIFY (KF CONSTRAINT CC_ACCSOB_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ACCSOB ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ACCSOB ON BARS.ACC_SOB (ACC, ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ACC_SOB ***
grant DELETE,INSERT,SELECT,UPDATE                                            on ACC_SOB         to ABS_ADMIN;
grant SELECT                                                                 on ACC_SOB         to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on ACC_SOB         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ACC_SOB         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on ACC_SOB         to CUST001;
grant SELECT                                                                 on ACC_SOB         to START1;
grant SELECT                                                                 on ACC_SOB         to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on ACC_SOB         to WR_ALL_RIGHTS;
grant DELETE,INSERT,SELECT,UPDATE                                            on ACC_SOB         to WR_VIEWACC;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ACC_SOB.sql =========*** End *** =====
PROMPT ===================================================================================== 
