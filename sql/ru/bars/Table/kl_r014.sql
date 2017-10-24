

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_R014.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_R014 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KL_R014'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KL_R014'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_R014 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_R014 
   (	PREM CHAR(3), 
	R020 CHAR(4), 
	R014 CHAR(1), 
	TXT VARCHAR2(144), 
	REM CHAR(2), 
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




PROMPT *** ALTER_POLICIES to KL_R014 ***
 exec bpa.alter_policies('KL_R014');


COMMENT ON TABLE BARS.KL_R014 IS 'Классификатор НБУ (KL_R014)';
COMMENT ON COLUMN BARS.KL_R014.PREM IS '';
COMMENT ON COLUMN BARS.KL_R014.R020 IS '';
COMMENT ON COLUMN BARS.KL_R014.R014 IS '';
COMMENT ON COLUMN BARS.KL_R014.TXT IS '';
COMMENT ON COLUMN BARS.KL_R014.REM IS '';
COMMENT ON COLUMN BARS.KL_R014.D_OPEN IS '';
COMMENT ON COLUMN BARS.KL_R014.D_CLOSE IS '';
COMMENT ON COLUMN BARS.KL_R014.D_MODE IS '';



PROMPT *** Create  grants  KL_R014 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on KL_R014         to ABS_ADMIN;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on KL_R014         to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on KL_R014         to SALGL;
grant SELECT                                                                 on KL_R014         to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on KL_R014         to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on KL_R014         to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_R014.sql =========*** End *** =====
PROMPT ===================================================================================== 
