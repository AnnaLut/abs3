

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_F20.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_F20 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KL_F20'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KL_F20'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''KL_F20'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_F20 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_F20 
   (	KF CHAR(2), 
	R020 CHAR(4), 
	T020 CHAR(1), 
	K030 CHAR(1), 
	R031 CHAR(1), 
	S181 CHAR(1), 
	R013 CHAR(1), 
	DDD CHAR(10), 
	TXT VARCHAR2(60)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KL_F20 ***
 exec bpa.alter_policies('KL_F20');


COMMENT ON TABLE BARS.KL_F20 IS 'Коди показникiв для файлу звiтностi #20 ';
COMMENT ON COLUMN BARS.KL_F20.KF IS 'Код файлу';
COMMENT ON COLUMN BARS.KL_F20.R020 IS 'Балансовий рах.';
COMMENT ON COLUMN BARS.KL_F20.T020 IS '1-A,2-П';
COMMENT ON COLUMN BARS.KL_F20.K030 IS '1-рез,2-нерез';
COMMENT ON COLUMN BARS.KL_F20.R031 IS '1-НВ,2-IВ';
COMMENT ON COLUMN BARS.KL_F20.S181 IS '1-корот.,2-довгострок.';
COMMENT ON COLUMN BARS.KL_F20.R013 IS 'Пар.R013';
COMMENT ON COLUMN BARS.KL_F20.DDD IS 'Код  DDD';
COMMENT ON COLUMN BARS.KL_F20.TXT IS 'Назва коду';




PROMPT *** Create  index XIE_KF_KL_F20 ***
begin   
 execute immediate '
  CREATE INDEX BARS.XIE_KF_KL_F20 ON BARS.KL_F20 (KF, R020, T020, K030, R031, S181, R013) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  KL_F20 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on KL_F20          to ABS_ADMIN;
grant SELECT                                                                 on KL_F20          to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on KL_F20          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KL_F20          to BARS_DM;
grant SELECT                                                                 on KL_F20          to RPBN002;
grant DELETE,INSERT,SELECT,UPDATE                                            on KL_F20          to SALGL;
grant SELECT                                                                 on KL_F20          to START1;
grant SELECT                                                                 on KL_F20          to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on KL_F20          to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to KL_F20 ***

  CREATE OR REPLACE PUBLIC SYNONYM KL_F20 FOR BARS.KL_F20;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_F20.sql =========*** End *** ======
PROMPT ===================================================================================== 
