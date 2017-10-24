

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/FM_STABLE_PARTNER_TMP.sql =========***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to FM_STABLE_PARTNER_TMP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''FM_STABLE_PARTNER_TMP'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''FM_STABLE_PARTNER_TMP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table FM_STABLE_PARTNER_TMP ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.FM_STABLE_PARTNER_TMP 
   (	RNK_A VARCHAR2(128), 
	RNK_B VARCHAR2(128), 
	CNT NUMBER, 
	REF NUMBER, 
	KF VARCHAR2(6)
   ) ON COMMIT DELETE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to FM_STABLE_PARTNER_TMP ***
 exec bpa.alter_policies('FM_STABLE_PARTNER_TMP');


COMMENT ON TABLE BARS.FM_STABLE_PARTNER_TMP IS '';
COMMENT ON COLUMN BARS.FM_STABLE_PARTNER_TMP.RNK_A IS '';
COMMENT ON COLUMN BARS.FM_STABLE_PARTNER_TMP.RNK_B IS '';
COMMENT ON COLUMN BARS.FM_STABLE_PARTNER_TMP.CNT IS '';
COMMENT ON COLUMN BARS.FM_STABLE_PARTNER_TMP.REF IS '';
COMMENT ON COLUMN BARS.FM_STABLE_PARTNER_TMP.KF IS '';



PROMPT *** Create  grants  FM_STABLE_PARTNER_TMP ***
grant SELECT                                                                 on FM_STABLE_PARTNER_TMP to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on FM_STABLE_PARTNER_TMP to BARS_DM;
grant SELECT                                                                 on FM_STABLE_PARTNER_TMP to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/FM_STABLE_PARTNER_TMP.sql =========***
PROMPT ===================================================================================== 
