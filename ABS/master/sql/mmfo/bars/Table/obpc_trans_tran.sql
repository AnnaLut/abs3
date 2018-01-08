

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OBPC_TRANS_TRAN.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OBPC_TRANS_TRAN ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OBPC_TRANS_TRAN'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''OBPC_TRANS_TRAN'', ''FILIAL'' , ''F'', ''F'', ''F'', ''F'');
               bpa.alter_policy_info(''OBPC_TRANS_TRAN'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OBPC_TRANS_TRAN ***
begin 
  execute immediate '
  CREATE TABLE BARS.OBPC_TRANS_TRAN 
   (	TRAN_TYPE CHAR(2), 
	TIP CHAR(3), 
	KV NUMBER(3,0), 
	TRANSIT_ACC NUMBER(38,0), 
	BRANCH VARCHAR2(30), 
	ACC_F_SHORT NUMBER(38,0), 
	ACC_F_LONG NUMBER(38,0), 
	ACC_U_SHORT NUMBER(38,0), 
	ACC_U_LONG NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OBPC_TRANS_TRAN ***
 exec bpa.alter_policies('OBPC_TRANS_TRAN');


COMMENT ON TABLE BARS.OBPC_TRANS_TRAN IS 'Транзиты ПЦ в разрезе типов операций и типов карточек';
COMMENT ON COLUMN BARS.OBPC_TRANS_TRAN.TRAN_TYPE IS 'Тип операции ПЦ';
COMMENT ON COLUMN BARS.OBPC_TRANS_TRAN.TIP IS 'Тип счета';
COMMENT ON COLUMN BARS.OBPC_TRANS_TRAN.KV IS 'Валюта';
COMMENT ON COLUMN BARS.OBPC_TRANS_TRAN.TRANSIT_ACC IS 'Ид. счета';
COMMENT ON COLUMN BARS.OBPC_TRANS_TRAN.BRANCH IS '';
COMMENT ON COLUMN BARS.OBPC_TRANS_TRAN.ACC_F_SHORT IS 'Ид. счета для ФЛ с действием карточки <=12 мес.';
COMMENT ON COLUMN BARS.OBPC_TRANS_TRAN.ACC_F_LONG IS 'Ид. счета для ФЛ с действием карточки >12 мес.';
COMMENT ON COLUMN BARS.OBPC_TRANS_TRAN.ACC_U_SHORT IS 'Ид. счета для ЮЛ с действием карточки <=12 мес.';
COMMENT ON COLUMN BARS.OBPC_TRANS_TRAN.ACC_U_LONG IS 'Ид. счета для ЮЛ с действием карточки >12 мес.';




PROMPT *** Create  constraint PK_OBPCTRANSTRAN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBPC_TRANS_TRAN ADD CONSTRAINT PK_OBPCTRANSTRAN PRIMARY KEY (BRANCH, TRAN_TYPE, TIP, KV)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OBPCTRANSTRAN_TRANTYPE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBPC_TRANS_TRAN MODIFY (TRAN_TYPE CONSTRAINT CC_OBPCTRANSTRAN_TRANTYPE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OBPCTRANSTRAN_TIP_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBPC_TRANS_TRAN MODIFY (TIP CONSTRAINT CC_OBPCTRANSTRAN_TIP_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OBPCTRANSTRAN_KV_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBPC_TRANS_TRAN MODIFY (KV CONSTRAINT CC_OBPCTRANSTRAN_KV_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OBPCTRANSTRAN_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBPC_TRANS_TRAN MODIFY (BRANCH CONSTRAINT CC_OBPCTRANSTRAN_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OBPCTRANSTRAN ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_OBPCTRANSTRAN ON BARS.OBPC_TRANS_TRAN (BRANCH, TRAN_TYPE, TIP, KV) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OBPC_TRANS_TRAN ***
grant SELECT                                                                 on OBPC_TRANS_TRAN to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on OBPC_TRANS_TRAN to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OBPC_TRANS_TRAN to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on OBPC_TRANS_TRAN to OBPC;
grant SELECT                                                                 on OBPC_TRANS_TRAN to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OBPC_TRANS_TRAN.sql =========*** End *
PROMPT ===================================================================================== 
