

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CP_RATES_SB.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CP_RATES_SB ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CP_RATES_SB'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CP_RATES_SB'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CP_RATES_SB'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CP_RATES_SB ***
begin 
  execute immediate '
  CREATE TABLE BARS.CP_RATES_SB 
   (	REF NUMBER, 
	RATE_B NUMBER, 
	FL_ALG NUMBER(*,0), 
	QUOT_SIGN NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CP_RATES_SB ***
 exec bpa.alter_policies('CP_RATES_SB');


COMMENT ON TABLE BARS.CP_RATES_SB IS 'Таблиця для розрахунку переоц_нки';
COMMENT ON COLUMN BARS.CP_RATES_SB.REF IS 'Реф-с пакета';
COMMENT ON COLUMN BARS.CP_RATES_SB.RATE_B IS 'Сума котирування';
COMMENT ON COLUMN BARS.CP_RATES_SB.FL_ALG IS 'Флаг алгоритму';
COMMENT ON COLUMN BARS.CP_RATES_SB.QUOT_SIGN IS 'Ознака котирування';




PROMPT *** Create  constraint XPK_CP_RATESSB ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_RATES_SB ADD CONSTRAINT XPK_CP_RATESSB PRIMARY KEY (REF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_CP_RATESSB ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_CP_RATESSB ON BARS.CP_RATES_SB (REF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CP_RATES_SB ***
grant SELECT                                                                 on CP_RATES_SB     to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CP_RATES_SB     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CP_RATES_SB     to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CP_RATES_SB     to START1;
grant SELECT                                                                 on CP_RATES_SB     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CP_RATES_SB.sql =========*** End *** =
PROMPT ===================================================================================== 
