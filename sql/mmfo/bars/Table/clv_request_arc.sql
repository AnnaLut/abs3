

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CLV_REQUEST_ARC.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CLV_REQUEST_ARC ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CLV_REQUEST_ARC'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CLV_REQUEST_ARC'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CLV_REQUEST_ARC'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CLV_REQUEST_ARC ***
begin 
  execute immediate '
  CREATE TABLE BARS.CLV_REQUEST_ARC 
   (	RNK NUMBER(38,0), 
	REQ_DATE DATE, 
	REQ_USERID NUMBER(22,0), 
	REQ_TYPE NUMBER(1,0), 
	APR_DATE DATE, 
	APR_USERID NUMBER(22,0), 
	APR_STATUS NUMBER(1,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CLV_REQUEST_ARC ***
 exec bpa.alter_policies('CLV_REQUEST_ARC');


COMMENT ON TABLE BARS.CLV_REQUEST_ARC IS 'Запити на зміну реквізитів клієнтів';
COMMENT ON COLUMN BARS.CLV_REQUEST_ARC.RNK IS 'РНК';
COMMENT ON COLUMN BARS.CLV_REQUEST_ARC.REQ_DATE IS 'Дата запиту';
COMMENT ON COLUMN BARS.CLV_REQUEST_ARC.REQ_USERID IS 'Ід.користувача-автора запиту';
COMMENT ON COLUMN BARS.CLV_REQUEST_ARC.REQ_TYPE IS 'Тип: 0-створення КК, 1-оновлення КК, 2-запит(0) відхилено';
COMMENT ON COLUMN BARS.CLV_REQUEST_ARC.APR_DATE IS 'Дата підтвердження/відхилення';
COMMENT ON COLUMN BARS.CLV_REQUEST_ARC.APR_USERID IS 'Ід.користувача, що підтвердив/відхилив запит';
COMMENT ON COLUMN BARS.CLV_REQUEST_ARC.APR_STATUS IS 'Статус запиту: 0-відхилено, 1-підтверджено, 2-змінено';




PROMPT *** Create  constraint CC_CLVREQUESTARC_REQTYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.CLV_REQUEST_ARC ADD CONSTRAINT CC_CLVREQUESTARC_REQTYPE CHECK (req_type in (0,1,2)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CLVREQUESTARC_APRSTATUS ***
begin   
 execute immediate '
  ALTER TABLE BARS.CLV_REQUEST_ARC ADD CONSTRAINT CC_CLVREQUESTARC_APRSTATUS CHECK (apr_status in (0,1,2)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_CLVREQUESTARC ***
begin   
 execute immediate '
  ALTER TABLE BARS.CLV_REQUEST_ARC ADD CONSTRAINT PK_CLVREQUESTARC PRIMARY KEY (RNK, APR_DATE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CLVREQARC_RNK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CLV_REQUEST_ARC MODIFY (RNK CONSTRAINT CC_CLVREQARC_RNK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CLVREQARC_REQDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CLV_REQUEST_ARC MODIFY (REQ_DATE CONSTRAINT CC_CLVREQARC_REQDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CLVREQARC_REQUSERID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CLV_REQUEST_ARC MODIFY (REQ_USERID CONSTRAINT CC_CLVREQARC_REQUSERID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CLVREQARC_REQTYPE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CLV_REQUEST_ARC MODIFY (REQ_TYPE CONSTRAINT CC_CLVREQARC_REQTYPE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CLVREQARC_APRDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CLV_REQUEST_ARC MODIFY (APR_DATE CONSTRAINT CC_CLVREQARC_APRDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CLVREQARC_APRUSERID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CLV_REQUEST_ARC MODIFY (APR_USERID CONSTRAINT CC_CLVREQARC_APRUSERID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CLVREQARC_APRSTATUS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CLV_REQUEST_ARC MODIFY (APR_STATUS CONSTRAINT CC_CLVREQARC_APRSTATUS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CLVREQUESTARC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CLVREQUESTARC ON BARS.CLV_REQUEST_ARC (RNK, APR_DATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CLV_REQUEST_ARC ***
grant SELECT                                                                 on CLV_REQUEST_ARC to BARSREADER_ROLE;
grant SELECT                                                                 on CLV_REQUEST_ARC to BARS_DM;
grant SELECT                                                                 on CLV_REQUEST_ARC to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CLV_REQUEST_ARC.sql =========*** End *
PROMPT ===================================================================================== 
