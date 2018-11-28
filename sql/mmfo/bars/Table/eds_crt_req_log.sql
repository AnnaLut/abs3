PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/EDS_CRT_REQ_LOG.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to EDS_CRT_REQ_LOG ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''EDS_CRT_REQ_LOG'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''EDS_CRT_REQ_LOG'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''EDS_CRT_REQ_LOG'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table EDS_CRT_REQ_LOG ***
begin 
  execute immediate '
  CREATE TABLE BARS.EDS_CRT_REQ_LOG 
   (    ID VARCHAR2(36), 
    TRANSP_REQ_ID VARCHAR2(255), 
    SO_KF VARCHAR2(6), 
    DECL_ID NUMBER, 
    REQ_USER_ID NUMBER, 
    REQ_TIME DATE, 
    RESP_TIME DATE, 
    REQ_BODY VARCHAR2(4000), 
    RESP_BODY VARCHAR2(4000), 
    REQ_STATUS NUMBER, 
    ERR VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to EDS_CRT_REQ_LOG ***
 exec bpa.alter_policies('EDS_CRT_REQ_LOG');


COMMENT ON TABLE BARS.EDS_CRT_REQ_LOG IS 'Журнал запитів на створення декларації';
COMMENT ON COLUMN BARS.EDS_CRT_REQ_LOG.ID IS 'ІД запиту';
COMMENT ON COLUMN BARS.EDS_CRT_REQ_LOG.TRANSP_REQ_ID IS 'Ід транспотру';
COMMENT ON COLUMN BARS.EDS_CRT_REQ_LOG.SO_KF IS 'КФ джерела запиту';
COMMENT ON COLUMN BARS.EDS_CRT_REQ_LOG.DECL_ID IS 'ІД декларації';
COMMENT ON COLUMN BARS.EDS_CRT_REQ_LOG.REQ_USER_ID IS 'ІД користувача під яким прийшов запит';
COMMENT ON COLUMN BARS.EDS_CRT_REQ_LOG.REQ_TIME IS 'Час прийняття запиту';
COMMENT ON COLUMN BARS.EDS_CRT_REQ_LOG.RESP_TIME IS 'Час відправки відповіді';
COMMENT ON COLUMN BARS.EDS_CRT_REQ_LOG.REQ_BODY IS 'Тіло запиту';
COMMENT ON COLUMN BARS.EDS_CRT_REQ_LOG.RESP_BODY IS 'Тіло відповіді';
COMMENT ON COLUMN BARS.EDS_CRT_REQ_LOG.REQ_STATUS IS 'Стан запиту';
COMMENT ON COLUMN BARS.EDS_CRT_REQ_LOG.ERR IS 'Помилкі';




PROMPT *** Create  index PK_EDS_CRT_REQ_LOG ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_EDS_CRT_REQ_LOG ON BARS.EDS_CRT_REQ_LOG (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  constraint PK_EDS_CRT_REQ_LOG ***
begin   
 execute immediate '
  ALTER TABLE BARS.EDS_CRT_REQ_LOG ADD CONSTRAINT PK_EDS_CRT_REQ_LOG PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/EDS_CRT_REQ_LOG.sql =========*** End *
PROMPT ===================================================================================== 

