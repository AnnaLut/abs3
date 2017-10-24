

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/FINMON/Table/DICT_K_DFM01E.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  table DICT_K_DFM01E ***
begin 
  execute immediate '
  CREATE TABLE FINMON.DICT_K_DFM01E 
   (	CODE VARCHAR2(1), 
	NAME VARCHAR2(120), 
	D_CLOSE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE FINMON.DICT_K_DFM01E IS '';
COMMENT ON COLUMN FINMON.DICT_K_DFM01E.CODE IS '';
COMMENT ON COLUMN FINMON.DICT_K_DFM01E.NAME IS '';
COMMENT ON COLUMN FINMON.DICT_K_DFM01E.D_CLOSE IS '';



PROMPT *** Create  grants  DICT_K_DFM01E ***
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on DICT_K_DFM01E   to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/FINMON/Table/DICT_K_DFM01E.sql =========*** End *
PROMPT ===================================================================================== 
