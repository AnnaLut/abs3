

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/FINMON_QUE.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to FINMON_QUE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''FINMON_QUE'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''FINMON_QUE'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''FINMON_QUE'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table FINMON_QUE ***
begin 
  execute immediate '
  CREATE TABLE BARS.FINMON_QUE 
   (	ID NUMBER, 
	REF NUMBER, 
	REC NUMBER, 
	STATUS VARCHAR2(2), 
	OPR_VID1 VARCHAR2(15) DEFAULT ''999999999999999'', 
	OPR_VID2 VARCHAR2(4) DEFAULT ''0000'', 
	COMM_VID2 VARCHAR2(254), 
	OPR_VID3 VARCHAR2(3) DEFAULT ''000'', 
	COMM_VID3 VARCHAR2(254), 
	AGENT_ID NUMBER, 
	IN_DATE DATE DEFAULT SYSDATE, 
	MONITOR_MODE NUMBER(1,0) DEFAULT 0, 
	RNK_A NUMBER, 
	RNK_B NUMBER, 
	COMMENTS VARCHAR2(254), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	DAT_I DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to FINMON_QUE ***
 exec bpa.alter_policies('FINMON_QUE');


COMMENT ON TABLE BARS.FINMON_QUE IS 'Очередь подозрительных сообщений для импорта в финмониторинг';
COMMENT ON COLUMN BARS.FINMON_QUE.ID IS 'Ид.';
COMMENT ON COLUMN BARS.FINMON_QUE.REF IS 'Референс документа АБС';
COMMENT ON COLUMN BARS.FINMON_QUE.REC IS 'Rec документа АБС';
COMMENT ON COLUMN BARS.FINMON_QUE.STATUS IS 'Статус';
COMMENT ON COLUMN BARS.FINMON_QUE.OPR_VID1 IS 'Код вида операции';
COMMENT ON COLUMN BARS.FINMON_QUE.OPR_VID2 IS 'Код признака операции подпадающей под мониторинг';
COMMENT ON COLUMN BARS.FINMON_QUE.COMM_VID2 IS 'Комментарий';
COMMENT ON COLUMN BARS.FINMON_QUE.OPR_VID3 IS 'Код признака оперции по внутрн. мониторингу';
COMMENT ON COLUMN BARS.FINMON_QUE.COMM_VID3 IS 'Комментарий';
COMMENT ON COLUMN BARS.FINMON_QUE.AGENT_ID IS 'Идентификатор пользователя-информатора';
COMMENT ON COLUMN BARS.FINMON_QUE.IN_DATE IS 'Дата+Время внесения операции в очередь';
COMMENT ON COLUMN BARS.FINMON_QUE.MONITOR_MODE IS 'Режим мониторинга клиентов: 0-по МФО, 1-сторона А, 2-сторона Б, 3-обоих';
COMMENT ON COLUMN BARS.FINMON_QUE.RNK_A IS 'Код клиента по стороне А';
COMMENT ON COLUMN BARS.FINMON_QUE.RNK_B IS 'Код клиента по стороне Б';
COMMENT ON COLUMN BARS.FINMON_QUE.COMMENTS IS 'Коментар';
COMMENT ON COLUMN BARS.FINMON_QUE.KF IS '';
COMMENT ON COLUMN BARS.FINMON_QUE.DAT_I IS 'Дата поступления/получения сообщения об операции';




PROMPT *** Create  constraint FINMON_QUE_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.FINMON_QUE ADD CONSTRAINT FINMON_QUE_ID PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_FINMONQUE_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.FINMON_QUE MODIFY (KF CONSTRAINT CC_FINMONQUE_KF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDX_FINMON_QUE_REF ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.IDX_FINMON_QUE_REF ON BARS.FINMON_QUE (REF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDX_FINMON_QUE_REC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.IDX_FINMON_QUE_REC ON BARS.FINMON_QUE (REC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index FINMON_QUE_ID ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.FINMON_QUE_ID ON BARS.FINMON_QUE (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  FINMON_QUE ***
grant SELECT                                                                 on FINMON_QUE      to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on FINMON_QUE      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on FINMON_QUE      to BARS_DM;
grant ALTER,DEBUG,DELETE,FLASHBACK,INDEX,INSERT,ON COMMIT REFRESH,QUERY REWRITE,REFERENCES,SELECT,UPDATE on FINMON_QUE      to FINMON;
grant DELETE,INSERT,SELECT,UPDATE                                            on FINMON_QUE      to FINMON01;
grant SELECT                                                                 on FINMON_QUE      to UPLD;



PROMPT *** Create SYNONYM  to FINMON_QUE ***

  CREATE OR REPLACE PUBLIC SYNONYM FINMON_QUE FOR BARS.FINMON_QUE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/FINMON_QUE.sql =========*** End *** ==
PROMPT ===================================================================================== 
