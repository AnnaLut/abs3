BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''IBX_TP_PARAMS_LST'', ''WHOLE'' , null, null, null, null);
               bpa.alter_policy_info(''IBX_TP_PARAMS_LST'', ''FILIAL'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/
--справочник параметров
begin 
  execute immediate '
create table IBX_TP_PARAMS_LST (
       paramcode varchar2(20) not null,
       paramname varchar2(100),
       defvalue varchar(30)
)
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/
-- ПК на справочник параметров
begin   
 execute immediate '
  ALTER TABLE IBX_TP_PARAMS_LST ADD CONSTRAINT IBX_TP_PARAMS_LST_PK PRIMARY KEY (paramcode)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
end;
/
grant select, insert, update, delete, alter, debug on IBX_TP_PARAMS_LST to BARS_ACCESS_DEFROLE;
/
comment on table IBX_TP_PARAMS_LST  is 'Типы параметров терминалов Томас';
comment on column IBX_TP_PARAMS_LST.PARAMCODE  is 'Код параметра';
comment on column IBX_TP_PARAMS_LST.PARAMNAME  is 'Наименование параметра';
comment on column IBX_TP_PARAMS_LST.DEFVALUE   is 'Значение по умолчанию';
/

