

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DWH_IMPORT_STAT.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DWH_IMPORT_STAT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DWH_IMPORT_STAT'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DWH_IMPORT_STAT'', ''FILIAL'' , ''M'', ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''DWH_IMPORT_STAT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DWH_IMPORT_STAT ***
begin 
  execute immediate '
  CREATE TABLE BARS.DWH_IMPORT_STAT 
   (	SYS_DATE DATE, 
	BANK_DATE DATE, 
	TYPE VARCHAR2(3), 
	STATUS VARCHAR2(10), 
	ERRMSG VARCHAR2(1000), 
	RETRY_CNT NUMBER
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DWH_IMPORT_STAT ***
 exec bpa.alter_policies('DWH_IMPORT_STAT');


COMMENT ON TABLE BARS.DWH_IMPORT_STAT IS 'Сататистика по загрузке в DWH';
COMMENT ON COLUMN BARS.DWH_IMPORT_STAT.SYS_DATE IS 'Системная дата загрузки';
COMMENT ON COLUMN BARS.DWH_IMPORT_STAT.BANK_DATE IS 'Банковская дата загрузки';
COMMENT ON COLUMN BARS.DWH_IMPORT_STAT.TYPE IS 'Тип дня: DAY - только дневная, ALL - дневная+месячная';
COMMENT ON COLUMN BARS.DWH_IMPORT_STAT.STATUS IS 'Статус загрузки банковского дня';
COMMENT ON COLUMN BARS.DWH_IMPORT_STAT.ERRMSG IS '';
COMMENT ON COLUMN BARS.DWH_IMPORT_STAT.RETRY_CNT IS 'Номер попытки загрузки после состояния ERROR';




PROMPT *** Create  constraint XFK_DWHIMPSTAT ***
begin   
 execute immediate '
  ALTER TABLE BARS.DWH_IMPORT_STAT ADD CONSTRAINT XFK_DWHIMPSTAT FOREIGN KEY (STATUS)
	  REFERENCES BARS.DWH_STATUS (STATUS) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XPK_DWHIMPSTAT ***
begin   
 execute immediate '
  ALTER TABLE BARS.DWH_IMPORT_STAT ADD CONSTRAINT XPK_DWHIMPSTAT PRIMARY KEY (BANK_DATE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_DWHIMPSTAT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_DWHIMPSTAT ON BARS.DWH_IMPORT_STAT (BANK_DATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DWH_IMPORT_STAT ***
grant SELECT                                                                 on DWH_IMPORT_STAT to BARSDWH_ACCESS_USER;
grant SELECT                                                                 on DWH_IMPORT_STAT to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DWH_IMPORT_STAT.sql =========*** End *
PROMPT ===================================================================================== 
