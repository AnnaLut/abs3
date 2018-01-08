

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/REZ_ACC.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to REZ_ACC ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''REZ_ACC'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''REZ_ACC'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''REZ_ACC'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table REZ_ACC ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.REZ_ACC 
   (	ACC NUMBER, 
	NLS VARCHAR2(15), 
	KV NUMBER(*,0), 
	NBS VARCHAR2(4), 
	RNK NUMBER, 
	DAOS DATE, 
	DAPP DATE, 
	ISP NUMBER, 
	NMS VARCHAR2(70), 
	LIM NUMBER(24,0), 
	PAP NUMBER(*,0), 
	TIP CHAR(3), 
	VID NUMBER(38,0), 
	MDATE DATE, 
	DAZS DATE, 
	ACCC NUMBER(*,0), 
	TOBO VARCHAR2(30), 
	KV_D NUMBER(3,0)
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to REZ_ACC ***
 exec bpa.alter_policies('REZ_ACC');


COMMENT ON TABLE BARS.REZ_ACC IS 'Временная таблица для счетов участвующих в формировании резерва';
COMMENT ON COLUMN BARS.REZ_ACC.ACC IS '';
COMMENT ON COLUMN BARS.REZ_ACC.NLS IS '';
COMMENT ON COLUMN BARS.REZ_ACC.KV IS '';
COMMENT ON COLUMN BARS.REZ_ACC.NBS IS '';
COMMENT ON COLUMN BARS.REZ_ACC.RNK IS '';
COMMENT ON COLUMN BARS.REZ_ACC.DAOS IS '';
COMMENT ON COLUMN BARS.REZ_ACC.DAPP IS '';
COMMENT ON COLUMN BARS.REZ_ACC.ISP IS '';
COMMENT ON COLUMN BARS.REZ_ACC.NMS IS '';
COMMENT ON COLUMN BARS.REZ_ACC.LIM IS '';
COMMENT ON COLUMN BARS.REZ_ACC.PAP IS '';
COMMENT ON COLUMN BARS.REZ_ACC.TIP IS '';
COMMENT ON COLUMN BARS.REZ_ACC.VID IS '';
COMMENT ON COLUMN BARS.REZ_ACC.MDATE IS '';
COMMENT ON COLUMN BARS.REZ_ACC.DAZS IS '';
COMMENT ON COLUMN BARS.REZ_ACC.ACCC IS '';
COMMENT ON COLUMN BARS.REZ_ACC.TOBO IS '';
COMMENT ON COLUMN BARS.REZ_ACC.KV_D IS '';




PROMPT *** Create  constraint PK_REZ_ACC ***
begin   
 execute immediate '
  ALTER TABLE BARS.REZ_ACC ADD CONSTRAINT PK_REZ_ACC PRIMARY KEY (ACC) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010259 ***
begin   
 execute immediate '
  ALTER TABLE BARS.REZ_ACC MODIFY (ACC NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_REZ_ACC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_REZ_ACC ON BARS.REZ_ACC (ACC) ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDX_REZ_ACC_RNK ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_REZ_ACC_RNK ON BARS.REZ_ACC (RNK) ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  REZ_ACC ***
grant SELECT                                                                 on REZ_ACC         to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on REZ_ACC         to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on REZ_ACC         to START1;
grant SELECT                                                                 on REZ_ACC         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/REZ_ACC.sql =========*** End *** =====
PROMPT ===================================================================================== 
