

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/PARAMS_PRIME_LOAD.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to PARAMS_PRIME_LOAD ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''PARAMS_PRIME_LOAD'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''PARAMS_PRIME_LOAD'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table PARAMS_PRIME_LOAD ***
begin 
  execute immediate '
  CREATE TABLE BARS.PARAMS_PRIME_LOAD 
   (	TT CHAR(3), 
	PRIME NUMBER(1,0), 
	N_VALUE VARCHAR2(100), 
	N_IS_EMPTY NUMBER(1,0), 
	N_IS_EDIT NUMBER(1,0), 
	B_VALUE VARCHAR2(100), 
	B_IS_EMPTY NUMBER(1,0), 
	B_IS_EDIT NUMBER(1,0), 
	G_VALUE VARCHAR2(100), 
	G_IS_EMPTY NUMBER(1,0), 
	G_IS_EDIT NUMBER(1,0), 
	IS_CA NUMBER(1,0), 
	DESCRIPTION VARCHAR2(500)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to PARAMS_PRIME_LOAD ***
 exec bpa.alter_policies('PARAMS_PRIME_LOAD');


COMMENT ON TABLE BARS.PARAMS_PRIME_LOAD IS 'ѕервичные значени€и комбинации параметров';
COMMENT ON COLUMN BARS.PARAMS_PRIME_LOAD.TT IS 'код операции';
COMMENT ON COLUMN BARS.PARAMS_PRIME_LOAD.PRIME IS '1-первична€ загрузка';
COMMENT ON COLUMN BARS.PARAMS_PRIME_LOAD.N_VALUE IS 'значение KOD_N';
COMMENT ON COLUMN BARS.PARAMS_PRIME_LOAD.N_IS_EMPTY IS 'может быть пустым 1-да/0-нет';
COMMENT ON COLUMN BARS.PARAMS_PRIME_LOAD.N_IS_EDIT IS 'доступно к редактированию 1-да/0-нет';
COMMENT ON COLUMN BARS.PARAMS_PRIME_LOAD.B_VALUE IS 'значение KOD_B';
COMMENT ON COLUMN BARS.PARAMS_PRIME_LOAD.B_IS_EMPTY IS 'может быть пустым 1-да/0-нет';
COMMENT ON COLUMN BARS.PARAMS_PRIME_LOAD.B_IS_EDIT IS 'доступно к редактированию 1-да/0-нет';
COMMENT ON COLUMN BARS.PARAMS_PRIME_LOAD.G_VALUE IS 'значение KOD_G';
COMMENT ON COLUMN BARS.PARAMS_PRIME_LOAD.G_IS_EMPTY IS 'может быть пустым 1-да/0-нет';
COMMENT ON COLUMN BARS.PARAMS_PRIME_LOAD.G_IS_EDIT IS 'доступно к редактированию 1-да/0-нет';
COMMENT ON COLUMN BARS.PARAMS_PRIME_LOAD.IS_CA IS '÷ј - 1/ –” - 0';
COMMENT ON COLUMN BARS.PARAMS_PRIME_LOAD.DESCRIPTION IS 'описание';




PROMPT *** Create  constraint SYS_C00118469 ***
begin   
 execute immediate '
  ALTER TABLE BARS.PARAMS_PRIME_LOAD MODIFY (TT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00118470 ***
begin   
 execute immediate '
  ALTER TABLE BARS.PARAMS_PRIME_LOAD MODIFY (PRIME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_PARAMSPRIMELOAD ***
begin   
 execute immediate '
  ALTER TABLE BARS.PARAMS_PRIME_LOAD ADD CONSTRAINT UK_PARAMSPRIMELOAD UNIQUE (TT, PRIME, IS_CA)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00118477 ***
begin   
 execute immediate '
  ALTER TABLE BARS.PARAMS_PRIME_LOAD MODIFY (IS_CA NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00118476 ***
begin   
 execute immediate '
  ALTER TABLE BARS.PARAMS_PRIME_LOAD MODIFY (G_IS_EDIT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00118475 ***
begin   
 execute immediate '
  ALTER TABLE BARS.PARAMS_PRIME_LOAD MODIFY (G_IS_EMPTY NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00118474 ***
begin   
 execute immediate '
  ALTER TABLE BARS.PARAMS_PRIME_LOAD MODIFY (B_IS_EDIT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00118473 ***
begin   
 execute immediate '
  ALTER TABLE BARS.PARAMS_PRIME_LOAD MODIFY (B_IS_EMPTY NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00118472 ***
begin   
 execute immediate '
  ALTER TABLE BARS.PARAMS_PRIME_LOAD MODIFY (N_IS_EDIT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00118471 ***
begin   
 execute immediate '
  ALTER TABLE BARS.PARAMS_PRIME_LOAD MODIFY (N_IS_EMPTY NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_PARAMSPRIMELOAD ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_PARAMSPRIMELOAD ON BARS.PARAMS_PRIME_LOAD (TT, PRIME, IS_CA) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/PARAMS_PRIME_LOAD.sql =========*** End
PROMPT ===================================================================================== 
