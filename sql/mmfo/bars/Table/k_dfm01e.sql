

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/K_DFM01E.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to K_DFM01E ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''K_DFM01E'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''K_DFM01E'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''K_DFM01E'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table K_DFM01E ***
begin 
  execute immediate '
  CREATE TABLE BARS.K_DFM01E 
   (	CODE VARCHAR2(1), 
	NAME VARCHAR2(120), 
	D_CLOSE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to K_DFM01E ***
 exec bpa.alter_policies('K_DFM01E');


COMMENT ON TABLE BARS.K_DFM01E IS '';
COMMENT ON COLUMN BARS.K_DFM01E.CODE IS '';
COMMENT ON COLUMN BARS.K_DFM01E.NAME IS '';
COMMENT ON COLUMN BARS.K_DFM01E.D_CLOSE IS '';




PROMPT *** Create  constraint PK_KDFM01E_CODE ***
begin   
 execute immediate '
  ALTER TABLE BARS.K_DFM01E ADD CONSTRAINT PK_KDFM01E_CODE PRIMARY KEY (CODE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_KDFM01E_CODE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.K_DFM01E MODIFY (CODE CONSTRAINT CC_KDFM01E_CODE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_KDFM01E_CODE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_KDFM01E_CODE ON BARS.K_DFM01E (CODE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  K_DFM01E ***
grant SELECT                                                                 on K_DFM01E        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on K_DFM01E        to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/K_DFM01E.sql =========*** End *** ====
PROMPT ===================================================================================== 
