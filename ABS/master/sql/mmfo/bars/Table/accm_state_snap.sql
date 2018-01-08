

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ACCM_STATE_SNAP.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ACCM_STATE_SNAP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ACCM_STATE_SNAP'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''ACCM_STATE_SNAP'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ACCM_STATE_SNAP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ACCM_STATE_SNAP ***
begin 
  execute immediate '
  CREATE TABLE BARS.ACCM_STATE_SNAP 
   (	CALDT_ID NUMBER(38,0), 
	SNAP_BALANCE CHAR(1) DEFAULT ''N'', 
	LOCKED VARCHAR2(1), 
	SNAP_SCN NUMBER, 
	SID NUMBER, 
	SERIAL# NUMBER, 
	SNAP_DATE DATE, 
	CALL_SCN NUMBER, 
	CALL_DATE DATE, 
	CALL_FLAG VARCHAR2(30)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSACCM ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ACCM_STATE_SNAP ***
 exec bpa.alter_policies('ACCM_STATE_SNAP');


COMMENT ON TABLE BARS.ACCM_STATE_SNAP IS 'Подсистема накопления. Метаописание состояний снимков в разрезе дат';
COMMENT ON COLUMN BARS.ACCM_STATE_SNAP.CALDT_ID IS 'Ид. календарной даты';
COMMENT ON COLUMN BARS.ACCM_STATE_SNAP.SNAP_BALANCE IS 'Признак наличия снимка баланса';
COMMENT ON COLUMN BARS.ACCM_STATE_SNAP.LOCKED IS 'Флаг блокировки снимка баланса';
COMMENT ON COLUMN BARS.ACCM_STATE_SNAP.SNAP_SCN IS 'SCN создания снимка баланса';
COMMENT ON COLUMN BARS.ACCM_STATE_SNAP.SID IS 'Идентификатор сессии';
COMMENT ON COLUMN BARS.ACCM_STATE_SNAP.SERIAL# IS 'Серийный номер сессии';
COMMENT ON COLUMN BARS.ACCM_STATE_SNAP.SNAP_DATE IS 'Дата+время создания снимка баланса';
COMMENT ON COLUMN BARS.ACCM_STATE_SNAP.CALL_SCN IS 'SCN последнего обращения к снимку баланса';
COMMENT ON COLUMN BARS.ACCM_STATE_SNAP.CALL_DATE IS 'Дата+время последнего обращения к снимку баланса';
COMMENT ON COLUMN BARS.ACCM_STATE_SNAP.CALL_FLAG IS 'Флаг обращения к снимку баланса: CREATED-создан, RECREATED-пересоздан, REUSED-повторно использован';




PROMPT *** Create  constraint CC_ACCMSTATESNAP_SNAPBAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCM_STATE_SNAP ADD CONSTRAINT CC_ACCMSTATESNAP_SNAPBAL CHECK (snap_balance in (''Y'', ''N'')) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_ACCMSTATESNAP ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCM_STATE_SNAP ADD CONSTRAINT PK_ACCMSTATESNAP PRIMARY KEY (CALDT_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSACCM  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCMSTATESNAP_LOCKED_CC ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCM_STATE_SNAP ADD CONSTRAINT CC_ACCMSTATESNAP_LOCKED_CC CHECK (locked=''Y'') ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCMSTATESNAP_CALLFLAG_CC ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCM_STATE_SNAP ADD CONSTRAINT CC_ACCMSTATESNAP_CALLFLAG_CC CHECK (call_flag in (''CREATED'',''RECREATED'',''REUSED'')) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCMSTATESNAP_SNAPBAL_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCM_STATE_SNAP MODIFY (SNAP_BALANCE CONSTRAINT CC_ACCMSTATESNAP_SNAPBAL_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCMSTATESNAP_CALID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCM_STATE_SNAP MODIFY (CALDT_ID CONSTRAINT CC_ACCMSTATESNAP_CALID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ACCMSTATESNAP ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ACCMSTATESNAP ON BARS.ACCM_STATE_SNAP (CALDT_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSACCM ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ACCM_STATE_SNAP ***
grant DELETE,INSERT,SELECT,UPDATE                                            on ACCM_STATE_SNAP to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ACCM_STATE_SNAP to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on ACCM_STATE_SNAP to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ACCM_STATE_SNAP.sql =========*** End *
PROMPT ===================================================================================== 
