

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_F00_INT$GLOBAL.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_F00_INT$GLOBAL ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KL_F00_INT$GLOBAL'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KL_F00_INT$GLOBAL'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KL_F00_INT$GLOBAL'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_F00_INT$GLOBAL ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_F00_INT$GLOBAL 
   (	KODF CHAR(2), 
	AA CHAR(2), 
	A017 CHAR(1), 
	NN CHAR(2), 
	PERIOD CHAR(1), 
	PROCC VARCHAR2(5), 
	R CHAR(1), 
	SEMANTIC VARCHAR2(70), 
	KODF_EXT VARCHAR2(2), 
	F_PREF VARCHAR2(1), 
	TYPE_ZNAP VARCHAR2(1) DEFAULT ''C'', 
	PROCK NUMBER, 
	RECID NUMBER, 
	PR_TOBO NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KL_F00_INT$GLOBAL ***
 exec bpa.alter_policies('KL_F00_INT$GLOBAL');


COMMENT ON TABLE BARS.KL_F00_INT$GLOBAL IS 'Глобальные данные по внутрисистемным отчетным файлам';
COMMENT ON COLUMN BARS.KL_F00_INT$GLOBAL.KODF IS '';
COMMENT ON COLUMN BARS.KL_F00_INT$GLOBAL.AA IS '';
COMMENT ON COLUMN BARS.KL_F00_INT$GLOBAL.A017 IS '';
COMMENT ON COLUMN BARS.KL_F00_INT$GLOBAL.NN IS '';
COMMENT ON COLUMN BARS.KL_F00_INT$GLOBAL.PERIOD IS '';
COMMENT ON COLUMN BARS.KL_F00_INT$GLOBAL.PROCC IS '';
COMMENT ON COLUMN BARS.KL_F00_INT$GLOBAL.R IS '';
COMMENT ON COLUMN BARS.KL_F00_INT$GLOBAL.SEMANTIC IS '';
COMMENT ON COLUMN BARS.KL_F00_INT$GLOBAL.KODF_EXT IS '';
COMMENT ON COLUMN BARS.KL_F00_INT$GLOBAL.F_PREF IS '';
COMMENT ON COLUMN BARS.KL_F00_INT$GLOBAL.TYPE_ZNAP IS '';
COMMENT ON COLUMN BARS.KL_F00_INT$GLOBAL.PROCK IS '';
COMMENT ON COLUMN BARS.KL_F00_INT$GLOBAL.RECID IS '';
COMMENT ON COLUMN BARS.KL_F00_INT$GLOBAL.PR_TOBO IS '';




PROMPT *** Create  constraint PK_KLFINT ***
begin   
 execute immediate '
  ALTER TABLE BARS.KL_F00_INT$GLOBAL ADD CONSTRAINT PK_KLFINT PRIMARY KEY (KODF, A017)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008387 ***
begin   
 execute immediate '
  ALTER TABLE BARS.KL_F00_INT$GLOBAL MODIFY (KODF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008388 ***
begin   
 execute immediate '
  ALTER TABLE BARS.KL_F00_INT$GLOBAL MODIFY (PROCC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_KLFINT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_KLFINT ON BARS.KL_F00_INT$GLOBAL (KODF, A017) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  KL_F00_INT$GLOBAL ***
grant DELETE,INSERT,SELECT,UPDATE                                            on KL_F00_INT$GLOBAL to ABS_ADMIN;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on KL_F00_INT$GLOBAL to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KL_F00_INT$GLOBAL to BARS_DM;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on KL_F00_INT$GLOBAL to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on KL_F00_INT$GLOBAL to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_F00_INT$GLOBAL.sql =========*** End
PROMPT ===================================================================================== 
