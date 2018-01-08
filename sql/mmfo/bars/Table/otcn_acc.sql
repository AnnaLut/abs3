

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OTCN_ACC.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OTCN_ACC ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OTCN_ACC'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''OTCN_ACC'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''OTCN_ACC'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OTCN_ACC ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.OTCN_ACC 
   (	ACC NUMBER, 
	NLS VARCHAR2(15), 
	KV NUMBER(38,0), 
	NBS VARCHAR2(4), 
	OB22 VARCHAR2(2), 
	RNK NUMBER, 
	DAOS DATE, 
	DAPP DATE, 
	ISP NUMBER, 
	NMS VARCHAR2(70), 
	LIM NUMBER(24,0), 
	PAP NUMBER(38,0), 
	TIP CHAR(3), 
	VID NUMBER(*,0), 
	MDATE DATE, 
	DAZS DATE, 
	ACCC NUMBER(38,0), 
	TOBO VARCHAR2(30), 
	NLS_ALT VARCHAR2(15), 
	OB22_ALT VARCHAR2(2), 
	DAT_ALT DATE
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OTCN_ACC ***
 exec bpa.alter_policies('OTCN_ACC');


COMMENT ON TABLE BARS.OTCN_ACC IS 'Временная таблица для счетов участвующих в формировании файлов отчетности';
COMMENT ON COLUMN BARS.OTCN_ACC.ACC IS '';
COMMENT ON COLUMN BARS.OTCN_ACC.NLS IS '';
COMMENT ON COLUMN BARS.OTCN_ACC.KV IS '';
COMMENT ON COLUMN BARS.OTCN_ACC.NBS IS '';
COMMENT ON COLUMN BARS.OTCN_ACC.OB22 IS '';
COMMENT ON COLUMN BARS.OTCN_ACC.RNK IS '';
COMMENT ON COLUMN BARS.OTCN_ACC.DAOS IS '';
COMMENT ON COLUMN BARS.OTCN_ACC.DAPP IS '';
COMMENT ON COLUMN BARS.OTCN_ACC.ISP IS '';
COMMENT ON COLUMN BARS.OTCN_ACC.NMS IS '';
COMMENT ON COLUMN BARS.OTCN_ACC.LIM IS '';
COMMENT ON COLUMN BARS.OTCN_ACC.PAP IS '';
COMMENT ON COLUMN BARS.OTCN_ACC.TIP IS '';
COMMENT ON COLUMN BARS.OTCN_ACC.VID IS '';
COMMENT ON COLUMN BARS.OTCN_ACC.MDATE IS '';
COMMENT ON COLUMN BARS.OTCN_ACC.DAZS IS '';
COMMENT ON COLUMN BARS.OTCN_ACC.ACCC IS '';
COMMENT ON COLUMN BARS.OTCN_ACC.TOBO IS '';
COMMENT ON COLUMN BARS.OTCN_ACC.NLS_ALT IS '';
COMMENT ON COLUMN BARS.OTCN_ACC.OB22_ALT IS '';
COMMENT ON COLUMN BARS.OTCN_ACC.DAT_ALT IS '';




PROMPT *** Create  constraint SYS_C00139663 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_ACC MODIFY (ACC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OTCN_ACC ***
grant DELETE,INSERT,SELECT,UPDATE                                            on OTCN_ACC        to ABS_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on OTCN_ACC        to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on OTCN_ACC        to RPBN002;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on OTCN_ACC        to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OTCN_ACC.sql =========*** End *** ====
PROMPT ===================================================================================== 
