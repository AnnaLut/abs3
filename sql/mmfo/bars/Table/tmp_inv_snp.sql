

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_INV_SNP.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_INV_SNP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TMP_INV_SNP'', ''CENTER'' , ''C'', ''C'', ''C'', null);
               bpa.alter_policy_info(''TMP_INV_SNP'', ''FILIAL'' , ''F'', ''F'', ''F'', null);
               bpa.alter_policy_info(''TMP_INV_SNP'', ''WHOLE'' , ''C'', ''C'', ''C'', null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_INV_SNP ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_INV_SNP 
   (	CALDT_ID NUMBER(38,0), 
	ACC NUMBER(38,0), 
	RNK NUMBER(38,0), 
	OST NUMBER(24,0), 
	OSTQ NUMBER(24,0), 
	DOS NUMBER(24,0), 
	DOSQ NUMBER(24,0), 
	KOS NUMBER(24,0), 
	KOSQ NUMBER(24,0), 
	CRDOS NUMBER(24,0), 
	CRDOSQ NUMBER(24,0), 
	CRKOS NUMBER(24,0), 
	CRKOSQ NUMBER(24,0)
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_INV_SNP ***
 exec bpa.alter_policies('TMP_INV_SNP');


COMMENT ON TABLE BARS.TMP_INV_SNP IS '';
COMMENT ON COLUMN BARS.TMP_INV_SNP.CALDT_ID IS '';
COMMENT ON COLUMN BARS.TMP_INV_SNP.ACC IS '';
COMMENT ON COLUMN BARS.TMP_INV_SNP.RNK IS '';
COMMENT ON COLUMN BARS.TMP_INV_SNP.OST IS '';
COMMENT ON COLUMN BARS.TMP_INV_SNP.OSTQ IS '';
COMMENT ON COLUMN BARS.TMP_INV_SNP.DOS IS '';
COMMENT ON COLUMN BARS.TMP_INV_SNP.DOSQ IS '';
COMMENT ON COLUMN BARS.TMP_INV_SNP.KOS IS '';
COMMENT ON COLUMN BARS.TMP_INV_SNP.KOSQ IS '';
COMMENT ON COLUMN BARS.TMP_INV_SNP.CRDOS IS '';
COMMENT ON COLUMN BARS.TMP_INV_SNP.CRDOSQ IS '';
COMMENT ON COLUMN BARS.TMP_INV_SNP.CRKOS IS '';
COMMENT ON COLUMN BARS.TMP_INV_SNP.CRKOSQ IS '';



PROMPT *** Create  grants  TMP_INV_SNP ***
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_INV_SNP     to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_INV_SNP     to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_INV_SNP.sql =========*** End *** =
PROMPT ===================================================================================== 
