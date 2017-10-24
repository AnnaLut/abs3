

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OW_PKK_HISTORY.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OW_PKK_HISTORY ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OW_PKK_HISTORY'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''OW_PKK_HISTORY'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''OW_PKK_HISTORY'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OW_PKK_HISTORY ***
begin 
  execute immediate '
  CREATE TABLE BARS.OW_PKK_HISTORY 
   (	REF NUMBER(22,0), 
	ACC NUMBER(22,0), 
	DK NUMBER(1,0), 
	F_N VARCHAR2(100), 
	K_DATE DATE DEFAULT sysdate, 
	K_DONEBY VARCHAR2(30) DEFAULT user, 
	RESP_CLASS VARCHAR2(100), 
	RESP_CODE VARCHAR2(100), 
	RESP_TEXT VARCHAR2(254), 
	DRN NUMBER(22,0), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OW_PKK_HISTORY ***
 exec bpa.alter_policies('OW_PKK_HISTORY');


COMMENT ON TABLE BARS.OW_PKK_HISTORY IS 'OW. Очередь на отправку/квитовку документов ЦРВ';
COMMENT ON COLUMN BARS.OW_PKK_HISTORY.REF IS 'Реф';
COMMENT ON COLUMN BARS.OW_PKK_HISTORY.ACC IS 'Acc';
COMMENT ON COLUMN BARS.OW_PKK_HISTORY.DK IS '0-Д, 1-К';
COMMENT ON COLUMN BARS.OW_PKK_HISTORY.F_N IS 'Имя файла, в кот. отправлен док.';
COMMENT ON COLUMN BARS.OW_PKK_HISTORY.K_DATE IS 'Дата квитовки/удаления документа';
COMMENT ON COLUMN BARS.OW_PKK_HISTORY.K_DONEBY IS 'Пользователь, кот. сквитовал/удалил док.';
COMMENT ON COLUMN BARS.OW_PKK_HISTORY.RESP_CLASS IS '';
COMMENT ON COLUMN BARS.OW_PKK_HISTORY.RESP_CODE IS '';
COMMENT ON COLUMN BARS.OW_PKK_HISTORY.RESP_TEXT IS '';
COMMENT ON COLUMN BARS.OW_PKK_HISTORY.DRN IS '';
COMMENT ON COLUMN BARS.OW_PKK_HISTORY.KF IS '';




PROMPT *** Create  constraint PK_OWPKKHISTORY ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_PKK_HISTORY ADD CONSTRAINT PK_OWPKKHISTORY PRIMARY KEY (REF, DK)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OWPKKHISTORY_DK ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_PKK_HISTORY ADD CONSTRAINT CC_OWPKKHISTORY_DK CHECK (dk in (0,1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OWPKKHISTORY_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_PKK_HISTORY MODIFY (KF CONSTRAINT CC_OWPKKHISTORY_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_OWPKKHISTORY_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_PKK_HISTORY ADD CONSTRAINT FK_OWPKKHISTORY_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_OWPKKHISTORY_IICFILES ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_PKK_HISTORY ADD CONSTRAINT FK_OWPKKHISTORY_IICFILES FOREIGN KEY (F_N)
	  REFERENCES BARS.OW_IICFILES (FILE_NAME) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OWPKKHISTORY_REF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_PKK_HISTORY MODIFY (REF CONSTRAINT CC_OWPKKHISTORY_REF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OWPKKHISTORY_ACC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_PKK_HISTORY MODIFY (ACC CONSTRAINT CC_OWPKKHISTORY_ACC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OWPKKHISTORY_DK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_PKK_HISTORY MODIFY (DK CONSTRAINT CC_OWPKKHISTORY_DK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_OWPKKHISTORY_FN ***
begin   
 execute immediate '
  CREATE INDEX BARS.I_OWPKKHISTORY_FN ON BARS.OW_PKK_HISTORY (F_N) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OWPKKHISTORY ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_OWPKKHISTORY ON BARS.OW_PKK_HISTORY (REF, DK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_OWPKKHISTORY_DRN ***
begin   
 execute immediate '
  CREATE INDEX BARS.I_OWPKKHISTORY_DRN ON BARS.OW_PKK_HISTORY (DRN) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OW_PKK_HISTORY ***
grant INSERT,SELECT                                                          on OW_PKK_HISTORY  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OW_PKK_HISTORY  to BARS_DM;
grant INSERT,SELECT                                                          on OW_PKK_HISTORY  to OW;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OW_PKK_HISTORY.sql =========*** End **
PROMPT ===================================================================================== 
