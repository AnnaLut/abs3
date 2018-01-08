

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ACCOUNTS_RSRV.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ACCOUNTS_RSRV ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ACCOUNTS_RSRV'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''ACCOUNTS_RSRV'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''ACCOUNTS_RSRV'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ACCOUNTS_RSRV ***
begin 
  execute immediate '
  CREATE TABLE BARS.ACCOUNTS_RSRV 
   (	KF VARCHAR2(6) DEFAULT SYS_CONTEXT(''BARS_CONTEXT'',''USER_MFO''), 
	NLS VARCHAR2(15), 
	KV NUMBER(3,0), 
	NMS VARCHAR2(70), 
	BRANCH VARCHAR2(30) DEFAULT SYS_CONTEXT(''BARS_CONTEXT'',''USER_BRANCH''), 
	ISP NUMBER(38,0), 
	RNK NUMBER(38,0), 
	AGRM_NUM VARCHAR2(40), 
	USR_ID NUMBER(38,0), 
	CRT_DT DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ACCOUNTS_RSRV ***
 exec bpa.alter_policies('ACCOUNTS_RSRV');


COMMENT ON TABLE BARS.ACCOUNTS_RSRV IS 'Зарезервовані номера рахунків';
COMMENT ON COLUMN BARS.ACCOUNTS_RSRV.KF IS 'Код фiлiалу (МФО)';
COMMENT ON COLUMN BARS.ACCOUNTS_RSRV.NLS IS 'Номер рахунку';
COMMENT ON COLUMN BARS.ACCOUNTS_RSRV.KV IS 'Валюта рахунку';
COMMENT ON COLUMN BARS.ACCOUNTS_RSRV.NMS IS 'Назва рахунку';
COMMENT ON COLUMN BARS.ACCOUNTS_RSRV.BRANCH IS 'Код ТВБВ';
COMMENT ON COLUMN BARS.ACCOUNTS_RSRV.ISP IS 'Ід. відповіднального виконавця';
COMMENT ON COLUMN BARS.ACCOUNTS_RSRV.RNK IS 'Реєстраційний Номер Клієнта (РНК)';
COMMENT ON COLUMN BARS.ACCOUNTS_RSRV.AGRM_NUM IS 'Номер договору банківського обслуговування (SPECPARAM.NKD)';
COMMENT ON COLUMN BARS.ACCOUNTS_RSRV.USR_ID IS 'Creator';
COMMENT ON COLUMN BARS.ACCOUNTS_RSRV.CRT_DT IS 'Creation date';




PROMPT *** Create  constraint CC_ACCRSRV_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS_RSRV MODIFY (KF CONSTRAINT CC_ACCRSRV_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCRSRV_NLS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS_RSRV MODIFY (NLS CONSTRAINT CC_ACCRSRV_NLS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCRSRV_KV_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS_RSRV MODIFY (KV CONSTRAINT CC_ACCRSRV_KV_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_ACCRSRV ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS_RSRV ADD CONSTRAINT PK_ACCRSRV PRIMARY KEY (NLS, KV)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ACCRSRV ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ACCRSRV ON BARS.ACCOUNTS_RSRV (NLS, KV) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ACCOUNTS_RSRV ***
grant SELECT                                                                 on ACCOUNTS_RSRV   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ACCOUNTS_RSRV   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ACCOUNTS_RSRV.sql =========*** End ***
PROMPT ===================================================================================== 
