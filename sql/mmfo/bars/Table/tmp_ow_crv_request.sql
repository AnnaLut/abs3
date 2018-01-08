

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_OW_CRV_REQUEST.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_OW_CRV_REQUEST ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_OW_CRV_REQUEST ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_OW_CRV_REQUEST 
   (	ID NUMBER(22,0), 
	NAME VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_OW_CRV_REQUEST ***
 exec bpa.alter_policies('TMP_OW_CRV_REQUEST');


COMMENT ON TABLE BARS.TMP_OW_CRV_REQUEST IS '';
COMMENT ON COLUMN BARS.TMP_OW_CRV_REQUEST.ID IS '';
COMMENT ON COLUMN BARS.TMP_OW_CRV_REQUEST.NAME IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_OW_CRV_REQUEST.sql =========*** En
PROMPT ===================================================================================== 
