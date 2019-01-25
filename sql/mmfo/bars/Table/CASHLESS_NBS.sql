

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CASHLESS_NBS.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CASHLESS_NBS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CASHLESS_NBS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CASHLESS_NBS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CASHLESS_NBS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CASHLESS_NBS ***
begin 
  execute immediate '
  CREATE TABLE BARS.CASHLESS_NBS 
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




PROMPT *** ALTER_POLICIES to CASHLESS_NBS ***
 exec bpa.alter_policies('CASHLESS_NBS');


COMMENT ON TABLE BARS.CASHLESS_NBS IS 'Перечень балансовых для отчетности по безналичным';
COMMENT ON COLUMN BARS.CASHLESS_NBS.NBS IS '';
COMMENT ON COLUMN BARS.CASHLESS_NBS.OB22 IS '';




PROMPT *** Create  constraint XUK_CASHLESSNBS ***
begin   
 execute immediate '
  ALTER TABLE BARS.CASHLESS_NBS ADD CONSTRAINT XUK_CASHLESSNBS UNIQUE (NBS, OB22)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XUK_CASHNBS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XUK_CASHLESSNBS ON BARS.CASHLESS_NBS (NBS, OB22) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CASHLESS_NBS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CASHLESS_NBS        to ABS_ADMIN;
grant SELECT                                                                 on CASHLESS_NBS        to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CASHLESS_NBS        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CASHLESS_NBS        to BARS_DM;
grant SELECT                                                                 on CASHLESS_NBS        to OPER000;
grant SELECT                                                                 on CASHLESS_NBS        to RPBN001;
grant SELECT                                                                 on CASHLESS_NBS        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CASHLESS_NBS.sql =========*** End *** ====
PROMPT ===================================================================================== 
