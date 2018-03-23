PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TEST_MANY.sql =========*** Run *** ======
PROMPT ===================================================================================== 

PROMPT *** Create  table TEST_MANY ***

begin 
  execute immediate '
     CREATE GLOBAL TEMPORARY TABLE BARS.TEST_MANY
                 ( FDAT    DATE,
                   SDI     NUMBER,
                   P1_SS   NUMBER,
                   P1_SN   NUMBER,
                   FAKT    NUMBER,
                   P2_SS   NUMBER,
                   P2_SN   NUMBER,
                   IR      NUMBER,
                   MANY    NUMBER,
                   LIM1    NUMBER,
                   LIM2    NUMBER,
                   GPK     INTEGER,
                   PLAN1   NUMBER,
                   PLAN2   NUMBER,
                   K       NUMBER,
                   PV      NUMBER,
                   DOX     NUMBER,
                   IRR     NUMBER,
                   OTM     INTEGER,
                   P2_PPT  NUMBER,
                   DAT     DATE,
                   ID      NUMBER,
                   ND      NUMBER,
                   PVZ     NUMBER,
                   ZAL     NUMBER
                  ) 
    ON COMMIT PRESERVE ROWS
    RESULT_CACHE (MODE DEFAULT)
    NOCACHE';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

COMMENT ON COLUMN BARS.TEST_MANY.PV  IS 'Теп.варт КД (тiльки грошовi кошти по ГПК)';
COMMENT ON COLUMN BARS.TEST_MANY.PVZ IS 'Теп.варт КД (тiльки забезп)';
COMMENT ON COLUMN BARS.TEST_MANY.ZAL IS 'Ликв.залог в потоке';

PROMPT *** Create  constraint PK_TESTMANY ***

begin   
 execute immediate 'ALTER TABLE BARS.TEST_MANY ADD CONSTRAINT PK_TESTMANY PRIMARY KEY (DAT, ID, ND, FDAT)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

PROMPT *** Create  grants  TEST_MANY ***
GRANT DELETE, INSERT, SELECT, UPDATE ON BARS.TEST_MANY TO BARS_ACCESS_DEFROLE;
GRANT DELETE, INSERT, SELECT, UPDATE ON BARS.TEST_MANY TO RCC_DEAL;

PROMPT ===================================================================================== 
PROMPT *** End *** ======== Scripts /Sql/BARS/Table/TEST_MANY.sql ========*** End *** ======
PROMPT ===================================================================================== 

