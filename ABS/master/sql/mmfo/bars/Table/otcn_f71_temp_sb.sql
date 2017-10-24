

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OTCN_F71_TEMP_SB.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OTCN_F71_TEMP_SB ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OTCN_F71_TEMP_SB'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''OTCN_F71_TEMP_SB'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OTCN_F71_TEMP_SB ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.OTCN_F71_TEMP_SB 
   (	RNK NUMBER, 
	ACC NUMBER, 
	TP NUMBER, 
	ND NUMBER, 
	P090 VARCHAR2(20), 
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




PROMPT *** ALTER_POLICIES to OTCN_F71_TEMP_SB ***
 exec bpa.alter_policies('OTCN_F71_TEMP_SB');


COMMENT ON TABLE BARS.OTCN_F71_TEMP_SB IS 'Временная таблица хар.контрагента для формирования файла @71';
COMMENT ON COLUMN BARS.OTCN_F71_TEMP_SB.RNK IS '';
COMMENT ON COLUMN BARS.OTCN_F71_TEMP_SB.ACC IS '';
COMMENT ON COLUMN BARS.OTCN_F71_TEMP_SB.TP IS '';
COMMENT ON COLUMN BARS.OTCN_F71_TEMP_SB.ND IS '';
COMMENT ON COLUMN BARS.OTCN_F71_TEMP_SB.P090 IS '';
COMMENT ON COLUMN BARS.OTCN_F71_TEMP_SB.P080 IS '';
COMMENT ON COLUMN BARS.OTCN_F71_TEMP_SB.P081 IS '';
COMMENT ON COLUMN BARS.OTCN_F71_TEMP_SB.P110 IS '';
COMMENT ON COLUMN BARS.OTCN_F71_TEMP_SB.P111 IS '';
COMMENT ON COLUMN BARS.OTCN_F71_TEMP_SB.P112 IS '';
COMMENT ON COLUMN BARS.OTCN_F71_TEMP_SB.P113 IS '';
COMMENT ON COLUMN BARS.OTCN_F71_TEMP_SB.P160 IS '';
COMMENT ON COLUMN BARS.OTCN_F71_TEMP_SB.NBS IS '';
COMMENT ON COLUMN BARS.OTCN_F71_TEMP_SB.KV IS '';
COMMENT ON COLUMN BARS.OTCN_F71_TEMP_SB.DDD IS '';
COMMENT ON COLUMN BARS.OTCN_F71_TEMP_SB.P120 IS '';
COMMENT ON COLUMN BARS.OTCN_F71_TEMP_SB.P125 IS '';
COMMENT ON COLUMN BARS.OTCN_F71_TEMP_SB.P130 IS '';
COMMENT ON COLUMN BARS.OTCN_F71_TEMP_SB.P150 IS '';
COMMENT ON COLUMN BARS.OTCN_F71_TEMP_SB.NLS IS '';
COMMENT ON COLUMN BARS.OTCN_F71_TEMP_SB.FDAT IS '';
COMMENT ON COLUMN BARS.OTCN_F71_TEMP_SB.ISP IS '';




PROMPT *** Create  constraint SYS_C0010449 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_F71_TEMP_SB MODIFY (ACC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010448 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_F71_TEMP_SB MODIFY (RNK NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OTCN_F71_TEMP_SB ***
grant DELETE,INSERT,SELECT,UPDATE                                            on OTCN_F71_TEMP_SB to ABS_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on OTCN_F71_TEMP_SB to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on OTCN_F71_TEMP_SB to RPBN002;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on OTCN_F71_TEMP_SB to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OTCN_F71_TEMP_SB.sql =========*** End 
PROMPT ===================================================================================== 
