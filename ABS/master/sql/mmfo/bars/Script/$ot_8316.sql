


DELETE from  op_rules where TAG in ('OB40','OB40D') and TT='I00';

insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
values ('OB40', 'I00', 'M', 1, 3, null, null);

insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
values ('OB40D', 'I00', 'O', 1, 3, null, null);

COMMIT;
