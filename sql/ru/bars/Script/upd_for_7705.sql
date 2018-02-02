exec tuda;

update specparam_int
set r020_fa = '7705'
where p080 in ('0476', '0477') and
	r020_fa = '7707';
commit;