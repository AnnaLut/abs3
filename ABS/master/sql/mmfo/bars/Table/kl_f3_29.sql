

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_F3_29.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_F3_29 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KL_F3_29'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KL_F3_29'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''KL_F3_29'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_F3_29 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_F3_29 
   (	KF CHAR(2), 
	R020 CHAR(4), 
	R050 CHAR(2), 
	R012 CHAR(1), 
	DDD CHAR(3), 
	TXT VARCHAR2(60), 
	S240 CHAR(1)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KL_F3_29 ***
 exec bpa.alter_policies('KL_F3_29');


COMMENT ON TABLE BARS.KL_F3_29 IS 'Классификатор бал.счетов для файлов отчетности';
COMMENT ON COLUMN BARS.KL_F3_29.KF IS '';
COMMENT ON COLUMN BARS.KL_F3_29.R020 IS '';
COMMENT ON COLUMN BARS.KL_F3_29.R050 IS '';
COMMENT ON COLUMN BARS.KL_F3_29.R012 IS '';
COMMENT ON COLUMN BARS.KL_F3_29.DDD IS '';
COMMENT ON COLUMN BARS.KL_F3_29.TXT IS '';
COMMENT ON COLUMN BARS.KL_F3_29.S240 IS '';




PROMPT *** Create  index XIE_KF_KL_F329 ***
begin   
 execute immediate '
  CREATE INDEX BARS.XIE_KF_KL_F329 ON BARS.KL_F3_29 (KF, DDD, R020, R050, R012) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  KL_F3_29 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on KL_F3_29        to ABS_ADMIN;
grant SELECT                                                                 on KL_F3_29        to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on KL_F3_29        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KL_F3_29        to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on KL_F3_29        to KL_F3_29;
grant SELECT                                                                 on KL_F3_29        to START1;
grant SELECT                                                                 on KL_F3_29        to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on KL_F3_29        to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on KL_F3_29        to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_F3_29.sql =========*** End *** ====
PROMPT ===================================================================================== 
