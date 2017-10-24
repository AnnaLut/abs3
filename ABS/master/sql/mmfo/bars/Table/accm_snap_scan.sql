

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ACCM_SNAP_SCAN.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ACCM_SNAP_SCAN ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ACCM_SNAP_SCAN'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''ACCM_SNAP_SCAN'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ACCM_SNAP_SCAN'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ACCM_SNAP_SCAN ***
begin 
  execute immediate '
  CREATE TABLE BARS.ACCM_SNAP_SCAN 
   (	SCAN_ID NUMBER(*,0), 
	FDAT DATE, 
	TABLE_NAME VARCHAR2(30), 
	SCAN_SCN NUMBER, 
	SCAN_DATE DATE, 
	THRESHOLD_SCN NUMBER, 
	THRESHOLD_DATEINFO VARCHAR2(30), 
	MOD_ACC NUMBER(*,0), 
	MOD_SCN NUMBER, 
	MOD_DATEINFO VARCHAR2(30), 
	QUERY_CONDITION VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ACCM_SNAP_SCAN ***
 exec bpa.alter_policies('ACCM_SNAP_SCAN');


COMMENT ON TABLE BARS.ACCM_SNAP_SCAN IS 'Результаты сканирования партиций таблиц SALDOA, SALDOA_DEL_ROWS, SALDOB на предмет изменений';
COMMENT ON COLUMN BARS.ACCM_SNAP_SCAN.SCAN_ID IS '';
COMMENT ON COLUMN BARS.ACCM_SNAP_SCAN.FDAT IS 'Дата партиции';
COMMENT ON COLUMN BARS.ACCM_SNAP_SCAN.TABLE_NAME IS 'Имя таблицы';
COMMENT ON COLUMN BARS.ACCM_SNAP_SCAN.SCAN_SCN IS 'SCN сканирования партиции';
COMMENT ON COLUMN BARS.ACCM_SNAP_SCAN.SCAN_DATE IS 'Дата+время сканирования партиции';
COMMENT ON COLUMN BARS.ACCM_SNAP_SCAN.THRESHOLD_SCN IS 'Пороговое значение SCN сканирования партиции';
COMMENT ON COLUMN BARS.ACCM_SNAP_SCAN.THRESHOLD_DATEINFO IS 'Пороговае Дата+время сканирования партиции';
COMMENT ON COLUMN BARS.ACCM_SNAP_SCAN.MOD_ACC IS 'ACC модифицированного счета';
COMMENT ON COLUMN BARS.ACCM_SNAP_SCAN.MOD_SCN IS 'SCN модификации счета';
COMMENT ON COLUMN BARS.ACCM_SNAP_SCAN.MOD_DATEINFO IS 'Дата+время модификации счета';
COMMENT ON COLUMN BARS.ACCM_SNAP_SCAN.QUERY_CONDITION IS 'Условие для запроса на модификацию партиций';




PROMPT *** Create  constraint PK_ACCMSNAPSCAN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCM_SNAP_SCAN ADD CONSTRAINT PK_ACCMSNAPSCAN PRIMARY KEY (SCAN_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCMSNAPSCAN_SCANID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCM_SNAP_SCAN MODIFY (SCAN_ID CONSTRAINT CC_ACCMSNAPSCAN_SCANID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCMSNAPSCAN_MODDI_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCM_SNAP_SCAN MODIFY (MOD_DATEINFO CONSTRAINT CC_ACCMSNAPSCAN_MODDI_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCMSNAPSCAN_MODSCN_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCM_SNAP_SCAN MODIFY (MOD_SCN CONSTRAINT CC_ACCMSNAPSCAN_MODSCN_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCMSNAPSCAN_MODACC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCM_SNAP_SCAN MODIFY (MOD_ACC CONSTRAINT CC_ACCMSNAPSCAN_MODACC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCMSNAPSCAN_THRDI_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCM_SNAP_SCAN MODIFY (THRESHOLD_DATEINFO CONSTRAINT CC_ACCMSNAPSCAN_THRDI_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCMSNAPSCAN_THRSCN_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCM_SNAP_SCAN MODIFY (THRESHOLD_SCN CONSTRAINT CC_ACCMSNAPSCAN_THRSCN_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCMSNAPSCAN_SCANDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCM_SNAP_SCAN MODIFY (SCAN_DATE CONSTRAINT CC_ACCMSNAPSCAN_SCANDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCMSNAPSCAN_SCANSCN_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCM_SNAP_SCAN MODIFY (SCAN_SCN CONSTRAINT CC_ACCMSNAPSCAN_SCANSCN_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCMSNAPSCAN_TABNAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCM_SNAP_SCAN MODIFY (TABLE_NAME CONSTRAINT CC_ACCMSNAPSCAN_TABNAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCMSNAPSCAN_FDAT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCM_SNAP_SCAN MODIFY (FDAT CONSTRAINT CC_ACCMSNAPSCAN_FDAT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ACCMSNAPSCAN ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ACCMSNAPSCAN ON BARS.ACCM_SNAP_SCAN (SCAN_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I1_ACCMSNAPSCAN ***
begin   
 execute immediate '
  CREATE INDEX BARS.I1_ACCMSNAPSCAN ON BARS.ACCM_SNAP_SCAN (FDAT, TABLE_NAME) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ACCM_SNAP_SCAN ***
grant DELETE,INSERT,SELECT,UPDATE                                            on ACCM_SNAP_SCAN  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ACCM_SNAP_SCAN  to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on ACCM_SNAP_SCAN  to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ACCM_SNAP_SCAN.sql =========*** End **
PROMPT ===================================================================================== 
