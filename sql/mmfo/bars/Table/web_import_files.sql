

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/WEB_IMPORT_FILES.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to WEB_IMPORT_FILES ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table WEB_IMPORT_FILES ***
begin 
  execute immediate '
  CREATE TABLE BARS.WEB_IMPORT_FILES 
   (	YR NUMBER(*,0), 
	FN VARCHAR2(12), 
	BDT DATE, 
	SDT DATE DEFAULT sysdate
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to WEB_IMPORT_FILES ***
 exec bpa.alter_policies('WEB_IMPORT_FILES');


COMMENT ON TABLE BARS.WEB_IMPORT_FILES IS 'Заголовки файлов импорта документов от Энергорынка';
COMMENT ON COLUMN BARS.WEB_IMPORT_FILES.YR IS 'Номер года файла: 2006,2007,...';
COMMENT ON COLUMN BARS.WEB_IMPORT_FILES.FN IS 'Имя файла';
COMMENT ON COLUMN BARS.WEB_IMPORT_FILES.BDT IS 'Банковская дата во время импорта';
COMMENT ON COLUMN BARS.WEB_IMPORT_FILES.SDT IS 'Системная дата во время импорта';




PROMPT *** Create  constraint XPK_WEB_IMPORT_FILES ***
begin   
 execute immediate '
  ALTER TABLE BARS.WEB_IMPORT_FILES ADD CONSTRAINT XPK_WEB_IMPORT_FILES PRIMARY KEY (YR, FN)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_WEB_IMP_FL_BDT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WEB_IMPORT_FILES MODIFY (BDT CONSTRAINT CC_WEB_IMP_FL_BDT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_WEB_IMP_FL_SDT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WEB_IMPORT_FILES MODIFY (SDT CONSTRAINT CC_WEB_IMP_FL_SDT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_WEB_IMPORT_FILES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_WEB_IMPORT_FILES ON BARS.WEB_IMPORT_FILES (YR, FN) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index IE_WEB_IMPORT_FILES_BDT ***
begin   
 execute immediate '
  CREATE INDEX BARS.IE_WEB_IMPORT_FILES_BDT ON BARS.WEB_IMPORT_FILES (BDT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  WEB_IMPORT_FILES ***
grant SELECT                                                                 on WEB_IMPORT_FILES to BARSREADER_ROLE;
grant SELECT                                                                 on WEB_IMPORT_FILES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on WEB_IMPORT_FILES to BARS_DM;
grant SELECT                                                                 on WEB_IMPORT_FILES to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on WEB_IMPORT_FILES to WR_ALL_RIGHTS;
grant SELECT                                                                 on WEB_IMPORT_FILES to WR_IMPEXP;



PROMPT *** Create SYNONYM  to WEB_IMPORT_FILES ***

  CREATE OR REPLACE PUBLIC SYNONYM WEB_IMPORT_FILES FOR BARS.WEB_IMPORT_FILES;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/WEB_IMPORT_FILES.sql =========*** End 
PROMPT ===================================================================================== 
