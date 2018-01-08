

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_K080.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_K080 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KL_K080'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KL_K080'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KL_K080'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_K080 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_K080 
   (	K080 CHAR(2), 
	K081 CHAR(1), 
	K082 CHAR(1), 
	TXT VARCHAR2(96), 
	D_OPEN DATE, 
	D_CLOSE DATE, 
	D_MODE DATE, 
	K080_NEW CHAR(2), 
	K081_OLD CHAR(1)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KL_K080 ***
 exec bpa.alter_policies('KL_K080');


COMMENT ON TABLE BARS.KL_K080 IS '';
COMMENT ON COLUMN BARS.KL_K080.K080 IS '';
COMMENT ON COLUMN BARS.KL_K080.K081 IS '';
COMMENT ON COLUMN BARS.KL_K080.K082 IS '';
COMMENT ON COLUMN BARS.KL_K080.TXT IS '';
COMMENT ON COLUMN BARS.KL_K080.D_OPEN IS '';
COMMENT ON COLUMN BARS.KL_K080.D_CLOSE IS '';
COMMENT ON COLUMN BARS.KL_K080.D_MODE IS '';
COMMENT ON COLUMN BARS.KL_K080.K080_NEW IS '';
COMMENT ON COLUMN BARS.KL_K080.K081_OLD IS '';



PROMPT *** Create  grants  KL_K080 ***
grant SELECT                                                                 on KL_K080         to BARSUPL;
grant SELECT                                                                 on KL_K080         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KL_K080         to BARS_DM;
grant SELECT                                                                 on KL_K080         to CUST001;
grant SELECT                                                                 on KL_K080         to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on KL_K080         to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to KL_K080 ***

  CREATE OR REPLACE PUBLIC SYNONYM KL_K080 FOR BARS.KL_K080;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_K080.sql =========*** End *** =====
PROMPT ===================================================================================== 
