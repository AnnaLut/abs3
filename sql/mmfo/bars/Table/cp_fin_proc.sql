

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CP_FIN_PROC.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CP_FIN_PROC ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CP_FIN_PROC ***
begin 
  execute immediate '
  CREATE TABLE BARS.CP_FIN_PROC 
   (	FIN NUMBER, 
	PROC NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CP_FIN_PROC ***
 exec bpa.alter_policies('CP_FIN_PROC');


COMMENT ON TABLE BARS.CP_FIN_PROC IS 'Процент резервирования для ЦБ по фин.положению контрагента';
COMMENT ON COLUMN BARS.CP_FIN_PROC.FIN IS 'Фин.положение контрагента';
COMMENT ON COLUMN BARS.CP_FIN_PROC.PROC IS 'Процент корректировки ожидаемого возмещения';




PROMPT *** Create  constraint SYS_C009625 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_FIN_PROC MODIFY (FIN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_CP_FIN_PROC ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_FIN_PROC ADD CONSTRAINT PK_CP_FIN_PROC PRIMARY KEY (FIN)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CP_FIN_PROC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CP_FIN_PROC ON BARS.CP_FIN_PROC (FIN) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CP_FIN_PROC ***
grant SELECT                                                                 on CP_FIN_PROC     to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CP_FIN_PROC     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CP_FIN_PROC     to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CP_FIN_PROC     to CP_ROLE;
grant SELECT                                                                 on CP_FIN_PROC     to UPLD;



PROMPT *** Create SYNONYM  to CP_FIN_PROC ***

  CREATE OR REPLACE PUBLIC SYNONYM CP_FIN_PROC FOR BARS.CP_FIN_PROC;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CP_FIN_PROC.sql =========*** End *** =
PROMPT ===================================================================================== 
