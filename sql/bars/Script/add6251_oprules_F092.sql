
begin
     for u in ( select TT, TAG, OPT, USED4INPUT, VAL, NOMODIFY,
                       (select max(ord)+1 from op_rules
                         where tt=o.tt) ORD
                  from op_rules o
                 where o.tag ='D1#70'
     ) loop

          begin
                insert into op_rules
                          ( TT, TAG, OPT, USED4INPUT, ORD, VAL, NOMODIFY )
                   values ( u.TT, 'D1#3K', u.OPT, u.USED4INPUT, u.ORD, u.VAL, u.NOMODIFY );
          exception
              when dup_val_on_index
                   then    null; 
          end;
     end loop;

     for u in ( select TT, TAG, OPT, USED4INPUT, VAL, NOMODIFY,
                       (select max(ord)+1 from op_rules
                         where tt=o.tt) ORD
                  from op_rules o
                 where o.tag ='D1#D3'
     ) loop

          begin
                insert into op_rules
                          ( TT, TAG, OPT, USED4INPUT, ORD, VAL, NOMODIFY )
                   values ( u.TT, 'D1#3K', u.OPT, u.USED4INPUT, u.ORD, u.VAL, u.NOMODIFY );
          exception
              when dup_val_on_index
                   then    null; 
          end;
     end loop;

end;
/

commit;
