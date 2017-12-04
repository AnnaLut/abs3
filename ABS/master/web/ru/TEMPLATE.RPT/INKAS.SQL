delete from op_rules where tt in('093','TOF','TOH','TOQ','TOZ') and tag='FIO';
delete from op_rules where tt in('093','TOF','TOH','TOQ','TOZ') and tag='ADRES';
delete from op_rules where tt in('093','TOF','TOH','TOQ','TOZ') and tag='DT_R';
delete from op_rules where tt in('093','TOF','TOH','TOQ','TOZ') and tag='OTRIM';
update op_rules set ORD=1 where tt in('093','TOF','TOH','TOQ','TOZ') and tag='INK_I';
commit;