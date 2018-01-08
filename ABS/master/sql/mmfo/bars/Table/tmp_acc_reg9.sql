

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_ACC_REG9.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_ACC_REG9 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_ACC_REG9 ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_ACC_REG9 
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




PROMPT *** ALTER_POLICIES to TMP_ACC_REG9 ***
 exec bpa.alter_policies('TMP_ACC_REG9');


COMMENT ON TABLE BARS.TMP_ACC_REG9 IS '';
COMMENT ON COLUMN BARS.TMP_ACC_REG9.ACC IS '';
COMMENT ON COLUMN BARS.TMP_ACC_REG9.ISP IS '';
COMMENT ON COLUMN BARS.TMP_ACC_REG9.NMS IS '';
COMMENT ON COLUMN BARS.TMP_ACC_REG9.PAP IS '';
COMMENT ON COLUMN BARS.TMP_ACC_REG9.VID IS '';
COMMENT ON COLUMN BARS.TMP_ACC_REG9.POS IS '';
COMMENT ON COLUMN BARS.TMP_ACC_REG9.BLKD IS '';
COMMENT ON COLUMN BARS.TMP_ACC_REG9.BLKK IS '';
COMMENT ON COLUMN BARS.TMP_ACC_REG9.CHGDATE IS '';
COMMENT ON COLUMN BARS.TMP_ACC_REG9.CHGACTION IS '';
COMMENT ON COLUMN BARS.TMP_ACC_REG9.DAZS IS '';
COMMENT ON COLUMN BARS.TMP_ACC_REG9.IDUPD IS '';
COMMENT ON COLUMN BARS.TMP_ACC_REG9.DONEBY IS '';
COMMENT ON COLUMN BARS.TMP_ACC_REG9.USID IS '';




PROMPT *** Create  constraint NK_TMP_ACC_REG9_ACC ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ACC_REG9 MODIFY (ACC CONSTRAINT NK_TMP_ACC_REG9_ACC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_ACC_REG9 ***
grant SELECT                                                                 on TMP_ACC_REG9    to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_ACC_REG9    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_ACC_REG9    to RPBN001;
grant SELECT                                                                 on TMP_ACC_REG9    to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TMP_ACC_REG9    to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_ACC_REG9.sql =========*** End *** 
PROMPT ===================================================================================== 
