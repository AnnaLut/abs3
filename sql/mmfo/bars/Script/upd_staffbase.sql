prompt Update EAD_SYNC01
update staff$base set branch = '/', policy_group = 'WHOLE' where logname = 'EAD_SYNC01';
commit work;