

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/FINMON/Table/OLD_K_DFM01E.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  table OLD_K_DFM01E ***
begin 
  execute immediate '
  CREATE TABLE FINMON.OLD_K_DFM01E 
   (	CODE VARCHAR2(1), 
	NAME VARCHAR2(120), 
	D_CLOSE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE USERS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE FINMON.OLD_K_DFM01E IS '';
COMMENT ON COLUMN FINMON.OLD_K_DFM01E.CODE IS '';
COMMENT ON COLUMN FINMON.OLD_K_DFM01E.NAME IS '';
COMMENT ON COLUMN FINMON.OLD_K_DFM01E.D_CLOSE IS '';



PROMPT *** Create  grants  OLD_K_DFM01E ***
grant SELECT                                                                 on OLD_K_DFM01E    to BARSREADER_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/FINMON/Table/OLD_K_DFM01E.sql =========*** End **
PROMPT ===================================================================================== 
