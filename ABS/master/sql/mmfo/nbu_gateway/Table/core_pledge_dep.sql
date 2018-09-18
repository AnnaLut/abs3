declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin
    execute immediate
    'create table core_pledge_dep
     (
            request_id          number(38),
            rnk                 number(38),
            acc                 number(38),
            ordernum            number(2),
            numberpledge        varchar2(30),
            pledgeday           date,
            s031                varchar2(2),
            r030                varchar2(3),
            sumpledge           number(32),
            pricepledge         number(32),
            lastpledgeday       date,
            codrealty           number(1),
            ziprealty           varchar2(10),
            squarerealty        number(16,4),
            real6income         number(32),
            noreal6income       number(32),
            flaginsurancepledge number(1),
            numdogdp            varchar2(50),
            dogdaydp            date,
            r030dp              varchar2(3),
            sumdp               number(32),
            default_pledge_kf   varchar2(6 char),
            default_pledge_id   number(38),
            pledge_object_id    number(38),
            status              varchar2(30 char),
            status_message      varchar2(4000 byte),
            kf                  varchar2(6 char),
			SUMBAIL		        NUMBER(22),
			SUMGUARANTEE	    NUMBER(22)
     )
     tablespace brsmdld
     partition by range (request_id) interval (1)
     ( partition initial_partition values less than (1) )';
exception
    when name_already_used then
         null;
end;
/
begin
    execute immediate
    'alter table core_pledge_dep add SUMBAIL NUMBER(22)';
exception
    when others then
         null;
end;
/
begin
    execute immediate
    'alter table core_pledge_dep add SUMGUARANTEE NUMBER(22)';
exception
    when others then
         null;
end;
/


comment on table core_pledge_dep is 'Залоги';
comment on column core_pledge_dep.rnk is 'Регистрационный номер.';
comment on column core_pledge_dep.acc is 'ACC сч.обеспечения';
comment on column core_pledge_dep.ordernum is 'Порядковий номер  запису у повідомлені';
comment on column core_pledge_dep.numberpledge is 'Номер договору застави/іпотеки, гарантії, поруки, грошового покриття';
comment on column core_pledge_dep.pledgeday is 'Дата укладання договору застави/іпотеки, гарантії, поруки, грошового покриття';
comment on column core_pledge_dep.s031 is 'Код виду забезпечення за договором';
comment on column core_pledge_dep.r030 is 'Код валюти';
comment on column core_pledge_dep.sumpledge is 'Сума забезпечення згідно з договором';
comment on column core_pledge_dep.pricepledge is 'Вартість забезпечення згідно з висновком суб’єкта оціночної діяльності';
comment on column core_pledge_dep.lastpledgeday is 'Дата останньої оцінки забезпечення';
comment on column core_pledge_dep.codrealty is 'Вид нерухомого майна';
comment on column core_pledge_dep.ziprealty is 'Поштовий індекс';
comment on column core_pledge_dep.squarerealty is 'Загальна площа нерухомого майна';
comment on column core_pledge_dep.real6income is 'Середній підтверджений дохід особи, що надала фінансову поруку (гарантію)';
comment on column core_pledge_dep.noreal6income is 'Регулярний непідтверджений дохід особи, що надала фінансову поруку (гарантію)';
comment on column core_pledge_dep.flaginsurancepledge is 'Факт страхування  забезпечення';
comment on column core_pledge_dep.numdogdp is 'Номер депозитного договору';
comment on column core_pledge_dep.dogdaydp is 'Дата укладання депозитного договору';
comment on column core_pledge_dep.r030dp is 'Код валюти за депозитом';
comment on column core_pledge_dep.sumdp is 'Сума депозиту';

declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin
    execute immediate 'create unique index i_core_pledge_dep on core_pledge_dep (request_id, acc) tablespace brsmdli local compress 1';
exception
    when name_already_used then
         null;
end;
/
begin 
execute immediate 'alter table core_pledge_dep add sumBail NUMBER(32)'; 
exception 
	when others then if sqlcode=-955 then null; end if;
end;
/	


begin 
execute immediate 'alter table core_pledge_dep add sumGuarantee NUMBER(32)'; 
exception 
	when others then if sqlcode=-955 then null; end if;
end;
/	



