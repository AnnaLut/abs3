

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_KLPVAL.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_KLPVAL ***

  CREATE OR REPLACE PROCEDURE BARS.P_KLPVAL (kod_ number, ret_ IN OUT number)
is
  l_clob                clob          ;
  l_namef               varchar2(12)  ;
  l_xml                 xmltype       ;
  l_AdresBankBen        varchar2(254) ;
  l_AdresBankPl         varchar2(254) ;
  l_AdresBen            varchar2(254) ;
  l_AdresPl             varchar2(254) ;
  l_Apartment           varchar2(32)  ;
  l_BankPosr            varchar2(140) ;
  l_BIK                 varchar2(32)  ;
  l_CheckBox1           varchar2(16)  ;
  l_CheckBox2           varchar2(16)  ;
  l_CheckBox3           varchar2(16)  ;
  l_CheckBox4           varchar2(16)  ;
  l_CheckBox5           varchar2(16)  ;
  l_CheckBox6           varchar2(16)  ;
  l_City                varchar2(96)  ;
  l_DateTimePicker1     varchar2(16)  ;
  l_FIO1                varchar2(96)  ;
  l_FIO2                varchar2(96)  ;
  l_FonFax              varchar2(96)  ;
  l_House               varchar2(32)  ;
  l_I_VA                varchar2(16)  ;
  l_I_VA_Prod           varchar2(16)  ;
  l_IbanBen             varchar2(254) ;
  l_INNBank             varchar2(32)  ;
  l_KodBankBen          varchar2(96)  ;
  l_KodBankPl           varchar2(32)  ;
  l_KodOp               varchar2(32)  ;
  l_KodStrBen           varchar2(96)  ;
  l_Komis               varchar2(32)  ;
  l_Kurs                varchar2(32)  ;
  l_Name                varchar2(254) ;
  l_NameBankBen         varchar2(254) ;
  l_NameBankKor         varchar2(254) ;
  l_NameBankPl          varchar2(254) ;
  l_NameBen             varchar2(254) ;
  l_NamePl              varchar2(254) ;
  l_NameUp              varchar2(96)  ;
  l_NameVidBank         varchar2(254) ;
  l_NaznPlat            varchar2(1024);
  l_NDS                 varchar2(96)  ;
  l_NKorR               varchar2(96)  ;
  l_OkpoPl              varchar2(32)  ;
  l_Pidstav             varchar2(254) ;
  l_PostInd             varchar2(32)  ;
  l_PS_Date             varchar2(16)  ;
  l_PS_Number           varchar2(96)  ;
  l_PS_Number1          varchar2(96)  ;
  l_PS_Number2          varchar2(96)  ;
  l_PS_summa            varchar2(96)  ;
  l_PS_Type             varchar2(32)  ;
  l_RahBank             varchar2(96)  ;
  l_RahBen              varchar2(96)  ;
  l_RahPl               varchar2(96)  ;
  l_RahPot              varchar2(96)  ;
  l_RahPotVal           varchar2(96)  ;
  l_RahVal              varchar2(96)  ;
  l_Rayon               varchar2(96)  ;
  l_Region              varchar2(96)  ;
  l_Street              varchar2(96)  ;
  l_SumKurs             varchar2(32)  ;
  l_Summa               varchar2(96)  ;
  l_SumProp             varchar2(254) ;
  l_SumVal              varchar2(96)  ;
  l_TelUp               varchar2(96)  ;

  l_NumKorrahBankBen    varchar2(96)  ;
  l_NameVidBankBen      varchar2(254) ;
  l_BikKodBankBen       varchar2(96)  ;
  l_NameBankKorBankBen  varchar2(254) ;
  l_INNBankBen          varchar2(96)  ;
  l_SWIFTKodBankBen     varchar2(96)  ;

begin

  ret_ := 0;

--bars_audit.info('KLPVAL: 0_0');

  commit;

  begin

    select namef
    into   l_namef
    from   tmp_klp_clob
    where  rownum=1;

--  bars_audit.info('KLPVAL: 0_1');
--  bars_audit.info('KLPVAL: '||l_namef||','||kod_);

    select namef,
           replace(replace(replace(c,chr(38),chr(38)||'amp;'),chr(38)||chr(38)||'amp;',chr(38)||'amp;'),chr(38)||'amp;amp;',chr(38)||'amp;')
    into   l_namef,
           l_clob
    from   tmp_klp_clob
    where  rownum=1;

--  bars_audit.info('KLPVAL: '||l_namef||','||kod_);

    l_xml := xmltype(l_clob);

--  bars_audit.info('KLPVAL: 0_2');

--  exception when OTHERS then
--    ret_ := 1;
--    goto fin;
  end;

  if    kod_=1 then -- покупка

    begin
      l_FIO1          := l_xml.extract('/ROOT/LocalParam/@FIO1'            ).getStringVal();
    exception when others then
      l_FIO1          := '';
    end;
    begin
      l_FIO2          := l_xml.extract('/ROOT/LocalParam/@FIO2'            ).getStringVal();
    exception when others then
      l_FIO2          := '';
    end;
    l_I_VA            := l_xml.extract('/ROOT/DOCBYRULE/DocData/@I_VA'     ).getStringVal();
    l_SumVal          := l_xml.extract('/ROOT/DOCBYRULE/DocData/@SumVal'   ).getStringVal();
    l_Kurs            := l_xml.extract('/ROOT/DOCBYRULE/DocData/@Kurs'     ).getStringVal();
    l_SumKurs         := l_xml.extract('/ROOT/DOCBYRULE/DocData/@SumKurs'  ).getStringVal();
    l_RahBank         := l_xml.extract('/ROOT/DOCBYRULE/DocData/@RahBank'  ).getStringVal();
    l_RahPot          := l_xml.extract('/ROOT/DOCBYRULE/DocData/@RahPot'   ).getStringVal();
    l_Komis           := l_xml.extract('/ROOT/DOCBYRULE/DocData/@Komis'    ).getStringVal();
    l_RahPotVal       := l_xml.extract('/ROOT/DOCBYRULE/DocData/@RahPotVal').getStringVal();
    l_PS_Number       := l_xml.extract('/ROOT/LocalParam/@PS_Number'       ).getStringVal();
    l_DateTimePicker1 := l_xml.extract('/ROOT/LocalParam/@DateTimePicker1' ).getStringVal();
    l_Name            := l_xml.extract('/ROOT/LocalParam/@Name'            ).getStringVal();
    l_PostInd         := l_xml.extract('/ROOT/LocalParam/@PostInd'         ).getStringVal();
    l_City            := l_xml.extract('/ROOT/LocalParam/@City'            ).getStringVal();
    l_Street          := l_xml.extract('/ROOT/LocalParam/@Street'          ).getStringVal();
    l_House           := l_xml.extract('/ROOT/LocalParam/@House'           ).getStringVal();
    l_Apartment       := l_xml.extract('/ROOT/LocalParam/@Apartment'       ).getStringVal();
    l_FonFax          := l_xml.extract('/ROOT/LocalParam/@FonFax'          ).getStringVal();
    l_Region          := l_xml.extract('/ROOT/LocalParam/@Region'          ).getStringVal();
    l_NameUp          := l_xml.extract('/ROOT/LocalParam/@NameUp'          ).getStringVal();
    l_TelUp           := l_xml.extract('/ROOT/LocalParam/@TelUp'           ).getStringVal();
    l_Pidstav         := l_xml.extract('/ROOT/LocalParam/@Pidstav'         ).getStringVal();

    begin
      insert
      into   klp_ZKUPP (I_VA           ,
                        SumVal         ,
                        Kurs           ,
                        SumKurs        ,
                        RahBank        ,
                        RahPot         ,
                        Komis          ,
                        RahPotVal      ,
                        FIO1           ,
                        FIO2           ,
                        PS_Number      ,
                        DateTimePicker1,
                        Name           ,
                        PostInd        ,
                        City           ,
                        Street         ,
                        House          ,
                        Apartment      ,
                        FonFax         ,
                        Region         ,
                        NameUp         ,
                        TelUp          ,
                        Pidstav        ,
                        namef          ,
                        fl)
                values (DBMS_XMLGEN.convert(DBMS_XMLGEN.convert(l_I_VA           ,1),1),
                        DBMS_XMLGEN.convert(DBMS_XMLGEN.convert(l_SumVal         ,1),1),
                        DBMS_XMLGEN.convert(DBMS_XMLGEN.convert(l_Kurs           ,1),1),
                        DBMS_XMLGEN.convert(DBMS_XMLGEN.convert(l_SumKurs        ,1),1),
                        DBMS_XMLGEN.convert(DBMS_XMLGEN.convert(l_RahBank        ,1),1),
                        DBMS_XMLGEN.convert(DBMS_XMLGEN.convert(l_RahPot         ,1),1),
                        DBMS_XMLGEN.convert(DBMS_XMLGEN.convert(l_Komis          ,1),1),
                        DBMS_XMLGEN.convert(DBMS_XMLGEN.convert(l_RahPotVal      ,1),1),
                        DBMS_XMLGEN.convert(DBMS_XMLGEN.convert(l_FIO1           ,1),1),
                        DBMS_XMLGEN.convert(DBMS_XMLGEN.convert(l_FIO2           ,1),1),
                        DBMS_XMLGEN.convert(DBMS_XMLGEN.convert(l_PS_Number      ,1),1),
                        DBMS_XMLGEN.convert(DBMS_XMLGEN.convert(l_DateTimePicker1,1),1),
                        DBMS_XMLGEN.convert(DBMS_XMLGEN.convert(l_Name           ,1),1),
                        DBMS_XMLGEN.convert(DBMS_XMLGEN.convert(l_PostInd        ,1),1),
                        DBMS_XMLGEN.convert(DBMS_XMLGEN.convert(l_City           ,1),1),
                        DBMS_XMLGEN.convert(DBMS_XMLGEN.convert(l_Street         ,1),1),
                        DBMS_XMLGEN.convert(DBMS_XMLGEN.convert(l_House          ,1),1),
                        DBMS_XMLGEN.convert(DBMS_XMLGEN.convert(l_Apartment      ,1),1),
                        DBMS_XMLGEN.convert(DBMS_XMLGEN.convert(l_FonFax         ,1),1),
                        DBMS_XMLGEN.convert(DBMS_XMLGEN.convert(l_Region         ,1),1),
                        DBMS_XMLGEN.convert(DBMS_XMLGEN.convert(l_NameUp         ,1),1),
                        DBMS_XMLGEN.convert(DBMS_XMLGEN.convert(l_TelUp          ,1),1),
                        DBMS_XMLGEN.convert(DBMS_XMLGEN.convert(l_Pidstav        ,1),1),
                        l_namef                                                        ,
                        0);
      ret_ := 0;
    exception when OTHERS then
      ret_ := 1;
    end;

  elsif kod_=2 then -- продажа

    begin
      l_FIO1          := l_xml.extract('/ROOT/LocalParam/@FIO1'            ).getStringVal();
    exception when others then
      l_FIO1          := '';
    end;
    begin
      l_FIO2          := l_xml.extract('/ROOT/LocalParam/@FIO2'            ).getStringVal();
    exception when others then
      l_FIO2          := '';
    end;
    l_I_VA            := l_xml.extract('/ROOT/DOCBYRULE/DocData/@I_VA'     ).getStringVal();
    l_SumVal          := l_xml.extract('/ROOT/DOCBYRULE/DocData/@SumVal'   ).getStringVal();
    l_Kurs            := l_xml.extract('/ROOT/DOCBYRULE/DocData/@Kurs'     ).getStringVal();
    l_SumKurs         := l_xml.extract('/ROOT/DOCBYRULE/DocData/@SumKurs'  ).getStringVal();
    l_RahBank         := l_xml.extract('/ROOT/DOCBYRULE/DocData/@RahBank'  ).getStringVal();
    l_RahPot          := l_xml.extract('/ROOT/DOCBYRULE/DocData/@RahPot'   ).getStringVal();
    l_Komis           := l_xml.extract('/ROOT/DOCBYRULE/DocData/@Komis'    ).getStringVal();
    l_RahPotVal       := l_xml.extract('/ROOT/DOCBYRULE/DocData/@RahPotVal').getStringVal();
    l_RahVal          := l_xml.extract('/ROOT/DOCBYRULE/DocData/@RahVal'   ).getStringVal();
    l_PS_Number       := l_xml.extract('/ROOT/LocalParam/@PS_Number'       ).getStringVal();
    l_DateTimePicker1 := l_xml.extract('/ROOT/LocalParam/@DateTimePicker1' ).getStringVal();
    l_Name            := l_xml.extract('/ROOT/LocalParam/@Name'            ).getStringVal();
    l_PostInd         := l_xml.extract('/ROOT/LocalParam/@PostInd'         ).getStringVal();
    l_Rayon           := l_xml.extract('/ROOT/LocalParam/@Rayon'           ).getStringVal();
    l_City            := l_xml.extract('/ROOT/LocalParam/@City'            ).getStringVal();
    l_Street          := l_xml.extract('/ROOT/LocalParam/@Street'          ).getStringVal();
    l_House           := l_xml.extract('/ROOT/LocalParam/@House'           ).getStringVal();
    l_Apartment       := l_xml.extract('/ROOT/LocalParam/@Apartment'       ).getStringVal();
    l_FonFax          := l_xml.extract('/ROOT/LocalParam/@FonFax'          ).getStringVal();
    l_Region          := l_xml.extract('/ROOT/LocalParam/@Region'          ).getStringVal();
    l_NameUp          := l_xml.extract('/ROOT/LocalParam/@NameUp'          ).getStringVal();
    l_TelUp           := l_xml.extract('/ROOT/LocalParam/@TelUp'           ).getStringVal();

    begin
      insert
      into   klp_ZPROD (FIO1           ,
                        FIO2           ,
                        I_VA           ,
                        SumVal         ,
                        Kurs           ,
                        SumKurs        ,
                        RahBank        ,
                        RahPot         ,
                        Komis          ,
                        RahPotVal      ,
                        RahVal         ,
                        PS_Number      ,
                        DateTimePicker1,
                        Name           ,
                        PostInd        ,
                        Rayon          ,
                        City           ,
                        Street         ,
                        House          ,
                        Apartment      ,
                        FonFax         ,
                        Region         ,
                        NameUp         ,
                        TelUp          ,
                        namef          ,
                        fl)
                values (DBMS_XMLGEN.convert(DBMS_XMLGEN.convert(l_FIO1           ,1),1),
                        DBMS_XMLGEN.convert(DBMS_XMLGEN.convert(l_FIO2           ,1),1),
                        DBMS_XMLGEN.convert(DBMS_XMLGEN.convert(l_I_VA           ,1),1),
                        DBMS_XMLGEN.convert(DBMS_XMLGEN.convert(l_SumVal         ,1),1),
                        DBMS_XMLGEN.convert(DBMS_XMLGEN.convert(l_Kurs           ,1),1),
                        DBMS_XMLGEN.convert(DBMS_XMLGEN.convert(l_SumKurs        ,1),1),
                        DBMS_XMLGEN.convert(DBMS_XMLGEN.convert(l_RahBank        ,1),1),
                        DBMS_XMLGEN.convert(DBMS_XMLGEN.convert(l_RahPot         ,1),1),
                        DBMS_XMLGEN.convert(DBMS_XMLGEN.convert(l_Komis          ,1),1),
                        DBMS_XMLGEN.convert(DBMS_XMLGEN.convert(l_RahPotVal      ,1),1),
                        DBMS_XMLGEN.convert(DBMS_XMLGEN.convert(l_RahVal         ,1),1),
                        DBMS_XMLGEN.convert(DBMS_XMLGEN.convert(l_PS_Number      ,1),1),
                        DBMS_XMLGEN.convert(DBMS_XMLGEN.convert(l_DateTimePicker1,1),1),
                        DBMS_XMLGEN.convert(DBMS_XMLGEN.convert(l_Name           ,1),1),
                        DBMS_XMLGEN.convert(DBMS_XMLGEN.convert(l_PostInd        ,1),1),
                        DBMS_XMLGEN.convert(DBMS_XMLGEN.convert(l_Rayon          ,1),1),
                        DBMS_XMLGEN.convert(DBMS_XMLGEN.convert(l_City           ,1),1),
                        DBMS_XMLGEN.convert(DBMS_XMLGEN.convert(l_Street         ,1),1),
                        DBMS_XMLGEN.convert(DBMS_XMLGEN.convert(l_House          ,1),1),
                        DBMS_XMLGEN.convert(DBMS_XMLGEN.convert(l_Apartment      ,1),1),
                        DBMS_XMLGEN.convert(DBMS_XMLGEN.convert(l_FonFax         ,1),1),
                        DBMS_XMLGEN.convert(DBMS_XMLGEN.convert(l_Region         ,1),1),
                        DBMS_XMLGEN.convert(DBMS_XMLGEN.convert(l_NameUp         ,1),1),
                        DBMS_XMLGEN.convert(DBMS_XMLGEN.convert(l_TelUp          ,1),1),
                        l_namef                                                        ,
                        0);
      ret_ := 0;
    exception when OTHERS then
      ret_ := 1;
    end;

  elsif kod_=3 then -- конверсия

    begin
      l_FIO1          := l_xml.extract('/ROOT/LocalParam/@FIO1'            ).getStringVal();
    exception when others then
      l_FIO1          := '';
    end;
    begin
      l_FIO2          := l_xml.extract('/ROOT/LocalParam/@FIO2'            ).getStringVal();
    exception when others then
      l_FIO2          := '';
    end;
    l_I_VA            := l_xml.extract('/ROOT/DOCBYRULE/DocData/@I_VA'     ).getStringVal();
    l_SumVal          := l_xml.extract('/ROOT/DOCBYRULE/DocData/@SumVal'   ).getStringVal();
    l_Kurs            := l_xml.extract('/ROOT/DOCBYRULE/DocData/@Kurs'     ).getStringVal();
    l_SumKurs         := l_xml.extract('/ROOT/DOCBYRULE/DocData/@SumKurs'  ).getStringVal();
    l_RahBank         := l_xml.extract('/ROOT/DOCBYRULE/DocData/@RahBank'  ).getStringVal();
    l_RahPot          := l_xml.extract('/ROOT/DOCBYRULE/DocData/@RahPot'   ).getStringVal();
    l_Komis           := l_xml.extract('/ROOT/DOCBYRULE/DocData/@Komis'    ).getStringVal();
    l_RahPotVal       := l_xml.extract('/ROOT/DOCBYRULE/DocData/@RahPotVal').getStringVal();
    l_I_VA_Prod       := l_xml.extract('/ROOT/DOCBYRULE/DocData/@I_VA_Prod').getStringVal();
    l_PS_Number       := l_xml.extract('/ROOT/LocalParam/@PS_Number'       ).getStringVal();
    l_DateTimePicker1 := l_xml.extract('/ROOT/LocalParam/@DateTimePicker1' ).getStringVal();
    l_Name            := l_xml.extract('/ROOT/LocalParam/@Name'            ).getStringVal();
    l_PostInd         := l_xml.extract('/ROOT/LocalParam/@PostInd'         ).getStringVal();
    l_Rayon           := l_xml.extract('/ROOT/LocalParam/@Rayon'           ).getStringVal();
    l_City            := l_xml.extract('/ROOT/LocalParam/@City'            ).getStringVal();
    l_Street          := l_xml.extract('/ROOT/LocalParam/@Street'          ).getStringVal();
    l_House           := l_xml.extract('/ROOT/LocalParam/@House'           ).getStringVal();
    l_Apartment       := l_xml.extract('/ROOT/LocalParam/@Apartment'       ).getStringVal();
    l_FonFax          := l_xml.extract('/ROOT/LocalParam/@FonFax'          ).getStringVal();
    l_Region          := l_xml.extract('/ROOT/LocalParam/@Region'          ).getStringVal();
    l_NameUp          := l_xml.extract('/ROOT/LocalParam/@NameUp'          ).getStringVal();
    l_TelUp           := l_xml.extract('/ROOT/LocalParam/@TelUp'           ).getStringVal();
    l_Pidstav         := l_xml.extract('/ROOT/LocalParam/@Pidstav'         ).getStringVal();

    begin
      insert
      into   klp_ZCONV (FIO1           ,
                        FIO2           ,
                        I_VA           ,
                        SumVal         ,
                        Kurs           ,
                        SumKurs        ,
                        RahBank        ,
                        RahPot         ,
                        Komis          ,
                        RahPotVal      ,
                        I_VA_Prod      ,
                        PS_Number      ,
                        DateTimePicker1,
                        Name           ,
                        PostInd        ,
                        Rayon          ,
                        City           ,
                        Street         ,
                        House          ,
                        Apartment      ,
                        FonFax         ,
                        Region         ,
                        NameUp         ,
                        TelUp          ,
                        Pidstav        ,
                        namef          ,
                        fl)
                values (DBMS_XMLGEN.convert(DBMS_XMLGEN.convert(l_FIO1           ,1),1),
                        DBMS_XMLGEN.convert(DBMS_XMLGEN.convert(l_FIO2           ,1),1),
                        DBMS_XMLGEN.convert(DBMS_XMLGEN.convert(l_I_VA           ,1),1),
                        DBMS_XMLGEN.convert(DBMS_XMLGEN.convert(l_SumVal         ,1),1),
                        DBMS_XMLGEN.convert(DBMS_XMLGEN.convert(l_Kurs           ,1),1),
                        DBMS_XMLGEN.convert(DBMS_XMLGEN.convert(l_SumKurs        ,1),1),
                        DBMS_XMLGEN.convert(DBMS_XMLGEN.convert(l_RahBank        ,1),1),
                        DBMS_XMLGEN.convert(DBMS_XMLGEN.convert(l_RahPot         ,1),1),
                        DBMS_XMLGEN.convert(DBMS_XMLGEN.convert(l_Komis          ,1),1),
                        DBMS_XMLGEN.convert(DBMS_XMLGEN.convert(l_RahPotVal      ,1),1),
                        DBMS_XMLGEN.convert(DBMS_XMLGEN.convert(l_I_VA_Prod      ,1),1),
                        DBMS_XMLGEN.convert(DBMS_XMLGEN.convert(l_PS_Number      ,1),1),
                        DBMS_XMLGEN.convert(DBMS_XMLGEN.convert(l_DateTimePicker1,1),1),
                        DBMS_XMLGEN.convert(DBMS_XMLGEN.convert(l_Name           ,1),1),
                        DBMS_XMLGEN.convert(DBMS_XMLGEN.convert(l_PostInd        ,1),1),
                        DBMS_XMLGEN.convert(DBMS_XMLGEN.convert(l_Rayon          ,1),1),
                        DBMS_XMLGEN.convert(DBMS_XMLGEN.convert(l_City           ,1),1),
                        DBMS_XMLGEN.convert(DBMS_XMLGEN.convert(l_Street         ,1),1),
                        DBMS_XMLGEN.convert(DBMS_XMLGEN.convert(l_House          ,1),1),
                        DBMS_XMLGEN.convert(DBMS_XMLGEN.convert(l_Apartment      ,1),1),
                        DBMS_XMLGEN.convert(DBMS_XMLGEN.convert(l_FonFax         ,1),1),
                        DBMS_XMLGEN.convert(DBMS_XMLGEN.convert(l_Region         ,1),1),
                        DBMS_XMLGEN.convert(DBMS_XMLGEN.convert(l_NameUp         ,1),1),
                        DBMS_XMLGEN.convert(DBMS_XMLGEN.convert(l_TelUp          ,1),1),
                        DBMS_XMLGEN.convert(DBMS_XMLGEN.convert(l_Pidstav        ,1),1),
                        l_namef                                                        ,
                        0);
      ret_ := 0;
    exception when OTHERS then
      ret_ := 1;
    end;

  elsif kod_=4 then -- SWIFT

--  bars_audit.info('KLPVAL: 4_1');

    begin
      l_FIO1             := l_xml.extract('/ROOT/LocalParam/@FIO1'              ).getStringVal();
    exception when others then
      l_FIO1             := '';
    end;
    begin
      l_FIO2             := l_xml.extract('/ROOT/LocalParam/@FIO2'              ).getStringVal();
    exception when others then
      l_FIO2             := '';
    end;
    l_PS_Number          := l_xml.extract('/ROOT/LocalParam/@PS_Number'         ).getStringVal();
    l_DateTimePicker1    := l_xml.extract('/ROOT/LocalParam/@DateTimePicker1'   ).getStringVal();
    l_NameBankPl         := l_xml.extract('/ROOT/LocalParam/@NameBankPl'        ).getStringVal();
    l_AdresBankPl        := l_xml.extract('/ROOT/LocalParam/@AdresBankPl'       ).getStringVal();
    l_NamePl             := l_xml.extract('/ROOT/LocalParam/@NamePl'            ).getStringVal();
    l_AdresPl            := l_xml.extract('/ROOT/LocalParam/@AdresPl'           ).getStringVal();
    l_RahPl              := l_xml.extract('/ROOT/LocalParam/@RahPl'             ).getStringVal();
    l_I_VA               := l_xml.extract('/ROOT/LocalParam/@I_VA'              ).getStringVal();
    l_Summa              := l_xml.extract('/ROOT/LocalParam/@Summa'             ).getStringVal();
    l_SumProp            := l_xml.extract('/ROOT/LocalParam/@SumProp'           ).getStringVal();
    l_NameBen            := l_xml.extract('/ROOT/LocalParam/@NameBen'           ).getStringVal();
    l_AdresBen           := l_xml.extract('/ROOT/LocalParam/@AdresBen'          ).getStringVal();
    l_RahBen             := l_xml.extract('/ROOT/LocalParam/@RahBen'            ).getStringVal();
    l_NameBankBen        := l_xml.extract('/ROOT/LocalParam/@NameBankBen'       ).getStringVal();
    l_AdresBankBen       := l_xml.extract('/ROOT/LocalParam/@AdresBankBen'      ).getStringVal();
    l_NaznPlat           := l_xml.extract('/ROOT/LocalParam/@NaznPlat'          ).getStringVal();
    l_NDS                := l_xml.extract('/ROOT/LocalParam/@NDS'               ).getStringVal();
    l_OkpoPl             := l_xml.extract('/ROOT/LocalParam/@OkpoPl'            ).getStringVal();
    l_KodOp              := l_xml.extract('/ROOT/LocalParam/@KodOp'             ).getStringVal();
    l_KodStrBen          := l_xml.extract('/ROOT/LocalParam/@KodStrBen'         ).getStringVal();
    l_KodBankPl          := l_xml.extract('/ROOT/LocalParam/@KodBankPl'         ).getStringVal();
    l_BankPosr           := l_xml.extract('/ROOT/LocalParam/@BankPosr'          ).getStringVal();
    l_KodBankBen         := l_xml.extract('/ROOT/LocalParam/@KodBankBen'        ).getStringVal();
    l_IbanBen            := l_xml.extract('/ROOT/LocalParam/@IbanBen'           ).getStringVal();
    l_CheckBox1          := l_xml.extract('/ROOT/LocalParam/@CheckBox1'         ).getStringVal();
    l_CheckBox2          := l_xml.extract('/ROOT/LocalParam/@CheckBox2'         ).getStringVal();
    l_CheckBox3          := l_xml.extract('/ROOT/LocalParam/@CheckBox3'         ).getStringVal();
    l_CheckBox4          := l_xml.extract('/ROOT/LocalParam/@CheckBox4'         ).getStringVal();
    l_CheckBox5          := l_xml.extract('/ROOT/LocalParam/@CheckBox5'         ).getStringVal();
    l_CheckBox6          := l_xml.extract('/ROOT/LocalParam/@CheckBox6'         ).getStringVal();
    l_BIK                := l_xml.extract('/ROOT/LocalParam/@BIK'               ).getStringVal();
    l_NKorR              := l_xml.extract('/ROOT/LocalParam/@NKorR'             ).getStringVal();
    l_NameBankKor        := l_xml.extract('/ROOT/LocalParam/@NameBankKor'       ).getStringVal();
    l_NameVidBank        := l_xml.extract('/ROOT/LocalParam/@NameVidBank'       ).getStringVal();
    l_INNBank            := l_xml.extract('/ROOT/LocalParam/@INNBank'           ).getStringVal();
    begin
      l_NumKorrahBankBen   := l_xml.extract('/ROOT/LocalParam/@NumKorrahBankBen'  ).getStringVal();
    exception when others then
      l_NumKorrahBankBen   := null;
    end;
    begin
      l_NameVidBankBen     := l_xml.extract('/ROOT/LocalParam/@NameVidBankBen'    ).getStringVal();
    exception when others then
      l_NameVidBankBen     := null;
    end;
    begin
      l_BikKodBankBen      := l_xml.extract('/ROOT/LocalParam/@BikKodBankBen'     ).getStringVal();
    exception when others then
      l_BikKodBankBen      := null;
    end;
    begin
      l_NameBankKorBankBen := l_xml.extract('/ROOT/LocalParam/@NameBankKorBankBen').getStringVal();
    exception when others then
      l_NameBankKorBankBen := null;
    end;
    begin
      l_INNBankBen         := l_xml.extract('/ROOT/LocalParam/@INNBankBen'        ).getStringVal();
    exception when others then
      l_INNBankBen         := null;
    end;
    begin
      l_SWIFTKodBankBen    := l_xml.extract('/ROOT/LocalParam/@SWIFTKodBankBen'   ).getStringVal();
    exception when others then
      l_SWIFTKodBankBen    := null;
    end;

--  bars_audit.info('KLPVAL: 4_2');

    begin
      insert
      into   klp_SWIFT (FIO1              ,
                        FIO2              ,
                        PS_Number         ,
                        DateTimePicker1   ,
                        NameBankPl        ,
                        AdresBankPl       ,
                        NamePl            ,
                        AdresPl           ,
                        RahPl             ,
                        I_VA              ,
                        Summa             ,
                        SumProp           ,
                        NameBen           ,
                        AdresBen          ,
                        RahBen            ,
                        NameBankBen       ,
                        AdresBankBen      ,
                        NaznPlat          ,
                        NDS               ,
                        OkpoPl            ,
                        KodOp             ,
                        KodStrBen         ,
                        KodBankPl         ,
                        BankPosr          ,
                        KodBankBen        ,
                        IbanBen           ,
                        CheckBox1         ,
                        CheckBox2         ,
                        CheckBox3         ,
                        CheckBox4         ,
                        CheckBox5         ,
                        CheckBox6         ,
                        BIK               ,
                        NKorR             ,
                        NameBankKor       ,
                        NameVidBank       ,
                        INNBank           ,
                        NumKorrahBankBen  ,
                        NameVidBankBen    ,
                        BikKodBankBen     ,
                        NameBankKorBankBen,
                        INNBankBen        ,
                        SWIFTKodBankBen   ,
                        namef             ,
                        fl)
                values (DBMS_XMLGEN.convert(DBMS_XMLGEN.convert(l_FIO1              ,1),1),
                        DBMS_XMLGEN.convert(DBMS_XMLGEN.convert(l_FIO2              ,1),1),
                        DBMS_XMLGEN.convert(DBMS_XMLGEN.convert(l_PS_Number         ,1),1),
                        DBMS_XMLGEN.convert(DBMS_XMLGEN.convert(l_DateTimePicker1   ,1),1),
                        DBMS_XMLGEN.convert(DBMS_XMLGEN.convert(l_NameBankPl        ,1),1),
                        DBMS_XMLGEN.convert(DBMS_XMLGEN.convert(l_AdresBankPl       ,1),1),
                        DBMS_XMLGEN.convert(DBMS_XMLGEN.convert(l_NamePl            ,1),1),
                        DBMS_XMLGEN.convert(DBMS_XMLGEN.convert(l_AdresPl           ,1),1),
                        DBMS_XMLGEN.convert(DBMS_XMLGEN.convert(l_RahPl             ,1),1),
                        DBMS_XMLGEN.convert(DBMS_XMLGEN.convert(l_I_VA              ,1),1),
                        DBMS_XMLGEN.convert(DBMS_XMLGEN.convert(l_Summa             ,1),1),
                        DBMS_XMLGEN.convert(DBMS_XMLGEN.convert(l_SumProp           ,1),1),
                        DBMS_XMLGEN.convert(DBMS_XMLGEN.convert(l_NameBen           ,1),1),
                        DBMS_XMLGEN.convert(DBMS_XMLGEN.convert(l_AdresBen          ,1),1),
                        DBMS_XMLGEN.convert(DBMS_XMLGEN.convert(l_RahBen            ,1),1),
                        DBMS_XMLGEN.convert(DBMS_XMLGEN.convert(l_NameBankBen       ,1),1),
                        DBMS_XMLGEN.convert(DBMS_XMLGEN.convert(l_AdresBankBen      ,1),1),
                        DBMS_XMLGEN.convert(DBMS_XMLGEN.convert(l_NaznPlat          ,1),1),
                        DBMS_XMLGEN.convert(DBMS_XMLGEN.convert(l_NDS               ,1),1),
                        DBMS_XMLGEN.convert(DBMS_XMLGEN.convert(l_OkpoPl            ,1),1),
                        DBMS_XMLGEN.convert(DBMS_XMLGEN.convert(l_KodOp             ,1),1),
                        DBMS_XMLGEN.convert(DBMS_XMLGEN.convert(l_KodStrBen         ,1),1),
                        DBMS_XMLGEN.convert(DBMS_XMLGEN.convert(l_KodBankPl         ,1),1),
                        DBMS_XMLGEN.convert(DBMS_XMLGEN.convert(l_BankPosr          ,1),1),
                        DBMS_XMLGEN.convert(DBMS_XMLGEN.convert(l_KodBankBen        ,1),1),
                        DBMS_XMLGEN.convert(DBMS_XMLGEN.convert(l_IbanBen           ,1),1),
                        replace(replace(l_CheckBox1,'True','x'),'False','')               ,
                        replace(replace(l_CheckBox2,'True','x'),'False','')               ,
                        replace(replace(l_CheckBox3,'True','x'),'False','')               ,
                        replace(replace(l_CheckBox4,'True','x'),'False','')               ,
                        replace(replace(l_CheckBox5,'True','x'),'False','')               ,
                        replace(replace(l_CheckBox6,'True','x'),'False','')               ,
                        DBMS_XMLGEN.convert(DBMS_XMLGEN.convert(l_BIK               ,1),1),
                        DBMS_XMLGEN.convert(DBMS_XMLGEN.convert(l_NKorR             ,1),1),
                        DBMS_XMLGEN.convert(DBMS_XMLGEN.convert(l_NameBankKor       ,1),1),
                        DBMS_XMLGEN.convert(DBMS_XMLGEN.convert(l_NameVidBank       ,1),1),
                        DBMS_XMLGEN.convert(DBMS_XMLGEN.convert(l_INNBank           ,1),1),
                        DBMS_XMLGEN.convert(DBMS_XMLGEN.convert(l_NumKorrahBankBen  ,1),1),
                        DBMS_XMLGEN.convert(DBMS_XMLGEN.convert(l_NameVidBankBen    ,1),1),
                        DBMS_XMLGEN.convert(DBMS_XMLGEN.convert(l_BikKodBankBen     ,1),1),
                        DBMS_XMLGEN.convert(DBMS_XMLGEN.convert(l_NameBankKorBankBen,1),1),
                        DBMS_XMLGEN.convert(DBMS_XMLGEN.convert(l_INNBankBen        ,1),1),
                        DBMS_XMLGEN.convert(DBMS_XMLGEN.convert(l_SWIFTKodBankBen   ,1),1),
                        l_namef                                                           ,
                        0);
      ret_ := 0;
    exception when OTHERS then
      ret_ := 1;
    end;

  elsif kod_=5 then -- отмена

    begin
      l_FIO1     := l_xml.extract('/ROOT/LocalParam/@FIO1'      ).getStringVal();
    exception when others then
      l_FIO1     := '';
    end;
    begin
      l_FIO2     := l_xml.extract('/ROOT/LocalParam/@FIO2'      ).getStringVal();
    exception when others then
      l_FIO2     := '';
    end;
    l_PS_Number1 := l_xml.extract('/ROOT/LocalParam/@PS_Number1').getStringVal();
    l_PS_Number2 := l_xml.extract('/ROOT/LocalParam/@PS_Number2').getStringVal();
    l_PS_Date    := l_xml.extract('/ROOT/LocalParam/@PS_Date'   ).getStringVal();
    l_PS_Type    := l_xml.extract('/ROOT/LocalParam/@PS_Type'   ).getStringVal();
    l_PS_summa   := l_xml.extract('/ROOT/LocalParam/@PS_summa'  ).getStringVal();

    begin
      insert
      into   klp_ZVIDM (FIO1      ,
                        FIO2      ,
                        PS_Number1,
                        PS_Number2,
                        PS_Date   ,
                        PS_Type   ,
                        PS_summa  ,
                        namef     ,
                        fl)
                values (DBMS_XMLGEN.convert(DBMS_XMLGEN.convert(l_FIO1      ,1),1),
                        DBMS_XMLGEN.convert(DBMS_XMLGEN.convert(l_FIO2      ,1),1),
                        DBMS_XMLGEN.convert(DBMS_XMLGEN.convert(l_PS_Number1,1),1),
                        DBMS_XMLGEN.convert(DBMS_XMLGEN.convert(l_PS_Number2,1),1),
                        DBMS_XMLGEN.convert(DBMS_XMLGEN.convert(l_PS_Date   ,1),1),
                        DBMS_XMLGEN.convert(DBMS_XMLGEN.convert(l_PS_Type   ,1),1),
                        DBMS_XMLGEN.convert(DBMS_XMLGEN.convert(l_PS_summa  ,1),1),
                        l_namef                                                   ,
                        0);
      ret_ := 0;
    exception when OTHERS then
      ret_ := 1;
    end;

  end if;

<<fin>> null;

end p_klpval;
/
show err;

PROMPT *** Create  grants  P_KLPVAL ***
grant EXECUTE                                                                on P_KLPVAL        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_KLPVAL        to TECH_MOM1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_KLPVAL.sql =========*** End *** 
PROMPT ===================================================================================== 
