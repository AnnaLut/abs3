create or replace view v_first_names as
select "FIRSTID","FIRSTRU","FIRSTUA","SEXID","MIDDLEUAM","MIDDLEUAF","MIDDLERUM","MIDDLERUF","FIRSTUAOF","FIRSTUAROD","FIRSTUADAT","FIRSTUAVIN","FIRSTUATVO","FIRSTUAPRE","FIRSTRUROD","FIRSTRUDAT","FIRSTRUVIN","FIRSTRUTVO","FIRSTRUPRE" from FIRST_NAMES;


GRANT SELECT ON v_first_names TO BARS_ACCESS_DEFROLE;