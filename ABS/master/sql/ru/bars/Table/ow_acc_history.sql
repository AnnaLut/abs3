

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OW_ACC_HISTORY.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OW_ACC_HISTORY ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OW_ACC_HISTORY'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''OW_ACC_HISTORY'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OW_ACC_HISTORY ***
begin 
  execute immediate '
  CREATE TABLE BARS.OW_ACC_HISTORY 
   (	ACC NUMBER(22,0), 
	S NUMBER(24,0), 
	DAT DATE, 
	F_N VARCHAR2(100), 
	K_DATE DATE DEFAULT sysdate, 
	K_DONEBY VARCHAR2(30) DEFAULT user, 
	RESP_CLASS VARCHAR2(100), 
	RESP_CODE VARCHAR2(100), 
	RESP_TEXT VARCHAR2(254)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OW_ACC_HISTORY ***
 exec bpa.alter_policies('OW_ACC_HISTORY');


COMMENT ON TABLE BARS.OW_ACC_HISTORY IS 'Історія - Черга арештованих рахунків до відправки в ПЦ';
COMMENT ON COLUMN BARS.OW_ACC_HISTORY.ACC IS 'ACC';
COMMENT ON COLUMN BARS.OW_ACC_HISTORY.S IS 'Арештована сума';
COMMENT ON COLUMN BARS.OW_ACC_HISTORY.DAT IS 'Дата встановлення суми арешту';
COMMENT ON COLUMN BARS.OW_ACC_HISTORY.F_N IS 'Ім'я файлу';
COMMENT ON COLUMN BARS.OW_ACC_HISTORY.K_DATE IS 'Дата квитовки/видалення';
COMMENT ON COLUMN BARS.OW_ACC_HISTORY.K_DONEBY IS 'Хто сквитував/видалив';
COMMENT ON COLUMN BARS.OW_ACC_HISTORY.RESP_CLASS IS '';
COMMENT ON COLUMN BARS.OW_ACC_HISTORY.RESP_CODE IS '';
COMMENT ON COLUMN BARS.OW_ACC_HISTORY.RESP_TEXT IS '';




PROMPT *** Create  constraint FK_OWACCHISTORY_OWIICFILES ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_ACC_HISTORY ADD CONSTRAINT FK_OWACCHISTORY_OWIICFILES FOREIGN KEY (F_N)
	  REFERENCES BARS.OW_IICFILES (FILE_NAME) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_OWACCHOSTORY_ACCOUNTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_ACC_HISTORY ADD CONSTRAINT FK_OWACCHOSTORY_ACCOUNTS FOREIGN KEY (ACC)
	  REFERENCES BARS.ACCOUNTS (ACC) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OWACCHISTORY_S_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_ACC_HISTORY MODIFY (S CONSTRAINT CC_OWACCHISTORY_S_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OWACCHISTORY_ACC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_ACC_HISTORY MODIFY (ACC CONSTRAINT CC_OWACCHISTORY_ACC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OW_ACC_HISTORY.sql =========*** End **
PROMPT ===================================================================================== 
