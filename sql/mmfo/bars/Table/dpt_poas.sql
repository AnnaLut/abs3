

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPT_POAS.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPT_POAS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPT_POAS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_POAS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_POAS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPT_POAS ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPT_POAS 
   (	ID NUMBER, 
	STAFF_ID NUMBER, 
	FIO VARCHAR2(500), 
	FIO_R VARCHAR2(500), 
	POST VARCHAR2(500), 
	POST_R VARCHAR2(500), 
	POA_DOC VARCHAR2(500), 
	POA_DATE DATE, 
	POA_NOTARY VARCHAR2(500), 
	POA_NOTARY_NUM VARCHAR2(500)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPT_POAS ***
 exec bpa.alter_policies('DPT_POAS');


COMMENT ON TABLE BARS.DPT_POAS IS 'Реєстр довіреностей на підписання договорів';
COMMENT ON COLUMN BARS.DPT_POAS.ID IS 'Ідентифікатор';
COMMENT ON COLUMN BARS.DPT_POAS.STAFF_ID IS 'Ід. користувача підписанта';
COMMENT ON COLUMN BARS.DPT_POAS.FIO IS 'ФИО підписанта';
COMMENT ON COLUMN BARS.DPT_POAS.FIO_R IS 'ФИО підписанта у р.в.';
COMMENT ON COLUMN BARS.DPT_POAS.POST IS 'Посада підписанта';
COMMENT ON COLUMN BARS.DPT_POAS.POST_R IS 'Посада підписанта у р.в.';
COMMENT ON COLUMN BARS.DPT_POAS.POA_DOC IS 'Док. що підтв. повн. у р.в.';
COMMENT ON COLUMN BARS.DPT_POAS.POA_DATE IS 'Дата док. що підтв. повн.';
COMMENT ON COLUMN BARS.DPT_POAS.POA_NOTARY IS 'Зв. та ПІБ нотар.';
COMMENT ON COLUMN BARS.DPT_POAS.POA_NOTARY_NUM IS 'Номер в реєстрі нотар. який посв. д.';




PROMPT *** Create  constraint PK_DPTPOAS ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_POAS ADD CONSTRAINT PK_DPTPOAS PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DPTPOAS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DPTPOAS ON BARS.DPT_POAS (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPT_POAS ***
grant SELECT                                                                 on DPT_POAS        to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_POAS        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPT_POAS        to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_POAS        to DPT_ADMIN;
grant SELECT                                                                 on DPT_POAS        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPT_POAS.sql =========*** End *** ====
PROMPT ===================================================================================== 
