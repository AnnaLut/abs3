exec bars.bpa.alter_policy_info( 'ZP_DEALS_UPDATE', 'WHOLE' , null, null, null, null ); 
/
exec bars.bpa.alter_policy_info( 'ZP_DEALS_UPDATE', 'FILIAL', 'M', 'M', 'M', 'M' );
/
begin execute immediate'create table bars.ZP_DEALS_UPDATE  (
   idupd         number,
   id            number                 ,
   deal_id       varchar2(60)           ,
   start_date    date                   ,
   close_date    date,
   deal_name     varchar2(400)          , 
   rnk           number,                
   sos           number,
   deal_premium  number                 ,
   central       number                 ,
   kod_tarif     number,
   acc_2909      number,    
   acc_3570      number,
   branch        varchar2(30)           ,
   kf            varchar2(6)            ,
   user_id       number, 
   comm_reject   varchar2(500),
   crt_date      date                   ,
   upd_date      date,
   fs            number, 
   upd_user_id   number,
   upd_user_fio  varchar2(500),
   
   constraint pk_ZP_DEALS_UPDATE_id        primary key (idupd)


  )';
exception when others then  
  if sqlcode = -00955 then null;   else raise; end if;   
end;
/
exec  bars.bpa.alter_policies('ZP_DEALS_UPDATE'); 
/
begin
    execute immediate 'create index idx_zp_deals_update_id on BARS.zp_deals_update (id)';
 exception when others then 
    if sqlcode = -955 or sqlcode = -1408 then null; else raise; 
    end if; 
end;
/
comment on table  bars.ZP_DEALS_UPDATE is 'Договора зарплатных проектов';
comment on column bars.ZP_DEALS_UPDATE.id is 'id договора';
comment on column bars.ZP_DEALS_UPDATE.deal_id is 'Номер договора';
comment on column bars.ZP_DEALS_UPDATE.start_date is 'Дата начала действия';
comment on column bars.ZP_DEALS_UPDATE.close_date is 'Дата закрытия';
comment on column bars.ZP_DEALS_UPDATE.deal_name is 'Название договора';
comment on column bars.ZP_DEALS_UPDATE.rnk is 'РНК';
comment on column bars.ZP_DEALS_UPDATE.sos is 'Состоятение договора';
comment on column bars.ZP_DEALS_UPDATE.deal_premium is 'Премиальность договора';
comment on column bars.ZP_DEALS_UPDATE.central is 'Признак централизации договора';
comment on column bars.ZP_DEALS_UPDATE.kod_tarif is 'Код тарифа';
/

grant select,delete,update,insert on bars.ZP_DEALS_UPDATE to bars_access_defrole;
/