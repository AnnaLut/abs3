

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/PS_SBFLAGS.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to PS_SBFLAGS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''PS_SBFLAGS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''PS_SBFLAGS'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''PS_SBFLAGS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table PS_SBFLAGS ***
begin 
  execute immediate '
  CREATE TABLE BARS.PS_SBFLAGS 
   (	SBFLAG CHAR(1), 
	NAME VARCHAR2(500)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to PS_SBFLAGS ***
 exec bpa.alter_policies('PS_SBFLAGS');


COMMENT ON TABLE BARS.PS_SBFLAGS IS 'Групи рахунків для балансу (Баланс-Рахунок-Документ) (флаг SB)';
COMMENT ON COLUMN BARS.PS_SBFLAGS.SBFLAG IS '';
COMMENT ON COLUMN BARS.PS_SBFLAGS.NAME IS '';




PROMPT *** Create  constraint XPK_PSSBFLAGS ***
begin   
 execute immediate '
  ALTER TABLE BARS.PS_SBFLAGS ADD CONSTRAINT XPK_PSSBFLAGS PRIMARY KEY (SBFLAG)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_PSSBFLAGS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_PSSBFLAGS ON BARS.PS_SBFLAGS (SBFLAG) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  PS_SBFLAGS ***
grant SELECT                                                                 on PS_SBFLAGS      to BARSREADER_ROLE;
grant FLASHBACK,SELECT                                                       on PS_SBFLAGS      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on PS_SBFLAGS      to BARS_DM;
grant SELECT                                                                 on PS_SBFLAGS      to START1;
grant SELECT                                                                 on PS_SBFLAGS      to UPLD;
grant FLASHBACK,SELECT                                                       on PS_SBFLAGS      to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/PS_SBFLAGS.sql =========*** End *** ==
PROMPT ===================================================================================== 
