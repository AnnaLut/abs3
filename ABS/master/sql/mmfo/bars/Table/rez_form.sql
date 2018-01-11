

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/REZ_FORM.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to REZ_FORM ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''REZ_FORM'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''REZ_FORM'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''REZ_FORM'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table REZ_FORM ***
begin 
  execute immediate '
  CREATE TABLE BARS.REZ_FORM 
   (	ID NUMBER(38,0), 
	DAT DATE, 
	DAT_FORM DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to REZ_FORM ***
 exec bpa.alter_policies('REZ_FORM');


COMMENT ON TABLE BARS.REZ_FORM IS '';
COMMENT ON COLUMN BARS.REZ_FORM.ID IS '';
COMMENT ON COLUMN BARS.REZ_FORM.DAT IS '';
COMMENT ON COLUMN BARS.REZ_FORM.DAT_FORM IS '';




PROMPT *** Create  index IDX_REZ_FORM_DAT ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_REZ_FORM_DAT ON BARS.REZ_FORM (DAT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  REZ_FORM ***
grant SELECT                                                                 on REZ_FORM        to BARSREADER_ROLE;
grant SELECT                                                                 on REZ_FORM        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on REZ_FORM        to RCC_DEAL;
grant SELECT                                                                 on REZ_FORM        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/REZ_FORM.sql =========*** End *** ====
PROMPT ===================================================================================== 
