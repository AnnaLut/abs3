PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/K9.sql =========*** Run *** ======
PROMPT ===================================================================================== 

PROMPT *** ALTER_POLICY_INFO to K9 ***

BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''K9'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''K9'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table K9 *** 


-- Create table
begin
    execute immediate 'create table K9
(
  k9   INTEGER not null,
  ifrs VARCHAR2(15),
  poci INTEGER,
  name VARCHAR2(30)
)
tablespace BRSDYND
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  )';
 exception when others then 
    if sqlcode = -955 then null; else raise; 
    end if; 
end;
/ 

PROMPT *** ALTER_POLICIES to K9 ***
 exec bpa.alter_policies('K9');

-- Add comments to the table 
comment on table  K9      is 'Умовні "Корзини" обліку Активів по МСФЗ-9';
comment on column K9.k9   is 'Числ.код~Корзини';
comment on column K9.ifrs is 'Принцип обліку Активу по МСФЗ-9';
comment on column K9.poci is 'Уточнення~POCI';

PROMPT ***Create/Recreate primary, unique and foreign key constraints *** 
begin
    execute immediate 'alter table K9
  add constraint XPK_K9 primary key (K9)
  using index 
  tablespace BRSDYND
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  )';
 exception when others then 
    if sqlcode = -2261 or sqlcode = -2260 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table K9  add constraint FK_K9IFRS foreign key (IFRS)  references IFRS (IFRS_ID)';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/ 



begin
    execute immediate 'alter table K9  add constraint CHK_K9POCI  check (POCI IN (0,1))';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 


PROMPT *** Create  grants  K9 ***
grant select, insert, update, delete on K9 to BARS_ACCESS_DEFROLE;
grant select on K9 to WR_REFREAD;

begin
    execute immediate 'insert into k9 (K9, IFRS, POCI, NAME) values (1, ''AC'', 0, ''IFRS=AC, POCI=Ні'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into k9 (K9, IFRS, POCI, NAME) values (2, ''FVOCI'', 0, ''IFRS=FVOCI, POCI=Ні'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into k9 (K9, IFRS, POCI, NAME) values (3, ''FVTPL/Other'', 0, ''IFRS=FVTPL/Other, POCI=Ні'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into k9 (K9, IFRS, POCI, NAME) values (4, ''AC'', 1, ''IFRS=AC, POCI=Так'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into k9 (K9, IFRS, POCI, NAME) values (5, ''FVOCI'', 1, ''IFRS=FVOCI, POCI=Так'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/K9.sql =========*** End *** ======
PROMPT ===================================================================================== 
/
