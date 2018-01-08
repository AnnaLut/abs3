

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SALDOHO.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SALDOHO ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SALDOHO'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SALDOHO'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SALDOHO'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SALDOHO ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.SALDOHO 
   (	FDAT DATE, 
	PDAT DATE, 
	OSTF NUMBER(24,0), 
	DOS NUMBER(24,0), 
	KOS NUMBER(24,0)
   ) ON COMMIT DELETE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SALDOHO ***
 exec bpa.alter_policies('SALDOHO');


COMMENT ON TABLE BARS.SALDOHO IS '';
COMMENT ON COLUMN BARS.SALDOHO.FDAT IS '';
COMMENT ON COLUMN BARS.SALDOHO.PDAT IS '';
COMMENT ON COLUMN BARS.SALDOHO.OSTF IS '';
COMMENT ON COLUMN BARS.SALDOHO.DOS IS '';
COMMENT ON COLUMN BARS.SALDOHO.KOS IS '';




PROMPT *** Create  constraint CC_SALDOHO_FDAT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SALDOHO MODIFY (FDAT CONSTRAINT CC_SALDOHO_FDAT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SALDOHO_FDAT_OSTF ***
begin   
 execute immediate '
  ALTER TABLE BARS.SALDOHO MODIFY (OSTF CONSTRAINT CC_SALDOHO_FDAT_OSTF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SALDOHO_FDAT_DOS ***
begin   
 execute immediate '
  ALTER TABLE BARS.SALDOHO MODIFY (DOS CONSTRAINT CC_SALDOHO_FDAT_DOS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SALDOHO_FDAT_KOS ***
begin   
 execute immediate '
  ALTER TABLE BARS.SALDOHO MODIFY (KOS CONSTRAINT CC_SALDOHO_FDAT_KOS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index I1_SALDOHO ***
begin   
 execute immediate '
  CREATE INDEX BARS.I1_SALDOHO ON BARS.SALDOHO (FDAT) ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SALDOHO ***
grant SELECT                                                                 on SALDOHO         to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on SALDOHO         to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on SALDOHO         to START1;
grant SELECT                                                                 on SALDOHO         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SALDOHO.sql =========*** End *** =====
PROMPT ===================================================================================== 
