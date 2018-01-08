

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_NAL_ACCC_OLD.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_NAL_ACCC_OLD ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TMP_NAL_ACCC_OLD'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_NAL_ACCC_OLD'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_NAL_ACCC_OLD'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_NAL_ACCC_OLD ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_NAL_ACCC_OLD 
   (	ACC NUMBER, 
	ACCC NUMBER(*,0), 
	NLS VARCHAR2(15), 
	NMS VARCHAR2(70), 
	NLSN VARCHAR2(15)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_NAL_ACCC_OLD ***
 exec bpa.alter_policies('TMP_NAL_ACCC_OLD');


COMMENT ON TABLE BARS.TMP_NAL_ACCC_OLD IS '';
COMMENT ON COLUMN BARS.TMP_NAL_ACCC_OLD.ACC IS '';
COMMENT ON COLUMN BARS.TMP_NAL_ACCC_OLD.ACCC IS '';
COMMENT ON COLUMN BARS.TMP_NAL_ACCC_OLD.NLS IS '';
COMMENT ON COLUMN BARS.TMP_NAL_ACCC_OLD.NMS IS '';
COMMENT ON COLUMN BARS.TMP_NAL_ACCC_OLD.NLSN IS '';



PROMPT *** Create  grants  TMP_NAL_ACCC_OLD ***
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_NAL_ACCC_OLD to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_NAL_ACCC_OLD to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_NAL_ACCC_OLD.sql =========*** End 
PROMPT ===================================================================================== 
