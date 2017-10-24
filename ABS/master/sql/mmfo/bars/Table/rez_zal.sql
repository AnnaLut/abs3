

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/REZ_ZAL.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to REZ_ZAL ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''REZ_ZAL'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''REZ_ZAL'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''REZ_ZAL'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table REZ_ZAL ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.REZ_ZAL 
   (	ACC NUMBER(*,0), 
	ACCS NUMBER(*,0), 
	KV NUMBER(3,0), 
	NLS VARCHAR2(15), 
	NBS CHAR(4), 
	PAWN NUMBER(38,0), 
	S031 VARCHAR2(2), 
	R031 CHAR(1), 
	PR_12 NUMBER(38,0), 
	PWN NUMBER, 
	OSTC_Z NUMBER, 
	ACCS1 NUMBER(*,0), 
	OSTC_S NUMBER, 
	ACCC NUMBER(38,0), 
	ND NUMBER, 
	OSTC_S_KP NUMBER, 
	OSTC_Z31 NUMBER, 
	KV_D NUMBER(3,0), 
	KV_S NUMBER(3,0)
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to REZ_ZAL ***
 exec bpa.alter_policies('REZ_ZAL');


COMMENT ON TABLE BARS.REZ_ZAL IS '';
COMMENT ON COLUMN BARS.REZ_ZAL.OSTC_Z31 IS '';
COMMENT ON COLUMN BARS.REZ_ZAL.KV_D IS '';
COMMENT ON COLUMN BARS.REZ_ZAL.KV_S IS '';
COMMENT ON COLUMN BARS.REZ_ZAL.ACC IS '';
COMMENT ON COLUMN BARS.REZ_ZAL.ACCS IS '';
COMMENT ON COLUMN BARS.REZ_ZAL.KV IS '';
COMMENT ON COLUMN BARS.REZ_ZAL.NLS IS '';
COMMENT ON COLUMN BARS.REZ_ZAL.NBS IS '';
COMMENT ON COLUMN BARS.REZ_ZAL.PAWN IS '';
COMMENT ON COLUMN BARS.REZ_ZAL.S031 IS '';
COMMENT ON COLUMN BARS.REZ_ZAL.R031 IS '';
COMMENT ON COLUMN BARS.REZ_ZAL.PR_12 IS '';
COMMENT ON COLUMN BARS.REZ_ZAL.PWN IS '';
COMMENT ON COLUMN BARS.REZ_ZAL.OSTC_Z IS '';
COMMENT ON COLUMN BARS.REZ_ZAL.ACCS1 IS '';
COMMENT ON COLUMN BARS.REZ_ZAL.OSTC_S IS '';
COMMENT ON COLUMN BARS.REZ_ZAL.ACCC IS '';
COMMENT ON COLUMN BARS.REZ_ZAL.ND IS '';
COMMENT ON COLUMN BARS.REZ_ZAL.OSTC_S_KP IS '';




PROMPT *** Create  constraint SYS_C0010497 ***
begin   
 execute immediate '
  ALTER TABLE BARS.REZ_ZAL MODIFY (ACC NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010498 ***
begin   
 execute immediate '
  ALTER TABLE BARS.REZ_ZAL MODIFY (ACCS NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010501 ***
begin   
 execute immediate '
  ALTER TABLE BARS.REZ_ZAL MODIFY (ACCS1 NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010500 ***
begin   
 execute immediate '
  ALTER TABLE BARS.REZ_ZAL MODIFY (NLS NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010499 ***
begin   
 execute immediate '
  ALTER TABLE BARS.REZ_ZAL MODIFY (KV NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDX_REZ_ZAL_ACCS ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_REZ_ZAL_ACCS ON BARS.REZ_ZAL (ACCS) ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/REZ_ZAL.sql =========*** End *** =====
PROMPT ===================================================================================== 
