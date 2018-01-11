

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/WCS_PRINT_SCANS.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to WCS_PRINT_SCANS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''WCS_PRINT_SCANS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_PRINT_SCANS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_PRINT_SCANS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table WCS_PRINT_SCANS ***
begin 
  execute immediate '
  CREATE TABLE BARS.WCS_PRINT_SCANS 
   (	PRINT_SESSION_ID VARCHAR2(100), 
	ORD NUMBER, 
	SCAN_DATA BLOB
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND 
 LOB (SCAN_DATA) STORE AS BASICFILE (
  TABLESPACE BRSDYND ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to WCS_PRINT_SCANS ***
 exec bpa.alter_policies('WCS_PRINT_SCANS');


COMMENT ON TABLE BARS.WCS_PRINT_SCANS IS 'Очередь печати сканкопий';
COMMENT ON COLUMN BARS.WCS_PRINT_SCANS.PRINT_SESSION_ID IS 'Идентификатор сессии печати';
COMMENT ON COLUMN BARS.WCS_PRINT_SCANS.ORD IS 'Порядок';
COMMENT ON COLUMN BARS.WCS_PRINT_SCANS.SCAN_DATA IS 'Сканкопия';




PROMPT *** Create  constraint PK_WCSPRINTSCANS ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_PRINT_SCANS ADD CONSTRAINT PK_WCSPRINTSCANS PRIMARY KEY (PRINT_SESSION_ID, ORD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_WCSPRINTSCANS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_WCSPRINTSCANS ON BARS.WCS_PRINT_SCANS (PRINT_SESSION_ID, ORD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  WCS_PRINT_SCANS ***
grant SELECT                                                                 on WCS_PRINT_SCANS to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on WCS_PRINT_SCANS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on WCS_PRINT_SCANS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/WCS_PRINT_SCANS.sql =========*** End *
PROMPT ===================================================================================== 
