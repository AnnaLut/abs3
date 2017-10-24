

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ACC_30.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ACC_30 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ACC_30'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''ACC_30'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ACC_30'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ACC_30 ***
begin 
  execute immediate '
  CREATE TABLE BARS.ACC_30 
   (	BRANCH VARCHAR2(30), 
	ACC NUMBER, 
	NLS VARCHAR2(15), 
	KV NUMBER(*,0), 
	S_OB22_30 NUMBER(38,0), 
	SQ_OB22_30 NUMBER(38,0), 
	S_OB22_31 NUMBER(38,0), 
	SQ_OB22_31 NUMBER(38,0), 
	S30 NUMBER(38,0), 
	S31 NUMBER(38,0), 
	SQ30 NUMBER(38,0), 
	SQ31 NUMBER(38,0), 
	RNK NUMBER(*,0), 
	NMK VARCHAR2(70), 
	COMM_1 VARCHAR2(200), 
	COMM_2 VARCHAR2(200)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ACC_30 ***
 exec bpa.alter_policies('ACC_30');


COMMENT ON TABLE BARS.ACC_30 IS 'Рахунки прострочені < 30 та > 30 днів';
COMMENT ON COLUMN BARS.ACC_30.BRANCH IS 'Відділення';
COMMENT ON COLUMN BARS.ACC_30.ACC IS 'Внутрішній номер рахунку';
COMMENT ON COLUMN BARS.ACC_30.NLS IS 'Номер рахунку';
COMMENT ON COLUMN BARS.ACC_30.KV IS 'Код валюти';
COMMENT ON COLUMN BARS.ACC_30.S_OB22_30 IS 'Сумма ном.по OB22 до 30 днів';
COMMENT ON COLUMN BARS.ACC_30.SQ_OB22_30 IS 'Сумма екв.по OB22 до 30 днів';
COMMENT ON COLUMN BARS.ACC_30.S_OB22_31 IS 'Сумма ном.по OB22 понад 30 днів';
COMMENT ON COLUMN BARS.ACC_30.SQ_OB22_31 IS 'Сумма екв.по OB22 понад 30 днів';
COMMENT ON COLUMN BARS.ACC_30.S30 IS 'Сумма ном.до    30 днів';
COMMENT ON COLUMN BARS.ACC_30.S31 IS 'Сумма ном.понад 30 днів';
COMMENT ON COLUMN BARS.ACC_30.SQ30 IS 'Сумма екв.до    30 днів';
COMMENT ON COLUMN BARS.ACC_30.SQ31 IS 'Сумма екв.понад 30 днів';
COMMENT ON COLUMN BARS.ACC_30.RNK IS 'РНК клієнта';
COMMENT ON COLUMN BARS.ACC_30.NMK IS 'Назва клієнта';
COMMENT ON COLUMN BARS.ACC_30.COMM_1 IS 'Параметры до 30 дней';
COMMENT ON COLUMN BARS.ACC_30.COMM_2 IS 'Параметры понад 30 дней';




PROMPT *** Create  constraint ACC_30ACC ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_30 ADD CONSTRAINT ACC_30ACC PRIMARY KEY (ACC)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index ACC_30ACC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.ACC_30ACC ON BARS.ACC_30 (ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ACC_30 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on ACC_30          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ACC_30          to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on ACC_30          to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ACC_30.sql =========*** End *** ======
PROMPT ===================================================================================== 
