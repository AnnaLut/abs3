BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''IBX_LIMITS'', ''WHOLE'' , null, null, null, null);
               bpa.alter_policy_info(''IBX_LIMITS'', ''FILIAL'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/
--справочник лимитов
begin 
  execute immediate '
create table IBX_LIMITS (
       NBS varchar2(4) not null,
       MIN_AMOUNT number,
       MAX_AMOUNT number
)
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

begin 
  execute immediate '
  alter table IBX_LIMITS   add constraint PK_IPX_TYPES primary key (NBS)
';
exception when others then         
  if sqlcode=-02260 then null; else raise; end if; 
end; 
/


grant select, insert, update, delete, alter, debug on IBX_LIMITS to BARS_ACCESS_DEFROLE;
/
comment on table IBX_LIMITS  is 'Лимиты платежей через терминалы ТОМАС';
comment on column IBX_LIMITS.NBS  is 'Номер балансового счета';
comment on column IBX_LIMITS.MIN_AMOUNT  is 'Минимальный платеж';
comment on column IBX_LIMITS.MAX_AMOUNT  is 'максимальный платеж';
/
commit;
