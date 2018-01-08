

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/FINMON/Table/OLD_K_DFM02.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  table OLD_K_DFM02 ***
begin 
  execute immediate '
  CREATE TABLE FINMON.OLD_K_DFM02 
   (	CODE VARCHAR2(4), 
	NAME VARCHAR2(512), 
	D_CLOSE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE USERS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE FINMON.OLD_K_DFM02 IS '';
COMMENT ON COLUMN FINMON.OLD_K_DFM02.CODE IS '';
COMMENT ON COLUMN FINMON.OLD_K_DFM02.NAME IS '';
COMMENT ON COLUMN FINMON.OLD_K_DFM02.D_CLOSE IS '';



PROMPT *** Create  grants  OLD_K_DFM02 ***
grant SELECT                                                                 on OLD_K_DFM02     to BARSREADER_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/FINMON/Table/OLD_K_DFM02.sql =========*** End ***
PROMPT ===================================================================================== 
