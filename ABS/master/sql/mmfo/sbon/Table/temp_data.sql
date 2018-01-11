

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/SBON/Table/TEMP_DATA.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  table TEMP_DATA ***
begin 
  execute immediate '
  CREATE TABLE SBON.TEMP_DATA 
   (	TEXT VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE SBON.TEMP_DATA IS '';
COMMENT ON COLUMN SBON.TEMP_DATA.TEXT IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/SBON/Table/TEMP_DATA.sql =========*** End *** ===
PROMPT ===================================================================================== 
