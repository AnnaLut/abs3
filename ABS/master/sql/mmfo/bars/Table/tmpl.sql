

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMPL.sql =========*** Run *** ========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMPL ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TMPL'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''TMPL'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''TMPL'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMPL ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMPL 
   (	ACC NUMBER(10,0)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMPL ***
 exec bpa.alter_policies('TMPL');


COMMENT ON TABLE BARS.TMPL IS '';
COMMENT ON COLUMN BARS.TMPL.ACC IS '';



PROMPT *** Create  grants  TMPL ***
grant DELETE,INSERT,SELECT,UPDATE                                            on TMPL            to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMPL            to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMPL.sql =========*** End *** ========
PROMPT ===================================================================================== 
