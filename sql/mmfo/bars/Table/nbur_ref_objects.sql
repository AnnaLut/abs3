

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NBUR_REF_OBJECTS.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NBUR_REF_OBJECTS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NBUR_REF_OBJECTS'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''NBUR_REF_OBJECTS'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''NBUR_REF_OBJECTS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NBUR_REF_OBJECTS ***
begin 
  execute immediate '
  CREATE TABLE BARS.NBUR_REF_OBJECTS 
   (	ID NUMBER(38,0), 
	OBJECT_NAME VARCHAR2(30), 
	SCHEME VARCHAR2(30), 
	OBJECT_TYPE VARCHAR2(30), 
	PROC_INSERT VARCHAR2(61), 
	PROC_UPDATE VARCHAR2(61), 
	PROC_DELETE VARCHAR2(61), 
	NAME_ID_VAR VARCHAR2(30)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to NBUR_REF_OBJECTS ***
 exec bpa.alter_policies('NBUR_REF_OBJECTS');


COMMENT ON TABLE BARS.NBUR_REF_OBJECTS IS 'Список об`єктiв для завантаження';
COMMENT ON COLUMN BARS.NBUR_REF_OBJECTS.ID IS 'Iдентифiкатор об^єкту';
COMMENT ON COLUMN BARS.NBUR_REF_OBJECTS.OBJECT_NAME IS 'Наiменування об^єкту';
COMMENT ON COLUMN BARS.NBUR_REF_OBJECTS.SCHEME IS 'Схема';
COMMENT ON COLUMN BARS.NBUR_REF_OBJECTS.OBJECT_TYPE IS 'Тип об^єкту';
COMMENT ON COLUMN BARS.NBUR_REF_OBJECTS.PROC_INSERT IS 'Процедура вставки';
COMMENT ON COLUMN BARS.NBUR_REF_OBJECTS.PROC_UPDATE IS 'Процедура оновлення';
COMMENT ON COLUMN BARS.NBUR_REF_OBJECTS.PROC_DELETE IS 'Процедура видалення';
COMMENT ON COLUMN BARS.NBUR_REF_OBJECTS.NAME_ID_VAR IS 'Iменований iдентифiкатор об^єкту';




PROMPT *** Create  constraint CC_NBURREFOBJECTS_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_REF_OBJECTS MODIFY (ID CONSTRAINT CC_NBURREFOBJECTS_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NBURREFOBJECTS_OBJECTNM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_REF_OBJECTS MODIFY (OBJECT_NAME CONSTRAINT CC_NBURREFOBJECTS_OBJECTNM_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NBURREFOBJECTS_SCHEME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_REF_OBJECTS MODIFY (SCHEME CONSTRAINT CC_NBURREFOBJECTS_SCHEME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_NBURREFOBJECTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_REF_OBJECTS ADD CONSTRAINT UK_NBURREFOBJECTS UNIQUE (OBJECT_NAME)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NBURREFOBJECTS_PROCINS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_REF_OBJECTS MODIFY (PROC_INSERT CONSTRAINT CC_NBURREFOBJECTS_PROCINS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_NBURREFOBJECTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_REF_OBJECTS ADD CONSTRAINT PK_NBURREFOBJECTS PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NBURREFOBJECTS_OBJECTTP_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_REF_OBJECTS MODIFY (OBJECT_TYPE CONSTRAINT CC_NBURREFOBJECTS_OBJECTTP_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_NBURREFOBJECTS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_NBURREFOBJECTS ON BARS.NBUR_REF_OBJECTS (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_NBURREFOBJECTS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_NBURREFOBJECTS ON BARS.NBUR_REF_OBJECTS (OBJECT_NAME) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  NBUR_REF_OBJECTS ***
grant SELECT                                                                 on NBUR_REF_OBJECTS to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NBUR_REF_OBJECTS.sql =========*** End 
PROMPT ===================================================================================== 
