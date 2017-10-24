

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/FINMON/Table/K_DFM08_COPY.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  table K_DFM08_COPY ***
begin 
  execute immediate '
  CREATE TABLE FINMON.K_DFM08_COPY 
   (	CODE VARCHAR2(2), 
	NAME VARCHAR2(90), 
	D_CLOSE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE USERS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE FINMON.K_DFM08_COPY IS '';
COMMENT ON COLUMN FINMON.K_DFM08_COPY.CODE IS '';
COMMENT ON COLUMN FINMON.K_DFM08_COPY.NAME IS '';
COMMENT ON COLUMN FINMON.K_DFM08_COPY.D_CLOSE IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/FINMON/Table/K_DFM08_COPY.sql =========*** End **
PROMPT ===================================================================================== 
