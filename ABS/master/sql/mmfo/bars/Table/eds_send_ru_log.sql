

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/EDS_SEND_RU_LOG.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to EDS_SEND_RU_LOG ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''EDS_SEND_RU_LOG'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''EDS_SEND_RU_LOG'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''EDS_SEND_RU_LOG'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table EDS_SEND_RU_LOG ***
begin 
  execute immediate '
  CREATE TABLE BARS.EDS_SEND_RU_LOG 
   (    REQ_ID VARCHAR2(36), 
    TRANS_ID VARCHAR2(36), 
    TRANSP_SUB_ID VARCHAR2(36), 
    STATUS NUMBER, 
    ERR VARCHAR2(4000), 
    KF VARCHAR2(6)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to EDS_SEND_RU_LOG ***
 exec bpa.alter_policies('EDS_SEND_RU_LOG');


COMMENT ON TABLE BARS.EDS_SEND_RU_LOG IS 'Лог відправки запитів на РУ';
COMMENT ON COLUMN BARS.EDS_SEND_RU_LOG.REQ_ID IS 'Ід запиту';
COMMENT ON COLUMN BARS.EDS_SEND_RU_LOG.TRANS_ID IS 'Ід транспорту';
COMMENT ON COLUMN BARS.EDS_SEND_RU_LOG.TRANSP_SUB_ID IS 'Ід запиту транспорту на РУ';
COMMENT ON COLUMN BARS.EDS_SEND_RU_LOG.STATUS IS 'Статус';
COMMENT ON COLUMN BARS.EDS_SEND_RU_LOG.ERR IS 'Текст помилки';
COMMENT ON COLUMN BARS.EDS_SEND_RU_LOG.KF IS '';




PROMPT *** Create  index PK_EDS_SEND_RU_LOG ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_EDS_SEND_RU_LOG ON BARS.EDS_SEND_RU_LOG (REQ_ID, KF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  constraint PK_EDS_SEND_RU_LOG ***
begin   
 execute immediate '
  ALTER TABLE BARS.EDS_SEND_RU_LOG ADD CONSTRAINT PK_EDS_SEND_RU_LOG PRIMARY KEY (REQ_ID, KF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/EDS_SEND_RU_LOG.sql =========*** End *
PROMPT ===================================================================================== 

