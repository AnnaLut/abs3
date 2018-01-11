

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_NAL_ACCC.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_NAL_ACCC ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TMP_NAL_ACCC'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_NAL_ACCC'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_NAL_ACCC'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_NAL_ACCC ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_NAL_ACCC 
   (	ACC NUMBER, 
	NLS VARCHAR2(15), 
	NMS VARCHAR2(70), 
	OB22 VARCHAR2(2)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_NAL_ACCC ***
 exec bpa.alter_policies('TMP_NAL_ACCC');


COMMENT ON TABLE BARS.TMP_NAL_ACCC IS '';
COMMENT ON COLUMN BARS.TMP_NAL_ACCC.ACC IS '';
COMMENT ON COLUMN BARS.TMP_NAL_ACCC.NLS IS '';
COMMENT ON COLUMN BARS.TMP_NAL_ACCC.NMS IS '';
COMMENT ON COLUMN BARS.TMP_NAL_ACCC.OB22 IS '';



PROMPT *** Create  grants  TMP_NAL_ACCC ***
grant SELECT                                                                 on TMP_NAL_ACCC    to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_NAL_ACCC    to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_NAL_ACCC    to START1;
grant SELECT                                                                 on TMP_NAL_ACCC    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_NAL_ACCC.sql =========*** End *** 
PROMPT ===================================================================================== 
