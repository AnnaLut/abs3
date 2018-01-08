

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CIM_F504_DETAIL2.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CIM_F504_DETAIL2 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CIM_F504_DETAIL2'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CIM_F504_DETAIL2'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CIM_F504_DETAIL2 ***
begin 
  execute immediate '
  CREATE TABLE BARS.CIM_F504_DETAIL2 
   (	F504_DET_ID NUMBER, 
	F504_ID NUMBER, 
	INDICATOR_ID NUMBER(3,0), 
	INDICATOR_NAME VARCHAR2(255), 
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




PROMPT *** ALTER_POLICIES to CIM_F504_DETAIL2 ***
 exec bpa.alter_policies('CIM_F504_DETAIL2');


COMMENT ON TABLE BARS.CIM_F504_DETAIL2 IS 'Дані для звіту f504 по показникам в розрізі місяців/років(крім 201,292,293)';
COMMENT ON COLUMN BARS.CIM_F504_DETAIL2.F504_DET_ID IS '';
COMMENT ON COLUMN BARS.CIM_F504_DETAIL2.F504_ID IS '';
COMMENT ON COLUMN BARS.CIM_F504_DETAIL2.INDICATOR_ID IS '';
COMMENT ON COLUMN BARS.CIM_F504_DETAIL2.INDICATOR_NAME IS '';
COMMENT ON COLUMN BARS.CIM_F504_DETAIL2.RRRR IS '';
COMMENT ON COLUMN BARS.CIM_F504_DETAIL2.W IS '';
COMMENT ON COLUMN BARS.CIM_F504_DETAIL2.VAL IS '';
COMMENT ON COLUMN BARS.CIM_F504_DETAIL2.DATE_REG IS '';
COMMENT ON COLUMN BARS.CIM_F504_DETAIL2.USER_REG IS '';
COMMENT ON COLUMN BARS.CIM_F504_DETAIL2.DATE_CH IS '';
COMMENT ON COLUMN BARS.CIM_F504_DETAIL2.USER_CH IS '';




PROMPT *** Create  constraint SYS_C00109138 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_F504_DETAIL2 MODIFY (F504_DET_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_F504_DET2_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_F504_DETAIL2 ADD CONSTRAINT PK_F504_DET2_ID PRIMARY KEY (F504_DET_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint СС_F504_DETAIL2_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_F504_DETAIL2 ADD CONSTRAINT СС_F504_DETAIL2_NN CHECK (F504_ID IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_F504_DET2_ID ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_F504_DET2_ID ON BARS.CIM_F504_DETAIL2 (F504_DET_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index CIM_F503_DETAIL2_IDX1 ***
begin   
 execute immediate '
  CREATE INDEX BARS.CIM_F503_DETAIL2_IDX1 ON BARS.CIM_F504_DETAIL2 (F504_ID, INDICATOR_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CIM_F504_DETAIL2 ***
grant SELECT                                                                 on CIM_F504_DETAIL2 to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_F504_DETAIL2 to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CIM_F504_DETAIL2 to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CIM_F504_DETAIL2.sql =========*** End 
PROMPT ===================================================================================== 
