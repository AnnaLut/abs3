

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SEP_UNLOCK_FILTERS.sql =*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SEP_UNLOCK_FILTERS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SEP_UNLOCK_FILTERS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SEP_UNLOCK_FILTERS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SEP_UNLOCK_FILTERS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SEP_UNLOCK_FILTERS ***
begin 
  execute immediate '
create table SEP_UNLOCK_FILTERS
(
  idfilter  NUMBER,
  namefilter VARCHAR2(50),
  sqlfilter CLOB,
  comm varchar2(1000)
)
tablespace BRSDYND
  pctfree 10
  initrans 1
  maxtrans 255 ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ACC_TARIF ***
 exec bpa.alter_policies('SEP_UNLOCK_FILTERS');


COMMENT ON TABLE BARS.SEP_UNLOCK_FILTERS IS 'Функції розблокування платежів СЕП';
COMMENT ON COLUMN BARS.SEP_UNLOCK_FILTERS.IDFILTER IS 'ID запису';
COMMENT ON COLUMN BARS.SEP_UNLOCK_FILTERS.NAMEFILTER IS 'Найменування';
COMMENT ON COLUMN BARS.SEP_UNLOCK_FILTERS.SQLFILTER IS 'SQL для виборки';
COMMENT ON COLUMN BARS.SEP_UNLOCK_FILTERS.COMM IS 'Коментар до  функції';



-- Create/Recreate primary, unique and foreign key constraints 
begin
  execute immediate '
alter table SEP_UNLOCK_FILTERS
  add constraint PK_SEP_UNLOCK_FILTERS primary key (IDFILTER)
  using index 
  tablespace BRSDYND
  pctfree 10
  initrans 2
  maxtrans 255';
exception 
  when others then 
    if sqlcode=-02260 then null; else raise; end if;
end;
/      


PROMPT *** Create  grants  SEP_UNLOCK_FILTERS ***
grant ALTER,DELETE,FLASHBACK,INSERT,SELECT,UPDATE   on SEP_UNLOCK_FILTERS       to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SEP_UNLOCK_FILTERS.sql =*** End *** ==
PROMPT ===================================================================================== 
