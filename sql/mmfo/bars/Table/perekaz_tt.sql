

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/PEREKAZ_TT.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to PEREKAZ_TT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''PEREKAZ_TT'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''PEREKAZ_TT'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''PEREKAZ_TT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table PEREKAZ_TT ***
begin 
  execute immediate '
  CREATE TABLE BARS.PEREKAZ_TT 
   (	TT CHAR(3), 
	FLAG VARCHAR2(1)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to PEREKAZ_TT ***
 exec bpa.alter_policies('PEREKAZ_TT');


COMMENT ON TABLE BARS.PEREKAZ_TT IS 'Таблица списка операций по переводам';
COMMENT ON COLUMN BARS.PEREKAZ_TT.TT IS 'Код операции';
COMMENT ON COLUMN BARS.PEREKAZ_TT.FLAG IS 'Признак приема/выплаты(I-прием, O-выплата)';




PROMPT *** Create  constraint PK_PEREKAZ_TT ***
begin   
 execute immediate '
  ALTER TABLE BARS.PEREKAZ_TT ADD CONSTRAINT PK_PEREKAZ_TT PRIMARY KEY (TT)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PEREKAZ_TT_TT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PEREKAZ_TT MODIFY (TT CONSTRAINT CC_PEREKAZ_TT_TT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PEREKAZ_TT_FLAG_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PEREKAZ_TT MODIFY (FLAG CONSTRAINT CC_PEREKAZ_TT_FLAG_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_PEREKAZ_TT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_PEREKAZ_TT ON BARS.PEREKAZ_TT (TT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  PEREKAZ_TT ***
grant SELECT                                                                 on PEREKAZ_TT      to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on PEREKAZ_TT      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on PEREKAZ_TT      to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on PEREKAZ_TT      to START1;
grant SELECT                                                                 on PEREKAZ_TT      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/PEREKAZ_TT.sql =========*** End *** ==
PROMPT ===================================================================================== 
