

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_AGRK_A.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_AGRK_A ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_AGRK_A ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_AGRK_A 
   (	OKPO VARCHAR2(14), 
	ND VARCHAR2(15)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_AGRK_A ***
 exec bpa.alter_policies('TMP_AGRK_A');


COMMENT ON TABLE BARS.TMP_AGRK_A IS '';
COMMENT ON COLUMN BARS.TMP_AGRK_A.OKPO IS '';
COMMENT ON COLUMN BARS.TMP_AGRK_A.ND IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_AGRK_A.sql =========*** End *** ==
PROMPT ===================================================================================== 
