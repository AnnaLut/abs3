PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NBUR_DCT_F6EX_EKP.sql =========*** Run 
PROMPT ===================================================================================== 

PROMPT *** ALTER_POLICY_INFO to NBUR_DCT_F6EX_EKP ***

BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NBUR_DCT_F6EX_EKP'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''NBUR_DCT_F6EX_EKP'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''NBUR_DCT_F6EX_EKP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NBUR_DCT_F6EX_EKP ***
begin 
  execute immediate '
  CREATE TABLE BARS.NBUR_DCT_F6EX_EKP 
   (	EKP            VARCHAR2(6 CHAR)   constraint CC_NBURDCT6EXEKP_EKP_NN NOT NULL, 
	    EKP_NAME       VARCHAR2(255 CHAR) constraint CC_NBURDCT6EXEKP_EKPNAME_NN NOT NULL,
        GRP_R030       VARCHAR2(1 CHAR) constraint CC_NBURDCT6EXEKP_GRPR030_NN NOT NULL,
        AGGR_EKP       VARCHAR2(6 CHAR),
        CONSTANT_VALUE NUMBER(38),
        FORMULA	       VARCHAR(255 CHAR),
	    LCY_PCT        NUMBER(12, 2), 
	    FCY_PCT        NUMBER(12, 2),
        R030_980       VARCHAR2(1 CHAR)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
  NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

PROMPT *** ALTER_POLICIES to NBUR_DCT_F6EX_EKP ***
 exec bpa.alter_policies('NBUR_DCT_F6EX_EKP');

prompt add column FORMULA
begin
    execute immediate 'alter table NBUR_DCT_F6EX_EKP add FORMULA varchar2(255 char)';
exception
    when others then
        if sqlcode = -1430 then null; else raise; end if;
end;
/
prompt add column R030_980
begin
    execute immediate 'alter table NBUR_DCT_F6EX_EKP add R030_980 VARCHAR2(1 CHAR)';
exception
    when others then
        if sqlcode = -1430 then null; else raise; end if;
end;
/


COMMENT ON TABLE BARS.NBUR_DCT_F6EX_EKP IS 'Показники для формування файлу 6EX';
COMMENT ON COLUMN BARS.NBUR_DCT_F6EX_EKP.EKP IS 'Код показника';
COMMENT ON COLUMN BARS.NBUR_DCT_F6EX_EKP.EKP_NAME IS 'Найменування показника';
COMMENT ON COLUMN BARS.NBUR_DCT_F6EX_EKP.GRP_R030  IS 'Флаг групування показника по валюті';
COMMENT ON COLUMN BARS.NBUR_DCT_F6EX_EKP.AGGR_EKP IS 'Код агрегуючого показника';
COMMENT ON COLUMN BARS.NBUR_DCT_F6EX_EKP.CONSTANT_VALUE IS 'Значення показника (константа)';
COMMENT ON COLUMN BARS.NBUR_DCT_F6EX_EKP.FORMULA IS 'Формула для розрахунку показника';
COMMENT ON COLUMN BARS.NBUR_DCT_F6EX_EKP.LCY_PCT IS 'Коефіцієнт показника у національній валюті';
COMMENT ON COLUMN BARS.NBUR_DCT_F6EX_EKP.FCY_PCT IS 'Коефіцієнт показника у іноземній валюті';
COMMENT ON COLUMN BARS.NBUR_DCT_F6EX_EKP.R030_980 IS 'Ознака того, що показник формувати з кодом 980 по всіх валютах';


PROMPT *** Create  constraint PK_NBUR_DCT_F6EX_EKP ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DCT_F6EX_EKP ADD CONSTRAINT PK_NBURDCT6EXEKP PRIMARY KEY (EKP)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

PROMPT *** Create  constraint CC_NBUR_DCT_F6EX_EKP_GRP_R030 ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DCT_F6EX_EKP ADD CONSTRAINT CC_NBUR_DCT_F6EX_EKP_GRP_R030 CHECK (GRP_R030 in (0,1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

PROMPT *** Create  constraint CC_NBUR_DCT_F6EX_EKP_LCY_PCT ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DCT_F6EX_EKP ADD CONSTRAINT CC_NBUR_DCT_F6EX_EKP_LCY_PCT CHECK (LCY_PCT between -100 and 100) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

PROMPT *** Create  constraint CC_NBUR_DCT_F6EX_EKP_FCY_PCT ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DCT_F6EX_EKP ADD CONSTRAINT CC_NBUR_DCT_F6EX_EKP_FCY_PCT CHECK (FCY_PCT between -100 and 100) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/


PROMPT *** Create  grants  NBUR_DCT_F6EX_EKP ***
grant SELECT                                                                 on NBUR_DCT_F6EX_EKP to BARS_DM;
grant SELECT                                                                 on NBUR_DCT_F6EX_EKP to UPLD;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NBUR_DCT_F6EX_EKP.sql =========*** End 
PROMPT ===================================================================================== 