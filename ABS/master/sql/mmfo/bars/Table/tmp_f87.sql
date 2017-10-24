

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_F87.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_F87 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TMP_F87'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_F87'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_F87'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_F87 ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_F87 
   (	KODP VARCHAR2(11), 
	ZNAP NUMBER(15,0)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_F87 ***
 exec bpa.alter_policies('TMP_F87');


COMMENT ON TABLE BARS.TMP_F87 IS '';
COMMENT ON COLUMN BARS.TMP_F87.KODP IS '';
COMMENT ON COLUMN BARS.TMP_F87.ZNAP IS '';



PROMPT *** Create  grants  TMP_F87 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_F87         to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_F87         to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_F87.sql =========*** End *** =====
PROMPT ===================================================================================== 
