Begin

   update transfer_2017 t
   set t.dat_end = t.dat_beg
   where t.dat_beg < sysdate;

   begin
      insert into transfer_2017 (r020_old, ob_old, r020_new, ob_new, dat_beg) values ('2605', '12', '2600', '14', to_date('01/01/2019', 'MM/DD/YYYY'));
   exception 
      when dup_val_on_index then null;
   end;

   begin
      insert into transfer_2017 (r020_old, ob_old, r020_new, ob_new, dat_beg) values ('2605', '13', '2600', '14', to_date('01/01/2019', 'MM/DD/YYYY'));
   exception 
      when dup_val_on_index then null;
   end;

   begin
      insert into transfer_2017 (r020_old, ob_old, r020_new, ob_new, dat_beg) values ('2655', '11', '2650', '12', to_date('01/01/2019', 'MM/DD/YYYY'));
   exception 
      when dup_val_on_index then null;
   end;

   begin
      insert into transfer_2017 (r020_old, ob_old, r020_new, ob_new, dat_beg) values ('2625', '30', '2620', '36', to_date('01/01/2019', 'MM/DD/YYYY'));
   exception 
      when dup_val_on_index then null;
   end;

   begin
      insert into transfer_2017 (r020_old, ob_old, r020_new, ob_new, dat_beg) values ('2625', '35', '2620', '36', to_date('01/01/2019', 'MM/DD/YYYY'));
   exception 
      when dup_val_on_index then null;
   end;

   begin
      insert into transfer_2017 (r020_old, ob_old, r020_new, ob_new, dat_beg) values ('2625', '36', '2620', '36', to_date('01/01/2019', 'MM/DD/YYYY'));
   exception 
      when dup_val_on_index then null;
   end;

   begin
      insert into transfer_2017 (r020_old, ob_old, r020_new, ob_new, dat_beg) values ('2625', '26', '2620', '36', to_date('01/01/2019', 'MM/DD/YYYY'));
   exception 
      when dup_val_on_index then null;
   end;

   begin
      insert into transfer_2017 (r020_old, ob_old, r020_new, ob_new, dat_beg) values ('2625', '23', '2620', '36', to_date('01/01/2019', 'MM/DD/YYYY'));
   exception 
      when dup_val_on_index then null;
   end;

   begin
      insert into transfer_2017 (r020_old, ob_old, r020_new, ob_new, dat_beg) values ('2625', '33', '2620', '36', to_date('01/01/2019', 'MM/DD/YYYY'));
   exception 
      when dup_val_on_index then null;
   end;

   begin
      insert into transfer_2017 (r020_old, ob_old, r020_new, ob_new, dat_beg) values ('2625', '27', '2620', '36', to_date('01/01/2019', 'MM/DD/YYYY'));
   exception 
      when dup_val_on_index then null;
   end;

   begin
      insert into transfer_2017 (r020_old, ob_old, r020_new, ob_new, dat_beg) values ('2625', '29', '2620', '36', to_date('01/01/2019', 'MM/DD/YYYY'));
   exception 
      when dup_val_on_index then null;
   end;

   begin
      insert into transfer_2017 (r020_old, ob_old, r020_new, ob_new, dat_beg) values ('2625', '29', '2620', '36', to_date('01/01/2019', 'MM/DD/YYYY'));
   exception 
      when dup_val_on_index then null;
   end;

   begin
      insert into transfer_2017 (r020_old, ob_old, r020_new, ob_new, dat_beg) values ('2625', '25', '2620', '36', to_date('01/01/2019', 'MM/DD/YYYY'));
   exception 
      when dup_val_on_index then null;
   end;

   begin
      insert into transfer_2017 (r020_old, ob_old, r020_new, ob_new, dat_beg) values ('2625', '25', '2620', '36', to_date('01/01/2019', 'MM/DD/YYYY'));
   exception 
      when dup_val_on_index then null;
   end;

   begin
      insert into transfer_2017 (r020_old, ob_old, r020_new, ob_new, dat_beg) values ('2625', '26', '2620', '36', to_date('01/01/2019', 'MM/DD/YYYY'));
   exception 
      when dup_val_on_index then null;
   end;

   begin
      insert into transfer_2017 (r020_old, ob_old, r020_new, ob_new, dat_beg) values ('2625', '26', '2620', '36', to_date('01/01/2019', 'MM/DD/YYYY'));
   exception 
      when dup_val_on_index then null;
   end;

   begin
      insert into transfer_2017 (r020_old, ob_old, r020_new, ob_new, dat_beg) values ('2625', '28', '2620', '36', to_date('01/01/2019', 'MM/DD/YYYY'));
   exception 
      when dup_val_on_index then null;
   end;

   begin
      insert into transfer_2017 (r020_old, ob_old, r020_new, ob_new, dat_beg) values ('2625', '28', '2620', '36', to_date('01/01/2019', 'MM/DD/YYYY'));
   exception 
      when dup_val_on_index then null;
   end;

   begin
      insert into transfer_2017 (r020_old, ob_old, r020_new, ob_new, dat_beg) values ('2625', '31', '2620', '36', to_date('01/01/2019', 'MM/DD/YYYY'));
   exception 
      when dup_val_on_index then null;
   end;

   begin
      insert into transfer_2017 (r020_old, ob_old, r020_new, ob_new, dat_beg) values ('2625', '31', '2620', '36', to_date('01/01/2019', 'MM/DD/YYYY'));
   exception 
      when dup_val_on_index then null;
   end;

   begin
      insert into transfer_2017 (r020_old, ob_old, r020_new, ob_new, dat_beg) values ('2625', '24', '2620', '36', to_date('01/01/2019', 'MM/DD/YYYY'));
   exception 
      when dup_val_on_index then null;
   end;

   begin
      insert into transfer_2017 (r020_old, ob_old, r020_new, ob_new, dat_beg) values ('2625', '24', '2620', '36', to_date('01/01/2019', 'MM/DD/YYYY'));
   exception 
      when dup_val_on_index then null;
   end;

   begin
      insert into transfer_2017 (r020_old, ob_old, r020_new, ob_new, dat_beg) values ('2625', '32', '2620', '36', to_date('01/01/2019', 'MM/DD/YYYY'));
   exception 
      when dup_val_on_index then null;
   end;

   begin
      insert into transfer_2017 (r020_old, ob_old, r020_new, ob_new, dat_beg) values ('2625', '32', '2620', '36', to_date('01/01/2019', 'MM/DD/YYYY'));
   exception 
      when dup_val_on_index then null;
   end;

   begin
      insert into transfer_2017 (r020_old, ob_old, r020_new, ob_new, dat_beg) values ('2625', '27', '2620', '36', to_date('01/01/2019', 'MM/DD/YYYY'));
   exception 
      when dup_val_on_index then null;
   end;

   begin
      insert into transfer_2017 (r020_old, ob_old, r020_new, ob_new, dat_beg) values ('2625', '33', '2620', '36', to_date('01/01/2019', 'MM/DD/YYYY'));
   exception 
      when dup_val_on_index then null;
   end;

   begin
      insert into transfer_2017 (r020_old, ob_old, r020_new, ob_new, dat_beg) values ('2625', '01', '2620', '36', to_date('01/01/2019', 'MM/DD/YYYY'));
   exception 
      when dup_val_on_index then null;
   end;

   begin
      insert into transfer_2017 (r020_old, ob_old, r020_new, ob_new, dat_beg) values ('2625', '30', '2620', '36', to_date('01/01/2019', 'MM/DD/YYYY'));
   exception 
      when dup_val_on_index then null;
   end;

   begin
      insert into transfer_2017 (r020_old, ob_old, r020_new, ob_new, dat_beg) values ('2625', '22', '2620', '36', to_date('01/01/2019', 'MM/DD/YYYY'));
   exception 
      when dup_val_on_index then null;
   end;

   begin
      insert into transfer_2017 (r020_old, ob_old, r020_new, ob_new, dat_beg) values ('2625', '37', '2620', '36', to_date('01/01/2019', 'MM/DD/YYYY'));
   exception 
      when dup_val_on_index then null;
   end;

   begin
      insert into transfer_2017 (r020_old, ob_old, r020_new, ob_new, dat_beg) values ('2625', '36', '2620', '36', to_date('01/01/2019', 'MM/DD/YYYY'));
   exception 
      when dup_val_on_index then null;
   end;

   begin
      insert into transfer_2017 (r020_old, ob_old, r020_new, ob_new, dat_beg) values ('2625', '23', '2620', '36', to_date('01/01/2019', 'MM/DD/YYYY'));
   exception 
      when dup_val_on_index then null;
   end;

   begin
      insert into transfer_2017 (r020_old, ob_old, r020_new, ob_new, dat_beg) values ('2625', '34', '2620', '36', to_date('01/01/2019', 'MM/DD/YYYY'));
   exception 
      when dup_val_on_index then null;
   end;

   begin
      insert into transfer_2017 (r020_old, ob_old, r020_new, ob_new, dat_beg) values ('2625', '02', '2620', '36', to_date('01/01/2019', 'MM/DD/YYYY'));
   exception 
      when dup_val_on_index then null;
   end;

   begin
      insert into transfer_2017 (r020_old, ob_old, r020_new, ob_new, dat_beg) values ('2625', '04', '2620', '36', to_date('01/01/2019', 'MM/DD/YYYY'));
   exception 
      when dup_val_on_index then null;
   end;

   begin
      insert into transfer_2017 (r020_old, ob_old, r020_new, ob_new, dat_beg) values ('2625', '05', '2620', '36', to_date('01/01/2019', 'MM/DD/YYYY'));
   exception 
      when dup_val_on_index then null;
   end;

   begin
      insert into transfer_2017 (r020_old, ob_old, r020_new, ob_new, dat_beg) values ('2625', '06', '2620', '36', to_date('01/01/2019', 'MM/DD/YYYY'));
   exception 
      when dup_val_on_index then null;
   end;

   begin
      insert into transfer_2017 (r020_old, ob_old, r020_new, ob_new, dat_beg) values ('2625', '08', '2620', '36', to_date('01/01/2019', 'MM/DD/YYYY'));
   exception 
      when dup_val_on_index then null;
   end;

   begin
      insert into transfer_2017 (r020_old, ob_old, r020_new, ob_new, dat_beg) values ('2625', '09', '2620', '36', to_date('01/01/2019', 'MM/DD/YYYY'));
   exception 
      when dup_val_on_index then null;
   end;

   begin
      insert into transfer_2017 (r020_old, ob_old, r020_new, ob_new, dat_beg) values ('2625', '10', '2620', '36', to_date('01/01/2019', 'MM/DD/YYYY'));
   exception 
      when dup_val_on_index then null;
   end;

   begin
      insert into transfer_2017 (r020_old, ob_old, r020_new, ob_new, dat_beg) values ('2625', '11', '2620', '36', to_date('01/01/2019', 'MM/DD/YYYY'));
   exception 
      when dup_val_on_index then null;
   end;

   begin
      insert into transfer_2017 (r020_old, ob_old, r020_new, ob_new, dat_beg) values ('2625', '12', '2620', '36', to_date('01/01/2019', 'MM/DD/YYYY'));
   exception 
      when dup_val_on_index then null;
   end;

   begin
      insert into transfer_2017 (r020_old, ob_old, r020_new, ob_new, dat_beg) values ('2625', '14', '2620', '36', to_date('01/01/2019', 'MM/DD/YYYY'));
   exception 
      when dup_val_on_index then null;
   end;

   begin
      insert into transfer_2017 (r020_old, ob_old, r020_new, ob_new, dat_beg) values ('2625', '15', '2620', '36', to_date('01/01/2019', 'MM/DD/YYYY'));
   exception 
      when dup_val_on_index then null;
   end;

   begin
      insert into transfer_2017 (r020_old, ob_old, r020_new, ob_new, dat_beg) values ('2625', '17', '2620', '36', to_date('01/01/2019', 'MM/DD/YYYY'));
   exception 
      when dup_val_on_index then null;
   end;

   begin
      insert into transfer_2017 (r020_old, ob_old, r020_new, ob_new, dat_beg) values ('2625', '19', '2620', '36', to_date('01/01/2019', 'MM/DD/YYYY'));
   exception 
      when dup_val_on_index then null;
   end;

   begin
      insert into transfer_2017 (r020_old, ob_old, r020_new, ob_new, dat_beg) values ('2625', '20', '2620', '36', to_date('01/01/2019', 'MM/DD/YYYY'));
   exception 
      when dup_val_on_index then null;
   end;

   begin
      insert into transfer_2017 (r020_old, ob_old, r020_new, ob_new, dat_beg) values ('2625', '21', '2620', '36', to_date('01/01/2019', 'MM/DD/YYYY'));
   exception 
      when dup_val_on_index then null;
   end;

   begin
      insert into transfer_2017 (r020_old, ob_old, r020_new, ob_new, dat_beg) values ('2605', '01', '2600', '14', to_date('01/01/2019', 'MM/DD/YYYY'));
   exception 
      when dup_val_on_index then null;
   end;

   begin
      insert into transfer_2017 (r020_old, ob_old, r020_new, ob_new, dat_beg) values ('2605', '02', '2600', '14', to_date('01/01/2019', 'MM/DD/YYYY'));
   exception 
      when dup_val_on_index then null;
   end;

   begin
      insert into transfer_2017 (r020_old, ob_old, r020_new, ob_new, dat_beg) values ('2605', '03', '2600', '14', to_date('01/01/2019', 'MM/DD/YYYY'));
   exception 
      when dup_val_on_index then null;
   end;

   begin
      insert into transfer_2017 (r020_old, ob_old, r020_new, ob_new, dat_beg) values ('2605', '04', '2600', '14', to_date('01/01/2019', 'MM/DD/YYYY'));
   exception 
      when dup_val_on_index then null;
   end;

   begin
      insert into transfer_2017 (r020_old, ob_old, r020_new, ob_new, dat_beg) values ('2605', '05', '2600', '14', to_date('01/01/2019', 'MM/DD/YYYY'));
   exception 
      when dup_val_on_index then null;
   end;

   begin
      insert into transfer_2017 (r020_old, ob_old, r020_new, ob_new, dat_beg) values ('2605', '06', '2600', '14', to_date('01/01/2019', 'MM/DD/YYYY'));
   exception 
      when dup_val_on_index then null;
   end;

   begin
      insert into transfer_2017 (r020_old, ob_old, r020_new, ob_new, dat_beg) values ('2605', '07', '2600', '14', to_date('01/01/2019', 'MM/DD/YYYY'));
   exception 
      when dup_val_on_index then null;
   end;

   begin
      insert into transfer_2017 (r020_old, ob_old, r020_new, ob_new, dat_beg) values ('2605', '08', '2600', '14', to_date('01/01/2019', 'MM/DD/YYYY'));
   exception 
      when dup_val_on_index then null;
   end;

   begin
      insert into transfer_2017 (r020_old, ob_old, r020_new, ob_new, dat_beg) values ('2605', '09', '2600', '14', to_date('01/01/2019', 'MM/DD/YYYY'));
   exception 
      when dup_val_on_index then null;
   end;

   begin
      insert into transfer_2017 (r020_old, ob_old, r020_new, ob_new, dat_beg) values ('2625', '01', '2620', '36', to_date('01/01/2019', 'MM/DD/YYYY'));
   exception 
      when dup_val_on_index then null;
   end;

   begin
      insert into transfer_2017 (r020_old, ob_old, r020_new, ob_new, dat_beg) values ('2625', '03', '2620', '36', to_date('01/01/2019', 'MM/DD/YYYY'));
   exception 
      when dup_val_on_index then null;
   end;

   begin
      insert into transfer_2017 (r020_old, ob_old, r020_new, ob_new, dat_beg) values ('2625', '07', '2620', '36', to_date('01/01/2019', 'MM/DD/YYYY'));
   exception 
      when dup_val_on_index then null;
   end;

   begin
      insert into transfer_2017 (r020_old, ob_old, r020_new, ob_new, dat_beg) values ('2625', '13', '2620', '36', to_date('01/01/2019', 'MM/DD/YYYY'));
   exception 
      when dup_val_on_index then null;
   end;

   begin
      insert into transfer_2017 (r020_old, ob_old, r020_new, ob_new, dat_beg) values ('2625', '16', '2620', '36', to_date('01/01/2019', 'MM/DD/YYYY'));
   exception 
      when dup_val_on_index then null;
   end;

   begin
      insert into transfer_2017 (r020_old, ob_old, r020_new, ob_new, dat_beg) values ('2605', '11', '2600', '14', to_date('01/01/2019', 'MM/DD/YYYY'));
   exception 
      when dup_val_on_index then null;
   end;

   begin
      insert into transfer_2017 (r020_old, ob_old, r020_new, ob_new, dat_beg) values ('2625', '18', '2620', '36', to_date('01/01/2019', 'MM/DD/YYYY'));
   exception 
      when dup_val_on_index then null;
   end;

   begin
      insert into transfer_2017 (r020_old, ob_old, r020_new, ob_new, dat_beg) values ('2655', '01', '2650', '12', to_date('01/01/2019', 'MM/DD/YYYY'));
   exception 
      when dup_val_on_index then null;
   end;

   begin
      insert into transfer_2017 (r020_old, ob_old, r020_new, ob_new, dat_beg) values ('2655', '02', '2650', '12', to_date('01/01/2019', 'MM/DD/YYYY'));
   exception 
      when dup_val_on_index then null;
   end;

   begin
      insert into transfer_2017 (r020_old, ob_old, r020_new, ob_new, dat_beg) values ('2655', '03', '2650', '12', to_date('01/01/2019', 'MM/DD/YYYY'));
   exception 
      when dup_val_on_index then null;
   end;

   begin
      insert into transfer_2017 (r020_old, ob_old, r020_new, ob_new, dat_beg) values ('2655', '04', '2650', '12', to_date('01/01/2019', 'MM/DD/YYYY'));
   exception 
      when dup_val_on_index then null;
   end;

   begin
      insert into transfer_2017 (r020_old, ob_old, r020_new, ob_new, dat_beg) values ('2655', '05', '2650', '12', to_date('01/01/2019', 'MM/DD/YYYY'));
   exception 
      when dup_val_on_index then null;
   end;

   begin
      insert into transfer_2017 (r020_old, ob_old, r020_new, ob_new, dat_beg) values ('2655', '06', '2650', '12', to_date('01/01/2019', 'MM/DD/YYYY'));
   exception 
      when dup_val_on_index then null;
   end;

   begin
      insert into transfer_2017 (r020_old, ob_old, r020_new, ob_new, dat_beg) values ('2655', '07', '2650', '12', to_date('01/01/2019', 'MM/DD/YYYY'));
   exception 
      when dup_val_on_index then null;
   end;

   begin
      insert into transfer_2017 (r020_old, ob_old, r020_new, ob_new, dat_beg) values ('2655', '08', '2650', '12', to_date('01/01/2019', 'MM/DD/YYYY'));
   exception 
      when dup_val_on_index then null;
   end;

   begin
      insert into transfer_2017 (r020_old, ob_old, r020_new, ob_new, dat_beg) values ('2655', '09', '2650', '12', to_date('01/01/2019', 'MM/DD/YYYY'));
   exception 
      when dup_val_on_index then null;
   end;

   begin
      insert into transfer_2017 (r020_old, ob_old, r020_new, ob_new, dat_beg) values ('2655', '10', '2650', '12', to_date('01/01/2019', 'MM/DD/YYYY'));
   exception 
      when dup_val_on_index then null;
   end;

   begin
      insert into transfer_2017 (r020_old, ob_old, r020_new, ob_new, dat_beg) values ('2625', '36', '2620', '36', to_date('01/01/2019', 'MM/DD/YYYY'));
   exception 
      when dup_val_on_index then null;
   end;

   begin
      insert into transfer_2017 (r020_old, ob_old, r020_new, ob_new, dat_beg) values ('2605', '14', '2600', '14', to_date('01/01/2019', 'MM/DD/YYYY'));
   exception 
      when dup_val_on_index then null;
   end;

   begin
      insert into transfer_2017 (r020_old, ob_old, r020_new, ob_new, dat_beg) values ('2625', '37', '2620', '36', to_date('01/01/2019', 'MM/DD/YYYY'));
   exception 
      when dup_val_on_index then null;
   end;

   update TRANSFER_2017 t 
   set t.dat_end = null
   where t.r020_old in ('2605', '2625', '2655');

   commit;
end;
/
