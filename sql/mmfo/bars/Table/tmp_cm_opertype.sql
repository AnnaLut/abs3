

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_CM_OPERTYPE.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_CM_OPERTYPE ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_CM_OPERTYPE ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_CM_OPERTYPE 
   (	ID NUMBER(22,0), 
	NAME VARCHAR2(100), 
	CLIENTTYPE NUMBER(1,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_CM_OPERTYPE ***
 exec bpa.alter_policies('TMP_CM_OPERTYPE');


COMMENT ON TABLE BARS.TMP_CM_OPERTYPE IS '';
COMMENT ON COLUMN BARS.TMP_CM_OPERTYPE.ID IS '';
COMMENT ON COLUMN BARS.TMP_CM_OPERTYPE.NAME IS '';
COMMENT ON COLUMN BARS.TMP_CM_OPERTYPE.CLIENTTYPE IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_CM_OPERTYPE.sql =========*** End *
PROMPT ===================================================================================== 
