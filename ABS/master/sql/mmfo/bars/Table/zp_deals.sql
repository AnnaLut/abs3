PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/bars/Table/zp_deals.sql =========*** Run **
PROMPT ===================================================================================== 

exec bars.bpa.alter_policy_info( 'ZP_DEALS', 'WHOLE' , null, null, null, null ); 

exec bars.bpa.alter_policy_info( 'ZP_DEALS', 'FILIAL', 'M', 'M', 'M', 'M' );

begin execute immediate'create table bars.zp_deals  (
   id            number                  constraint cc_zp_deals_id not null,
   deal_id       varchar2(60)                                      not null,
   start_date    date                    default sysdate,
   close_date    date,
   deal_name     varchar2(400)                                     not null, 
   rnk           number,                
   sos           number,
   deal_premium  number                  default 0,
   central       number                  default 0,
   kod_tarif     number,
   acc_2909      number,    
   acc_3570      number,
   branch        varchar2(30)            default sys_context(''bars_context'',''user_branch''),
   kf            varchar2(6)             default sys_context(''bars_context'',''user_mfo''),
   user_id       number, 
   comm_reject   varchar2(500),
   crt_date      date                    default  sysdate,
   upd_date      date,
   
   constraint pk_zp_deals_id        primary key (id),
   constraint fk_zp_deals_rnk       foreign key (rnk)  references bars.customer(rnk),
   constraint fk_zp_deals_sos       foreign key (sos)  references bars.zp_deals_sos(sos),
   constraint cc_zp_deals_prm       check (deal_premium in (0,1)),
   constraint cc_zp_deals_central   check (central in (0,1)),
   constraint fk_zp_deals_tarif     foreign key (kod_tarif,kf)  references bars.tarif(kod,kf),
   constraint fk_zp_deals_acc_2909  foreign key (acc_2909)   references bars.accounts (acc),
   constraint fk_zp_deals_acc_3570  foreign key (acc_3570)   references bars.accounts (acc),
   constraint fk_zp_deals_user_id   foreign key (user_id)   references bars.staff$base (id)
  )';
exception when others then  
  if sqlcode = -00955 then null;   else raise; end if;   
end;
/
exec  bars.bpa.alter_policies('ZP_DEALS'); 

comment on table  bars.ZP_DEALS is 'Договора зарплатных проектов';
comment on column bars.ZP_DEALS.id is 'id договора';
comment on column bars.ZP_DEALS.deal_id is 'Номер договора';
comment on column bars.ZP_DEALS.start_date is 'Дата начала действия';
comment on column bars.ZP_DEALS.close_date is 'Дата закрытия';
comment on column bars.ZP_DEALS.deal_name is 'Название договора';
comment on column bars.ZP_DEALS.rnk is 'РНК';
comment on column bars.ZP_DEALS.sos is 'Состоятение договора';
comment on column bars.ZP_DEALS.deal_premium is 'Премиальность договора';
comment on column bars.ZP_DEALS.central is 'Признак централизации договора';
comment on column bars.ZP_DEALS.kod_tarif is 'Код тарифа';

begin
    execute immediate 'alter table ZP_DEALS add fs number';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/
begin
    execute immediate 'create index idx_zp_deals_acc_2909 on BARS.zp_deals (acc_2909)';
 exception when others then 
    if sqlcode = -955 or sqlcode = -1408 then null; else raise; 
    end if; 
end;
/

begin
    execute immediate 'create index i_zp_deals_rnk on BARS.zp_deals (rnk)';
 exception when others then 
    if sqlcode = -955 or sqlcode = -1408 then null; else raise; 
    end if; 
end;
/

grant select,delete,update,insert on bars.ZP_DEALS to bars_access_defrole;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/bars/Table/zp_deals.sql =========*** End **
PROMPT ===================================================================================== 
