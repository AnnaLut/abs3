

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/FINMON/Table/K_DFM05_COPY.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  table K_DFM05_COPY ***
begin 
  execute immediate '
  CREATE TABLE FINMON.K_DFM05_COPY 
   (	CODE VARCHAR2(4), 
	NAME VARCHAR2(254), 
	D_CLOSE DATE
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE USERS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE FINMON.K_DFM05_COPY IS '';
COMMENT ON COLUMN FINMON.K_DFM05_COPY.D_CLOSE IS '';
COMMENT ON COLUMN FINMON.K_DFM05_COPY.NAME IS '';
COMMENT ON COLUMN FINMON.K_DFM05_COPY.CODE IS '';



PROMPT *** Create  grants  K_DFM05_COPY ***
grant SELECT                                                                 on K_DFM05_COPY    to BARSREADER_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/FINMON/Table/K_DFM05_COPY.sql =========*** End **
PROMPT ===================================================================================== 
