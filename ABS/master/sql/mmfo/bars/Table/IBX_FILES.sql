

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/IBX_FILES.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to IBX_FILES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''IBX_FILES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''IBX_FILES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table IBX_FILES ***
begin 
  execute immediate '
  CREATE TABLE BARS.IBX_FILES 
   (	TYPE_ID VARCHAR2(256), 
	FILE_NAME VARCHAR2(256), 
	FILE_DATE DATE, 
	TOTAL_COUNT NUMBER, 
	TOTAL_SUM NUMBER, 
	LOADED DATE
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to IBX_FILES ***
 exec bpa.alter_policies('IBX_FILES');


COMMENT ON TABLE BARS.IBX_FILES IS 'Таблица импортированных IBOX-файлов';
COMMENT ON COLUMN BARS.IBX_FILES.TYPE_ID IS 'Тип интерфейса';
COMMENT ON COLUMN BARS.IBX_FILES.FILE_NAME IS 'Имя файла';
COMMENT ON COLUMN BARS.IBX_FILES.FILE_DATE IS 'Дата файла';
COMMENT ON COLUMN BARS.IBX_FILES.TOTAL_COUNT IS 'Всего записей';
COMMENT ON COLUMN BARS.IBX_FILES.TOTAL_SUM IS 'Всего сумма';
COMMENT ON COLUMN BARS.IBX_FILES.LOADED IS 'Дата/время принятия';




PROMPT *** Create  constraint PK_IBXFILES ***
begin   
 execute immediate '
  ALTER TABLE BARS.IBX_FILES ADD CONSTRAINT PK_IBXFILES PRIMARY KEY (TYPE_ID, FILE_NAME)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_IBXFILES_TSUM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.IBX_FILES ADD CONSTRAINT CC_IBXFILES_TSUM_NN CHECK (TOTAL_SUM IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_IBXFILES_IBOXTYPE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.IBX_FILES ADD CONSTRAINT CC_IBXFILES_IBOXTYPE_NN CHECK (TYPE_ID IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_IBXFILES_FILENAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.IBX_FILES ADD CONSTRAINT CC_IBXFILES_FILENAME_NN CHECK (FILE_NAME IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_IBXFILES_FDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.IBX_FILES ADD CONSTRAINT CC_IBXFILES_FDATE_NN CHECK (FILE_DATE IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_IBXFILES_TCOUNT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.IBX_FILES ADD CONSTRAINT CC_IBXFILES_TCOUNT_NN CHECK (TOTAL_COUNT IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_IBXFILES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_IBXFILES ON BARS.IBX_FILES (TYPE_ID, FILE_NAME) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  IBX_FILES ***
grant SELECT                                                                 on IBX_FILES       to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/IBX_FILES.sql =========*** End *** ===
PROMPT ===================================================================================== 
