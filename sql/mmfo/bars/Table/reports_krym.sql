

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/REPORTS_KRYM.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to REPORTS_KRYM ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''REPORTS_KRYM'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''REPORTS_KRYM'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''REPORTS_KRYM'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table REPORTS_KRYM ***
begin 
  execute immediate '
  CREATE TABLE BARS.REPORTS_KRYM 
   (	RNK NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to REPORTS_KRYM ***
 exec bpa.alter_policies('REPORTS_KRYM');


COMMENT ON TABLE BARS.REPORTS_KRYM IS '';
COMMENT ON COLUMN BARS.REPORTS_KRYM.RNK IS '';



PROMPT *** Create  grants  REPORTS_KRYM ***
grant SELECT                                                                 on REPORTS_KRYM    to BARSREADER_ROLE;
grant SELECT                                                                 on REPORTS_KRYM    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on REPORTS_KRYM    to BARS_DM;
grant SELECT                                                                 on REPORTS_KRYM    to START1;
grant SELECT                                                                 on REPORTS_KRYM    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/REPORTS_KRYM.sql =========*** End *** 
PROMPT ===================================================================================== 
