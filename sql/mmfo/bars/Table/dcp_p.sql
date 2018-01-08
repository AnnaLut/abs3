

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DCP_P.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DCP_P ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DCP_P'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''DCP_P'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''DCP_P'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DCP_P ***
begin 
  execute immediate '
  CREATE TABLE BARS.DCP_P 
   (	ID NUMBER(*,0), 
	MFOA VARCHAR2(9), 
	MDOA VARCHAR2(9), 
	MFOB VARCHAR2(9), 
	MDOB VARCHAR2(9), 
	NLSB VARCHAR2(14), 
	OKPOB VARCHAR2(14), 
	S NUMBER, 
	ID_UG VARCHAR2(8), 
	DAT_UG DATE, 
	OZN_SP VARCHAR2(16), 
	REF NUMBER(38,0), 
	ACC NUMBER(38,0), 
	OKPOA VARCHAR2(14), 
	N_UG VARCHAR2(30), 
	D_UG DATE, 
	FN VARCHAR2(12), 
	DAT DATE, 
	FNA VARCHAR2(12), 
	DATA DATE, 
	FNT VARCHAR2(12), 
	DATT DATE, 
	ERR_NBU VARCHAR2(4), 
	ERR_DEP VARCHAR2(4), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DCP_P ***
 exec bpa.alter_policies('DCP_P');


COMMENT ON TABLE BARS.DCP_P IS '';
COMMENT ON COLUMN BARS.DCP_P.ID IS '';
COMMENT ON COLUMN BARS.DCP_P.MFOA IS '';
COMMENT ON COLUMN BARS.DCP_P.MDOA IS '';
COMMENT ON COLUMN BARS.DCP_P.MFOB IS '';
COMMENT ON COLUMN BARS.DCP_P.MDOB IS '';
COMMENT ON COLUMN BARS.DCP_P.NLSB IS '';
COMMENT ON COLUMN BARS.DCP_P.OKPOB IS '';
COMMENT ON COLUMN BARS.DCP_P.S IS '';
COMMENT ON COLUMN BARS.DCP_P.ID_UG IS '';
COMMENT ON COLUMN BARS.DCP_P.DAT_UG IS '';
COMMENT ON COLUMN BARS.DCP_P.OZN_SP IS '';
COMMENT ON COLUMN BARS.DCP_P.REF IS '';
COMMENT ON COLUMN BARS.DCP_P.ACC IS '';
COMMENT ON COLUMN BARS.DCP_P.OKPOA IS '';
COMMENT ON COLUMN BARS.DCP_P.N_UG IS '';
COMMENT ON COLUMN BARS.DCP_P.D_UG IS '';
COMMENT ON COLUMN BARS.DCP_P.FN IS '';
COMMENT ON COLUMN BARS.DCP_P.DAT IS 'Дата/время создания файла P';
COMMENT ON COLUMN BARS.DCP_P.FNA IS 'Имя файла А';
COMMENT ON COLUMN BARS.DCP_P.DATA IS 'Дата/время создания файла А';
COMMENT ON COLUMN BARS.DCP_P.FNT IS 'Имя файла Т';
COMMENT ON COLUMN BARS.DCP_P.DATT IS 'Дата/время создания файла Т';
COMMENT ON COLUMN BARS.DCP_P.ERR_NBU IS 'Код ошибки АРМ-НБУ по файлу А';
COMMENT ON COLUMN BARS.DCP_P.ERR_DEP IS 'Код ошибки Депозитария по файлу А';
COMMENT ON COLUMN BARS.DCP_P.KF IS '';




PROMPT *** Create  constraint PK_DCPP ***
begin   
 execute immediate '
  ALTER TABLE BARS.DCP_P ADD CONSTRAINT PK_DCPP PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DCPP_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DCP_P MODIFY (ID CONSTRAINT CC_DCPP_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DCPP_FN_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DCP_P MODIFY (FN CONSTRAINT CC_DCPP_FN_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DCPP_DAT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DCP_P MODIFY (DAT CONSTRAINT CC_DCPP_DAT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DCPP_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DCP_P MODIFY (KF CONSTRAINT CC_DCPP_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DCPP ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DCPP ON BARS.DCP_P (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DCP_P ***
grant SELECT                                                                 on DCP_P           to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on DCP_P           to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DCP_P           to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on DCP_P           to FOREX;
grant SELECT                                                                 on DCP_P           to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DCP_P.sql =========*** End *** =======
PROMPT ===================================================================================== 
