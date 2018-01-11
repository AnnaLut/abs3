

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/PFU/Table/TMP_DOWNLOAD.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  table TMP_DOWNLOAD ***
begin 
  execute immediate '
  CREATE TABLE PFU.TMP_DOWNLOAD 
   (	MFO VARCHAR2(6), 
	NAME VARCHAR2(100), 
	DATE_START DATE DEFAULT sysdate, 
	DATE_END DATE DEFAULT sysdate
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE PFU.TMP_DOWNLOAD IS '';
COMMENT ON COLUMN PFU.TMP_DOWNLOAD.MFO IS '';
COMMENT ON COLUMN PFU.TMP_DOWNLOAD.NAME IS '';
COMMENT ON COLUMN PFU.TMP_DOWNLOAD.DATE_START IS '';
COMMENT ON COLUMN PFU.TMP_DOWNLOAD.DATE_END IS '';



PROMPT *** Create  grants  TMP_DOWNLOAD ***
grant SELECT                                                                 on TMP_DOWNLOAD    to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_DOWNLOAD    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/PFU/Table/TMP_DOWNLOAD.sql =========*** End *** =
PROMPT ===================================================================================== 
