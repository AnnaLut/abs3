

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OBPC_BOF.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OBPC_BOF ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OBPC_BOF'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''OBPC_BOF'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''OBPC_BOF'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OBPC_BOF ***
begin 
  execute immediate '
  CREATE TABLE BARS.OBPC_BOF 
   (	BOF NUMBER, 
	NAME VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OBPC_BOF ***
 exec bpa.alter_policies('OBPC_BOF');


COMMENT ON TABLE BARS.OBPC_BOF IS 'Виды операций';
COMMENT ON COLUMN BARS.OBPC_BOF.BOF IS 'Код вида';
COMMENT ON COLUMN BARS.OBPC_BOF.NAME IS 'Наименование вида';




PROMPT *** Create  constraint PK_OBPCBOF ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBPC_BOF ADD CONSTRAINT PK_OBPCBOF PRIMARY KEY (BOF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OBPCBOF_BOF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBPC_BOF MODIFY (BOF CONSTRAINT CC_OBPCBOF_BOF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OBPCBOF ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_OBPCBOF ON BARS.OBPC_BOF (BOF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OBPC_BOF ***
grant DELETE,INSERT,SELECT,UPDATE                                            on OBPC_BOF        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OBPC_BOF        to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on OBPC_BOF        to OBPC;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on OBPC_BOF        to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OBPC_BOF.sql =========*** End *** ====
PROMPT ===================================================================================== 
