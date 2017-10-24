

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CIM_F504_DETAIL.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CIM_F504_DETAIL ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CIM_F504_DETAIL'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CIM_F504_DETAIL'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CIM_F504_DETAIL ***
begin 
  execute immediate '
  CREATE TABLE BARS.CIM_F504_DETAIL 
   (	F504_DET_ID NUMBER, 
	F504_ID NUMBER, 
	INDICATOR_ID NUMBER(3,0), 
	INDICATOR_NAME VARCHAR2(255), 
	NOPROGNOSIS NUMBER(1,0), 
	RRRR VARCHAR2(4), 
	W VARCHAR2(1), 
	VAL NUMBER, 
	DATE_REG DATE DEFAULT sysdate, 
	USER_REG VARCHAR2(30), 
	DATE_CH DATE, 
	USER_CH VARCHAR2(30)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CIM_F504_DETAIL ***
 exec bpa.alter_policies('CIM_F504_DETAIL');


COMMENT ON TABLE BARS.CIM_F504_DETAIL IS 'Дані для звіту f504 по показникам в розрізі місяців/років(201,292,293)';
COMMENT ON COLUMN BARS.CIM_F504_DETAIL.F504_DET_ID IS '';
COMMENT ON COLUMN BARS.CIM_F504_DETAIL.F504_ID IS '';
COMMENT ON COLUMN BARS.CIM_F504_DETAIL.INDICATOR_ID IS '';
COMMENT ON COLUMN BARS.CIM_F504_DETAIL.INDICATOR_NAME IS '';
COMMENT ON COLUMN BARS.CIM_F504_DETAIL.NOPROGNOSIS IS '';
COMMENT ON COLUMN BARS.CIM_F504_DETAIL.RRRR IS '';
COMMENT ON COLUMN BARS.CIM_F504_DETAIL.W IS '';
COMMENT ON COLUMN BARS.CIM_F504_DETAIL.VAL IS '';
COMMENT ON COLUMN BARS.CIM_F504_DETAIL.DATE_REG IS '';
COMMENT ON COLUMN BARS.CIM_F504_DETAIL.USER_REG IS '';
COMMENT ON COLUMN BARS.CIM_F504_DETAIL.DATE_CH IS '';
COMMENT ON COLUMN BARS.CIM_F504_DETAIL.USER_CH IS '';




PROMPT *** Create  constraint SYS_C00109134 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_F504_DETAIL MODIFY (F504_DET_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_F504_DET_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_F504_DETAIL ADD CONSTRAINT PK_F504_DET_ID PRIMARY KEY (F504_DET_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint СС_F504_DETAIL_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_F504_DETAIL ADD CONSTRAINT СС_F504_DETAIL_NN CHECK (F504_ID IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_F504_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_F504_DETAIL ADD CONSTRAINT FK_F504_ID FOREIGN KEY (F504_ID)
	  REFERENCES BARS.CIM_F504 (F504_ID) ON DELETE CASCADE DISABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_F504_DET_ID ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_F504_DET_ID ON BARS.CIM_F504_DETAIL (F504_DET_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index CIM_F503_DETAIL_IDX1 ***
begin   
 execute immediate '
  CREATE INDEX BARS.CIM_F503_DETAIL_IDX1 ON BARS.CIM_F504_DETAIL (F504_ID, INDICATOR_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CIM_F504_DETAIL ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_F504_DETAIL to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CIM_F504_DETAIL.sql =========*** End *
PROMPT ===================================================================================== 
