

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/FINMON/Table/OLD_K_DFM09.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  table OLD_K_DFM09 ***
begin 
  execute immediate '
  CREATE TABLE FINMON.OLD_K_DFM09 
   (	CODE VARCHAR2(1), 
	NAME VARCHAR2(30), 
	D_CLOSE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE USERS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE FINMON.OLD_K_DFM09 IS '';
COMMENT ON COLUMN FINMON.OLD_K_DFM09.CODE IS '';
COMMENT ON COLUMN FINMON.OLD_K_DFM09.NAME IS '';
COMMENT ON COLUMN FINMON.OLD_K_DFM09.D_CLOSE IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/FINMON/Table/OLD_K_DFM09.sql =========*** End ***
PROMPT ===================================================================================== 
