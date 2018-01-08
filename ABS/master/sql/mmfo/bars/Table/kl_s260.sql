

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_S260.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_S260 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KL_S260'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KL_S260'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KL_S260'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_S260 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_S260 
   (	S260 VARCHAR2(2), 
	TXT VARCHAR2(142), 
	D_OPEN DATE, 
	D_CLOSE DATE, 
	D_MODE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KL_S260 ***
 exec bpa.alter_policies('KL_S260');


COMMENT ON TABLE BARS.KL_S260 IS '';
COMMENT ON COLUMN BARS.KL_S260.S260 IS '';
COMMENT ON COLUMN BARS.KL_S260.TXT IS '';
COMMENT ON COLUMN BARS.KL_S260.D_OPEN IS '';
COMMENT ON COLUMN BARS.KL_S260.D_CLOSE IS '';
COMMENT ON COLUMN BARS.KL_S260.D_MODE IS '';



PROMPT *** Create  grants  KL_S260 ***
grant SELECT                                                                 on KL_S260         to BARSUPL;
grant SELECT                                                                 on KL_S260         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KL_S260         to BARS_DM;
grant SELECT                                                                 on KL_S260         to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on KL_S260         to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to KL_S260 ***

  CREATE OR REPLACE PUBLIC SYNONYM KL_S260 FOR BARS.KL_S260;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_S260.sql =========*** End *** =====
PROMPT ===================================================================================== 
