

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_SRC_SAB.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_SRC_SAB ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_SRC_SAB ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_SRC_SAB 
   (	NAME VARCHAR2(30), 
	TYPE VARCHAR2(12), 
	LINE NUMBER, 
	TEXT VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_SRC_SAB ***
 exec bpa.alter_policies('TMP_SRC_SAB');


COMMENT ON TABLE BARS.TMP_SRC_SAB IS '';
COMMENT ON COLUMN BARS.TMP_SRC_SAB.NAME IS '';
COMMENT ON COLUMN BARS.TMP_SRC_SAB.TYPE IS '';
COMMENT ON COLUMN BARS.TMP_SRC_SAB.LINE IS '';
COMMENT ON COLUMN BARS.TMP_SRC_SAB.TEXT IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_SRC_SAB.sql =========*** End *** =
PROMPT ===================================================================================== 
