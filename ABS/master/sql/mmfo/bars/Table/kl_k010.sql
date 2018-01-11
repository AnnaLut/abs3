

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_K010.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_K010 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KL_K010'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KL_K010'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KL_K010'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_K010 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_K010 
   (	K010 NUMBER(38,0), 
	K030 NUMBER(38,0), 
	K100 NUMBER(38,0), 
	TXT VARCHAR2(45)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KL_K010 ***
 exec bpa.alter_policies('KL_K010');


COMMENT ON TABLE BARS.KL_K010 IS '';
COMMENT ON COLUMN BARS.KL_K010.K010 IS '';
COMMENT ON COLUMN BARS.KL_K010.K030 IS '';
COMMENT ON COLUMN BARS.KL_K010.K100 IS '';
COMMENT ON COLUMN BARS.KL_K010.TXT IS '';



PROMPT *** Create  grants  KL_K010 ***
grant SELECT                                                                 on KL_K010         to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on KL_K010         to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on KL_K010         to START1;
grant SELECT                                                                 on KL_K010         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_K010.sql =========*** End *** =====
PROMPT ===================================================================================== 
