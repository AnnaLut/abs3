

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CP_ACCP.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CP_ACCP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CP_ACCP'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CP_ACCP'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CP_ACCP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CP_ACCP ***
begin 
  execute immediate '
  CREATE TABLE BARS.CP_ACCP 
   (	ID NUMBER, 
	ACC NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CP_ACCP ***
 exec bpa.alter_policies('CP_ACCP');


COMMENT ON TABLE BARS.CP_ACCP IS 'Звязок ЦП з забеспеченням';
COMMENT ON COLUMN BARS.CP_ACCP.ID IS 'Вн.Код ЦП';
COMMENT ON COLUMN BARS.CP_ACCP.ACC IS 'ACC рах.забеспечення';




PROMPT *** Create  constraint PK_CPACCP ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_ACCP ADD CONSTRAINT PK_CPACCP PRIMARY KEY (ID, ACC)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CPACCP ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CPACCP ON BARS.CP_ACCP (ID, ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CP_ACCP ***
grant SELECT                                                                 on CP_ACCP         to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT                                                   on CP_ACCP         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CP_ACCP         to BARS_DM;
grant DELETE,INSERT,SELECT                                                   on CP_ACCP         to CP_ROLE;
grant SELECT                                                                 on CP_ACCP         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CP_ACCP.sql =========*** End *** =====
PROMPT ===================================================================================== 
