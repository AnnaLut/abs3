

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NBUR_REF_FORM_STRU.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NBUR_REF_FORM_STRU ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NBUR_REF_FORM_STRU'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''NBUR_REF_FORM_STRU'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''NBUR_REF_FORM_STRU'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NBUR_REF_FORM_STRU ***
begin 
  execute immediate '
  CREATE TABLE BARS.NBUR_REF_FORM_STRU 
   (	FILE_ID NUMBER(12,0), 
	SEGMENT_NUMBER NUMBER(2,0), 
	SEGMENT_CODE VARCHAR2(30), 
	SEGMENT_NAME VARCHAR2(70), 
	SEGMENT_RULE VARCHAR2(70), 
	KEY_ATTRIBUTE VARCHAR2(1), 
	SORT_ATTRIBUTE NUMBER(2,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to NBUR_REF_FORM_STRU ***
 exec bpa.alter_policies('NBUR_REF_FORM_STRU');


COMMENT ON TABLE BARS.NBUR_REF_FORM_STRU IS 'Опис структури показника';
COMMENT ON COLUMN BARS.NBUR_REF_FORM_STRU.FILE_ID IS 'Iдентифiкатор файлу';
COMMENT ON COLUMN BARS.NBUR_REF_FORM_STRU.SEGMENT_NUMBER IS 'Номер сегменту показника';
COMMENT ON COLUMN BARS.NBUR_REF_FORM_STRU.SEGMENT_CODE IS 'Код сегменту показника';
COMMENT ON COLUMN BARS.NBUR_REF_FORM_STRU.SEGMENT_NAME IS 'Назва сегменту (опис)';
COMMENT ON COLUMN BARS.NBUR_REF_FORM_STRU.SEGMENT_RULE IS 'Формула визначення сегменту';
COMMENT ON COLUMN BARS.NBUR_REF_FORM_STRU.KEY_ATTRIBUTE IS 'Ознака наявностi ключа';
COMMENT ON COLUMN BARS.NBUR_REF_FORM_STRU.SORT_ATTRIBUTE IS 'Ознака сортування сегменту';




PROMPT *** Create  constraint SYS_C0084960 ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_REF_FORM_STRU MODIFY (FILE_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0084961 ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_REF_FORM_STRU MODIFY (SEGMENT_NUMBER NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_FILES_FORMSTRU ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_REF_FORM_STRU ADD CONSTRAINT FK_FILES_FORMSTRU FOREIGN KEY (FILE_ID)
	  REFERENCES BARS.NBUR_REF_FILES (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0084963 ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_REF_FORM_STRU MODIFY (SEGMENT_RULE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_NBUR_REF_FORM_STRU ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_REF_FORM_STRU ADD CONSTRAINT PK_NBUR_REF_FORM_STRU PRIMARY KEY (FILE_ID, SEGMENT_NUMBER)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0084962 ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_REF_FORM_STRU MODIFY (SEGMENT_NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_NBUR_REF_FORM_STRU ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_NBUR_REF_FORM_STRU ON BARS.NBUR_REF_FORM_STRU (FILE_ID, SEGMENT_NUMBER) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  NBUR_REF_FORM_STRU ***
grant SELECT                                                                 on NBUR_REF_FORM_STRU to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NBUR_REF_FORM_STRU.sql =========*** En
PROMPT ===================================================================================== 
