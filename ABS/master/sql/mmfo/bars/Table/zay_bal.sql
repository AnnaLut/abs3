

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ZAY_BAL.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ZAY_BAL ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ZAY_BAL'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''ZAY_BAL'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ZAY_BAL'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ZAY_BAL ***
begin 
  execute immediate '
  CREATE TABLE BARS.ZAY_BAL 
   (	NBS VARCHAR2(4), 
	FL_AUTOPEN NUMBER(1,0) DEFAULT 0
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ZAY_BAL ***
 exec bpa.alter_policies('ZAY_BAL');


COMMENT ON TABLE BARS.ZAY_BAL IS 'Справочник допустимых бал.счетов модуля <Биржевые операции>';
COMMENT ON COLUMN BARS.ZAY_BAL.NBS IS 'Бал.счет';
COMMENT ON COLUMN BARS.ZAY_BAL.FL_AUTOPEN IS 'Флаг автооткрытия';




PROMPT *** Create  constraint XPK_ZAY_BAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAY_BAL ADD CONSTRAINT XPK_ZAY_BAL PRIMARY KEY (NBS)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_ZAY_BAL_NBS ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAY_BAL MODIFY (NBS CONSTRAINT NK_ZAY_BAL_NBS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_ZAY_BAL ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_ZAY_BAL ON BARS.ZAY_BAL (NBS) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ZAY_BAL ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on ZAY_BAL         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ZAY_BAL         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on ZAY_BAL         to TECH_MOM1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on ZAY_BAL         to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on ZAY_BAL         to WR_REFREAD;
grant DELETE,INSERT,SELECT,UPDATE                                            on ZAY_BAL         to ZAY;



PROMPT *** Create SYNONYM  to ZAY_BAL ***

  CREATE OR REPLACE PUBLIC SYNONYM ZAY_BAL FOR BARS.ZAY_BAL;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ZAY_BAL.sql =========*** End *** =====
PROMPT ===================================================================================== 
