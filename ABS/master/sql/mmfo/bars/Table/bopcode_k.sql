

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BOPCODE_K.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BOPCODE_K ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BOPCODE_K'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''BOPCODE_K'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''BOPCODE_K'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BOPCODE_K ***
begin 
  execute immediate '
  CREATE TABLE BARS.BOPCODE_K 
   (	TRANSCODE VARCHAR2(7), 
	KOD_NNN NUMBER(11,0), 
	TRANSDESC VARCHAR2(50), 
	KIND CHAR(1)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BOPCODE_K ***
 exec bpa.alter_policies('BOPCODE_K');


COMMENT ON TABLE BARS.BOPCODE_K IS '';
COMMENT ON COLUMN BARS.BOPCODE_K.TRANSCODE IS '';
COMMENT ON COLUMN BARS.BOPCODE_K.KOD_NNN IS '';
COMMENT ON COLUMN BARS.BOPCODE_K.TRANSDESC IS '';
COMMENT ON COLUMN BARS.BOPCODE_K.KIND IS '';



PROMPT *** Create  grants  BOPCODE_K ***
grant SELECT                                                                 on BOPCODE_K       to BARS_DM;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on BOPCODE_K       to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BOPCODE_K.sql =========*** End *** ===
PROMPT ===================================================================================== 
