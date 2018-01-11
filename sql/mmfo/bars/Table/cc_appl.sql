

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CC_APPL.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CC_APPL ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CC_APPL'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CC_APPL'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CC_APPL'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CC_APPL ***
begin 
  execute immediate '
  CREATE TABLE BARS.CC_APPL 
   (	NA NUMBER, 
	SOS NUMBER(*,0), 
	RNK NUMBER(*,0), 
	TIPD NUMBER, 
	ADATE DATE DEFAULT SYSDATE, 
	BDATE DATE DEFAULT SYSDATE, 
	MDATE DATE DEFAULT SYSDATE, 
	S NUMBER(24,0), 
	KV NUMBER(*,0), 
	PR NUMBER(9,4), 
	VDATE DATE DEFAULT SYSDATE, 
	ND NUMBER, 
	REJ_REASON VARCHAR2(70)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CC_APPL ***
 exec bpa.alter_policies('CC_APPL');


COMMENT ON TABLE BARS.CC_APPL IS '';
COMMENT ON COLUMN BARS.CC_APPL.NA IS '';
COMMENT ON COLUMN BARS.CC_APPL.SOS IS '';
COMMENT ON COLUMN BARS.CC_APPL.RNK IS '';
COMMENT ON COLUMN BARS.CC_APPL.TIPD IS '';
COMMENT ON COLUMN BARS.CC_APPL.ADATE IS '';
COMMENT ON COLUMN BARS.CC_APPL.BDATE IS '';
COMMENT ON COLUMN BARS.CC_APPL.MDATE IS '';
COMMENT ON COLUMN BARS.CC_APPL.S IS '';
COMMENT ON COLUMN BARS.CC_APPL.KV IS '';
COMMENT ON COLUMN BARS.CC_APPL.PR IS '';
COMMENT ON COLUMN BARS.CC_APPL.VDATE IS '';
COMMENT ON COLUMN BARS.CC_APPL.ND IS '';
COMMENT ON COLUMN BARS.CC_APPL.REJ_REASON IS '';



PROMPT *** Create  grants  CC_APPL ***
grant SELECT                                                                 on CC_APPL         to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CC_APPL         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CC_APPL         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CC_APPL         to START1;
grant SELECT                                                                 on CC_APPL         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CC_APPL.sql =========*** End *** =====
PROMPT ===================================================================================== 
