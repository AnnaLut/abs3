

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/FINMON/Table/OLD_K_DFM07.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  table OLD_K_DFM07 ***
begin 
  execute immediate '
  CREATE TABLE FINMON.OLD_K_DFM07 
   (	CODE VARCHAR2(1), 
	NAME VARCHAR2(40), 
	D_CLOSE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE USERS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE FINMON.OLD_K_DFM07 IS '';
COMMENT ON COLUMN FINMON.OLD_K_DFM07.CODE IS '';
COMMENT ON COLUMN FINMON.OLD_K_DFM07.NAME IS '';
COMMENT ON COLUMN FINMON.OLD_K_DFM07.D_CLOSE IS '';



PROMPT *** Create  grants  OLD_K_DFM07 ***
grant SELECT                                                                 on OLD_K_DFM07     to BARSREADER_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/FINMON/Table/OLD_K_DFM07.sql =========*** End ***
PROMPT ===================================================================================== 
