

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/MOPER_ACCERTED_FILES.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to MOPER_ACCERTED_FILES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''MOPER_ACCERTED_FILES'', ''FILIAL'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table MOPER_ACCERTED_FILES ***
begin 
  execute immediate '
  CREATE TABLE BARS.MOPER_ACCERTED_FILES 
   (	FNAME VARCHAR2(100), 
	FSUM VARCHAR2(100), 
	ACCDAT DATE DEFAULT SYSDATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to MOPER_ACCERTED_FILES ***
 exec bpa.alter_policies('MOPER_ACCERTED_FILES');


COMMENT ON TABLE BARS.MOPER_ACCERTED_FILES IS 'Таблица оплаченых файлов MOPER';
COMMENT ON COLUMN BARS.MOPER_ACCERTED_FILES.FNAME IS 'Имя файла';
COMMENT ON COLUMN BARS.MOPER_ACCERTED_FILES.FSUM IS 'Контрольная сумма файла';
COMMENT ON COLUMN BARS.MOPER_ACCERTED_FILES.ACCDAT IS 'Дата оплаты';




PROMPT *** Create  constraint XPK_MOPER_ACCERTED_FILES ***
begin   
 execute immediate '
  ALTER TABLE BARS.MOPER_ACCERTED_FILES ADD CONSTRAINT XPK_MOPER_ACCERTED_FILES PRIMARY KEY (FNAME, FSUM)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_MOPER_ACCERTED_FILES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_MOPER_ACCERTED_FILES ON BARS.MOPER_ACCERTED_FILES (FNAME, FSUM) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  MOPER_ACCERTED_FILES ***
grant SELECT                                                                 on MOPER_ACCERTED_FILES to BARSREADER_ROLE;
grant INSERT,SELECT,UPDATE                                                   on MOPER_ACCERTED_FILES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on MOPER_ACCERTED_FILES to UPLD;



PROMPT *** Create SYNONYM  to MOPER_ACCERTED_FILES ***

  CREATE OR REPLACE PUBLIC SYNONYM MOPER_ACCERTED_FILES FOR BARS.MOPER_ACCERTED_FILES;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/MOPER_ACCERTED_FILES.sql =========*** 
PROMPT ===================================================================================== 
