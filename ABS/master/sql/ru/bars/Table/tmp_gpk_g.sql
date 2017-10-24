

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_GPK_G.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_GPK_G ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_GPK_G ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_GPK_G 
   (	REF NUMBER, 
	TIP NUMBER, 
	SUM NUMBER, 
	PL NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_GPK_G ***
 exec bpa.alter_policies('TMP_GPK_G');


COMMENT ON TABLE BARS.TMP_GPK_G IS '';
COMMENT ON COLUMN BARS.TMP_GPK_G.REF IS '';
COMMENT ON COLUMN BARS.TMP_GPK_G.TIP IS '';
COMMENT ON COLUMN BARS.TMP_GPK_G.SUM IS '';
COMMENT ON COLUMN BARS.TMP_GPK_G.PL IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_GPK_G.sql =========*** End *** ===
PROMPT ===================================================================================== 
