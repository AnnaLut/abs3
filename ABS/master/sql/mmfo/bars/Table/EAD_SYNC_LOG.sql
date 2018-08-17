PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/EAD_SYNC_LOG.sql =========*** Run
PROMPT ===================================================================================== 

PROMPT *** ALTER_POLICY_INFO to EAD_SYNC_LOG ***
BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''EAD_SYNC_LOG'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''EAD_SYNC_LOG'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''EAD_SYNC_LOG'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table EAD_SYNC_LOG ***
begin 
  execute immediate '
create table BARS.EAD_SYNC_LOG
( ID NUMBER(38) not null, 
  CRT_DATE DATE not null, 
  TYPE_ID VARCHAR2(100) not null, 
  CNTROWS NUMBER,
  CNTROWS_ERR NUMBER,
  CNTROWS_DURATION NUMBER,
  CNTROWS_DONE NUMBER,
  CNTROWS_RESPONCE_ERR NUMBER,
  CNTROWS_SERVICE_RUN NUMBER,
  FINISH_DATE DATE,
  KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'') not null)
  TABLESPACE BRSBIGD';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


PROMPT *** ALTER_POLICIES to EAD_SYNC_LOG ***
 exec bpa.alter_policies('EAD_SYNC_LOG');

-- Add comments
COMMENT ON TABLE    BARS.EAD_SYNC_LOG IS 'Логирование работы сервиса синхронизации с ЕА';
COMMENT ON COLUMN BARS.EAD_SYNC_LOG.ID IS 'Ідентифікатор';
COMMENT ON COLUMN BARS.EAD_SYNC_LOG.CRT_DATE IS 'Дата створення';
COMMENT ON COLUMN BARS.EAD_SYNC_LOG.TYPE_ID IS 'Тип повідомлення';
COMMENT ON COLUMN BARS.EAD_SYNC_LOG.KF IS 'МФО';
COMMENT ON COLUMN BARS.EAD_SYNC_LOG.CNTROWS IS 'Кількість вибраних з БД записів (всього)';
COMMENT ON COLUMN BARS.EAD_SYNC_LOG.CNTROWS_ERR IS 'Кількість вибраних з БД записів в статусі ERROR';
COMMENT ON COLUMN BARS.EAD_SYNC_LOG.CNTROWS_DURATION IS 'Тривалість вибірки з БД (Мс)';
COMMENT ON COLUMN BARS.EAD_SYNC_LOG.CNTROWS_DONE IS 'Кількість переданих у ЕА записів (всього)';
COMMENT ON COLUMN BARS.EAD_SYNC_LOG.CNTROWS_RESPONCE_ERR IS 'Кількість переданих у ЕА записів, по яких ЕА повернув помилку';
COMMENT ON COLUMN BARS.EAD_SYNC_LOG.CNTROWS_SERVICE_RUN IS 'Тривалість передачі у ЕА (Мс)';
COMMENT ON COLUMN BARS.EAD_SYNC_LOG.FINISH_DATE IS 'Дата/час завершення передачі';




PROMPT *** Create  grants  EAD_SYNC_LOG ***
grant ALL     on BARS.EAD_SYNC_LOG to BARS_ACCESS_DEFROLE;
grant SELECT  on BARS.EAD_SYNC_LOG to BARSREADER_ROLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/EAD_SYNC_LOG.sql =========*** End
PROMPT =====================================================================================