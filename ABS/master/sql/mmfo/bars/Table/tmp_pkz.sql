

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_PKZ.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_PKZ ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TMP_PKZ'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_PKZ'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_PKZ'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_PKZ ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_PKZ 
   (	FIO VARCHAR2(40), 
	NLS VARCHAR2(14), 
	KV NUMBER, 
	OSTATOK NUMBER, 
	RNK NUMBER, 
	TIP VARCHAR2(3)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_PKZ ***
 exec bpa.alter_policies('TMP_PKZ');


COMMENT ON TABLE BARS.TMP_PKZ IS '';
COMMENT ON COLUMN BARS.TMP_PKZ.FIO IS '';
COMMENT ON COLUMN BARS.TMP_PKZ.NLS IS '';
COMMENT ON COLUMN BARS.TMP_PKZ.KV IS '';
COMMENT ON COLUMN BARS.TMP_PKZ.OSTATOK IS '';
COMMENT ON COLUMN BARS.TMP_PKZ.RNK IS '';
COMMENT ON COLUMN BARS.TMP_PKZ.TIP IS '';



PROMPT *** Create  grants  TMP_PKZ ***
grant SELECT                                                                 on TMP_PKZ         to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_PKZ         to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_PKZ         to START1;
grant SELECT                                                                 on TMP_PKZ         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_PKZ.sql =========*** End *** =====
PROMPT ===================================================================================== 
