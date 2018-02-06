delete from SH_TARIF 
where kf != '300465';

-- Create/Recreate primary, unique and foreign key constraints 
alter table SH_TARIF
  drop constraint PK_SHTARIF cascade;
-- Drop check constraints 
alter table SH_TARIF
  drop constraint CC_SHTARIF_KF_NN;
-- Drop indexes 
drop index PK_SHTARIF;
  
-- Drop columns 
alter table SH_TARIF drop column kf;

alter table SH_TARIF
  add constraint PK_SHTARIF primary key (IDS, KOD)
  using index 
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 64K
    minextents 1
    maxextents unlimited
  );
