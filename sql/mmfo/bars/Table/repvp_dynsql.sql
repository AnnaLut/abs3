

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/REPVP_DYNSQL.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to REPVP_DYNSQL ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''REPVP_DYNSQL'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''REPVP_DYNSQL'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''REPVP_DYNSQL'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table REPVP_DYNSQL ***
begin 
  execute immediate '
  CREATE TABLE BARS.REPVP_DYNSQL 
   (	SQLID NUMBER, 
	DESCRIPT VARCHAR2(500), 
	SQLTXT CLOB
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD 
 LOB (SQLTXT) STORE AS BASICFILE (
  TABLESPACE BRSSMLD ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to REPVP_DYNSQL ***
 exec bpa.alter_policies('REPVP_DYNSQL');


COMMENT ON TABLE BARS.REPVP_DYNSQL IS 'Список запросов для динамического построения выписок';
COMMENT ON COLUMN BARS.REPVP_DYNSQL.SQLID IS 'Номер запроса для выписок';
COMMENT ON COLUMN BARS.REPVP_DYNSQL.DESCRIPT IS 'Описане запроса(для чего выписки)';
COMMENT ON COLUMN BARS.REPVP_DYNSQL.SQLTXT IS 'Текст запроса (должен включать последовательно 3 переменных :p_dat1,:p_dat2,:p_dat3). Запрос должен выбрать acc,nls,kv,tip,fdat,dos,kos,ostf,dapp,isp,nms,nmk,okpo';




PROMPT *** Create  constraint XPK_REPVPDYNSQL ***
begin   
 execute immediate '
  ALTER TABLE BARS.REPVP_DYNSQL ADD CONSTRAINT XPK_REPVPDYNSQL PRIMARY KEY (SQLID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_REPVPDYNSQL ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_REPVPDYNSQL ON BARS.REPVP_DYNSQL (SQLID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  REPVP_DYNSQL ***
grant DELETE,INSERT,SELECT,UPDATE                                            on REPVP_DYNSQL    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on REPVP_DYNSQL    to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on REPVP_DYNSQL    to RPBN001;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/REPVP_DYNSQL.sql =========*** End *** 
PROMPT ===================================================================================== 
