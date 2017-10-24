

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_MESL.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_MESL ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TMP_MESL'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_MESL'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_MESL'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_MESL ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_MESL 
   (	USID NUMBER, 
	NBS NUMBER, 
	OSTFD NUMBER, 
	OSTF NUMBER, 
	DOS NUMBER, 
	KOS NUMBER, 
	OSTID NUMBER, 
	OSTIK NUMBER
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_MESL ***
 exec bpa.alter_policies('TMP_MESL');


COMMENT ON TABLE BARS.TMP_MESL IS '';
COMMENT ON COLUMN BARS.TMP_MESL.USID IS '';
COMMENT ON COLUMN BARS.TMP_MESL.NBS IS '';
COMMENT ON COLUMN BARS.TMP_MESL.OSTFD IS '';
COMMENT ON COLUMN BARS.TMP_MESL.OSTF IS '';
COMMENT ON COLUMN BARS.TMP_MESL.DOS IS '';
COMMENT ON COLUMN BARS.TMP_MESL.KOS IS '';
COMMENT ON COLUMN BARS.TMP_MESL.OSTID IS '';
COMMENT ON COLUMN BARS.TMP_MESL.OSTIK IS '';



PROMPT *** Create  grants  TMP_MESL ***
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_MESL        to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_MESL        to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_MESL.sql =========*** End *** ====
PROMPT ===================================================================================== 
