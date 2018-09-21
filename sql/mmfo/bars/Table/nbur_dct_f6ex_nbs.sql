PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NBUR_DCT_F6EX_NBS.sql =========*** Run 
PROMPT ===================================================================================== 

PROMPT *** ALTER_POLICY_INFO to NBUR_DCT_F6EX_NBS ***

BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NBUR_DCT_F6EX_NBS'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''NBUR_DCT_F6EX_NBS'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''NBUR_DCT_F6EX_NBS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NBUR_DCT_F6EX_NBS ***
begin 
  execute immediate '
  CREATE TABLE BARS.NBUR_DCT_F6EX_NBS 
   (	
        RULE_ID         NUMBER constraint CC_NBURDCT6EXNBS_RULEID_NN NOT NULL,
        R020            VARCHAR2(4 CHAR),
        T020            VARCHAR2(1 CHAR),
        R011            VARCHAR2(1 CHAR),    
        R013            VARCHAR2(1 CHAR), 
        S130            VARCHAR2(2 CHAR),
        K030            VARCHAR2(1 CHAR),
        M030	        VARCHAR2(1 CHAR),
        K040            VARCHAR2(3 CHAR),
        K180            VARCHAR2(1 CHAR),
        K190            VARCHAR2(1 CHAR),
        S240            VARCHAR2(1 CHAR),
        BLKD            VARCHAR2(1 CHAR),
        MSG_RETURN_FLG  VARCHAR2(1 CHAR),
        DEFAULT_FLG     VARCHAR2(1 CHAR),
        LIQUID_TYPE     VARCHAR2(1 CHAR),
        CREDIT_WORK_FLG VARCHAR2(1 CHAR),
		CREDIT_IRR_COMM_FLG  VARCHAR2(1 CHAR),
        CUST_TYPE       VARCHAR2(2 CHAR),
        CUST_RATING     VARCHAR2(2 CHAR),
        FACTOR          NUMBER,
        EKP             VARCHAR2(6 CHAR)   constraint CC_NBURDCT6EXNBS_EKP_NN NOT NULL, 
	LCY_PCT         NUMBER(12, 2), 
	FCY_PCT         NUMBER(12, 2)       
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

begin 
  execute immediate '
  ALTER TABLE BARS.NBUR_DCT_F6EX_NBS 
  ADD (CREDIT_IRR_COMM_FLG  VARCHAR2(1 CHAR))';
exception when others then       
  if sqlcode=-01430 then null; else raise; end if; 
end; 
/  

PROMPT *** ALTER_POLICIES to NBUR_DCT_F6EX_NBS ***
 exec bpa.alter_policies('NBUR_DCT_F6EX_NBS');

COMMENT ON TABLE BARS.NBUR_DCT_F6EX_NBS IS 'Мапування до показників файлу 6EX';
COMMENT ON COLUMN BARS.NBUR_DCT_F6EX_NBS.RULE_ID IS 'Уникальный идентификатор правила';
COMMENT ON COLUMN BARS.NBUR_DCT_F6EX_NBS.R020 IS 'Балансовий рахунок';
COMMENT ON COLUMN BARS.NBUR_DCT_F6EX_NBS.T020 IS 'Показник актив/пасив';
COMMENT ON COLUMN BARS.NBUR_DCT_F6EX_NBS.R011 IS 'Параметр R011';
COMMENT ON COLUMN BARS.NBUR_DCT_F6EX_NBS.R013 IS 'Параметр R013';
COMMENT ON COLUMN BARS.NBUR_DCT_F6EX_NBS.S130 IS 'Параметр S130';
COMMENT ON COLUMN BARS.NBUR_DCT_F6EX_NBS.K030 IS 'Резидентність';
COMMENT ON COLUMN BARS.NBUR_DCT_F6EX_NBS.M030 IS 'Срок погашення до 30 днів';
COMMENT ON COLUMN BARS.NBUR_DCT_F6EX_NBS.K040 IS 'Код країни';
COMMENT ON COLUMN BARS.NBUR_DCT_F6EX_NBS.K180 IS 'Параметр K180';
COMMENT ON COLUMN BARS.NBUR_DCT_F6EX_NBS.K190 IS 'Параметр K190';
COMMENT ON COLUMN BARS.NBUR_DCT_F6EX_NBS.S240 IS 'Параметр S240';
COMMENT ON COLUMN BARS.NBUR_DCT_F6EX_NBS.FACTOR IS 'Множник показника';
COMMENT ON COLUMN BARS.NBUR_DCT_F6EX_NBS.BLKD IS 'Флаг наявності блокування дебетування рахунку';
COMMENT ON COLUMN BARS.NBUR_DCT_F6EX_NBS.MSG_RETURN_FLG IS 'Флаг наявності повідомлення про повернення вкладу/депозиту';
COMMENT ON COLUMN BARS.NBUR_DCT_F6EX_NBS.DEFAULT_FLG IS 'Флаг дефолту';
COMMENT ON COLUMN BARS.NBUR_DCT_F6EX_NBS.LIQUID_TYPE IS 'Тип ліквідних активів';
COMMENT ON COLUMN BARS.NBUR_DCT_F6EX_NBS.CUST_TYPE IS 'Тип клієнта';
COMMENT ON COLUMN BARS.NBUR_DCT_F6EX_NBS.CUST_RATING IS 'Рейтінг клієнта';
COMMENT ON COLUMN BARS.NBUR_DCT_F6EX_NBS.CREDIT_WORK_FLG IS 'Флаг повністю працюючого кредиту';
COMMENT ON COLUMN BARS.NBUR_DCT_F6EX_NBS.CREDIT_IRR_COMM_FLG IS 'Флаг безвідкличних зобов''язань банку з кредитування';
COMMENT ON COLUMN BARS.NBUR_DCT_F6EX_NBS.EKP IS 'Код показника';
COMMENT ON COLUMN BARS.NBUR_DCT_F6EX_NBS.LCY_PCT IS 'Коефіцієнт показника у національній валюті';
COMMENT ON COLUMN BARS.NBUR_DCT_F6EX_NBS.FCY_PCT IS 'Коефіцієнт показника у іноземній валюті';


PROMPT *** Create  constraint PK_NBUR_DCT_F6EX_NBS ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DCT_F6EX_NBS ADD CONSTRAINT PK_NBURDCT6EXNBS PRIMARY KEY (RULE_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

PROMPT *** Create  grants  NBUR_DCT_F6EX_NBS ***
grant SELECT                                                                 on NBUR_DCT_F6EX_NBS to BARS_DM;
grant SELECT                                                                 on NBUR_DCT_F6EX_NBS to UPLD;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NBUR_DCT_F6EX_NBS.sql =========*** End 
PROMPT ===================================================================================== 