

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_D020.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_D020 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KL_D020'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KL_D020'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_D020 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_D020 
   (	PREM CHAR(3), 
	R020 CHAR(4), 
	D020 CHAR(2), 
	T020 CHAR(1), 
	TXT VARCHAR2(144), 
	A010 CHAR(2), 
	D_OPEN DATE, 
	D_CLOSE DATE, 
	D_MODE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KL_D020 ***
 exec bpa.alter_policies('KL_D020');


COMMENT ON TABLE BARS.KL_D020 IS 'Классификатор НБУ (KL_D020)';
COMMENT ON COLUMN BARS.KL_D020.PREM IS '';
COMMENT ON COLUMN BARS.KL_D020.R020 IS '';
COMMENT ON COLUMN BARS.KL_D020.D020 IS '';
COMMENT ON COLUMN BARS.KL_D020.T020 IS '';
COMMENT ON COLUMN BARS.KL_D020.TXT IS '';
COMMENT ON COLUMN BARS.KL_D020.A010 IS '';
COMMENT ON COLUMN BARS.KL_D020.D_OPEN IS '';
COMMENT ON COLUMN BARS.KL_D020.D_CLOSE IS '';
COMMENT ON COLUMN BARS.KL_D020.D_MODE IS '';



PROMPT *** Create  grants  KL_D020 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on KL_D020         to ABS_ADMIN;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on KL_D020         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KL_D020         to BARS_DM;
grant SELECT                                                                 on KL_D020         to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on KL_D020         to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on KL_D020         to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_D020.sql =========*** End *** =====
PROMPT ===================================================================================== 
