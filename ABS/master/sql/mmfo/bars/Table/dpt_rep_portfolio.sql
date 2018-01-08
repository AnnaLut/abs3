

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPT_REP_PORTFOLIO.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPT_REP_PORTFOLIO ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPT_REP_PORTFOLIO'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_REP_PORTFOLIO'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_REP_PORTFOLIO'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPT_REP_PORTFOLIO ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPT_REP_PORTFOLIO 
   (	REC_ID NUMBER, 
	BRANCH_ID VARCHAR2(50), 
	TYPE_ID NUMBER, 
	TYPE_NAME VARCHAR2(250), 
	CUST_TYPE VARCHAR2(5), 
	NBS NUMBER, 
	OB22 VARCHAR2(3), 
	COUNT1 NUMBER, 
	AMOUNT1 NUMBER, 
	COUNT2_1 NUMBER, 
	AMOUNT2_1 NUMBER, 
	COUNT2_2 NUMBER, 
	AMOUNT2_2 NUMBER, 
	COUNT3_1 NUMBER, 
	AMOUNT3_1 NUMBER, 
	COUNT3_2 NUMBER, 
	AMOUNT3_2 NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYNI ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPT_REP_PORTFOLIO ***
 exec bpa.alter_policies('DPT_REP_PORTFOLIO');


COMMENT ON TABLE BARS.DPT_REP_PORTFOLIO IS '';
COMMENT ON COLUMN BARS.DPT_REP_PORTFOLIO.REC_ID IS '';
COMMENT ON COLUMN BARS.DPT_REP_PORTFOLIO.BRANCH_ID IS '';
COMMENT ON COLUMN BARS.DPT_REP_PORTFOLIO.TYPE_ID IS '';
COMMENT ON COLUMN BARS.DPT_REP_PORTFOLIO.TYPE_NAME IS 'Назва  депозитного продукту';
COMMENT ON COLUMN BARS.DPT_REP_PORTFOLIO.CUST_TYPE IS 'Признак клієнта';
COMMENT ON COLUMN BARS.DPT_REP_PORTFOLIO.NBS IS 'Балансовий рахунок';
COMMENT ON COLUMN BARS.DPT_REP_PORTFOLIO.OB22 IS 'Частина номеру аналітичного рахунку (OB22)';
COMMENT ON COLUMN BARS.DPT_REP_PORTFOLIO.COUNT1 IS 'Залишок станом на перший день року - укладених договорів (шт.)';
COMMENT ON COLUMN BARS.DPT_REP_PORTFOLIO.AMOUNT1 IS 'Залишок станом на перший день року - коштів на рахунках (грн.)';
COMMENT ON COLUMN BARS.DPT_REP_PORTFOLIO.COUNT2_1 IS 'Розірваних договорів (шт.) - за рік';
COMMENT ON COLUMN BARS.DPT_REP_PORTFOLIO.AMOUNT2_1 IS 'Розірваних договорів за рік - на загальну суму (грн.)';
COMMENT ON COLUMN BARS.DPT_REP_PORTFOLIO.COUNT2_2 IS 'Розірваних договорів за ІІ півріччя - укладених договорів (шт.)';
COMMENT ON COLUMN BARS.DPT_REP_PORTFOLIO.AMOUNT2_2 IS 'Розірваних договорів за ІІ півріччя - на загальну суму (грн.)';
COMMENT ON COLUMN BARS.DPT_REP_PORTFOLIO.COUNT3_1 IS '';
COMMENT ON COLUMN BARS.DPT_REP_PORTFOLIO.AMOUNT3_1 IS '';
COMMENT ON COLUMN BARS.DPT_REP_PORTFOLIO.COUNT3_2 IS '';
COMMENT ON COLUMN BARS.DPT_REP_PORTFOLIO.AMOUNT3_2 IS '';




PROMPT *** Create  constraint SYS_C004861 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_REP_PORTFOLIO MODIFY (REC_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPT_REP_PORTFOLIO ***
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_REP_PORTFOLIO to ABS_ADMIN;
grant REFERENCES,SELECT                                                      on DPT_REP_PORTFOLIO to BARSAQ with grant option;
grant REFERENCES,SELECT                                                      on DPT_REP_PORTFOLIO to BARSAQ_ADM with grant option;
grant SELECT                                                                 on DPT_REP_PORTFOLIO to BARSUPL;
grant ALTER,DELETE,FLASHBACK,INSERT,SELECT,UPDATE                            on DPT_REP_PORTFOLIO to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPT_REP_PORTFOLIO to BARS_DM;
grant SELECT                                                                 on DPT_REP_PORTFOLIO to CC_DOC;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on DPT_REP_PORTFOLIO to DPT;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_REP_PORTFOLIO to DPT_ADMIN;
grant SELECT                                                                 on DPT_REP_PORTFOLIO to DPT_ROLE;
grant SELECT                                                                 on DPT_REP_PORTFOLIO to REFSYNC_USR;
grant SELECT                                                                 on DPT_REP_PORTFOLIO to RPBN001;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on DPT_REP_PORTFOLIO to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPT_REP_PORTFOLIO to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on DPT_REP_PORTFOLIO to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPT_REP_PORTFOLIO.sql =========*** End
PROMPT ===================================================================================== 
