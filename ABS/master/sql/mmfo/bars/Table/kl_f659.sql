

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_F659.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_F659 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KL_F659'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KL_F659'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KL_F659'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_F659 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_F659 
   (	P VARCHAR2(1), 
	DDDDD VARCHAR2(5), 
	KOD VARCHAR2(5), 
	IDF VARCHAR2(1)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYNI ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KL_F659 ***
 exec bpa.alter_policies('KL_F659');


COMMENT ON TABLE BARS.KL_F659 IS '';
COMMENT ON COLUMN BARS.KL_F659.P IS '';
COMMENT ON COLUMN BARS.KL_F659.DDDDD IS '';
COMMENT ON COLUMN BARS.KL_F659.KOD IS '';
COMMENT ON COLUMN BARS.KL_F659.IDF IS '';



PROMPT *** Create  grants  KL_F659 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on KL_F659         to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on KL_F659         to RPBN002;



PROMPT *** Create SYNONYM  to KL_F659 ***

  CREATE OR REPLACE PUBLIC SYNONYM KL_F659 FOR BARS.KL_F659;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_F659.sql =========*** End *** =====
PROMPT ===================================================================================== 
