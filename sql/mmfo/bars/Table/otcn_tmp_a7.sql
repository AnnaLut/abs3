

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OTCN_TMP_A7.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OTCN_TMP_A7 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OTCN_TMP_A7'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''OTCN_TMP_A7'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''OTCN_TMP_A7'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OTCN_TMP_A7 ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.OTCN_TMP_A7 
   (	ACC NUMBER, 
	NLS VARCHAR2(15), 
	KV NUMBER(*,0), 
	FDAT DATE, 
	NBS CHAR(4), 
	S240 VARCHAR2(4000), 
	S180 VARCHAR2(4000), 
	S181 VARCHAR2(1), 
	R013 VARCHAR2(1), 
	R031 CHAR(1), 
	MDATE DATE, 
	OST NUMBER, 
	SDATE DATE
   ) ON COMMIT DELETE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OTCN_TMP_A7 ***
 exec bpa.alter_policies('OTCN_TMP_A7');


COMMENT ON TABLE BARS.OTCN_TMP_A7 IS '';
COMMENT ON COLUMN BARS.OTCN_TMP_A7.ACC IS '';
COMMENT ON COLUMN BARS.OTCN_TMP_A7.NLS IS '';
COMMENT ON COLUMN BARS.OTCN_TMP_A7.KV IS '';
COMMENT ON COLUMN BARS.OTCN_TMP_A7.FDAT IS '';
COMMENT ON COLUMN BARS.OTCN_TMP_A7.NBS IS '';
COMMENT ON COLUMN BARS.OTCN_TMP_A7.S240 IS '';
COMMENT ON COLUMN BARS.OTCN_TMP_A7.S180 IS '';
COMMENT ON COLUMN BARS.OTCN_TMP_A7.S181 IS '';
COMMENT ON COLUMN BARS.OTCN_TMP_A7.R013 IS '';
COMMENT ON COLUMN BARS.OTCN_TMP_A7.R031 IS '';
COMMENT ON COLUMN BARS.OTCN_TMP_A7.MDATE IS '';
COMMENT ON COLUMN BARS.OTCN_TMP_A7.OST IS '';
COMMENT ON COLUMN BARS.OTCN_TMP_A7.SDATE IS '';




PROMPT *** Create  constraint SYS_C0010315 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_TMP_A7 MODIFY (ACC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010317 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_TMP_A7 MODIFY (FDAT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010316 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_TMP_A7 MODIFY (KV NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OTCN_TMP_A7 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on OTCN_TMP_A7     to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on OTCN_TMP_A7     to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OTCN_TMP_A7.sql =========*** End *** =
PROMPT ===================================================================================== 
