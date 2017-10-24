

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPT_VIDD_OLD.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPT_VIDD_OLD ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPT_VIDD_OLD ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPT_VIDD_OLD 
   (	VIDD_OLD NUMBER(38,0), 
	VIDD_NEW NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPT_VIDD_OLD ***
 exec bpa.alter_policies('DPT_VIDD_OLD');


COMMENT ON TABLE BARS.DPT_VIDD_OLD IS '';
COMMENT ON COLUMN BARS.DPT_VIDD_OLD.VIDD_OLD IS '';
COMMENT ON COLUMN BARS.DPT_VIDD_OLD.VIDD_NEW IS '';



PROMPT *** Create  grants  DPT_VIDD_OLD ***
grant SELECT                                                                 on DPT_VIDD_OLD    to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPT_VIDD_OLD.sql =========*** End *** 
PROMPT ===================================================================================== 
