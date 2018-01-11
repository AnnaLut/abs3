

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OW_OUT_FILES_SOURCE.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OW_OUT_FILES_SOURCE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OW_OUT_FILES_SOURCE'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''OW_OUT_FILES_SOURCE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OW_OUT_FILES_SOURCE ***
begin 
  execute immediate '
  CREATE TABLE BARS.OW_OUT_FILES_SOURCE 
   (	ID NUMBER, 
	FUNCNAME VARCHAR2(254), 
	PROC VARCHAR2(4000), 
	TYPE NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OW_OUT_FILES_SOURCE ***
 exec bpa.alter_policies('OW_OUT_FILES_SOURCE');


COMMENT ON TABLE BARS.OW_OUT_FILES_SOURCE IS '';
COMMENT ON COLUMN BARS.OW_OUT_FILES_SOURCE.TYPE IS '';
COMMENT ON COLUMN BARS.OW_OUT_FILES_SOURCE.ID IS 'Ідентифікатор';
COMMENT ON COLUMN BARS.OW_OUT_FILES_SOURCE.FUNCNAME IS 'Назва функції для WEB';
COMMENT ON COLUMN BARS.OW_OUT_FILES_SOURCE.PROC IS 'Процедура для формування файлу. ';



PROMPT *** Create  grants  OW_OUT_FILES_SOURCE ***
grant SELECT                                                                 on OW_OUT_FILES_SOURCE to BARSREADER_ROLE;
grant SELECT                                                                 on OW_OUT_FILES_SOURCE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OW_OUT_FILES_SOURCE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OW_OUT_FILES_SOURCE.sql =========*** E
PROMPT ===================================================================================== 
