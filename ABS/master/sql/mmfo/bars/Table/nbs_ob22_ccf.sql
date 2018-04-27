PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NBS_OB22_CCF.sql =========*** Run *** 
PROMPT ===================================================================================== 

PROMPT *** ALTER_POLICY_INFO to NBS_OB22_CCF ***

BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NBS_OB22_CCF'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''NBS_OB22_CCF'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NBS_OB22_CCF ***
begin 
  execute immediate '
  CREATE TABLE BARS.NBS_OB22_CCF 
   (	NBS    VARCHAR2(4), 
	OB22   VARCHAR2(4), 
	SROK   NUMBER,
        CCF    NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD  ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

PROMPT *** ALTER_POLICIES to NBS_OB22_CCF ***
 exec bpa.alter_policies('NBS_OB22_CCF');

COMMENT ON TABLE  BARS.NBS_OB22_CCF       IS 'Показники кредитної конверсії';
COMMENT ON COLUMN BARS.NBS_OB22_CCF.NBS   IS 'Бал.рахунок';
COMMENT ON COLUMN BARS.NBS_OB22_CCF.OB22  IS 'ОБ22';
COMMENT ON COLUMN BARS.NBS_OB22_CCF.Srok  IS 'Строк';
COMMENT ON COLUMN BARS.NBS_OB22_CCF.CCF   IS 'CCF';

PROMPT *** Create  constraint PK_NBS_OB22_CCF ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBS_OB22_CCF ADD CONSTRAINT PK_NBS_OB22_CCF PRIMARY KEY (NBS, OB22, SROK)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

PROMPT *** Create  index PK_NBS_OB22_CCF ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_NBS_OB22_CCF ON BARS.NBS_OB22_CCF (NBS, OB22,SROK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/
PROMPT *** Create  grants  NBS_OB22_CCF ***

grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on NBS_OB22_CCF    to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on NBS_OB22_CCF    to START1;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NBS_OB22_CCF.sql =========*** End *** 
PROMPT ===================================================================================== 
