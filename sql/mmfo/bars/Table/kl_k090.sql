

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_K090.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_K090 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KL_K090'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KL_K090'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KL_K090'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_K090 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_K090 
   (	K090 CHAR(5), 
	RAZD CHAR(2), 
	K091 CHAR(2), 
	A3 CHAR(3), 
	K092 CHAR(1), 
	K093 CHAR(1), 
	TXT VARCHAR2(192), 
	KL_K110 VARCHAR2(137)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KL_K090 ***
 exec bpa.alter_policies('KL_K090');


COMMENT ON TABLE BARS.KL_K090 IS '';
COMMENT ON COLUMN BARS.KL_K090.K090 IS '';
COMMENT ON COLUMN BARS.KL_K090.RAZD IS '';
COMMENT ON COLUMN BARS.KL_K090.K091 IS '';
COMMENT ON COLUMN BARS.KL_K090.A3 IS '';
COMMENT ON COLUMN BARS.KL_K090.K092 IS '';
COMMENT ON COLUMN BARS.KL_K090.K093 IS '';
COMMENT ON COLUMN BARS.KL_K090.TXT IS '';
COMMENT ON COLUMN BARS.KL_K090.KL_K110 IS '';



PROMPT *** Create  grants  KL_K090 ***
grant SELECT                                                                 on KL_K090         to BARSUPL;
grant SELECT                                                                 on KL_K090         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KL_K090         to BARS_DM;
grant SELECT                                                                 on KL_K090         to RCC_DEAL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on KL_K090         to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to KL_K090 ***

  CREATE OR REPLACE PUBLIC SYNONYM KL_K090 FOR BARS.KL_K090;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_K090.sql =========*** End *** =====
PROMPT ===================================================================================== 
