

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_ACC_REGM.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_ACC_REGM ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_ACC_REGM ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_ACC_REGM 
   (	ACC NUMBER, 
	ISP NUMBER, 
	NMS VARCHAR2(70), 
	PAP NUMBER, 
	VID NUMBER, 
	POS NUMBER, 
	BLKD NUMBER, 
	BLKK NUMBER, 
	CHGDATE DATE, 
	CHGACTION NUMBER, 
	DAZS DATE, 
	IDUPD NUMBER, 
	DONEBY VARCHAR2(64), 
	USID NUMBER
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_ACC_REGM ***
 exec bpa.alter_policies('TMP_ACC_REGM');


COMMENT ON TABLE BARS.TMP_ACC_REGM IS '';
COMMENT ON COLUMN BARS.TMP_ACC_REGM.ACC IS '';
COMMENT ON COLUMN BARS.TMP_ACC_REGM.ISP IS '';
COMMENT ON COLUMN BARS.TMP_ACC_REGM.NMS IS '';
COMMENT ON COLUMN BARS.TMP_ACC_REGM.PAP IS '';
COMMENT ON COLUMN BARS.TMP_ACC_REGM.VID IS '';
COMMENT ON COLUMN BARS.TMP_ACC_REGM.POS IS '';
COMMENT ON COLUMN BARS.TMP_ACC_REGM.BLKD IS '';
COMMENT ON COLUMN BARS.TMP_ACC_REGM.BLKK IS '';
COMMENT ON COLUMN BARS.TMP_ACC_REGM.CHGDATE IS '';
COMMENT ON COLUMN BARS.TMP_ACC_REGM.CHGACTION IS '';
COMMENT ON COLUMN BARS.TMP_ACC_REGM.DAZS IS '';
COMMENT ON COLUMN BARS.TMP_ACC_REGM.IDUPD IS '';
COMMENT ON COLUMN BARS.TMP_ACC_REGM.DONEBY IS '';
COMMENT ON COLUMN BARS.TMP_ACC_REGM.USID IS '';




PROMPT *** Create  constraint NK_TMP_ACC_REGM_ACC ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ACC_REGM MODIFY (ACC CONSTRAINT NK_TMP_ACC_REGM_ACC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_ACC_REGM ***
grant SELECT                                                                 on TMP_ACC_REGM    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_ACC_REGM    to RPBN001;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TMP_ACC_REGM    to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_ACC_REGM.sql =========*** End *** 
PROMPT ===================================================================================== 
