PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/cc_aim_2.sql =========*** Run *** ========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to cc_aim_2 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''cc_aim_2'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''cc_aim_2'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''cc_aim_2'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table cc_aim_2 ***
begin
    execute immediate 'create table CC_AIM_2
(
  aim       INTEGER,
  name      VARCHAR2(35),  
  custtype  NUMBER(1),
  k9        INTEGER,
  nbs       CHAR(4),
  d_close   DATE
)
tablespace BRSSMLD
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 64K
    minextents 1
    maxextents unlimited
  )';
 exception when others then 
    if sqlcode = -955 then null; else raise; 
    end if; 
end;
/ 


PROMPT *** ALTER_POLICIES to cc_aim_2 ***
 exec bpa.alter_policies('cc_aim_2');

PROMPT *** Add comments to the table ***
comment on table CC_AIM_2
  is 'Целевое назначение КД и соотв. Бал.счета';
PROMPT *** Add comments to the columns ***
comment on column CC_AIM_2.aim      is 'Код цели';
comment on column CC_AIM_2.name     is 'Наименование';
comment on column CC_AIM_2.custtype is 'Тип клиента (ФО, ЮО)';
comment on column CC_AIM_2.k9       is 'Корзина МСФЗ';
comment on column CC_AIM_2.nbs      is 'Балансовый счёт КД';
comment on column CC_AIM_2.d_close  is 'Дата закрытия';

PROMPT *** Create/Recreate primary, unique and foreign key constraints ***
begin
    execute immediate 'alter table CC_AIM_2
  add constraint XPK_CC_AIM_2 primary key (AIM,custtype,k9)
  using index 
  tablespace BRSSMLI
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 128K
    next 128K
    minextents 1
    maxextents unlimited
  )';
 exception when others then 
    if sqlcode = -2261 or sqlcode = -2260 then null; else raise; 
    end if; 
end;
/ 


PROMPT *** Create/Recreate check constraints ***
begin
    execute immediate 'alter table CC_AIM_2
  add constraint NK_CC_AIM_2_AIM
  check (AIM IS NOT NULL)
  novalidate';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 

PROMPT *** Grant/Revoke object privileges ***
grant select, insert, update, delete on CC_AIM_2 to BARS_ACCESS_DEFROLE;
/

PROMPT *** insert data ***
begin
    execute immediate 'insert into CC_AIM_2 values ( 97,''Авалі '' , 2 , 1 ,''9003'',null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into CC_AIM_2 values ( 0 ,''Iпотека '' , 2 , 1 ,''2083'',null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into CC_AIM_2 values ( 77,''Фінансовий лізинг '' , 2 , 1 ,''2071'',null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into CC_AIM_2 values ( 62,''Поточна дiяльнiсть'' , 2 , 1 ,''2063'',null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into CC_AIM_2 values ( 99,''Акредитив '' , 2 , 1 ,''9122'',null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into CC_AIM_2 values ( 98,''Гарантії'' , 2 , 1 ,''9000'',null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into CC_AIM_2 values ( 100 ,''Поточна діяльність орг.мiсц самовр '' , 2 , 1 ,''2113'',null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into CC_AIM_2 values ( 210 ,''Поточна діяльність орг.держ. влади '' , 2 , 1 ,''2103'',null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into CC_AIM_2 values ( 212 ,''Іпотека орг. держ. влади'' , 2 , 1 ,''2123'',null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into CC_AIM_2 values ( 213 ,''Іпотека орг. місц. самоврядування '' , 2 , 1 ,''2133'',null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into CC_AIM_2 values ( 0 ,''Iпотека '' , 3 , 1 ,''2233'',null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into CC_AIM_2 values ( 62,''Поточна дiяльнiсть'' , 3 , 1 ,''2203'',null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into CC_AIM_2 values ( 0 ,''Iпотека '' , 2 , 3 ,''2395'',null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into CC_AIM_2 values ( 77,''Фінансовий лізинг '' , 2 , 3 ,''2394'',null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into CC_AIM_2 values ( 62,''Поточна дiяльнiсть'' , 2 , 3 ,''2390'',null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into CC_AIM_2 values ( 100 ,''Поточна діяльність орг.мiсц самовр '' , 2 , 3 ,''2381'',null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into CC_AIM_2 values ( 210 ,''Поточна діяльність орг.держ. влади '' , 2 , 3 ,''2380'',null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into CC_AIM_2 values ( 212 ,''Іпотека орг. держ. влади'' , 2 , 3 ,''2382'',null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into CC_AIM_2 values ( 213 ,''Іпотека орг. місц. самоврядування '' , 2 , 3 ,''2383'',null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into CC_AIM_2 values ( 0 ,''Iпотека '' , 3 , 3 ,''2453'',null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into CC_AIM_2 values ( 62,''Поточна дiяльнiсть'' , 3 , 3 ,''2450'',null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into CC_AIM_2 values ( 0 ,''Iпотека '' , 2 , 4 ,''2045'',null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into CC_AIM_2 values ( 77,''Фінансовий лізинг '' , 2 , 4 ,''2044'',null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into CC_AIM_2 values ( 62,''Поточна дiяльнiсть'' , 2 , 4 ,''2043'',null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into CC_AIM_2 values ( 100 ,''Поточна діяльність орг.мiсц самовр '' , 2 , 4 ,''2141'',null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into CC_AIM_2 values ( 210 ,''Поточна діяльність орг.держ. влади '' , 2 , 4 ,''2140'',null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into CC_AIM_2 values ( 212 ,''Іпотека орг. держ. влади'' , 2 , 4 ,''2142'',null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into CC_AIM_2 values ( 213 ,''Іпотека орг. місц. самоврядування '' , 2 , 4 ,''2143'',null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into CC_AIM_2 values ( 0 ,''Iпотека '' , 3 , 4 ,''2243'',null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into CC_AIM_2 values ( 62,''Поточна дiяльнiсть'' , 3 , 4 ,''2240'',null)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/cc_aim_2.sql =========*** End *** ========
PROMPT ===================================================================================== 
