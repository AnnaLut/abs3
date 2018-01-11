

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_2620.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_2620 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_2620 ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_2620 
   (	NLS CHAR(14)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_2620 ***
 exec bpa.alter_policies('TMP_2620');


COMMENT ON TABLE BARS.TMP_2620 IS '';
COMMENT ON COLUMN BARS.TMP_2620.NLS IS '';



PROMPT *** Create  grants  TMP_2620 ***
grant SELECT                                                                 on TMP_2620        to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_2620        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_2620.sql =========*** End *** ====
PROMPT ===================================================================================== 
