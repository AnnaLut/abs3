

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TYPNLS_CORP.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TYPNLS_CORP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TYPNLS_CORP'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''TYPNLS_CORP'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''TYPNLS_CORP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TYPNLS_CORP ***
begin 
  execute immediate '
  CREATE TABLE BARS.TYPNLS_CORP 
   (KOD CHAR(2), 
	TXT VARCHAR2(150),
	CORP_ID VARCHAR2(10)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

PROMPT *** Add  column CORP_ID ***
begin 
execute immediate'
alter table BARS.TYPNLS_CORP add (
  CORP_ID VARCHAR2(10))';
exception
 when others 
 then 
 if sqlcode = -1430 then null; 
 else raise;
 end if;
end;
/

PROMPT *** MODIFY  column CORP_ID ***
begin 
execute immediate'
alter table BARS.TYPNLS_CORP MODIFY TXT VARCHAR2(255)';
exception
 when others 
 then 
 if sqlcode = -1430 then null; 
 else raise;
 end if;
end;
/

PROMPT *** Create  constraint PK_SPARAMLIST ***
begin   
 execute immediate '
  ALTER TABLE BARS.TYPNLS_CORP ADD CONSTRAINT PK_TYPNLS_CORP PRIMARY KEY (CORP_ID, KOD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** ALTER_POLICIES to TYPNLS_CORP ***
 exec bpa.alter_policies('TYPNLS_CORP');


COMMENT ON TABLE BARS.TYPNLS_CORP IS 'Довідник кодів ТРКК корпоративних клієнтів';
COMMENT ON COLUMN BARS.TYPNLS_CORP.KOD IS 'Код ТРКК';
COMMENT ON COLUMN BARS.TYPNLS_CORP.TXT IS 'Опис коду ТРКК';
COMMENT ON COLUMN BARS.TYPNLS_CORP.CORP_ID IS 'ІД корпорації';



PROMPT *** Create  grants  TYPNLS_CORP ***
grant FLASHBACK,SELECT, INSERT, UPDATE, DELETE                               on TYPNLS_CORP     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TYPNLS_CORP     to BARS_DM;
grant FLASHBACK,SELECT                                                       on TYPNLS_CORP     to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TYPNLS_CORP.sql =========*** End *** =
PROMPT ===================================================================================== 
