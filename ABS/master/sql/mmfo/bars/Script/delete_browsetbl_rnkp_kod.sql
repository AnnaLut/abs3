BEGIN
bars_metabase.delete_browsetbl( bars_metabase.get_tabid('SALDO'), bars_metabase.get_tabid('RNKP_KOD'),  45, 1, 3);
END;
/
COMMIT;
/