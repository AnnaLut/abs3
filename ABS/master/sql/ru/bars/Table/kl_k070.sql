

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_K070.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_K070 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KL_K070'', ''FILIAL'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_K070 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_K070 
   (	K070 CHAR(5), 
	K071 CHAR(1), 
	K072 CHAR(1), 
	K073 CHAR(1), 
	K074 CHAR(1), 
	TXT VARCHAR2(190), 
	D_OPEN DATE, 
	D_CLOSE DATE, 
	D_MODE DATE, 
	K070_OLD CHAR(5), 
	TXT_OLD VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KL_K070 ***
 exec bpa.alter_policies('KL_K070');


COMMENT ON TABLE BARS.KL_K070 IS '';
COMMENT ON COLUMN BARS.KL_K070.K070 IS '';
COMMENT ON COLUMN BARS.KL_K070.K071 IS '';
COMMENT ON COLUMN BARS.KL_K070.K072 IS '';
COMMENT ON COLUMN BARS.KL_K070.K073 IS '';
COMMENT ON COLUMN BARS.KL_K070.K074 IS '';
COMMENT ON COLUMN BARS.KL_K070.TXT IS '';
COMMENT ON COLUMN BARS.KL_K070.D_OPEN IS '';
COMMENT ON COLUMN BARS.KL_K070.D_CLOSE IS '';
COMMENT ON COLUMN BARS.KL_K070.D_MODE IS '';
COMMENT ON COLUMN BARS.KL_K070.K070_OLD IS '';
COMMENT ON COLUMN BARS.KL_K070.TXT_OLD IS '';



PROMPT *** Create  grants  KL_K070 ***
grant SELECT                                                                 on KL_K070         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KL_K070         to BARS_SUP;
grant DELETE,INSERT,SELECT,UPDATE                                            on KL_K070         to KL_K070;
grant SELECT                                                                 on KL_K070         to START1;



PROMPT *** Create SYNONYM  to KL_K070 ***

  CREATE OR REPLACE PUBLIC SYNONYM KL_K070 FOR BARS.KL_K070;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_K070.sql =========*** End *** =====
PROMPT ===================================================================================== 
