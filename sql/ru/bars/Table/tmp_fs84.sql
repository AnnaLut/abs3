

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_FS84.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_FS84 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_FS84 ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_FS84 
   (	KODP VARCHAR2(35), 
	ZNAP VARCHAR2(101)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_FS84 ***
 exec bpa.alter_policies('TMP_FS84');


COMMENT ON TABLE BARS.TMP_FS84 IS '';
COMMENT ON COLUMN BARS.TMP_FS84.KODP IS '';
COMMENT ON COLUMN BARS.TMP_FS84.ZNAP IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_FS84.sql =========*** End *** ====
PROMPT ===================================================================================== 
