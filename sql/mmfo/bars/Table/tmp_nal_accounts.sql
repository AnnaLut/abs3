

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_NAL_ACCOUNTS.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_NAL_ACCOUNTS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TMP_NAL_ACCOUNTS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_NAL_ACCOUNTS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_NAL_ACCOUNTS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_NAL_ACCOUNTS ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_NAL_ACCOUNTS 
   (	ACC NUMBER, 
	ACCC NUMBER
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_NAL_ACCOUNTS ***
 exec bpa.alter_policies('TMP_NAL_ACCOUNTS');


COMMENT ON TABLE BARS.TMP_NAL_ACCOUNTS IS '';
COMMENT ON COLUMN BARS.TMP_NAL_ACCOUNTS.ACC IS '';
COMMENT ON COLUMN BARS.TMP_NAL_ACCOUNTS.ACCC IS '';



PROMPT *** Create  grants  TMP_NAL_ACCOUNTS ***
grant SELECT                                                                 on TMP_NAL_ACCOUNTS to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_NAL_ACCOUNTS to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_NAL_ACCOUNTS to START1;
grant SELECT                                                                 on TMP_NAL_ACCOUNTS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_NAL_ACCOUNTS.sql =========*** End 
PROMPT ===================================================================================== 
