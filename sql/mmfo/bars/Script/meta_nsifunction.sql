declare
 l_tabid meta_tables.tabid%type;

begin
   select tabid into l_tabid from META_TABLES where TABNAME LIKE 'V_DEB_REG_TMP%';
   update META_NSIFUNCTION set funcid = 4 where tabid = l_tabid and proc_name like 'dr_ch.upsert_debreg_res_s(0)%';
   update META_NSIFUNCTION set funcid = 3 where tabid = l_tabid and proc_name like 'dr.dr_new(:Dat)%';
   update META_NSIFUNCTION set funcid = 1, descr = 'Відмітити записи для файлу' , icon_id=117  
   where tabid = l_tabid and proc_name like 'dr_ch.p_nsi_deb_reg_tmp%';
   begin
      Insert into BARS.META_NSIFUNCTION (TABID, FUNCID, DESCR, PROC_NAME, PROC_EXEC, QST, MSG, ICON_ID)
      Values (l_tabid, 2, 'Сформувати файл (поновити реест боржників) ', 'dr.pf_name', 'ONCE', 
              'Поновити реест боржників для передачі в ЦБД?', 'Виконано', 68);
   exception when others then
      if SQLCODE in ( -00001, -06512) then NULL; else raise;   end if;
   end;
   commit;
end;
/