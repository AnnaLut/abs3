-- Add/modify columns 
alter table TMP_DPTRPT add depaltaccnum VARCHAR2(15);
comment on column TMP_DPTRPT.depaltaccnum
  is 'Альтернативный номер депозитного счета';