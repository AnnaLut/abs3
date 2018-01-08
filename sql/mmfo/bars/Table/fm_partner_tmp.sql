

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/FM_PARTNER_TMP.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to FM_PARTNER_TMP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''FM_PARTNER_TMP'', ''CENTER'' , ''C'', ''C'', ''C'', null);
               bpa.alter_policy_info(''FM_PARTNER_TMP'', ''FILIAL'' , ''F'', ''F'', ''F'', null);
               bpa.alter_policy_info(''FM_PARTNER_TMP'', ''WHOLE'' , ''C'', ''C'', ''C'', null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table FM_PARTNER_TMP ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.FM_PARTNER_TMP 
   (	ID_A VARCHAR2(14), 
	ID_B VARCHAR2(14), 
	CNT NUMBER, 
	REF NUMBER
   ) ON COMMIT DELETE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to FM_PARTNER_TMP ***
 exec bpa.alter_policies('FM_PARTNER_TMP');


COMMENT ON TABLE BARS.FM_PARTNER_TMP IS '';
COMMENT ON COLUMN BARS.FM_PARTNER_TMP.ID_A IS '';
COMMENT ON COLUMN BARS.FM_PARTNER_TMP.ID_B IS '';
COMMENT ON COLUMN BARS.FM_PARTNER_TMP.CNT IS '';
COMMENT ON COLUMN BARS.FM_PARTNER_TMP.REF IS '';



PROMPT *** Create  grants  FM_PARTNER_TMP ***
grant SELECT                                                                 on FM_PARTNER_TMP  to BARSREADER_ROLE;
grant SELECT                                                                 on FM_PARTNER_TMP  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on FM_PARTNER_TMP  to BARS_DM;
grant SELECT                                                                 on FM_PARTNER_TMP  to START1;
grant SELECT                                                                 on FM_PARTNER_TMP  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/FM_PARTNER_TMP.sql =========*** End **
PROMPT ===================================================================================== 
