

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/FINMON/Table/DICT_K_DFM09.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  table DICT_K_DFM09 ***
begin 
  execute immediate '
  CREATE TABLE FINMON.DICT_K_DFM09 
   (	CODE VARCHAR2(1), 
	NAME VARCHAR2(200), 
	D_CLOSE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE FINMON.DICT_K_DFM09 IS '';
COMMENT ON COLUMN FINMON.DICT_K_DFM09.CODE IS '';
COMMENT ON COLUMN FINMON.DICT_K_DFM09.NAME IS '';
COMMENT ON COLUMN FINMON.DICT_K_DFM09.D_CLOSE IS '';



PROMPT *** Create  grants  DICT_K_DFM09 ***
grant SELECT                                                                 on DICT_K_DFM09    to BARSREADER_ROLE;
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on DICT_K_DFM09    to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/FINMON/Table/DICT_K_DFM09.sql =========*** End **
PROMPT ===================================================================================== 
