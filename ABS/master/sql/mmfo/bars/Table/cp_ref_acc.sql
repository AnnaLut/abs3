

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CP_REF_ACC.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CP_REF_ACC ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CP_REF_ACC'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CP_REF_ACC'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CP_REF_ACC'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CP_REF_ACC ***
begin 
  execute immediate '
  CREATE TABLE BARS.CP_REF_ACC 
   (	REF NUMBER(38,0), 
	ACC NUMBER(38,0), 
	S NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CP_REF_ACC ***
 exec bpa.alter_policies('CP_REF_ACC');


COMMENT ON TABLE BARS.CP_REF_ACC IS 'Таблиця рах-в в_ртуального Дисконту/Прем_ї';
COMMENT ON COLUMN BARS.CP_REF_ACC.REF IS 'Реф-с пакета';
COMMENT ON COLUMN BARS.CP_REF_ACC.ACC IS 'acc  рах-ку в_ртуального Дисконту/Прем_ї';
COMMENT ON COLUMN BARS.CP_REF_ACC.S IS 'Сума на рах-ку в_рт. Д/П';




PROMPT *** Create  constraint SYS_C009215 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_REF_ACC MODIFY (REF NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009216 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_REF_ACC MODIFY (ACC NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_CPREFACC ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_REF_ACC ADD CONSTRAINT PK_CPREFACC PRIMARY KEY (REF, ACC)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CPREFACC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CPREFACC ON BARS.CP_REF_ACC (REF, ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CP_REF_ACC ***
grant SELECT                                                                 on CP_REF_ACC      to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CP_REF_ACC      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CP_REF_ACC      to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CP_REF_ACC      to START1;
grant SELECT                                                                 on CP_REF_ACC      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CP_REF_ACC.sql =========*** End *** ==
PROMPT ===================================================================================== 
