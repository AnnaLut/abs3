

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CORR_M.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CORR_M ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CORR_M'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CORR_M'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CORR_M'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CORR_M ***
begin 
  execute immediate '
  CREATE TABLE BARS.CORR_M 
   (	USD CHAR(5), 
	BANKERS_TR VARCHAR2(28), 
	NEW_YORK VARCHAR2(30), 
	N4 VARCHAR2(24), 
	BKTRUS33 VARCHAR2(18)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CORR_M ***
 exec bpa.alter_policies('CORR_M');


COMMENT ON TABLE BARS.CORR_M IS '';
COMMENT ON COLUMN BARS.CORR_M.USD IS '';
COMMENT ON COLUMN BARS.CORR_M.BANKERS_TR IS '';
COMMENT ON COLUMN BARS.CORR_M.NEW_YORK IS '';
COMMENT ON COLUMN BARS.CORR_M.N4 IS '';
COMMENT ON COLUMN BARS.CORR_M.BKTRUS33 IS '';



PROMPT *** Create  grants  CORR_M ***
grant SELECT                                                                 on CORR_M          to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CORR_M          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CORR_M          to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CORR_M          to START1;
grant SELECT                                                                 on CORR_M          to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CORR_M.sql =========*** End *** ======
PROMPT ===================================================================================== 
