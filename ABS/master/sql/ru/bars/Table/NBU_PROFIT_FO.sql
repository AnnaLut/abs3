BEGIN
    bpa.alter_policy_info('NBU_PROFIT_FO', 'FILIAL', 'M', 'M', 'M', 'M');
    bpa.alter_policy_info('NBU_PROFIT_FO', 'WHOLE', null, 'E', 'E', 'E');
END;
/

declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin
    execute immediate
    'create table NBU_PROFIT_FO
    (
        rnk             NUMBER(38),
        real6month      NUMBER(32),
        noreal6month    NUMBER(32),
        status          VARCHAR2(5),
        members         NUMBER(2),
        type            NUMBER(3),
		kf              VARCHAR2(6)  DEFAULT sys_context(''bars_context'',''user_mfo'') 
    )
    TABLESPACE BRSMDLD';
exception
    when name_already_used then
         null;
end;
/


begin 
  execute immediate 
    ' ALTER TABLE bars.NBU_PROFIT_FO ADD (members NUMBER(2))';
exception when others then 
  if sqlcode=-1430 then null; else raise; end if;
end;
/


begin 
  execute immediate 
    ' ALTER TABLE bars.NBU_PROFIT_FO ADD (type NUMBER(3))';
exception when others then 
  if sqlcode=-1430 then null; else raise; end if;
end;
/

begin 
  execute immediate 
    ' ALTER TABLE bars.NBU_PROFIT_FO ADD (kf   VARCHAR2(6)  DEFAULT sys_context(''bars_context'',''user_mfo'') )';
exception when others then 
  if sqlcode=-1430 then null; else raise; end if;
end;
/


begin 
  execute immediate 
    ' ALTER TABLE bars.NBU_PROFIT_FO modify (kf   VARCHAR2(6)  DEFAULT sys_context(''bars_context'',''user_mfo'') )';
exception when others then 
  if sqlcode=-1430 then null; else raise; end if;
end;
/

begin 
  execute immediate 
    ' ALTER TABLE bars.NBU_PROFIT_FO modify ( real6month      NUMBER  )';
exception when others then 
  if sqlcode=-1430 then null; else raise; end if;
end;
/

begin 
  execute immediate 
    ' ALTER TABLE bars.NBU_PROFIT_FO modify ( noreal6month    NUMBER  )';
exception when others then 
  if sqlcode=-1430 then null; else raise; end if;
end;
/


begin 
  execute immediate 
    ' ALTER TABLE bars.NBU_PROFIT_FO add ( real6income     NUMBER  )';
exception when others then 
  if sqlcode=-1430 then null; else raise; end if;
end;
/

begin 
  execute immediate 
    ' ALTER TABLE bars.NBU_PROFIT_FO add ( noreal6income   NUMBER  )';
exception when others then 
  if sqlcode=-1430 then null; else raise; end if;
end;
/
COMMENT ON TABLE BARS.NBU_PROFIT_FO IS 'Дані про дохід Боржника ';
COMMENT ON COLUMN BARS.NBU_PROFIT_FO.rnk IS 'Регистрационный номер.';
COMMENT ON COLUMN BARS.NBU_PROFIT_FO.real6month IS 'Підтверджений дохід Боржника ';
COMMENT ON COLUMN BARS.NBU_PROFIT_FO.noreal6month IS 'Непідтверджений дохід Боржника';
COMMENT ON COLUMN BARS.NBU_PROFIT_FO.status IS 'Статус true\false';

exec bpa.alter_policies('NBU_PROFIT_FO');

declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin
    execute immediate 'create unique index UI_NBU_PROFIT_FO on NBU_PROFIT_FO (rnk) TABLESPACE BRSMDLI' ;
exception
    when name_already_used then
         null;
end;
/
