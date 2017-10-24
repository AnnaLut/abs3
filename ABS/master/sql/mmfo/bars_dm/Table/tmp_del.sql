

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS_DM/Table/TMP_DEL.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  table TMP_DEL ***
begin 
  execute immediate '
  CREATE TABLE BARS_DM.TMP_DEL 
   (	ID CLOB
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE USERS 
 LOB (ID) STORE AS BASICFILE (
  TABLESPACE USERS ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARS_DM.TMP_DEL IS '';
COMMENT ON COLUMN BARS_DM.TMP_DEL.ID IS '';



PROMPT *** Create  grants  TMP_DEL ***
grant SELECT                                                                 on TMP_DEL         to BARSUPL;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS_DM/Table/TMP_DEL.sql =========*** End *** ==
PROMPT ===================================================================================== 
