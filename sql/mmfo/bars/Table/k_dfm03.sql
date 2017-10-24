

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/K_DFM03.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to K_DFM03 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''K_DFM03'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''K_DFM03'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''K_DFM03'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table K_DFM03 ***
begin 
  execute immediate '
  CREATE TABLE BARS.K_DFM03 
   (	CODE VARCHAR2(3), 
	NAME VARCHAR2(512), 
	D_CLOSE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to K_DFM03 ***
 exec bpa.alter_policies('K_DFM03');


COMMENT ON TABLE BARS.K_DFM03 IS '';
COMMENT ON COLUMN BARS.K_DFM03.CODE IS '';
COMMENT ON COLUMN BARS.K_DFM03.NAME IS '';
COMMENT ON COLUMN BARS.K_DFM03.D_CLOSE IS '';




PROMPT *** Create  constraint PK_KDFM03_CODE ***
begin   
 execute immediate '
  ALTER TABLE BARS.K_DFM03 ADD CONSTRAINT PK_KDFM03_CODE PRIMARY KEY (CODE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_KDFM03_CODE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.K_DFM03 MODIFY (CODE CONSTRAINT CC_KDFM03_CODE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_KDFM03_CODE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_KDFM03_CODE ON BARS.K_DFM03 (CODE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  K_DFM03 ***
grant SELECT                                                                 on K_DFM03         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on K_DFM03         to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/K_DFM03.sql =========*** End *** =====
PROMPT ===================================================================================== 
