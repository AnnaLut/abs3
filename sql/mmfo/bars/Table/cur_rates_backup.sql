

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CUR_RATES_BACKUP.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CUR_RATES_BACKUP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CUR_RATES_BACKUP'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CUR_RATES_BACKUP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CUR_RATES_BACKUP ***
begin 
  execute immediate '
  CREATE TABLE BARS.CUR_RATES_BACKUP 
   (	FILENAME VARCHAR2(100), 
	DATE_LOAD DATE, 
	FILE_TYPE VARCHAR2(20), 
	USERID_LOAD NUMBER, 
	FILE_BODY CLOB
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND 
 LOB (FILE_BODY) STORE AS BASICFILE (
  TABLESPACE BRSDYND ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CUR_RATES_BACKUP ***
 exec bpa.alter_policies('CUR_RATES_BACKUP');


COMMENT ON TABLE BARS.CUR_RATES_BACKUP IS '';
COMMENT ON COLUMN BARS.CUR_RATES_BACKUP.FILENAME IS '';
COMMENT ON COLUMN BARS.CUR_RATES_BACKUP.DATE_LOAD IS '';
COMMENT ON COLUMN BARS.CUR_RATES_BACKUP.FILE_TYPE IS '';
COMMENT ON COLUMN BARS.CUR_RATES_BACKUP.USERID_LOAD IS '';
COMMENT ON COLUMN BARS.CUR_RATES_BACKUP.FILE_BODY IS '';



PROMPT *** Create  grants  CUR_RATES_BACKUP ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CUR_RATES_BACKUP to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CUR_RATES_BACKUP.sql =========*** End 
PROMPT ===================================================================================== 
