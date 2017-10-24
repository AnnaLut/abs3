

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/K_DFM01B.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to K_DFM01B ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''K_DFM01B'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''K_DFM01B'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''K_DFM01B'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table K_DFM01B ***
begin 
  execute immediate '
  CREATE TABLE BARS.K_DFM01B 
   (	CODE VARCHAR2(1), 
	NAME VARCHAR2(150), 
	D_CLOSE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to K_DFM01B ***
 exec bpa.alter_policies('K_DFM01B');


COMMENT ON TABLE BARS.K_DFM01B IS '';
COMMENT ON COLUMN BARS.K_DFM01B.CODE IS '';
COMMENT ON COLUMN BARS.K_DFM01B.NAME IS '';
COMMENT ON COLUMN BARS.K_DFM01B.D_CLOSE IS '';




PROMPT *** Create  constraint PK_KDFM01B_CODE ***
begin   
 execute immediate '
  ALTER TABLE BARS.K_DFM01B ADD CONSTRAINT PK_KDFM01B_CODE PRIMARY KEY (CODE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_KDFM01B_CODE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.K_DFM01B MODIFY (CODE CONSTRAINT CC_KDFM01B_CODE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_KDFM01B_CODE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_KDFM01B_CODE ON BARS.K_DFM01B (CODE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  K_DFM01B ***
grant SELECT                                                                 on K_DFM01B        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on K_DFM01B        to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/K_DFM01B.sql =========*** End *** ====
PROMPT ===================================================================================== 
