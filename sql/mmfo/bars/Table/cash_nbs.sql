

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CASH_NBS.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CASH_NBS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CASH_NBS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CASH_NBS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CASH_NBS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CASH_NBS ***
begin 
  execute immediate '
  CREATE TABLE BARS.CASH_NBS 
   (	NBS CHAR(4), 
	OB22 VARCHAR2(2)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLI ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CASH_NBS ***
 exec bpa.alter_policies('CASH_NBS');


COMMENT ON TABLE BARS.CASH_NBS IS 'Перечень балансовых для отчетности по кассе';
COMMENT ON COLUMN BARS.CASH_NBS.NBS IS '';
COMMENT ON COLUMN BARS.CASH_NBS.OB22 IS '';




PROMPT *** Create  constraint XFK_CASHNBS ***
begin   
 execute immediate '
  ALTER TABLE BARS.CASH_NBS ADD CONSTRAINT XFK_CASHNBS FOREIGN KEY (NBS)
	  REFERENCES BARS.PS (NBS) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XUK_CASHNBS ***
begin   
 execute immediate '
  ALTER TABLE BARS.CASH_NBS ADD CONSTRAINT XUK_CASHNBS UNIQUE (NBS, OB22)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XUK_CASHNBS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XUK_CASHNBS ON BARS.CASH_NBS (NBS, OB22) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CASH_NBS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CASH_NBS        to ABS_ADMIN;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CASH_NBS        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CASH_NBS        to BARS_DM;
grant SELECT                                                                 on CASH_NBS        to OPER000;
grant SELECT                                                                 on CASH_NBS        to RPBN001;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CASH_NBS.sql =========*** End *** ====
PROMPT ===================================================================================== 
