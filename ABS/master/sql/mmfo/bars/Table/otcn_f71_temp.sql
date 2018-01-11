

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OTCN_F71_TEMP.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OTCN_F71_TEMP ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OTCN_F71_TEMP ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.OTCN_F71_TEMP 
   (	RNK NUMBER, 
	ACC NUMBER, 
	TP NUMBER, 
	ND NUMBER, 
	P090 VARCHAR2(50), 
	P080 VARCHAR2(70), 
	P081 NUMBER, 
	P110 NUMBER, 
	P111 DATE, 
	P112 DATE, 
	P113 DATE, 
	P160 VARCHAR2(2), 
	NBS VARCHAR2(4), 
	KV NUMBER, 
	DDD VARCHAR2(3), 
	P120 NUMBER, 
	P125 NUMBER, 
	P130 NUMBER, 
	P150 NUMBER, 
	NLS VARCHAR2(20), 
	FDAT DATE, 
	ISP NUMBER
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OTCN_F71_TEMP ***
 exec bpa.alter_policies('OTCN_F71_TEMP');


COMMENT ON TABLE BARS.OTCN_F71_TEMP IS 'Временная таблица хар.контрагента для формирования файла #D8';
COMMENT ON COLUMN BARS.OTCN_F71_TEMP.RNK IS '';
COMMENT ON COLUMN BARS.OTCN_F71_TEMP.ACC IS '';
COMMENT ON COLUMN BARS.OTCN_F71_TEMP.TP IS '';
COMMENT ON COLUMN BARS.OTCN_F71_TEMP.ND IS '';
COMMENT ON COLUMN BARS.OTCN_F71_TEMP.P090 IS '';
COMMENT ON COLUMN BARS.OTCN_F71_TEMP.P080 IS '';
COMMENT ON COLUMN BARS.OTCN_F71_TEMP.P081 IS '';
COMMENT ON COLUMN BARS.OTCN_F71_TEMP.P110 IS '';
COMMENT ON COLUMN BARS.OTCN_F71_TEMP.P111 IS '';
COMMENT ON COLUMN BARS.OTCN_F71_TEMP.P112 IS '';
COMMENT ON COLUMN BARS.OTCN_F71_TEMP.P113 IS '';
COMMENT ON COLUMN BARS.OTCN_F71_TEMP.P160 IS '';
COMMENT ON COLUMN BARS.OTCN_F71_TEMP.NBS IS '';
COMMENT ON COLUMN BARS.OTCN_F71_TEMP.KV IS '';
COMMENT ON COLUMN BARS.OTCN_F71_TEMP.DDD IS '';
COMMENT ON COLUMN BARS.OTCN_F71_TEMP.P120 IS '';
COMMENT ON COLUMN BARS.OTCN_F71_TEMP.P125 IS '';
COMMENT ON COLUMN BARS.OTCN_F71_TEMP.P130 IS '';
COMMENT ON COLUMN BARS.OTCN_F71_TEMP.P150 IS '';
COMMENT ON COLUMN BARS.OTCN_F71_TEMP.NLS IS '';
COMMENT ON COLUMN BARS.OTCN_F71_TEMP.FDAT IS '';
COMMENT ON COLUMN BARS.OTCN_F71_TEMP.ISP IS '';




PROMPT *** Create  constraint CC_OTCN_F71_TEMP ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_F71_TEMP ADD CONSTRAINT CC_OTCN_F71_TEMP UNIQUE (RNK, ACC, ND, P090) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010220 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_F71_TEMP MODIFY (RNK NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010221 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_F71_TEMP MODIFY (ACC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index I1_OTCN_F71_TEMP ***
begin   
 execute immediate '
  CREATE INDEX BARS.I1_OTCN_F71_TEMP ON BARS.OTCN_F71_TEMP (RNK) ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index CC_OTCN_F71_TEMP ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.CC_OTCN_F71_TEMP ON BARS.OTCN_F71_TEMP (RNK, ACC, ND, P090) ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OTCN_F71_TEMP ***
grant DELETE,INSERT,SELECT,UPDATE                                            on OTCN_F71_TEMP   to ABS_ADMIN;
grant SELECT                                                                 on OTCN_F71_TEMP   to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on OTCN_F71_TEMP   to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on OTCN_F71_TEMP   to RPBN002;
grant SELECT                                                                 on OTCN_F71_TEMP   to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on OTCN_F71_TEMP   to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OTCN_F71_TEMP.sql =========*** End ***
PROMPT ===================================================================================== 
