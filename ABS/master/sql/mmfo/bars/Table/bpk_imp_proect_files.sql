

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BPK_IMP_PROECT_FILES.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BPK_IMP_PROECT_FILES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BPK_IMP_PROECT_FILES'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''BPK_IMP_PROECT_FILES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''BPK_IMP_PROECT_FILES'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BPK_IMP_PROECT_FILES ***
begin 
  execute immediate '
  CREATE TABLE BARS.BPK_IMP_PROECT_FILES 
   (	ID NUMBER(22,0), 
	FILE_NAME VARCHAR2(30), 
	FILE_DATE DATE, 
	PRODUCT_ID NUMBER(22,0), 
	FILIAL VARCHAR2(5), 
	BRANCH VARCHAR2(30), 
	ISP NUMBER(22,0)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BPK_IMP_PROECT_FILES ***
 exec bpa.alter_policies('BPK_IMP_PROECT_FILES');


COMMENT ON TABLE BARS.BPK_IMP_PROECT_FILES IS 'Таблица файлов для регистрации БПК';
COMMENT ON COLUMN BARS.BPK_IMP_PROECT_FILES.ID IS 'Ид. файла';
COMMENT ON COLUMN BARS.BPK_IMP_PROECT_FILES.FILE_NAME IS 'Имя файла';
COMMENT ON COLUMN BARS.BPK_IMP_PROECT_FILES.FILE_DATE IS 'Дата импорта файла';
COMMENT ON COLUMN BARS.BPK_IMP_PROECT_FILES.PRODUCT_ID IS 'Код продукта';
COMMENT ON COLUMN BARS.BPK_IMP_PROECT_FILES.FILIAL IS 'Код филиала';
COMMENT ON COLUMN BARS.BPK_IMP_PROECT_FILES.BRANCH IS 'Бранч';
COMMENT ON COLUMN BARS.BPK_IMP_PROECT_FILES.ISP IS 'Исполнитель';




PROMPT *** Create  constraint PK_BPKIMPPROECTFILES ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_IMP_PROECT_FILES ADD CONSTRAINT PK_BPKIMPPROECTFILES PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BPKIMPPROECTFILES_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_IMP_PROECT_FILES MODIFY (ID CONSTRAINT CC_BPKIMPPROECTFILES_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BPKIMPPROECTFILES_FNAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_IMP_PROECT_FILES MODIFY (FILE_NAME CONSTRAINT CC_BPKIMPPROECTFILES_FNAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BPKIMPPROECTFILES_FDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_IMP_PROECT_FILES MODIFY (FILE_DATE CONSTRAINT CC_BPKIMPPROECTFILES_FDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_BPKIMPPROECTFILES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_BPKIMPPROECTFILES ON BARS.BPK_IMP_PROECT_FILES (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BPK_IMP_PROECT_FILES ***
grant SELECT                                                                 on BPK_IMP_PROECT_FILES to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on BPK_IMP_PROECT_FILES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BPK_IMP_PROECT_FILES to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on BPK_IMP_PROECT_FILES to OBPC;
grant SELECT                                                                 on BPK_IMP_PROECT_FILES to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BPK_IMP_PROECT_FILES.sql =========*** 
PROMPT ===================================================================================== 
