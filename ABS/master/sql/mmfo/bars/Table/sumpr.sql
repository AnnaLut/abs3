

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SUMPR.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SUMPR ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SUMPR'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SUMPR'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''SUMPR'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SUMPR ***
begin 
  execute immediate '
  CREATE TABLE BARS.SUMPR 
   (	I NUMBER(2,0), 
	E NUMBER(2,0), 
	ROD CHAR(1), 
	DES VARCHAR2(20), 
	DES2 VARCHAR2(20), 
	DES3 VARCHAR2(20)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SUMPR ***
 exec bpa.alter_policies('SUMPR');


COMMENT ON TABLE BARS.SUMPR IS 'Таблица для генерации суммы прописью';
COMMENT ON COLUMN BARS.SUMPR.I IS 'Сумма цифрами (единицы)';
COMMENT ON COLUMN BARS.SUMPR.E IS 'Количество разрядов (нулей)';
COMMENT ON COLUMN BARS.SUMPR.ROD IS '';
COMMENT ON COLUMN BARS.SUMPR.DES IS 'Сумма прописью';
COMMENT ON COLUMN BARS.SUMPR.DES2 IS 'Сумма прописью-2';
COMMENT ON COLUMN BARS.SUMPR.DES3 IS 'Сумма прописью-3';




PROMPT *** Create  constraint PK_SUMPR ***
begin   
 execute immediate '
  ALTER TABLE BARS.SUMPR ADD CONSTRAINT PK_SUMPR PRIMARY KEY (I, E, ROD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SUMPR_I_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SUMPR MODIFY (I CONSTRAINT CC_SUMPR_I_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SUMPR_E_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SUMPR MODIFY (E CONSTRAINT CC_SUMPR_E_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SUMPR_ROD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SUMPR MODIFY (ROD CONSTRAINT CC_SUMPR_ROD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SUMPR_DES_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SUMPR MODIFY (DES CONSTRAINT CC_SUMPR_DES_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SUMPR_DES2_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SUMPR MODIFY (DES2 CONSTRAINT CC_SUMPR_DES2_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SUMPR_DES3_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SUMPR MODIFY (DES3 CONSTRAINT CC_SUMPR_DES3_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SUMPR ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SUMPR ON BARS.SUMPR (I, E, ROD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SUMPR ***
grant DELETE,INSERT,SELECT,UPDATE                                            on SUMPR           to ABS_ADMIN;
grant SELECT                                                                 on SUMPR           to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on SUMPR           to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SUMPR           to BARS_DM;
grant SELECT                                                                 on SUMPR           to START1;
grant SELECT                                                                 on SUMPR           to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SUMPR           to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SUMPR.sql =========*** End *** =======
PROMPT ===================================================================================== 
