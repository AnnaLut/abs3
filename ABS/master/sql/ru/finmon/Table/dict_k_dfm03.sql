

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/FINMON/Table/DICT_K_DFM03.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  table DICT_K_DFM03 ***
begin 
  execute immediate '
  CREATE TABLE FINMON.DICT_K_DFM03 
   (	CODE VARCHAR2(3), 
	NAME VARCHAR2(512), 
	D_CLOSE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE FINMON.DICT_K_DFM03 IS '';
COMMENT ON COLUMN FINMON.DICT_K_DFM03.CODE IS '';
COMMENT ON COLUMN FINMON.DICT_K_DFM03.NAME IS '';
COMMENT ON COLUMN FINMON.DICT_K_DFM03.D_CLOSE IS '';



PROMPT *** Create  grants  DICT_K_DFM03 ***
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on DICT_K_DFM03    to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/FINMON/Table/DICT_K_DFM03.sql =========*** End **
PROMPT ===================================================================================== 
