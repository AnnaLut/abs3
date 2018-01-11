

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OTCN_F08_DELOYT.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OTCN_F08_DELOYT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OTCN_F08_DELOYT'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''OTCN_F08_DELOYT'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''OTCN_F08_DELOYT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OTCN_F08_DELOYT ***
begin 
  execute immediate '
  CREATE TABLE BARS.OTCN_F08_DELOYT 
   (	ACCD NUMBER, 
	TT CHAR(3), 
	REF NUMBER(38,0), 
	KV NUMBER(*,0), 
	NLSD VARCHAR2(15), 
	S VARCHAR2(16), 
	SQ VARCHAR2(16), 
	FDAT DATE, 
	NAZN VARCHAR2(160), 
	ACCK NUMBER, 
	NLSK VARCHAR2(15), 
	ISP NUMBER, 
	TOBO VARCHAR2(12), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OTCN_F08_DELOYT ***
 exec bpa.alter_policies('OTCN_F08_DELOYT');


COMMENT ON TABLE BARS.OTCN_F08_DELOYT IS '';
COMMENT ON COLUMN BARS.OTCN_F08_DELOYT.KF IS '';
COMMENT ON COLUMN BARS.OTCN_F08_DELOYT.ACCD IS '';
COMMENT ON COLUMN BARS.OTCN_F08_DELOYT.TT IS '';
COMMENT ON COLUMN BARS.OTCN_F08_DELOYT.REF IS '';
COMMENT ON COLUMN BARS.OTCN_F08_DELOYT.KV IS '';
COMMENT ON COLUMN BARS.OTCN_F08_DELOYT.NLSD IS '';
COMMENT ON COLUMN BARS.OTCN_F08_DELOYT.S IS '';
COMMENT ON COLUMN BARS.OTCN_F08_DELOYT.SQ IS '';
COMMENT ON COLUMN BARS.OTCN_F08_DELOYT.FDAT IS '';
COMMENT ON COLUMN BARS.OTCN_F08_DELOYT.NAZN IS '';
COMMENT ON COLUMN BARS.OTCN_F08_DELOYT.ACCK IS '';
COMMENT ON COLUMN BARS.OTCN_F08_DELOYT.NLSK IS '';
COMMENT ON COLUMN BARS.OTCN_F08_DELOYT.ISP IS '';
COMMENT ON COLUMN BARS.OTCN_F08_DELOYT.TOBO IS '';




PROMPT *** Create  constraint CC_OTCNF08DELOYT_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_F08_DELOYT MODIFY (KF CONSTRAINT CC_OTCNF08DELOYT_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OTCN_F08_DELOYT ***
grant SELECT                                                                 on OTCN_F08_DELOYT to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on OTCN_F08_DELOYT to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on OTCN_F08_DELOYT to START1;
grant SELECT                                                                 on OTCN_F08_DELOYT to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OTCN_F08_DELOYT.sql =========*** End *
PROMPT ===================================================================================== 
