SET DEFINE OFF;

exec bc.home;

delete from NBUR_DCT_F6EX_EKP;

Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E178', '—ума за новими договорами/контрактами прот€гом 30 дн≥в за коштами, що отриман≥ за операц≥€ми репо та забезпечен≥ високо€к≥сними л≥кв≥дними активами', '1', NULL, 12, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E179', '—ума фактичних в≥дплив≥в грошових кошт≥в прот€гом 30 дн≥в за коштами, що отриман≥ за операц≥€ми репо та забезпечен≥ активами, €к≥ не Ї високо€к≥сними л≥кв≥дними активами', '1', 'A6K047', 10, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E180', '—ума за пролонгованими договорами/контрактами прот€гом 30 дн≥в за коштами, що отриман≥ за операц≥€ми репо та забезпечен≥ активами, €к≥ не Ї високо€к≥сними л≥кв≥дними активами', '1', 'A6K047', 14, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E181', '—ума за новими договорами/контрактами прот€гом 30 дн≥в за коштами, що отриман≥ за операц≥€ми репо та забезпечен≥ активами, €к≥ не Ї високо€к≥сними л≥кв≥дними активами', '1', NULL, 12, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E182', '—ума фактичних в≥дплив≥в грошових кошт≥в прот€гом 30 дн≥в за нарахованими витратами прот€гом 30 дн≥в за вкладами ф≥зичних ос≥б', '1', 'B6K006', 10, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E183', '—ума фактичних в≥дплив≥в грошових кошт≥в прот€гом 30 дн≥в за коштами в розрахунках ≥нших банк≥в', '1', 'B6K008', 10, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E184', '—ума фактичних в≥дплив≥в грошових кошт≥в прот€гом 30 дн≥в за нарахованими витратами за коштами банк≥в', '1', 'B6K009', 10, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E185', '—ума фактичних в≥дплив≥в грошових кошт≥в прот€гом 30 дн≥в за нарахованими витратами за рахунками бюджетних установ', '1', 'B6K011', 10, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E186', '—ума фактичних в≥дплив≥в грошових кошт≥в прот€гом 30 дн≥в за нарахованими витратами за коштами небанк≥вських ф≥нансових установ', '1', 'B6K014', 10, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E187', '—ума фактичних в≥дплив≥в грошових кошт≥в прот€гом 30 дн≥в за нарахованими витратами за кредитами в≥д м≥жнародних банк≥в розвитку та ≥нших ф≥нансових орган≥зац≥й', '1', 'B6K017', 10, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E188', '—ума фактичних в≥дплив≥в грошових кошт≥в прот€гом 30 дн≥в за нарахованими витратами за ц≥нними паперами власного боргу', '1', 'B6K018', 10, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E189', '—ума фактичних в≥дплив≥в грошових кошт≥в прот€гом 30 дн≥в за нарахованими витратами за субординованим боргом', '1', 'B6K019', 10, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E190', '—ума фактичних в≥дплив≥в грошових кошт≥в прот€гом 30 дн≥в за нарахованими витратами за вкладами суб''Їкт≥в господарськоњ д≥€льност≥', '1', 'B6K023', 10, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E191', '—ума фактичних в≥дплив≥в грошових кошт≥в прот€гом 30 дн≥в за нарахованими витратами за кредитами Ќац≥онального банку ”крањни та коштами, отриманими за операц≥€ми репо', '1', 'B6K027', 10, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E192', '—ума фактичних контрактних надходжень грошових кошт≥в прот€гом 30 дн≥в за нарахованими доходами за кредитами овердрафт', '1', 'A6K080', 1, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E080', '—ума фактичних контрактних надходжень грошових кошт≥в прот€гом 30 дн≥в за кредитами ф≥зичних ос≥б на поточн≥ потреби', '1', 'A6K049', 1, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E081', '‘актична сума роловера за кредитами ф≥зичних ос≥б на поточн≥ потреби, що оч≥кувалис€ прот€гом 30 дн≥в', '1', 'A6K049', 2, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E082', '‘актична сума лонгац≥й за кредитами ф≥зичних ос≥б на поточн≥ потреби, що оч≥кувалис€ прот€гом 30 дн≥в', '1', 'A6K049', 3, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E083', '—ума фактичних понад контрактних надходжень грошових кошт≥в прот€гом 30 дн≥в за кредитами ф≥зичних ос≥б на поточн≥ потреби ', '1', 'A6K049', 4, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E084', '—ума фактичних контрактних надходжень грошових кошт≥в прот€гом 30 дн≥в за ≥потечними кредитами ф≥зичних ос≥б ', '1', 'A6K050', 1, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E085', '‘актична сума роловера за ≥потечними кредитами ф≥зичних ос≥б, що оч≥кувалис€ прот€гом 30 дн≥в', '1', 'A6K050', 2, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E086', '‘актична сума лонгац≥й за ≥потечними кредитами ф≥зичних ос≥б, що оч≥кувалис€ прот€гом 30 дн≥в', '1', 'A6K050', 3, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E087', '—ума фактичних понад контрактних надходжень грошових кошт≥в прот€гом 30 дн≥в за ≥потечними кредитами ф≥зичних ос≥б ', '1', 'A6K050', 4, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E088', '—ума фактичних контрактних надходжень грошових кошт≥в прот€гом 30 дн≥в за ф≥нансовим л≥зингом (орендою) ф≥зичних ос≥б', '1', 'A6K051', 1, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E089', '‘актична сума роловера за ф≥нансовим л≥зингом (орендою) ф≥зичних ос≥б, що оч≥кувалис€ прот€гом 30 дн≥в', '1', 'A6K051', 2, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E090', '‘актична сума лонгац≥й за ф≥нансовим л≥зингом (орендою) ф≥зичних ос≥б, що оч≥кувалис€ прот€гом 30 дн≥в', '1', 'A6K051', 3, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E091', '—ума фактичних понад контрактних надходжень грошових кошт≥в прот€гом 30 дн≥в за ф≥нансовим л≥зингом (орендою) ф≥зичних ос≥б ', '1', 'A6K051', 4, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E092', '—ума фактичних контрактних надходжень грошових кошт≥в прот€гом 30 дн≥в за кредитами ф≥зичних ос≥б, що надан≥ за врахованими вексел€ми', '1', 'A6K052', 1, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E093', '—ума фактичних контрактних надходжень грошових кошт≥в прот€гом 30 дн≥в за нарахованими доходами за кредитами ф≥зичних ос≥б', '1', 'A6K053', 1, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E094', '—ума фактичних контрактних надходжень грошових кошт≥в прот€гом 30 дн≥в за кредитами суб''Їктам господарськоњ д≥€льност≥ в поточну д≥€льн≥сть', '1', 'A6K054', 1, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E095', '‘актична сума роловера за кредитами субТЇкт≥в господарськоњ д≥€льност≥ в поточну д≥€льн≥сть, що оч≥кувалис€ прот€гом 30 дн≥в', '1', 'A6K054', 2, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E096', '‘актична сума лонгац≥й за кредитами суб''Їктам господарськоњ д≥€льност≥ в поточну д≥€льн≥сть, що оч≥кувалис€ прот€гом 30 дн≥в', '1', 'A6K054', 3, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E097', '—ума фактичних понад контрактних надходжень грошових кошт≥в прот€гом 30 дн≥в за кредитами суб''Їктам господарськоњ д≥€льност≥ в поточну д≥€льн≥сть', '1', 'A6K054', 4, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E098', '—ума фактичних контрактних надходжень грошових кошт≥в прот€гом 30 дн≥в за ≥потечними кредитами суб''Їктам господарськоњ д≥€льност≥ ', '1', 'A6K055', 1, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E099', '‘актична сума роловера за ≥потечними кредитами субТЇкт≥в господарськоњ д≥€льност≥, що оч≥кувалис€ прот€гом 30 дн≥в', '1', 'A6K055', 2, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E100', '‘актична сума лонгац≥й за ≥потечними кредитами суб''Їктам господарськоњ д≥€льност≥, що оч≥кувалис€ прот€гом 30 дн≥в', '1', 'A6K055', 3, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E101', '—ума фактичних понад контрактних надходжень грошових кошт≥в прот€гом 30 дн≥в за ≥потечними кредитами суб''Їктам господарськоњ д≥€льност≥ ', '1', 'A6K055', 4, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E102', '—ума фактичних контрактних надходжень грошових кошт≥в прот€гом 30 дн≥в за ф≥нансовим л≥зингом (орендою) суб''Їктам господарськоњ д≥€льност≥', '1', 'A6K056', 1, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E103', '‘актична сума роловера за ф≥нансовим л≥зингом (орендою) субТЇкт≥в господарськоњ д≥€льност≥, що оч≥кувалис€ прот€гом 30 дн≥в', '1', 'A6K056', 2, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E104', '‘актична сума лонгац≥й за ф≥нансовим л≥зингом (орендою) суб''Їктам господарськоњ д≥€льност≥, що оч≥кувалис€ прот€гом 30 дн≥в', '1', 'A6K056', 3, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E105', '—ума фактичних понад контрактних надходжень грошових кошт≥в прот€гом 30 дн≥в за ф≥нансовим л≥зингом (орендою) субТЇктам господарськоњ д≥€льност≥', '1', 'A6K056', 4, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E106', '—ума фактичних контрактних надходжень грошових кошт≥в прот€гом 30 дн≥в за кредитами суб''Їктам господарськоњ д≥€льност≥, що надан≥ за врахованими вексел€ми', '1', 'A6K058', 1, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E107', '—ума фактичних контрактних надходжень грошових кошт≥в прот€гом 30 дн≥в за нарахованими доходами за кредитами суб''Їктам господарськоњ д≥€льност≥', '1', 'A6K059', 1, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E108', '—ума фактичних контрактних надходжень грошових кошт≥в прот€гом 30 дн≥в за факторинговими операц≥€ми ≥з суб''Їктам господарськоњ д≥€льност≥ ', '1', 'A6K057', 1, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E109', '‘актична сума роловера грошових надходжень за факторинговими операц≥€ми ≥з субТЇктами господарськоњ д≥€льност≥, що оч≥кувалис€ прот€гом 30 дн≥в
', '1', 'A6K057', 2, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E110', '‘актична сума лонгац≥й грошових надходжень за факторинговими операц≥€ми ≥з субТЇктами господарськоњ д≥€льност≥, що оч≥кувалис€ прот€гом 30 дн≥в
', '1', 'A6K057', 3, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E111', '—ума фактичних понад контрактних надходжень грошових кошт≥в прот€гом 30 дн≥в за факторинговими операц≥€ми ≥з субТЇктами господарськоњ д≥€льност≥
', '1', 'A6K057', 4, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E112', '—ума фактичних контрактних надходжень грошових кошт≥в прот€гом 30 дн≥в за нарахованими доходами за кредитами орган≥в державноњ влади та орган≥в м≥сцевого самовр€дуванн€', '1', 'A6K062', 1, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E113', '—ума фактичних контрактних надходжень грошових кошт≥в прот€гом 30 дн≥в за кредитами орган≥в державноњ влади та орган≥в м≥сцевого самовр€дуванн€', '1', 'A6K060', 1, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E114', '—ума фактичних контрактних надходжень грошових кошт≥в прот€гом 30 дн≥в за ≥потечними кредитами орган≥в державноњ влади та орган≥в м≥сцевого самовр€дуванн€', '1', 'A6K061', 1, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E115', '—ума фактичних контрактних надходжень грошових кошт≥в прот€гом 30 дн≥в за кредитами та ф≥нансовими л≥зингом (орендою), наданим ≥ншим банкам', '1', 'A6K068', 1, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E116', '—ума фактичних контрактних надходжень грошових кошт≥в прот€гом 30 дн≥в за кредитами (депозитами), що надан≥ (розм≥щен≥) на умовах субординованого боргу', '1', 'A6K069', 1, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E117', '—ума фактичних контрактних надходжень грошових кошт≥в прот€гом 30 дн≥в за нарахованими доходами за коштами в ≥нших банках', '1', 'A6K071', 1, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E118', '—ума фактичних контрактних надходжень, що оч≥кувалис€ прот€гом 30 дн≥в, за борговими ц≥нними паперами, €к≥ не включен≥ до високо€к≥сних л≥кв≥дних актив≥в, та нарахованими доходами за ними
', '1', 'A6K072', 1, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E119', '—ума фактичних контрактних надходжень, що оч≥кувалис€ прот€гом 30 дн≥в, за операц≥€ми з деривативами', '1', 'A6K076', 1, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E120', '—ума фактичних контрактних надходжень, що оч≥кувалис€ прот€гом 30 дн≥в, за деб≥торською заборгован≥стю з придбанн€ та продажу ≥ноземноњ валюти за рахунок банку', '1', 'A6K077', 1, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E121', '—ума фактичних контрактних надходжень, що оч≥кувалис€ прот€гом 30 дн≥в, за деб≥торською заборгован≥стю за операц≥€ми з банками та кл≥Їнтами', '1', 'A6K078', 1, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E122', '—ума фактичних контрактних надходжень, що оч≥кувалис€ прот€гом 30 дн≥в, за операц≥€ми зворотного репо без переходу права власност≥/розпор€дженн€ та нарахованими доходами за ними', '1', 'A6K073', 1, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E123', '—ума фактичних контрактних надходжень, що оч≥кувалис€ прот€гом 30 дн≥в, за операц≥€ми зворотного репо з переходом права власност≥/розпор€дженн€, забезпеченими активами, €к≥ не Ї високо€к≥сними л≥кв≥дними активами, та нарахованими доходами за ними', '1', 'A6K074', 1, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E124', '—ума фактичних контрактних надходжень, що оч≥кувалис€ прот€гом 30 дн≥в, за операц≥€ми зворотного репо з переходом права власност≥/розпор€дженн€, забезпеченими високо€к≥сними л≥кв≥дними
активами, та нарахованими доходами за ними
', '1', 'A6K075', 1, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E125', '—ума фактичних в≥дплив≥в за кредитами овердрафт ф≥зичним особам
', '1', NULL, 5, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E126', '—ума безв≥дкличних зобов''€зань банку за кредитами овердрафт ф≥зичним особам', '1', NULL, 13, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E127', '—ума в≥дкличних зобов''€зань банку за кредитами овердрафт ф≥зичним особам', '1', NULL, 13, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E128', '—ума фактичних в≥дплив≥в за кредитами овердрафт субТЇктам господарськоњ д≥€льност≥
', '1', NULL, 5, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E129', '—ума безв≥дкличних зобов''€зань банку за кредитами овердрафт суб''Їктам господарськоњ д≥€льност≥', '1', NULL, 13, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E130', '—ума в≥дкличних зобов''€зань банку за кредитами овердрафт суб''Їктам господарськоњ д≥€льност≥', '1', NULL, 13, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E131', '—ума фактичних в≥дплив≥в за кредитами овердрафт банкам
', '1', NULL, 5, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E132', '—ума безв≥дкличних  зобов''€зань банку за кредитами овердрафт банкам', '1', NULL, 13, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E134', '—ума фактичних в≥дплив≥в за кредитними л≥н≥€ми ф≥зичним особам
', '1', NULL, 6, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E135', '—ума безв≥дкличних зобов''€зань банку за кредитними л≥н≥€ми ф≥зичним особам', '1', NULL, 13, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E136', '—ума в≥дкличних зобов''€зань банку за кредитними л≥н≥€ми ф≥зичним особам', '1', NULL, 13, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E137', '—ума фактичних в≥дплив≥в за кредитними л≥н≥€ми субТЇктам господарськоњ д≥€льност≥
', '1', NULL, 6, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E138', '—ума безв≥дкличних зобов''€зань банку за кредитними л≥н≥€ми суб''Їктам господарськоњ д≥€льност≥', '1', NULL, 13, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E139', '—ума в≥дкличних зобов''€зань банку за кредитними л≥н≥€ми суб''Їктам господарськоњ д≥€льност≥', '1', NULL, 13, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E140', '—ума фактичних в≥дплив≥в за кредитними л≥н≥€ми банк≥в
', '1', NULL, 6, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E141', '—ума в≥дкличних зобов''€зань банку за кредитними л≥н≥€ми банк≥в', '1', NULL, 13, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E142', '—ума безв≥дкличних зобов''€зань банку за кредитними л≥н≥€ми банк≥в', '1', NULL, 13, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E143', '—ума фактичних в≥дплив≥в за рахунками-ескроу ф≥зичних ос≥б', '1', 'B6K005', 7, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E144', '—ума залишку за рахунками-ескроу ф≥зичних ос≥б', '1', NULL, 13, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E145', '—ума фактичних в≥дплив≥в за рахунками-ескроу суб''Їкт≥в господарськоњ д≥€льност≥', '1', 'B6K007', 7, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E146', '—ума залишку за рахунками-ескроу суб''Їкт≥в господарськоњ д≥€льност≥', '1', NULL, 13, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E149', '—ума фактичних надходжень за кредитами овердрафт ф≥зичним особам', '1', NULL, 8, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E150', '—ума фактичних надходжень за кредитами овердрафт суб''Їктам господарськоњ д≥€льност≥', '1', NULL, 8, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E151', '—ума фактичних надходжень за кредитами овердрафт банкам', '1', NULL, 8, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E152', '—ума фактичних в≥дплив≥в грошових кошт≥в прот€гом 30 дн≥в за вкладами ф≥зичних ос≥б (на вимогу та строковими), €к≥ були повернут≥ зг≥дно з отриманим пов≥домленн€м про њх поверненн€', '1', 'A6K020', 9, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E153', '—ума фактичних в≥дплив≥в грошових кошт≥в прот€гом 30 дн≥в за строковими вкладами ф≥зичних ос≥б', '1', 'A6K021', 10, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E154', '—ума за пролонгованими та повторно укладеними договорами/контрактами за  строковими вкладами ф≥зичних ос≥б, €к≥ зг≥дно з умовами договор≥в мали бути  повернен≥ прот€гом 30 дн≥в', '1', 'A6K021', 11, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E155', '—ума за новими договорами/контрактами за строковими вкладами ф≥зичних ос≥б', '1', NULL, 12, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E156', '—ума фактичних в≥дплив≥в грошових кошт≥в прот€гом 30 дн≥в за вкладами суб''Їкт≥в господарськоњ д≥€льност≥ (на вимогу та строковими), €к≥ були повернут≥ зг≥дно з отриманим пов≥домленн€м про њх поверненн€', '1', 'A6K024', 9, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E157', '—ума фактичних в≥дплив≥в грошових кошт≥в прот€гом 30 дн≥в за строковими вкладами суб''Їкт≥в господарськоњ д≥€льност≥', '1', 'A6K025', 10, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E158', '—ума за пролонгованими та повторно укладеними договорами/контрактами за строковими вкладами субТЇкт≥в господарськоњ д≥€льност≥, €к≥ зг≥дно з умовами договор≥в мали бути повернен≥ прот€гом 30 дн≥в', '1', 'A6K025', 11, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E159', '—ума за новими договорами/контрактами за строковими вкладами суб''Їкт≥в господарськоњ д≥€льност≥', '1', NULL, 12, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E160', '—ума фактичних в≥дплив≥в грошових кошт≥в прот€гом 30 дн≥в за строковими депозитами ≥нших банк≥в та за строковими кредитами, що отриман≥ в≥д ≥нших банк≥в', '1', 'A6K027', 10, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E161', '—ума фактичних в≥дплив≥в грошових кошт≥в прот€гом 30 дн≥в за вкладами бюджетних установ, €к≥ були повернут≥ зг≥дно з отриманим пов≥домленн€м про њх поверненн€', '1', 'A6K079', 9, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E162', '—ума фактичних в≥дплив≥в грошових кошт≥в прот€гом 30 дн≥в за строковими коштами бюджетних установ', '1', 'A6K028', 10, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E163', '—ума фактичних в≥дплив≥в грошових кошт≥в прот€гом 30 дн≥в за строковими коштами небанк≥вських ф≥нансових установ', '1', 'A6K029', 10, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E164', '—ума фактичних в≥дплив≥в грошових кошт≥в прот€гом 30 дн≥в за вкладами небанк≥вських ф≥нансових установ (на вимогу та строковими), €к≥ були повернен≥ в≥дпов≥дно до отриманого пов≥домленн€ про њх поверненн€', '1', 'A6K030', 9, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E165', '—ума фактичних в≥дплив≥в грошових кошт≥в прот€гом 30 дн≥в за кредитами в≥д м≥жнародних банк≥в розвитку', '1', 'A6K032', 10, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E166', '—ума фактичних в≥дплив≥в грошових кошт≥в прот€гом 30 дн≥в за кредитами в≥д ≥нших орган≥зац≥й', '1', 'A6K033', 10, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E167', '—ума фактичних в≥дплив≥в грошових кошт≥в прот€гом 30 дн≥в за строковими ощадними (депозитними) сертиф≥катами', '1', 'A6K034', 10, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E168', '—ума фактичних в≥дплив≥в грошових кошт≥в прот€гом 30 дн≥в за ≥ншими ц≥нними паперами власного боргу', '1', 'A6K035', 10, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E169', '—ума фактичних в≥дплив≥в грошових кошт≥в прот€гом 30 дн≥в за субординованим боргом', '1', 'A6K036', 10, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E170', '—ума фактичних в≥дплив≥в грошових кошт≥в за безв≥дкличними зобов''€занн€ми з кредитуванн€, що надан≥ ≥ншим ф≥нансовим установам', '1', 'A6K039', 6, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E171', '—ума фактичних в≥дплив≥в грошових кошт≥в прот€гом 30 дн≥в за операц≥€ми, пов''€заними з торговим ф≥нансуванн€м (гарант≥њ, акредитиви)', '1', 'A6K040', 6, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E172', '—ума фактичних в≥дплив≥в грошових кошт≥в прот€гом 30 дн≥в за ≥ншими балансовими та позабалансовими зобов''€занн€ми', '1', 'A6K041', 6, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E173', '—ума фактичних в≥дплив≥в грошових кошт≥в прот€гом 30 дн≥в за операц≥€ми з деривативами', '1', 'A6K042', 10, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E174', '—ума фактичних в≥дплив≥в грошових кошт≥в прот€гом 30 дн≥в за кредиторською заборгован≥стю з придбанн€ та продажу ≥ноземноњ валюти за рахунок банку', '1', 'A6K043', 10, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E175', '—ума фактичних в≥дплив≥в грошових кошт≥в прот€гом 30 дн≥в за кредиторською заборгован≥стю', '1', 'A6K044', 10, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E176', '—ума фактичних в≥дплив≥в грошових кошт≥в прот€гом 30 дн≥в за коштами, що отриман≥ за операц≥€ми репо та забезпечен≥ високо€к≥сними л≥кв≥дними активами', '1', 'A6K046', 10, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E177', '—ума за пролонгованими та повторно укладеними договорами/контрактами прот€гом 30 дн≥в за коштами, що отриман≥ за операц≥€ми репо та забезпечен≥ високо€к≥сними л≥кв≥дними активами', '1', 'A6K046', 11, 
    NULL, 100, 100, NULL);
COMMIT;
