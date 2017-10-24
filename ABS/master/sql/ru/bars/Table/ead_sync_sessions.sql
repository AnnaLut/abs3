

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/EAD_SYNC_SESSIONS.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to EAD_SYNC_SESSIONS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''EAD_SYNC_SESSIONS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''EAD_SYNC_SESSIONS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table EAD_SYNC_SESSIONS ***
begin 
  execute immediate '
  CREATE TABLE BARS.EAD_SYNC_SESSIONS 
   (	TYPE_ID VARCHAR2(100), 
	CDC_LASTKEY VARCHAR2(300), 
	SYNC_START DATE, 
	SYNC_END DATE, 
	MSG_COUNT NUMBER, 
	ERROR_COUNT NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to EAD_SYNC_SESSIONS ***
 exec bpa.alter_policies('EAD_SYNC_SESSIONS');


COMMENT ON TABLE BARS.EAD_SYNC_SESSIONS IS 'Cеанси синхронізації з ЕА';
COMMENT ON COLUMN BARS.EAD_SYNC_SESSIONS.TYPE_ID IS 'Ід. типу';
COMMENT ON COLUMN BARS.EAD_SYNC_SESSIONS.CDC_LASTKEY IS 'Останній ключ для захвату змін';
COMMENT ON COLUMN BARS.EAD_SYNC_SESSIONS.SYNC_START IS 'Дата/час початку';
COMMENT ON COLUMN BARS.EAD_SYNC_SESSIONS.SYNC_END IS 'Дата/час кінця';
COMMENT ON COLUMN BARS.EAD_SYNC_SESSIONS.MSG_COUNT IS 'Кіл-ть оброблених повідомлень';
COMMENT ON COLUMN BARS.EAD_SYNC_SESSIONS.ERROR_COUNT IS 'Кіл-ть повідомлень оброблених з помилками';




PROMPT *** Create  constraint FK_EADSYNCSNS_TID_EADTYPES_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.EAD_SYNC_SESSIONS ADD CONSTRAINT FK_EADSYNCSNS_TID_EADTYPES_ID FOREIGN KEY (TYPE_ID)
	  REFERENCES BARS.EAD_TYPES (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_EADSYNCSNS ***
begin   
 execute immediate '
  ALTER TABLE BARS.EAD_SYNC_SESSIONS ADD CONSTRAINT PK_EADSYNCSNS PRIMARY KEY (TYPE_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_EADSYNCSNS_CLK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.EAD_SYNC_SESSIONS MODIFY (CDC_LASTKEY CONSTRAINT CC_EADSYNCSNS_CLK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_EADSYNCSNS_TID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.EAD_SYNC_SESSIONS MODIFY (TYPE_ID CONSTRAINT CC_EADSYNCSNS_TID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_EADSYNCSNS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_EADSYNCSNS ON BARS.EAD_SYNC_SESSIONS (TYPE_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  EAD_SYNC_SESSIONS ***
grant SELECT                                                                 on EAD_SYNC_SESSIONS to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/EAD_SYNC_SESSIONS.sql =========*** End
PROMPT ===================================================================================== 
