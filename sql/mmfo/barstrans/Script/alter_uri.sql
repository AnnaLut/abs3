alter table OUT_REQS drop constraint FK_OUT_REQS_URI;
drop table out_uri purge;
update out_types set URI_GROUP = null;
update out_reqs set URI_GR_ID = null;
update out_reqs set URI_KF = null;
alter table out_types modify URI_GROUP varchar2(50);
alter table out_reqs modify URI_GR_ID varchar2(50);
alter table out_reqs modify URI_KF varchar2(10);
/
