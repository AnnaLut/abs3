

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CP_ALIEN.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CP_ALIEN ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CP_ALIEN'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CP_ALIEN'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''CP_ALIEN'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CP_ALIEN ***
begin 
  execute immediate '
  CREATE TABLE BARS.CP_ALIEN 
   (	MFO VARCHAR2(12), 
	BIC CHAR(11), 
	NAME VARCHAR2(35), 
	NLS VARCHAR2(35), 
	KOD_G CHAR(3), 
	KOD_B CHAR(4), 
	OKPO VARCHAR2(10), 
	KV NUMBER(38,0), 
	BICK CHAR(11), 
	NLSK VARCHAR2(35), 
	ID NUMBER(*,0), 
	TXT VARCHAR2(100), 
	AGRMNT_NUM VARCHAR2(10), 
	AGRMNT_DATE DATE, 
	INTERM_B VARCHAR2(250), 
	TELEXNUM VARCHAR2(35), 
	CODCAGENT NUMBER(*,0), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CP_ALIEN ***
 exec bpa.alter_policies('CP_ALIEN');


COMMENT ON TABLE BARS.CP_ALIEN IS 'Партнери по угодах з ЦП';
COMMENT ON COLUMN BARS.CP_ALIEN.MFO IS '....';
COMMENT ON COLUMN BARS.CP_ALIEN.BIC IS 'BIC-код банку';
COMMENT ON COLUMN BARS.CP_ALIEN.NAME IS 'назва банку';
COMMENT ON COLUMN BARS.CP_ALIEN.NLS IS 'рах-к ';
COMMENT ON COLUMN BARS.CP_ALIEN.KOD_G IS 'код держави';
COMMENT ON COLUMN BARS.CP_ALIEN.KOD_B IS 'код банку';
COMMENT ON COLUMN BARS.CP_ALIEN.OKPO IS 'ЗКПО ';
COMMENT ON COLUMN BARS.CP_ALIEN.KV IS 'код валюти';
COMMENT ON COLUMN BARS.CP_ALIEN.BICK IS 'BICK-код';
COMMENT ON COLUMN BARS.CP_ALIEN.NLSK IS 'рах-к ';
COMMENT ON COLUMN BARS.CP_ALIEN.ID IS 'ID запису';
COMMENT ON COLUMN BARS.CP_ALIEN.TXT IS 'код банку';
COMMENT ON COLUMN BARS.CP_ALIEN.AGRMNT_NUM IS '';
COMMENT ON COLUMN BARS.CP_ALIEN.AGRMNT_DATE IS '';
COMMENT ON COLUMN BARS.CP_ALIEN.INTERM_B IS '';
COMMENT ON COLUMN BARS.CP_ALIEN.TELEXNUM IS '';
COMMENT ON COLUMN BARS.CP_ALIEN.CODCAGENT IS '';
COMMENT ON COLUMN BARS.CP_ALIEN.KF IS '';




PROMPT *** Create  constraint CC_CPALIEN_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_ALIEN MODIFY (KF CONSTRAINT CC_CPALIEN_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CPALIEN_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_ALIEN ADD CONSTRAINT FK_CPALIEN_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XAK_CPALIENID ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XAK_CPALIENID ON BARS.CP_ALIEN (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE USERS ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CP_ALIEN ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CP_ALIEN        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CP_ALIEN        to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CP_ALIEN        to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CP_ALIEN.sql =========*** End *** ====
PROMPT ===================================================================================== 
