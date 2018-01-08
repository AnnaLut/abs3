

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ACCOUNTS_LIMS_TMP.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ACCOUNTS_LIMS_TMP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ACCOUNTS_LIMS_TMP'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''ACCOUNTS_LIMS_TMP'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ACCOUNTS_LIMS_TMP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ACCOUNTS_LIMS_TMP ***
begin 
  execute immediate '
  CREATE TABLE BARS.ACCOUNTS_LIMS_TMP 
   (	ACC NUMBER, 
	LIM NUMBER(24,0)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ACCOUNTS_LIMS_TMP ***
 exec bpa.alter_policies('ACCOUNTS_LIMS_TMP');


COMMENT ON TABLE BARS.ACCOUNTS_LIMS_TMP IS '';
COMMENT ON COLUMN BARS.ACCOUNTS_LIMS_TMP.ACC IS '';
COMMENT ON COLUMN BARS.ACCOUNTS_LIMS_TMP.LIM IS '';



PROMPT *** Create  grants  ACCOUNTS_LIMS_TMP ***
grant DELETE,INSERT,SELECT,UPDATE                                            on ACCOUNTS_LIMS_TMP to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ACCOUNTS_LIMS_TMP to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on ACCOUNTS_LIMS_TMP to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ACCOUNTS_LIMS_TMP.sql =========*** End
PROMPT ===================================================================================== 
