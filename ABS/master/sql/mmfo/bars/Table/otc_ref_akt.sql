

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OTC_REF_AKT.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OTC_REF_AKT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OTC_REF_AKT'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''OTC_REF_AKT'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''OTC_REF_AKT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OTC_REF_AKT ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.OTC_REF_AKT 
   (	ACC NUMBER, 
	KODP VARCHAR2(20), 
	OSTQ NUMBER, 
	ACC_A NUMBER, 
	NBS_A VARCHAR2(4), 
	T020_A VARCHAR2(1), 
	R013_A VARCHAR2(1), 
	S580_A VARCHAR2(1), 
	OSTQ_A NUMBER
   ) ON COMMIT DELETE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OTC_REF_AKT ***
 exec bpa.alter_policies('OTC_REF_AKT');


COMMENT ON TABLE BARS.OTC_REF_AKT IS '';
COMMENT ON COLUMN BARS.OTC_REF_AKT.ACC IS '';
COMMENT ON COLUMN BARS.OTC_REF_AKT.KODP IS '';
COMMENT ON COLUMN BARS.OTC_REF_AKT.OSTQ IS '';
COMMENT ON COLUMN BARS.OTC_REF_AKT.ACC_A IS '';
COMMENT ON COLUMN BARS.OTC_REF_AKT.NBS_A IS '';
COMMENT ON COLUMN BARS.OTC_REF_AKT.T020_A IS '';
COMMENT ON COLUMN BARS.OTC_REF_AKT.R013_A IS '';
COMMENT ON COLUMN BARS.OTC_REF_AKT.S580_A IS '';
COMMENT ON COLUMN BARS.OTC_REF_AKT.OSTQ_A IS '';



PROMPT *** Create  grants  OTC_REF_AKT ***
grant SELECT                                                                 on OTC_REF_AKT     to BARSREADER_ROLE;
grant SELECT                                                                 on OTC_REF_AKT     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OTC_REF_AKT.sql =========*** End *** =
PROMPT ===================================================================================== 
