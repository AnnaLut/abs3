

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OTC_RISK_S580.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OTC_RISK_S580 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OTC_RISK_S580'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''OTC_RISK_S580'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''OTC_RISK_S580'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OTC_RISK_S580 ***
begin 
  execute immediate '
  CREATE TABLE BARS.OTC_RISK_S580 
   (	R020 VARCHAR2(4), 
	T020 VARCHAR2(1), 
	R013 VARCHAR2(1), 
	KOEF VARCHAR2(10), 
	S580 VARCHAR2(1), 
	COMM VARCHAR2(64)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE USERS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OTC_RISK_S580 ***
 exec bpa.alter_policies('OTC_RISK_S580');


COMMENT ON TABLE BARS.OTC_RISK_S580 IS '';
COMMENT ON COLUMN BARS.OTC_RISK_S580.R020 IS '';
COMMENT ON COLUMN BARS.OTC_RISK_S580.T020 IS '';
COMMENT ON COLUMN BARS.OTC_RISK_S580.R013 IS '';
COMMENT ON COLUMN BARS.OTC_RISK_S580.KOEF IS '';
COMMENT ON COLUMN BARS.OTC_RISK_S580.S580 IS '';
COMMENT ON COLUMN BARS.OTC_RISK_S580.COMM IS '';




PROMPT *** Create  index I1_OTC_RISK_S580 ***
begin   
 execute immediate '
  CREATE INDEX BARS.I1_OTC_RISK_S580 ON BARS.OTC_RISK_S580 (R020, T020, R013) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE USERS ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OTC_RISK_S580 ***
grant SELECT                                                                 on OTC_RISK_S580   to BARSREADER_ROLE;
grant SELECT                                                                 on OTC_RISK_S580   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OTC_RISK_S580   to BARS_DM;
grant SELECT                                                                 on OTC_RISK_S580   to START1;
grant SELECT                                                                 on OTC_RISK_S580   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OTC_RISK_S580.sql =========*** End ***
PROMPT ===================================================================================== 
