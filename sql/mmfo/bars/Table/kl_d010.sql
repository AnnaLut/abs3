

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_D010.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_D010 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KL_D010'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KL_D010'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KL_D010'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_D010 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_D010 
   (	D010 CHAR(2), 
	F_12 CHAR(1), 
	F_13 CHAR(1), 
	F_28 CHAR(1), 
	F_92 CHAR(1), 
	F_93 CHAR(1), 
	D_OPEN DATE, 
	D_CLOSE DATE, 
	TXT VARCHAR2(96)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KL_D010 ***
 exec bpa.alter_policies('KL_D010');


COMMENT ON TABLE BARS.KL_D010 IS '';
COMMENT ON COLUMN BARS.KL_D010.D010 IS '';
COMMENT ON COLUMN BARS.KL_D010.F_12 IS '';
COMMENT ON COLUMN BARS.KL_D010.F_13 IS '';
COMMENT ON COLUMN BARS.KL_D010.F_28 IS '';
COMMENT ON COLUMN BARS.KL_D010.F_92 IS '';
COMMENT ON COLUMN BARS.KL_D010.F_93 IS '';
COMMENT ON COLUMN BARS.KL_D010.D_OPEN IS '';
COMMENT ON COLUMN BARS.KL_D010.D_CLOSE IS '';
COMMENT ON COLUMN BARS.KL_D010.TXT IS '';



PROMPT *** Create  grants  KL_D010 ***
grant SELECT                                                                 on KL_D010         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KL_D010         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on KL_D010         to KL_D010;
grant SELECT                                                                 on KL_D010         to START1;



PROMPT *** Create SYNONYM  to KL_D010 ***

  CREATE OR REPLACE PUBLIC SYNONYM KL_D010 FOR BARS.KL_D010;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_D010.sql =========*** End *** =====
PROMPT ===================================================================================== 
