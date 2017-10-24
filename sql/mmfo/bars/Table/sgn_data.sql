

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SGN_DATA.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SGN_DATA ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SGN_DATA'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''SGN_DATA'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SGN_DATA ***
begin 
  execute immediate '
  CREATE TABLE BARS.SGN_DATA 
   (	ID NUMBER, 
	SIGN_TYPE VARCHAR2(3), 
	KEY_ID VARCHAR2(256), 
	CREATING_DATE DATE, 
	SIGN_HEX CLOB
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD 
 LOB (SIGN_HEX) STORE AS BASICFILE (
  TABLESPACE BRSBIGD ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SGN_DATA ***
 exec bpa.alter_policies('SGN_DATA');


COMMENT ON TABLE BARS.SGN_DATA IS 'Сховище данних з ЕЦП';
COMMENT ON COLUMN BARS.SGN_DATA.ID IS 'Ідентифікатор підпису';
COMMENT ON COLUMN BARS.SGN_DATA.SIGN_TYPE IS 'Тип ЕЦП';
COMMENT ON COLUMN BARS.SGN_DATA.KEY_ID IS 'Ідентифікатор ключа';
COMMENT ON COLUMN BARS.SGN_DATA.CREATING_DATE IS 'Дата створення підпису';
COMMENT ON COLUMN BARS.SGN_DATA.SIGN_HEX IS 'Підпис в представленні HEX';




PROMPT *** Create  constraint CC_SGNDATA_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SGN_DATA MODIFY (ID CONSTRAINT CC_SGNDATA_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SGNDATA_SIGNTYPE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SGN_DATA MODIFY (SIGN_TYPE CONSTRAINT CC_SGNDATA_SIGNTYPE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SGNDATA_KEYID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SGN_DATA MODIFY (KEY_ID CONSTRAINT CC_SGNDATA_KEYID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SGNDATA_SGNTYPE_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.SGN_DATA ADD CONSTRAINT FK_SGNDATA_SGNTYPE_ID FOREIGN KEY (SIGN_TYPE)
	  REFERENCES BARS.SGN_TYPE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SGNDATA_SIGN_HEX_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SGN_DATA MODIFY (SIGN_HEX CONSTRAINT CC_SGNDATA_SIGN_HEX_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_SGNDATA ***
begin   
 execute immediate '
  ALTER TABLE BARS.SGN_DATA ADD CONSTRAINT PK_SGNDATA PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SGNDATA_CRDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SGN_DATA MODIFY (CREATING_DATE CONSTRAINT CC_SGNDATA_CRDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SGNDATA ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SGNDATA ON BARS.SGN_DATA (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SGN_DATA ***
grant SELECT                                                                 on SGN_DATA        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SGN_DATA        to TOSS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SGN_DATA.sql =========*** End *** ====
PROMPT ===================================================================================== 
