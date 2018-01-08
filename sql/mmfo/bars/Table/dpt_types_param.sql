

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPT_TYPES_PARAM.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPT_TYPES_PARAM ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPT_TYPES_PARAM'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_TYPES_PARAM'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPT_TYPES_PARAM ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPT_TYPES_PARAM 
   (	TYPE_ID NUMBER(38,0), 
	DESCRIPTION_UK VARCHAR2(500), 
	DESCRIPTION_EN VARCHAR2(500), 
	DESCRIPTION_RU VARCHAR2(500), 
	TOPUPAMOUNT_UK VARCHAR2(500), 
	TOPUPAMOUNT_EN VARCHAR2(500), 
	TOPUPAMOUNT_RU VARCHAR2(500), 
	EARLYCLOSE_UK VARCHAR2(500), 
	EARLYCLOSE_EN VARCHAR2(500), 
	EARLYCLOSE_RU VARCHAR2(500), 
	WITHDRAWAL_UK VARCHAR2(500), 
	WITHDRAWAL_EN VARCHAR2(500), 
	WITHDRAWAL_RU VARCHAR2(500), 
	PENSIONER NUMBER(1,0) DEFAULT 0, 
	EMPLOYEE NUMBER(1,0) DEFAULT 0
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPT_TYPES_PARAM ***
 exec bpa.alter_policies('DPT_TYPES_PARAM');


COMMENT ON TABLE BARS.DPT_TYPES_PARAM IS 'Параметри типів депозитних договорів ФО';
COMMENT ON COLUMN BARS.DPT_TYPES_PARAM.TYPE_ID IS 'Числ.код типа договора';
COMMENT ON COLUMN BARS.DPT_TYPES_PARAM.DESCRIPTION_UK IS 'Опис продукту (УКР)';
COMMENT ON COLUMN BARS.DPT_TYPES_PARAM.DESCRIPTION_EN IS 'Опис продукту (АНГЛ)';
COMMENT ON COLUMN BARS.DPT_TYPES_PARAM.DESCRIPTION_RU IS 'Опис продукту (РОС)';
COMMENT ON COLUMN BARS.DPT_TYPES_PARAM.TOPUPAMOUNT_UK IS 'Опис умов поповнення (УКР)';
COMMENT ON COLUMN BARS.DPT_TYPES_PARAM.TOPUPAMOUNT_EN IS 'Опис умов поповнення (РОС)';
COMMENT ON COLUMN BARS.DPT_TYPES_PARAM.TOPUPAMOUNT_RU IS '';
COMMENT ON COLUMN BARS.DPT_TYPES_PARAM.EARLYCLOSE_UK IS 'Опис умов дострокового закриття (УКР)';
COMMENT ON COLUMN BARS.DPT_TYPES_PARAM.EARLYCLOSE_EN IS 'Опис умов дострокового закриття (АНГЛ)';
COMMENT ON COLUMN BARS.DPT_TYPES_PARAM.EARLYCLOSE_RU IS 'Опис умов дострокового закриття (РОС)';
COMMENT ON COLUMN BARS.DPT_TYPES_PARAM.WITHDRAWAL_UK IS 'Опис умов часткового закриття (УКР)';
COMMENT ON COLUMN BARS.DPT_TYPES_PARAM.WITHDRAWAL_EN IS 'Опис умов часткового закриття (АНГЛ)';
COMMENT ON COLUMN BARS.DPT_TYPES_PARAM.WITHDRAWAL_RU IS 'Опис умов часткового закриття (РОС)';
COMMENT ON COLUMN BARS.DPT_TYPES_PARAM.PENSIONER IS 'Ознака сегменту (пенсіонерам)';
COMMENT ON COLUMN BARS.DPT_TYPES_PARAM.EMPLOYEE IS 'Ознака сегменту (працівникам Банку)';



PROMPT *** Create  grants  DPT_TYPES_PARAM ***
grant SELECT                                                                 on DPT_TYPES_PARAM to BARSREADER_ROLE;
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on DPT_TYPES_PARAM to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPT_TYPES_PARAM to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPT_TYPES_PARAM.sql =========*** End *
PROMPT ===================================================================================== 
