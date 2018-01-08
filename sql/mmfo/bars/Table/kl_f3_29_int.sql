

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_F3_29_INT.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_F3_29_INT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KL_F3_29_INT'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KL_F3_29_INT'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''KL_F3_29_INT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_F3_29_INT ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_F3_29_INT 
   (	KF CHAR(2), 
	R020 CHAR(4), 
	R050 CHAR(2), 
	R012 CHAR(1), 
	DDD CHAR(3), 
	TXT VARCHAR2(60), 
	S240 CHAR(1)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KL_F3_29_INT ***
 exec bpa.alter_policies('KL_F3_29_INT');


COMMENT ON TABLE BARS.KL_F3_29_INT IS 'Классификатор бал.счетов для файлов внутренней отчетности';
COMMENT ON COLUMN BARS.KL_F3_29_INT.KF IS '';
COMMENT ON COLUMN BARS.KL_F3_29_INT.R020 IS '';
COMMENT ON COLUMN BARS.KL_F3_29_INT.R050 IS '';
COMMENT ON COLUMN BARS.KL_F3_29_INT.R012 IS '';
COMMENT ON COLUMN BARS.KL_F3_29_INT.DDD IS '';
COMMENT ON COLUMN BARS.KL_F3_29_INT.TXT IS '';
COMMENT ON COLUMN BARS.KL_F3_29_INT.S240 IS '';



PROMPT *** Create  grants  KL_F3_29_INT ***
grant DELETE,INSERT,SELECT,UPDATE                                            on KL_F3_29_INT    to ABS_ADMIN;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on KL_F3_29_INT    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KL_F3_29_INT    to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on KL_F3_29_INT    to KL_F3_29;
grant SELECT                                                                 on KL_F3_29_INT    to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on KL_F3_29_INT    to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on KL_F3_29_INT    to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_F3_29_INT.sql =========*** End *** 
PROMPT ===================================================================================== 
