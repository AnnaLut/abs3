

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_BIZNESPR_NAZN.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_BIZNESPR_NAZN ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_BIZNESPR_NAZN ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_BIZNESPR_NAZN 
   (	SLOVO VARCHAR2(29), 
	COMM VARCHAR2(48)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_BIZNESPR_NAZN ***
 exec bpa.alter_policies('TMP_BIZNESPR_NAZN');


COMMENT ON TABLE BARS.TMP_BIZNESPR_NAZN IS '';
COMMENT ON COLUMN BARS.TMP_BIZNESPR_NAZN.SLOVO IS '';
COMMENT ON COLUMN BARS.TMP_BIZNESPR_NAZN.COMM IS '';



PROMPT *** Create  grants  TMP_BIZNESPR_NAZN ***
grant SELECT                                                                 on TMP_BIZNESPR_NAZN to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_BIZNESPR_NAZN.sql =========*** End
PROMPT ===================================================================================== 
