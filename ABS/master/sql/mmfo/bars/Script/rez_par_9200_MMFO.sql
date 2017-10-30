exec bc.go('300465');
update rez_par_9200 set fdat=to_date('01-11-2017','dd-mm-yyyy') where fdat is null;
commit;
exec bc.go('/');
/
