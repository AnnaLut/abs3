

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SCLI_R20.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SCLI_R20 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SCLI_R20'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SCLI_R20'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SCLI_R20'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SCLI_R20 ***
begin 
  execute immediate '
  CREATE TABLE BARS.SCLI_R20 
   (	R020 NUMBER(4,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SCLI_R20 ***
 exec bpa.alter_policies('SCLI_R20');


COMMENT ON TABLE BARS.SCLI_R20 IS '';
COMMENT ON COLUMN BARS.SCLI_R20.R020 IS '';



PROMPT *** Create  grants  SCLI_R20 ***
grant SELECT                                                                 on SCLI_R20        to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SCLI_R20.sql =========*** End *** ====
PROMPT ===================================================================================== 
