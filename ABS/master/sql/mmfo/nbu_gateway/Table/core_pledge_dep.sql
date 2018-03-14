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
            kf                  varchar2(6 char)
     )
     tablespace brsmdld
     partition by range (request_id) interval (1)
     ( partition initial_partition values less than (1) )';
exception
    when name_already_used then
         null;
end;
/

comment on table core_pledge_dep is '������';
comment on column core_pledge_dep.rnk is '��������������� �����.';
comment on column core_pledge_dep.acc is 'ACC ��.�����������';
comment on column core_pledge_dep.ordernum is '���������� �����  ������ � ���������';
comment on column core_pledge_dep.numberpledge is '����� �������� �������/�������, ������, ������, ��������� ��������';
comment on column core_pledge_dep.pledgeday is '���� ��������� �������� �������/�������, ������, ������, ��������� ��������';
comment on column core_pledge_dep.s031 is '��� ���� ������������ �� ���������';
comment on column core_pledge_dep.r030 is '��� ������';
comment on column core_pledge_dep.sumpledge is '���� ������������ ����� � ���������';
comment on column core_pledge_dep.pricepledge is '������� ������������ ����� � ��������� ��ᒺ��� �������� ��������';
comment on column core_pledge_dep.lastpledgeday is '���� �������� ������ ������������';
comment on column core_pledge_dep.codrealty is '��� ���������� �����';
comment on column core_pledge_dep.ziprealty is '�������� ������';
comment on column core_pledge_dep.squarerealty is '�������� ����� ���������� �����';
comment on column core_pledge_dep.real6income is '������� ������������ ����� �����, �� ������ ��������� ������ (�������)';
comment on column core_pledge_dep.noreal6income is '���������� �������������� ����� �����, �� ������ ��������� ������ (�������)';
comment on column core_pledge_dep.flaginsurancepledge is '���� �����������  ������������';
comment on column core_pledge_dep.numdogdp is '����� ����������� ��������';
comment on column core_pledge_dep.dogdaydp is '���� ��������� ����������� ��������';
comment on column core_pledge_dep.r030dp is '��� ������ �� ���������';
comment on column core_pledge_dep.sumdp is '���� ��������';

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
