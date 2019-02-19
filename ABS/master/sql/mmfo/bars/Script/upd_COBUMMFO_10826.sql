-- 3AX
alter table NBUR_LOG_F3AX
RENAME COLUMN T090 to T090_1;

alter table NBUR_LOG_F3AX
ADD (T090 NUMBER(12, 4));

comment on column NBUR_LOG_F3AX.T090 is 'Процента ставка';

exec bc.home;

update NBUR_LOG_F3AX
set T090 = T090_1
where t090 is null;
commit;

ALTER TABLE NBUR_LOG_F3AX SET UNUSED (T090_1);

begin
    execute immediate 'ALTER TABLE NBUR_LOG_F3AX DROP unused columns';
exception
    when others then    
        if sqlcode = -39726 then null; else raise; end if;    
end;
/

-- F4X
alter table NBUR_LOG_FF4X
RENAME COLUMN T090 to T090_1;

alter table NBUR_LOG_FF4X
ADD (T090 NUMBER(12, 4));

comment on column NBUR_LOG_FF4X.T090 is 'Процента ставка';

exec bc.home;

update NBUR_LOG_FF4X
set T090 = T090_1
where t090 is null;
commit;

ALTER TABLE NBUR_LOG_FF4X SET UNUSED (T090_1);

begin
    execute immediate 'ALTER TABLE NBUR_LOG_FF4X DROP unused columns';
exception
    when others then    
        if sqlcode = -39726 then null; else raise; end if;    
end;
/

-- I5X
alter table NBUR_LOG_FI5X
RENAME COLUMN T090 to T090_1;

alter table NBUR_LOG_FI5X
ADD (T090 NUMBER(12, 4));

comment on column NBUR_LOG_FI5X.T090 is 'Процента ставка';

exec bc.home;

update NBUR_LOG_FI5X
set T090 = T090_1
where t090 is null;
commit;

ALTER TABLE NBUR_LOG_FI5X SET UNUSED (T090_1);

begin
    execute immediate 'ALTER TABLE NBUR_LOG_FI5X DROP unused columns';
exception
    when others then    
        if sqlcode = -39726 then null; else raise; end if;    
end;
/