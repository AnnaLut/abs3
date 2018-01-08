

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CH_1S.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CH_1S ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CH_1S'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CH_1S'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CH_1S'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CH_1S ***
begin 
  execute immediate '
  CREATE TABLE BARS.CH_1S 
   (	IDS NUMBER(*,0), 
	NAME VARCHAR2(25), 
	S9910 VARCHAR2(15), 
	S9830 VARCHAR2(25), 
	S9831 VARCHAR2(25), 
	S3739 VARCHAR2(25), 
	S2909 VARCHAR2(25), 
	K3739 VARCHAR2(15), 
	K2909 VARCHAR2(15), 
	TT6 CHAR(3), 
	NLS6 VARCHAR2(15), 
	CH_NAZN VARCHAR2(160)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CH_1S ***
 exec bpa.alter_policies('CH_1S');


COMMENT ON TABLE BARS.CH_1S IS '';
COMMENT ON COLUMN BARS.CH_1S.IDS IS '';
COMMENT ON COLUMN BARS.CH_1S.NAME IS '';
COMMENT ON COLUMN BARS.CH_1S.S9910 IS '';
COMMENT ON COLUMN BARS.CH_1S.S9830 IS '';
COMMENT ON COLUMN BARS.CH_1S.S9831 IS '';
COMMENT ON COLUMN BARS.CH_1S.S3739 IS '';
COMMENT ON COLUMN BARS.CH_1S.S2909 IS '';
COMMENT ON COLUMN BARS.CH_1S.K3739 IS '';
COMMENT ON COLUMN BARS.CH_1S.K2909 IS '';
COMMENT ON COLUMN BARS.CH_1S.TT6 IS '';
COMMENT ON COLUMN BARS.CH_1S.NLS6 IS '';
COMMENT ON COLUMN BARS.CH_1S.CH_NAZN IS '';




PROMPT *** Create  constraint XPK_CH_1S ***
begin   
 execute immediate '
  ALTER TABLE BARS.CH_1S ADD CONSTRAINT XPK_CH_1S PRIMARY KEY (IDS)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_CH_1S ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_CH_1S ON BARS.CH_1S (IDS) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CH_1S ***
grant SELECT                                                                 on CH_1S           to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CH_1S           to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CH_1S           to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CH_1S           to RCH_1;
grant SELECT                                                                 on CH_1S           to UPLD;
grant FLASHBACK,SELECT                                                       on CH_1S           to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CH_1S.sql =========*** End *** =======
PROMPT ===================================================================================== 
