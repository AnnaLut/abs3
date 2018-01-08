

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_DPT_PAYMENTS_OPLDOK.sql =========*
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_DPT_PAYMENTS_OPLDOK ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_DPT_PAYMENTS_OPLDOK ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_DPT_PAYMENTS_OPLDOK 
   (	REF VARCHAR2(40)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_DPT_PAYMENTS_OPLDOK ***
 exec bpa.alter_policies('TMP_DPT_PAYMENTS_OPLDOK');


COMMENT ON TABLE BARS.TMP_DPT_PAYMENTS_OPLDOK IS '';
COMMENT ON COLUMN BARS.TMP_DPT_PAYMENTS_OPLDOK.REF IS '';



PROMPT *** Create  grants  TMP_DPT_PAYMENTS_OPLDOK ***
grant SELECT                                                                 on TMP_DPT_PAYMENTS_OPLDOK to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_DPT_PAYMENTS_OPLDOK.sql =========*
PROMPT ===================================================================================== 
