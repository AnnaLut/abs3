begin
  
  begin
   execute immediate 'CREATE TABLE tmp_recovery2620_220218 AS
  (select a.acc, a.nls, a.kf, 
   ''                                                                                                                                                                                                                 '' note
   from bars.accounts a
   where 1 = 0)';

  exception
  when OTHERS then 
    
    if (sqlcode = -00955) then 
      dbms_output.put_line('Table already exists.');
      execute immediate 'truncate table tmp_recovery2620_220218';      
    else raise;
    end if; 
  end;
  
   
  insert into tmp_recovery2620_220218 
  select x.acc, x.nls, x.kf, '---' from (
select 261487602 acc, '26208043199111' nls, '324805' kf, 35405602 rnk from dual union all
select 261910502 acc, '26207043222711' nls, '324805' kf, 121187902 rnk from dual union all
select 261311502 acc, '26204043189211' nls, '324805' kf, 5330102 rnk from dual union all
select 261497402 acc, '26204043202411' nls, '324805' kf, 121171102 rnk from dual union all
select 260388202 acc, '26200042978911' nls, '324805' kf, 120848502 rnk from dual union all
select 304139302 acc, '26205058041611' nls, '324805' kf, 4874302 rnk from dual union all
select 259584002 acc, '26208042717011' nls, '324805' kf, 72569902 rnk from dual union all
select 259529202 acc, '26206042704811' nls, '324805' kf, 1224402 rnk from dual union all
select 258523002 acc, '26206042345311' nls, '324805' kf, 31531702 rnk from dual union all
select 258102402 acc, '26206042177211' nls, '324805' kf, 2484702 rnk from dual union all
select 259159702 acc, '26207042539911' nls, '324805' kf, 13976302 rnk from dual union all
select 255657802 acc, '26203041290211' nls, '324805' kf, 5271502 rnk from dual union all
select 251916002 acc, '26204039627011' nls, '324805' kf, 2141402 rnk from dual union all
select 248894202 acc, '26209038800511' nls, '324805' kf, 3626002 rnk from dual union all
select 251130402 acc, '26205039394611' nls, '324805' kf, 368902 rnk from dual union all
select 245378702 acc, '26200038320711' nls, '324805' kf, 116014202 rnk from dual union all
select 250366202 acc, '26200039213311' nls, '324805' kf, 6039002 rnk from dual union all
select 245210902 acc, '26201038307711' nls, '324805' kf, 42739602 rnk from dual union all
select 244399602 acc, '26205038177011' nls, '324805' kf, 1267902 rnk from dual union all
select 243821702 acc, '26208038135511' nls, '324805' kf, 115795702 rnk from dual union all
select 244327402 acc, '26200038171711' nls, '324805' kf, 4138502 rnk from dual union all
select 244411102 acc, '26204038178011' nls, '324805' kf, 1889102 rnk from dual union all
select 242687402 acc, '26204038019211' nls, '324805' kf, 115442802 rnk from dual union all
select 242736902 acc, '26206038026611' nls, '324805' kf, 1448002 rnk from dual union all
select 237990102 acc, '26200035688111' nls, '324805' kf, 69390602 rnk from dual union all
select 237997102 acc, '26203035690311' nls, '324805' kf, 112656102 rnk from dual union all
select 74919702 acc, '26201000197045' nls, '324805' kf, 2649902 rnk from dual union all
select 304010802 acc, '26203057998411' nls, '324805' kf, 41315402 rnk from dual union all
select 304073202 acc, '26203058020311' nls, '324805' kf, 74430702 rnk from dual union all
select 307193002 acc, '26201058745911' nls, '324805' kf, 120888502 rnk from dual union all
select 305223802 acc, '26200058361211' nls, '324805' kf, 74894002 rnk from dual union all
select 306475302 acc, '26201058600711' nls, '324805' kf, 134857702 rnk from dual union all
select 304993302 acc, '26207058306611' nls, '324805' kf, 4603902 rnk from dual union all
select 304355902 acc, '26201058123511' nls, '324805' kf, 29667902 rnk from dual union all
select 303287302 acc, '26201057884011' nls, '324805' kf, 4379802 rnk from dual union all
select 302231902 acc, '26206057598711' nls, '324805' kf, 50668902 rnk from dual union all
select 303300502 acc, '26200057888911' nls, '324805' kf, 70896302 rnk from dual union all
select 301301102 acc, '26204057442911' nls, '324805' kf, 133765202 rnk from dual union all
select 300598902 acc, '26201057163011' nls, '324805' kf, 133529702 rnk from dual union all
select 299694602 acc, '26200056866611' nls, '324805' kf, 133249902 rnk from dual union all
select 299535202 acc, '26200056833611' nls, '324805' kf, 74497502 rnk from dual union all
select 296374802 acc, '26205055894311' nls, '324805' kf, 132444202 rnk from dual union all
select 287783402 acc, '26206052683911' nls, '324805' kf, 22158902 rnk from dual union all
select 286952902 acc, '26209052450011' nls, '324805' kf, 56235702 rnk from dual union all
select 209311902 acc, '26205026350011' nls, '324805' kf, 60028202 rnk from dual union all
select 227340002 acc, '26204031703911' nls, '324805' kf, 107866102 rnk from dual union all
select 297663002 acc, '26208056486811' nls, '324805' kf, 132919002 rnk from dual union all
select 296375802 acc, '26203055894711' nls, '324805' kf, 30532602 rnk from dual union all
select 286218402 acc, '26209052093111' nls, '324805' kf, 128928202 rnk from dual union all
select 294139802 acc, '26206055070811' nls, '324805' kf, 131691802 rnk from dual union all
select 294189702 acc, '26203055082211' nls, '324805' kf, 131704902 rnk from dual union all
select 294190802 acc, '26201055082611' nls, '324805' kf, 131705002 rnk from dual union all
select 294204902 acc, '26209055087511' nls, '324805' kf, 131709602 rnk from dual union all
select 293611602 acc, '26206054857411' nls, '324805' kf, 131464902 rnk from dual union all
select 293629502 acc, '26208054863511' nls, '324805' kf, 131472702 rnk from dual union all
select 291102102 acc, '26204053729111' nls, '324805' kf, 130470102 rnk from dual union all
select 209314702 acc, '26202026351411' nls, '324805' kf, 76096302 rnk from dual union all
select 204201902 acc, '26209025316911' nls, '324805' kf, 58912002 rnk from dual union all
select 277635002 acc, '26204049063911' nls, '324805' kf, 1326902 rnk from dual union all
select 277188402 acc, '26208048841011' nls, '324805' kf, 9407802 rnk from dual union all
select 276176402 acc, '26201048399311' nls, '324805' kf, 13538202 rnk from dual union all
select 277005202 acc, '26208048749511' nls, '324805' kf, 3688802 rnk from dual union all
select 199554002 acc, '26204024035511' nls, '324805' kf, 24922302 rnk from dual union all
select 270976702 acc, '26201046208211' nls, '324805' kf, 123915802 rnk from dual union all
select 270571502 acc, '26209046047311' nls, '324805' kf, 4982302 rnk from dual union all
select 270557002 acc, '26208046042511' nls, '324805' kf, 30787302 rnk from dual union all
select 267358802 acc, '26203045160411' nls, '324805' kf, 37356702 rnk from dual union all
select 266370502 acc, '26204044799611' nls, '324805' kf, 122743202 rnk from dual union all
select 266836902 acc, '26200044978511' nls, '324805' kf, 13594402 rnk from dual union all
select 266079502 acc, '26201044772211' nls, '324805' kf, 3634302 rnk from dual union all
select 326993706 acc, '26206033952004' nls, '335106' kf, 156568706 rnk from dual union all
select 372398906 acc, '26206051964104' nls, '335106' kf, 45273806 rnk from dual union all
select 384722806 acc, '26208057695204' nls, '335106' kf, 97999106 rnk from dual union all
select 384687206 acc, '26205057689804' nls, '335106' kf, 29708406 rnk from dual union all
select 401777706 acc, '26209065796804' nls, '335106' kf, 183400606 rnk from dual union all
select 281147002 acc, '26207050267811' nls, '324805' kf, 28844502 rnk from dual union all
select 279270102 acc, '26209049697111' nls, '324805' kf, 3933802 rnk from dual union all
select 276080702 acc, '26209048351511' nls, '324805' kf, 5070802 rnk from dual union all
select 278511702 acc, '26200049438711' nls, '324805' kf, 40093102 rnk from dual union all
select 271506002 acc, '26208046362611' nls, '324805' kf, 45424702 rnk from dual union all
select 271124202 acc, '26202046246711' nls, '324805' kf, 19294802 rnk from dual union all
select 269002102 acc, '26205045671511' nls, '324805' kf, 1372702 rnk from dual union all
select 265696902 acc, '26203044705811' nls, '324805' kf, 58360802 rnk from dual union all
select 266319602 acc, '26202044790311' nls, '324805' kf, 562002 rnk from dual union all
select 265993302 acc, '26200044752511' nls, '324805' kf, 122605102 rnk from dual union all
select 101877306 acc, '26203000288931' nls, '335106' kf, 29598506 rnk from dual union all
select 325820706 acc, '26205033827204' nls, '335106' kf, 155861806 rnk from dual union all
select 325117006 acc, '26202033714804' nls, '335106' kf, 46230106 rnk from dual union all
select 325053606 acc, '26201033701904' nls, '335106' kf, 155594606 rnk from dual union all
select 325044306 acc, '26208033700704' nls, '335106' kf, 155593706 rnk from dual union all
select 325036806 acc, '26202033699004' nls, '335106' kf, 155593906 rnk from dual union all
select 324746206 acc, '26205033670804' nls, '335106' kf, 155517506 rnk from dual union all
select 324529906 acc, '26207033653904' nls, '335106' kf, 145800306 rnk from dual union all
select 324623706 acc, '26208033665504' nls, '335106' kf, 155515306 rnk from dual union all
select 325929906 acc, '26207033843004' nls, '335106' kf, 7734206 rnk from dual union all
select 384562706 acc, '26201057669204' nls, '335106' kf, 177496706 rnk from dual union all
select 400059406 acc, '26205065045504' nls, '335106' kf, 173192606 rnk from dual union all
select 343423306 acc, '26207039521104' nls, '335106' kf, 93039106 rnk from dual union all
select 361994506 acc, '26202047675304' nls, '335106' kf, 168371806 rnk from dual union all
select 361994506 acc, '26202047675304' nls, '335106' kf, 168371806 rnk from dual union all
select 397774106 acc, '26205064016404' nls, '335106' kf, 182064006 rnk from dual union all
select 397489806 acc, '26205063910404' nls, '335106' kf, 29835006 rnk from dual union all
select 484628106 acc, '26205002291504' nls, '335106' kf, 85280806 rnk from dual union all
select 427165406 acc, '26201077209804' nls, '335106' kf, 18809806 rnk from dual union all
select 468871306 acc, '26203095909504' nls, '335106' kf, 205611306 rnk from dual union all
select 475591106 acc, '26206098264704' nls, '335106' kf, 87786306 rnk from dual union all
select 475761106 acc, '26201098293004' nls, '335106' kf, 86907906 rnk from dual union all
select 470985906 acc, '26200096058004' nls, '335106' kf, 170923706 rnk from dual union all
select 476458306 acc, '26208098392704' nls, '335106' kf, 108646606 rnk from dual union all
select 475771206 acc, '26207098296704' nls, '335106' kf, 7815506 rnk from dual union all
select 476377306 acc, '26202098376704' nls, '335106' kf, 207656906 rnk from dual union all
select 484907806 acc, '26203102415204' nls, '335106' kf, 210683806 rnk from dual union all
select 324953506 acc, '26206033697604' nls, '335106' kf, 155491706 rnk from dual union all
select 323586606 acc, '26203033563504' nls, '335106' kf, 155386106 rnk from dual union all
select 324751706 acc, '26207033671704' nls, '335106' kf, 155486906 rnk from dual union all
select 324518206 acc, '26204033651404' nls, '335106' kf, 4958606 rnk from dual union all
select 324430206 acc, '26201033644704' nls, '335106' kf, 47577506 rnk from dual union all
select 324047906 acc, '26201033604904' nls, '335106' kf, 155450106 rnk from dual union all
select 324481806 acc, '26205033649404' nls, '335106' kf, 68886406 rnk from dual union all
select 322799106 acc, '26201033506604' nls, '335106' kf, 45087806 rnk from dual union all
select 341169106 acc, '26209038624204' nls, '335106' kf, 158837806 rnk from dual union all
select 358401906 acc, '26202046055204' nls, '335106' kf, 166947006 rnk from dual union all
select 356598806 acc, '26202045609004' nls, '335106' kf, 166948806 rnk from dual union all
select 368143406 acc, '26201050067104' nls, '335106' kf, 170365606 rnk from dual union all
select 383565006 acc, '26209057231504' nls, '335106' kf, 177216306 rnk from dual union all
select 398022106 acc, '26203064109904' nls, '335106' kf, 182150806 rnk from dual union all
select 398830506 acc, '26205064493704' nls, '335106' kf, 182443006 rnk from dual union all
select 398894106 acc, '26208064508704' nls, '335106' kf, 60788606 rnk from dual union all
select 397478006 acc, '26202063908204' nls, '335106' kf, 45085906 rnk from dual union all
select 398001906 acc, '26204064103404' nls, '335106' kf, 201238206 rnk from dual union all
select 339051206 acc, '26207037629804' nls, '335106' kf, 160431206 rnk from dual union all
select 354213106 acc, '26207044434004' nls, '335106' kf, 46828406 rnk from dual union all
select 354158406 acc, '26207044418804' nls, '335106' kf, 29592706 rnk from dual union all
select 367049806 acc, '26201050042204' nls, '335106' kf, 42856906 rnk from dual union all
select 368167806 acc, '26200050071704' nls, '335106' kf, 49639106 rnk from dual union all
select 368470506 acc, '26209050107204' nls, '335106' kf, 36079506 rnk from dual union all
select 368500006 acc, '26205050108304' nls, '335106' kf, 170396306 rnk from dual union all
select 380857806 acc, '26206055941004' nls, '335106' kf, 142444706 rnk from dual union all
select 456899206 acc, '26202090274804' nls, '335106' kf, 201239406 rnk from dual union all
select 457926606 acc, '26203090708904' nls, '335106' kf, 201576606 rnk from dual union all
select 333851706 acc, '26209035395804' nls, '335106' kf, 158630806 rnk from dual union all
select 333841206 acc, '26200035393504' nls, '335106' kf, 43025406 rnk from dual union all
select 351958706 acc, '26200043418404' nls, '335106' kf, 165135506 rnk from dual union all
select 364225606 acc, '26205048790304' nls, '335106' kf, 152419406 rnk from dual union all
select 365656206 acc, '26204049362204' nls, '335106' kf, 61136606 rnk from dual union all
select 365495006 acc, '26205049316204' nls, '335106' kf, 169708106 rnk from dual union all
select 365480006 acc, '26209049312204' nls, '335106' kf, 16878106 rnk from dual union all
select 365520506 acc, '26208049322604' nls, '335106' kf, 169712806 rnk from dual union all
select 364478806 acc, '26200048818504' nls, '335106' kf, 109886506 rnk from dual union all
select 365448906 acc, '26207049301604' nls, '335106' kf, 169694606 rnk from dual union all
select 404215106 acc, '26207066892204' nls, '335106' kf, 47312506 rnk from dual union all
select 400915206 acc, '26200065440104' nls, '335106' kf, 183064406 rnk from dual union all
select 315326406 acc, '26206031993504' nls, '335106' kf, 152907406 rnk from dual union all
select 331899306 acc, '26201034744904' nls, '335106' kf, 16318306 rnk from dual union all
select 331901806 acc, '26206034745704' nls, '335106' kf, 29605906 rnk from dual union all
select 333287706 acc, '26205035188004' nls, '335106' kf, 158440906 rnk from dual union all
select 332537806 acc, '26202035006004' nls, '335106' kf, 12684506 rnk from dual union all
select 334323106 acc, '26203035589304' nls, '335106' kf, 15920406 rnk from dual union all
select 331754906 acc, '26209034719704' nls, '335106' kf, 16137506 rnk from dual union all
select 334288106 acc, '26205035584404' nls, '335106' kf, 158785406 rnk from dual union all
select 330979806 acc, '26201034567404' nls, '335106' kf, 49300806 rnk from dual union all
select 330629206 acc, '26200034500804' nls, '335106' kf, 157653106 rnk from dual union all
select 348424906 acc, '26205041809504' nls, '335106' kf, 157038606 rnk from dual union all
select 494629806 acc, '26203007092904' nls, '335106' kf, 49494006 rnk from dual union all
select 497275306 acc, '26202008292704' nls, '335106' kf, 46849506 rnk from dual union all
select 495715806 acc, '26203007571704' nls, '335106' kf, 215678906 rnk from dual union all
select 496707206 acc, '26203008032004' nls, '335106' kf, 216138306 rnk from dual union all
select 486852106 acc, '26200003333604' nls, '335106' kf, 211861406 rnk from dual union all
select 550209606 acc, '26206131334104' nls, '335106' kf, 235588806 rnk from dual union all
select 304744606 acc, '26202029713604' nls, '335106' kf, 149350406 rnk from dual union all
select 315440206 acc, '26207032017604' nls, '335106' kf, 150328706 rnk from dual union all
select 457714506 acc, '26200090635304' nls, '335106' kf, 22511106 rnk from dual union all
select 457655706 acc, '26208090624704' nls, '335106' kf, 29766306 rnk from dual union all
select 457708606 acc, '26205090633204' nls, '335106' kf, 177584006 rnk from dual union all
select 453849406 acc, '26206089044104' nls, '335106' kf, 200256406 rnk from dual union all
select 421550306 acc, '26203074618504' nls, '335106' kf, 188475006 rnk from dual union all
select 445231806 acc, '26204085141304' nls, '335106' kf, 197254606 rnk from dual union all
select 448426506 acc, '26208086561804' nls, '335106' kf, 7462306 rnk from dual union all
select 195750806 acc, '26205003590204' nls, '335106' kf, 107435506 rnk from dual union all
select 282009606 acc, '26200022499604' nls, '335106' kf, 148096106 rnk from dual union all
select 319986406 acc, '26209033112904' nls, '335106' kf, 75076906 rnk from dual union all
select 338969406 acc, '26201037609604' nls, '335106' kf, 152347906 rnk from dual union all
select 338141706 acc, '26203037271104' nls, '335106' kf, 160161006 rnk from dual union all
select 405802506 acc, '26206067530704' nls, '335106' kf, 9656906 rnk from dual union all
select 419231206 acc, '26200074111004' nls, '335106' kf, 75909206 rnk from dual union all
select 431757306 acc, '26207078773504' nls, '335106' kf, 192307506 rnk from dual union all
select 431707206 acc, '26207078759904' nls, '335106' kf, 192301606 rnk from dual union all
select 431002006 acc, '26209078652504' nls, '335106' kf, 47336506 rnk from dual union all
select 432662506 acc, '26209079211104' nls, '335106' kf, 30461306 rnk from dual union all
select 445205506 acc, '26205085137704' nls, '335106' kf, 28999706 rnk from dual union all
select 509599506 acc, '26205114254804' nls, '335106' kf, 220052406 rnk from dual union all
select 297758306 acc, '26203027850104' nls, '335106' kf, 147686106 rnk from dual union all
select 316199006 acc, '26205032083704' nls, '335106' kf, 45980506 rnk from dual union all
select 315471206 acc, '26208032023404' nls, '335106' kf, 152747606 rnk from dual union all
select 316050006 acc, '26200032059904' nls, '335106' kf, 58811606 rnk from dual union all
select 315395606 acc, '26204032003804' nls, '335106' kf, 152916506 rnk from dual union all
select 334454506 acc, '26205035619904' nls, '335106' kf, 158824106 rnk from dual union all
select 453835606 acc, '26209089040804' nls, '335106' kf, 7923506 rnk from dual union all
select 313291806 acc, '26209031782604' nls, '335106' kf, 152421406 rnk from dual union all
select 315335506 acc, '26204031996804' nls, '335106' kf, 152909306 rnk from dual union all
select 313819406 acc, '26206031889704' nls, '335106' kf, 152737906 rnk from dual union all
select 505000106 acc, '26209112106604' nls, '335106' kf, 15184206 rnk from dual union all
select 505000906 acc, '26203112106804' nls, '335106' kf, 219626506 rnk from dual union all
select 506863306 acc, '26201012959904' nls, '335106' kf, 220059606 rnk from dual union all
select 506925306 acc, '26205012977904' nls, '335106' kf, 84423206 rnk from dual union all
select 506875406 acc, '26208012962604' nls, '335106' kf, 29682306 rnk from dual union all
select 507445006 acc, '26202013226204' nls, '335106' kf, 78715706 rnk from dual union all
select 541432406 acc, '26204028417404' nls, '335106' kf, 23603606 rnk from dual union all
select 551529206 acc, '26200031583404' nls, '335106' kf, 13205506 rnk from dual union all
select 549012506 acc, '26208130957104' nls, '335106' kf, 75081706 rnk from dual union all
select 552582606 acc, '26203131948504' nls, '335106' kf, 235964406 rnk from dual union all
select 551139306 acc, '26201131553504' nls, '335106' kf, 235772006 rnk from dual union all
select 549599906 acc, '26209031216404' nls, '335106' kf, 235495406 rnk from dual union all
select 549490406 acc, '26203131181004' nls, '335106' kf, 235461406 rnk from dual union all
select 549674006 acc, '26203131240804' nls, '335106' kf, 73582606 rnk from dual union all
select 549610106 acc, '26207031219704' nls, '335106' kf, 35475306 rnk from dual union all
select 551525006 acc, '26203031581704' nls, '335106' kf, 235793406 rnk from dual union all
select 552869906 acc, '26208032045404' nls, '335106' kf, 17375406 rnk from dual union all
select 552597206 acc, '26201031954504' nls, '335106' kf, 236010906 rnk from dual union all
select 552953506 acc, '26209132058204' nls, '335106' kf, 45241306 rnk from dual union all
select 554419406 acc, '26205132560804' nls, '335106' kf, 236488606 rnk from dual union all
select 557237006 acc, '26200033812504' nls, '335106' kf, 83245706 rnk from dual union all
select 553710006 acc, '26206132253604' nls, '335106' kf, 29642806 rnk from dual union all
select 558007506 acc, '26204134094904' nls, '335106' kf, 16403206 rnk from dual union all
select 560251806 acc, '26200135116904' nls, '335106' kf, 8672106 rnk from dual union all
select 557809706 acc, '26204034019904' nls, '335106' kf, 237459606 rnk from dual union all
select 607729506 acc, '26200143985804' nls, '335106' kf, 47619006 rnk from dual union all
select 592423206 acc, '26200143586504' nls, '335106' kf, 28491706 rnk from dual union all
select 601357106 acc, '26202143852504' nls, '335106' kf, 42882606 rnk from dual union all
select 604331806 acc, '26207143926004' nls, '335106' kf, 119314706 rnk from dual union all
select 604420306 acc, '26205143939004' nls, '335106' kf, 1764106 rnk from dual union all
select 608956906 acc, '26208144100204' nls, '335106' kf, 8114206 rnk from dual union all
select 590430106 acc, '26202143285104' nls, '335106' kf, 59019006 rnk from dual union all
select 591788006 acc, '26209143443604' nls, '335106' kf, 159884906 rnk from dual union all
select 589765506 acc, '26209143074404' nls, '335106' kf, 244695806 rnk from dual union all
select 589727506 acc, '26202143060404' nls, '335106' kf, 15224206 rnk from dual union all
select 589728506 acc, '26203143060704' nls, '335106' kf, 125255106 rnk from dual union all
select 591918306 acc, '26205143485804' nls, '335106' kf, 245106306 rnk from dual union all
select 588195106 acc, '26209042616004' nls, '335106' kf, 12836106 rnk from dual union all
select 589212106 acc, '26208142917604' nls, '335106' kf, 89846306 rnk from dual union all
select 586752406 acc, '26203142387604' nls, '335106' kf, 171353606 rnk from dual union all
select 588630406 acc, '26203142727004' nls, '335106' kf, 14308206 rnk from dual union all
select 587226206 acc, '26204142442504' nls, '335106' kf, 167469906 rnk from dual union all
select 586384406 acc, '26207142289504' nls, '335106' kf, 55874506 rnk from dual union all
select 586257606 acc, '26203142261504' nls, '335106' kf, 205492706 rnk from dual union all
select 586825806 acc, '26205142412704' nls, '335106' kf, 200787606 rnk from dual union all
select 310355706 acc, '26203030809904' nls, '335106' kf, 95993606 rnk from dual union all
select 329041506 acc, '26204034087204' nls, '335106' kf, 157065206 rnk from dual union all
select 331078006 acc, '26200034597204' nls, '335106' kf, 42889506 rnk from dual union all
select 327117406 acc, '26203034000204' nls, '335106' kf, 22923006 rnk from dual union all
select 326900906 acc, '26204033921004' nls, '335106' kf, 105914506 rnk from dual union all
select 527033706 acc, '26201121914904' nls, '335106' kf, 227820306 rnk from dual union all
select 526714006 acc, '26205121863404' nls, '335106' kf, 227363206 rnk from dual union all
select 526808206 acc, '26207121883404' nls, '335106' kf, 227767506 rnk from dual union all
select 528015206 acc, '26206122185704' nls, '335106' kf, 11391606 rnk from dual union all
select 528430806 acc, '26203022334904' nls, '335106' kf, 153635106 rnk from dual union all
select 527598006 acc, '26208122092204' nls, '335106' kf, 227949806 rnk from dual union all
select 527909806 acc, '26200122165504' nls, '335106' kf, 47561806 rnk from dual union all
select 525607106 acc, '26209021405504' nls, '335106' kf, 227303406 rnk from dual union all
select 528446806 acc, '26205022340004' nls, '335106' kf, 11399606 rnk from dual union all
select 528939706 acc, '26209122502704' nls, '335106' kf, 82866806 rnk from dual union all
select 528016806 acc, '26207122186304' nls, '335106' kf, 228055006 rnk from dual union all
select 568471106 acc, '26206137747104' nls, '335106' kf, 39467006 rnk from dual union all
select 570110206 acc, '26204138126704' nls, '335106' kf, 42813306 rnk from dual union all
select 610473506 acc, '26204144282104' nls, '335106' kf, 5893906 rnk from dual union all
select 529909906 acc, '26209122884604' nls, '335106' kf, 124685906 rnk from dual union all
select 568389406 acc, '26201137725604' nls, '335106' kf, 123855406 rnk from dual union all
select 567646306 acc, '26200137505104' nls, '335106' kf, 42866206 rnk from dual union all
select 568364206 acc, '26203137717104' nls, '335106' kf, 164453206 rnk from dual union all
select 570194406 acc, '26204138165204' nls, '335106' kf, 28019206 rnk from dual union all
select 569958906 acc, '26209138061604' nls, '335106' kf, 96786506 rnk from dual union all
select 574613306 acc, '26202139752704' nls, '335106' kf, 47363006 rnk from dual union all
select 571693806 acc, '26201138556504' nls, '335106' kf, 60747506 rnk from dual union all
select 573599506 acc, '26203139424804' nls, '335106' kf, 19817206 rnk from dual union all
select 573120606 acc, '26205139219404' nls, '335106' kf, 12741906 rnk from dual union all
select 573439906 acc, '26204139357204' nls, '335106' kf, 220052406 rnk from dual union all
select 575955106 acc, '26207140381404' nls, '335106' kf, 46344006 rnk from dual union all
select 570796406 acc, '26208138379104' nls, '335106' kf, 18049506 rnk from dual union all
select 570576906 acc, '26206138314804' nls, '335106' kf, 123224006 rnk from dual union all
select 573193506 acc, '26208139250404' nls, '335106' kf, 45369706 rnk from dual union all
select 570626106 acc, '26208138329604' nls, '335106' kf, 85375206 rnk from dual union all
select 570370706 acc, '26200138230304' nls, '335106' kf, 80615506 rnk from dual union all
select 570510406 acc, '26205138297104' nls, '335106' kf, 176694206 rnk from dual union all
select 570549706 acc, '26200138305604' nls, '335106' kf, 240442906 rnk from dual union all
select 570598306 acc, '26207138319604' nls, '335106' kf, 238616506 rnk from dual union all
select 569641606 acc, '26206137999004' nls, '335106' kf, 240079906 rnk from dual union all
select 570586306 acc, '26202138317504' nls, '335106' kf, 107526206 rnk from dual union all
select 576835506 acc, '26207040733204' nls, '335106' kf, 45313706 rnk from dual union all
select 577398906 acc, '26202040897004' nls, '335106' kf, 40094506 rnk from dual union all
select 575570106 acc, '26200140192504' nls, '335106' kf, 241909406 rnk from dual union all
select 580985206 acc, '26204141632304' nls, '335106' kf, 16832006 rnk from dual union all
select 579710706 acc, '26207141541704' nls, '335106' kf, 7335806 rnk from dual union all
select 580527206 acc, '26204141601904' nls, '335106' kf, 5276806 rnk from dual union all
select 564482306 acc, '26201136432404' nls, '335106' kf, 238931806 rnk from dual union all
select 563986306 acc, '26205136296204' nls, '335106' kf, 46493206 rnk from dual union all
select 563719506 acc, '26201136224504' nls, '335106' kf, 45367406 rnk from dual union all
select 565613006 acc, '26209136723104' nls, '335106' kf, 45900706 rnk from dual union all
select 564616606 acc, '26207136468104' nls, '335106' kf, 192700406 rnk from dual union all
select 564500806 acc, '26202136439804' nls, '335106' kf, 17149906 rnk from dual union all
select 563932306 acc, '26206136277404' nls, '335106' kf, 182773806 rnk from dual union all
select 564537306 acc, '26209136452204' nls, '335106' kf, 154437606 rnk from dual union all
select 564502006 acc, '26207136440304' nls, '335106' kf, 190419306 rnk from dual union all
select 584838806 acc, '26207142096504' nls, '335106' kf, 228026406 rnk from dual union all
select 584156106 acc, '26209142006804' nls, '335106' kf, 46772106 rnk from dual union all
select 563055206 acc, '26206135982604' nls, '335106' kf, 238591406 rnk from dual union all
select 563059406 acc, '26201135984704' nls, '335106' kf, 15196506 rnk from dual union all
select 560002106 acc, '26205035011104' nls, '335106' kf, 237931506 rnk from dual union all
select 561875006 acc, '26208135721904' nls, '335106' kf, 238427706 rnk from dual union all
select 561158306 acc, '26209135368504' nls, '335106' kf, 238208806 rnk from dual union all
select 561068206 acc, '26205135363804' nls, '335106' kf, 167089106 rnk from dual union all
select 620888006 acc, '26206145595304' nls, '335106' kf, 73516006 rnk from dual union all
select 627905706 acc, '26202146229004' nls, '335106' kf, 46609606 rnk from dual union all
select 637790406 acc, '26205147084104' nls, '335106' kf, 150915106 rnk from dual union all
select 613867406 acc, '26200144720604' nls, '335106' kf, 151580906 rnk from dual union all
select 613867406 acc, '26200144720604' nls, '335106' kf, 151580906 rnk from dual union all
select 614551606 acc, '26208144881404' nls, '335106' kf, 170487006 rnk from dual union all
select 604274406 acc, '26203143920004' nls, '335106' kf, 15240206 rnk from dual union all
select 366586511 acc, '26202053040926' nls, '322669' kf, 49351411 rnk from dual union all
select 395254611 acc, '26209065673726' nls, '322669' kf, 158419611 rnk from dual union all
select 559073211 acc, '26208002562426' nls, '322669' kf, 200828411 rnk from dual union all
select 770165711 acc, '26202047020026' nls, '322669' kf, 234300711 rnk from dual union all
select 665644411 acc, '26205034943726' nls, '322669' kf, 205402711 rnk from dual union all
select 224086313 acc, '26206001684712' nls, '304665' kf, 38291013 rnk from dual union all
select 634601306 acc, '26202146881204' nls, '335106' kf, 73053406 rnk from dual union all
select 634601306 acc, '26202146881204' nls, '335106' kf, 73053406 rnk from dual union all
select 247947711 acc, '26208010595526' nls, '322669' kf, 109079511 rnk from dual union all
select 246076511 acc, '26208010337126' nls, '322669' kf, 108691011 rnk from dual union all
select 307137211 acc, '26209029925926' nls, '322669' kf, 128586811 rnk from dual union all
select 430700011 acc, '26200076637426' nls, '322669' kf, 168415011 rnk from dual union all
select 404096911 acc, '26204069950826' nls, '322669' kf, 50368211 rnk from dual union all
select 422205711 acc, '26201075163826' nls, '322669' kf, 161158911 rnk from dual union all
select 258506811 acc, '26202012282026' nls, '322669' kf, 111655211 rnk from dual union all
select 824106211 acc, '26206054663126' nls, '322669' kf, 2927311 rnk from dual union all
select 777652511 acc, '26208148914626' nls, '322669' kf, 140641511 rnk from dual union all
select 489476611 acc, '26207084917926' nls, '322669' kf, 26458611 rnk from dual union all
select 467793311 acc, '26208081448226' nls, '322669' kf, 7347611 rnk from dual union all
select 467793311 acc, '26208081448226' nls, '322669' kf, 7347611 rnk from dual union all
select 200546413 acc, '26207000848912' nls, '304665' kf, 15703913 rnk from dual union all
select 200207213 acc, '26201000842312' nls, '304665' kf, 116231913 rnk from dual union all
select 199584513 acc, '26200000832312' nls, '304665' kf, 106850513 rnk from dual union all
select 199203813 acc, '26205000825012' nls, '304665' kf, 115755913 rnk from dual union all
select 200187413 acc, '26205000840912' nls, '304665' kf, 116140313 rnk from dual union all
select 199212913 acc, '26203000825412' nls, '304665' kf, 90214413 rnk from dual union all
select 200180113 acc, '26206000840212' nls, '304665' kf, 10167213 rnk from dual union all
select 200303913 acc, '26205000844112' nls, '304665' kf, 116222213 rnk from dual union all
select 199839413 acc, '26201000836812' nls, '304665' kf, 27056613 rnk from dual union all
select 201386013 acc, '26203000858412' nls, '304665' kf, 15683913 rnk from dual union all
select 201474313 acc, '26209000859512' nls, '304665' kf, 93928513 rnk from dual union all
select 199558113 acc, '26200000830712' nls, '304665' kf, 11370413 rnk from dual union all
select 199149313 acc, '26207000824312' nls, '304665' kf, 15547713 rnk from dual union all
select 199578013 acc, '26208000831412' nls, '304665' kf, 77880713 rnk from dual union all
select 225383413 acc, '26208001726612' nls, '304665' kf, 89431713 rnk from dual union all
select 224275313 acc, '26202001691312' nls, '304665' kf, 83484813 rnk from dual union all
select 224758313 acc, '26206001706612' nls, '304665' kf, 121110113 rnk from dual union all
select 223702713 acc, '26205001673412' nls, '304665' kf, 38828813 rnk from dual union all
select 224702813 acc, '26208001704612' nls, '304665' kf, 121113813 rnk from dual union all
select 223735013 acc, '26209001675212' nls, '304665' kf, 120807013 rnk from dual union all
select 224445713 acc, '26204001696412' nls, '304665' kf, 121044113 rnk from dual union all
select 224389313 acc, '26201001694912' nls, '304665' kf, 103158113 rnk from dual union all
select 224342713 acc, '26209001693012' nls, '304665' kf, 27984013 rnk from dual union all
select 223878313 acc, '26203001678312' nls, '304665' kf, 11512513 rnk from dual union all
select 223879413 acc, '26200001678412' nls, '304665' kf, 31367313 rnk from dual union all
select 224991913 acc, '26209001711712' nls, '304665' kf, 42401913 rnk from dual union all
select 225059213 acc, '26206001714712' nls, '304665' kf, 121224913 rnk from dual union all
select 224099113 acc, '26208001685612' nls, '304665' kf, 120945013 rnk from dual union all
select 225185213 acc, '26200001718112' nls, '304665' kf, 26699013 rnk from dual union all
select 224630813 acc, '26208001701712' nls, '304665' kf, 88511113 rnk from dual union all
select 225055413 acc, '26205001714412' nls, '304665' kf, 97991613 rnk from dual union all
select 225223713 acc, '26206001718912' nls, '304665' kf, 121265813 rnk from dual union all
select 225005313 acc, '26205001713112' nls, '304665' kf, 96412113 rnk from dual union all
select 223979813 acc, '26202001683212' nls, '304665' kf, 24864513 rnk from dual union all
select 225178013 acc, '26203001717712' nls, '304665' kf, 61863113 rnk from dual union all
select 225233613 acc, '26201001719712' nls, '304665' kf, 121273813 rnk from dual union all
select 224448713 acc, '26209001696912' nls, '304665' kf, 26560413 rnk from dual union all
select 221971213 acc, '26201001643112' nls, '304665' kf, 27149613 rnk from dual union all
select 221964813 acc, '26205001642012' nls, '304665' kf, 68057713 rnk from dual union all
select 221968613 acc, '26200001642512' nls, '304665' kf, 62620113 rnk from dual union all
select 223545213 acc, '26201001666412' nls, '304665' kf, 38499913 rnk from dual union all
select 223550013 acc, '26206001666912' nls, '304665' kf, 120745913 rnk from dual union all
select 223550513 acc, '26209001667112' nls, '304665' kf, 120746113 rnk from dual union all
select 221963213 acc, '26201001641512' nls, '304665' kf, 68057713 rnk from dual union all
select 222214713 acc, '26204001649812' nls, '304665' kf, 86009113 rnk from dual union all
select 223525113 acc, '26204001664712' nls, '304665' kf, 120737213 rnk from dual union all
select 224392613 acc, '26204001695112' nls, '304665' kf, 121032413 rnk from dual union all
select 222303113 acc, '26207001650712' nls, '304665' kf, 36832313 rnk from dual union all
select 223342413 acc, '26201001662212' nls, '304665' kf, 120674813 rnk from dual union all
select 223527513 acc, '26201001664812' nls, '304665' kf, 120740313 rnk from dual union all
select 223050613 acc, '26207001660412' nls, '304665' kf, 86747513 rnk from dual union all
select 221513513 acc, '26201001640212' nls, '304665' kf, 42966213 rnk from dual union all
select 222996213 acc, '26204001658212' nls, '304665' kf, 120653713 rnk from dual union all
select 222999913 acc, '26208001658412' nls, '304665' kf, 103643813 rnk from dual union all
select 220025013 acc, '26201001623712' nls, '304665' kf, 42873713 rnk from dual union all
select 218979613 acc, '26206001608312' nls, '304665' kf, 43445013 rnk from dual union all
select 220087013 acc, '26206001624512' nls, '304665' kf, 1909313 rnk from dual union all
select 219185213 acc, '26201001615612' nls, '304665' kf, 120218113 rnk from dual union all
select 219644813 acc, '26206001621612' nls, '304665' kf, 95069613 rnk from dual union all
select 220246513 acc, '26200001634412' nls, '304665' kf, 113960713 rnk from dual union all
select 219138613 acc, '26209001612112' nls, '304665' kf, 53975013 rnk from dual union all
select 218988113 acc, '26208001609212' nls, '304665' kf, 42892013 rnk from dual union all
select 219162913 acc, '26207001613812' nls, '304665' kf, 120225613 rnk from dual union all
select 218858613 acc, '26206001603812' nls, '304665' kf, 112210213 rnk from dual union all
select 218968213 acc, '26201001607512' nls, '304665' kf, 120173013 rnk from dual union all
select 219472913 acc, '26204001621012' nls, '304665' kf, 72358213 rnk from dual union all
select 218916513 acc, '26201001606212' nls, '304665' kf, 71006113 rnk from dual union all
select 218772313 acc, '26203001600012' nls, '304665' kf, 36490913 rnk from dual union all
select 217719213 acc, '26203001572612' nls, '304665' kf, 119727413 rnk from dual union all
select 218248513 acc, '26201001582712' nls, '304665' kf, 28156113 rnk from dual union all
select 196239213 acc, '26205000810812' nls, '304665' kf, 52529213 rnk from dual union all
select 196109913 acc, '26205000806912' nls, '304665' kf, 90900913 rnk from dual union all
select 196099013 acc, '26204000806612' nls, '304665' kf, 115270513 rnk from dual union all
select 195862313 acc, '26201000805412' nls, '304665' kf, 115188913 rnk from dual union all
select 193295513 acc, '26202000791912' nls, '304665' kf, 95690213 rnk from dual union all
select 192114713 acc, '26203000781512' nls, '304665' kf, 113153313 rnk from dual union all
select 218650513 acc, '26200001597612' nls, '304665' kf, 119366113 rnk from dual union all
select 217556513 acc, '26208001567912' nls, '304665' kf, 119642813 rnk from dual union all
select 217435513 acc, '26203001562912' nls, '304665' kf, 58536813 rnk from dual union all
select 218128313 acc, '26204001581312' nls, '304665' kf, 37568713 rnk from dual union all
select 217104613 acc, '26205001556012' nls, '304665' kf, 34899613 rnk from dual union all
select 218340013 acc, '26205001586112' nls, '304665' kf, 39389513 rnk from dual union all
select 218343613 acc, '26204001586812' nls, '304665' kf, 72691313 rnk from dual union all
select 217845513 acc, '26200001576912' nls, '304665' kf, 119694213 rnk from dual union all
select 219202313 acc, '26209001616312' nls, '304665' kf, 120334413 rnk from dual union all
select 219295613 acc, '26202001619112' nls, '304665' kf, 120347013 rnk from dual union all
select 218766513 acc, '26209001599912' nls, '304665' kf, 8371013 rnk from dual union all
select 217478513 acc, '26206001564412' nls, '304665' kf, 119629813 rnk from dual union all
select 218368013 acc, '26207001588312' nls, '304665' kf, 119963113 rnk from dual union all
select 217697113 acc, '26209001570812' nls, '304665' kf, 43209913 rnk from dual union all
select 217813813 acc, '26208001575012' nls, '304665' kf, 119720613 rnk from dual union all
select 218332313 acc, '26207001585412' nls, '304665' kf, 15511613 rnk from dual union all
select 217409913 acc, '26206001560212' nls, '304665' kf, 56690213 rnk from dual union all
select 216252313 acc, '26204001530512' nls, '304665' kf, 119464213 rnk from dual union all
select 216343513 acc, '26201001532212' nls, '304665' kf, 62410313 rnk from dual union all
select 216367113 acc, '26201001533512' nls, '304665' kf, 119365113 rnk from dual union all
select 213798713 acc, '26204001441612' nls, '304665' kf, 119133013 rnk from dual union all
select 244767613 acc, '26207002537812' nls, '304665' kf, 56251413 rnk from dual union all
select 215886013 acc, '26201001508912' nls, '304665' kf, 37406913 rnk from dual union all
select 215964713 acc, '26200001515412' nls, '304665' kf, 51580313 rnk from dual union all
select 215820613 acc, '26204001505912' nls, '304665' kf, 67189513 rnk from dual union all
select 214898513 acc, '26200001501512' nls, '304665' kf, 117344613 rnk from dual union all
select 213944413 acc, '26202001460112' nls, '304665' kf, 77180313 rnk from dual union all
select 214046513 acc, '26203001471412' nls, '304665' kf, 119206513 rnk from dual union all
select 214198613 acc, '26204001491112' nls, '304665' kf, 116569413 rnk from dual union all
select 213820913 acc, '26201001447512' nls, '304665' kf, 62607513 rnk from dual union all
select 213823413 acc, '26202001448112' nls, '304665' kf, 119117013 rnk from dual union all
select 214104313 acc, '26202001479512' nls, '304665' kf, 119114813 rnk from dual union all
select 215813513 acc, '26201001505012' nls, '304665' kf, 35119413 rnk from dual union all
select 216646313 acc, '26207001545612' nls, '304665' kf, 119468813 rnk from dual union all
select 215925113 acc, '26201001513112' nls, '304665' kf, 14311013 rnk from dual union all
select 216650013 acc, '26205001546312' nls, '304665' kf, 87161713 rnk from dual union all
select 216748613 acc, '26208001548812' nls, '304665' kf, 35561313 rnk from dual union all
select 213945013 acc, '26206001460312' nls, '304665' kf, 68590413 rnk from dual union all
select 214170113 acc, '26204001488512' nls, '304665' kf, 119228413 rnk from dual union all
select 188095813 acc, '26206000747412' nls, '304665' kf, 113474013 rnk from dual union all
select 237612013 acc, '26207002233912' nls, '304665' kf, 41861313 rnk from dual union all
select 213520413 acc, '26205001396012' nls, '304665' kf, 119070913 rnk from dual union all
select 213133813 acc, '26201001327212' nls, '304665' kf, 1794113 rnk from dual union all
select 213201313 acc, '26205001335512' nls, '304665' kf, 83939213 rnk from dual union all
select 213028813 acc, '26202001296212' nls, '304665' kf, 72909013 rnk from dual union all
select 212050213 acc, '26209001068012' nls, '304665' kf, 11522413 rnk from dual union all
select 212561313 acc, '26208001170912' nls, '304665' kf, 8184713 rnk from dual union all
select 211346113 acc, '26203000985512' nls, '304665' kf, 96520813 rnk from dual union all
select 210797913 acc, '26207000979212' nls, '304665' kf, 98202113 rnk from dual union all
select 211439413 acc, '26204000990012' nls, '304665' kf, 43216913 rnk from dual union all
select 210686913 acc, '26207000976312' nls, '304665' kf, 97541813 rnk from dual union all
select 210595813 acc, '26209000975612' nls, '304665' kf, 35204413 rnk from dual union all
select 211786013 acc, '26202001010012' nls, '304665' kf, 118516813 rnk from dual union all
select 212098313 acc, '26204001086312' nls, '304665' kf, 74605013 rnk from dual union all
select 212609413 acc, '26201001189212' nls, '304665' kf, 25818913 rnk from dual union all
select 213289413 acc, '26208001366812' nls, '304665' kf, 11361013 rnk from dual union all
select 212619213 acc, '26205001193312' nls, '304665' kf, 118884813 rnk from dual union all
select 212156513 acc, '26202001110912' nls, '304665' kf, 25131013 rnk from dual union all
select 211931413 acc, '26204001038412' nls, '304665' kf, 1001713 rnk from dual union all
select 237594413 acc, '26205002232012' nls, '304665' kf, 65874913 rnk from dual union all
select 237902713 acc, '26207002250412' nls, '304665' kf, 123716713 rnk from dual union all
select 237608113 acc, '26206002233612' nls, '304665' kf, 123738713 rnk from dual union all
select 237534313 acc, '26205002222312' nls, '304665' kf, 123698913 rnk from dual union all
select 236203513 acc, '26206002104912' nls, '304665' kf, 16360113 rnk from dual union all
select 236197013 acc, '26204002104312' nls, '304665' kf, 123161813 rnk from dual union all
select 236112513 acc, '26206002097212' nls, '304665' kf, 123127313 rnk from dual union all
select 236113313 acc, '26207002097512' nls, '304665' kf, 105092313 rnk from dual union all
select 237550813 acc, '26208002223512' nls, '304665' kf, 70455113 rnk from dual union all
select 237562813 acc, '26204002225912' nls, '304665' kf, 11101813 rnk from dual union all
select 236262713 acc, '26208002111312' nls, '304665' kf, 122502313 rnk from dual union all
select 237520813 acc, '26206002219012' nls, '304665' kf, 116604413 rnk from dual union all
select 236394513 acc, '26207002121712' nls, '304665' kf, 88713713 rnk from dual union all
select 236262113 acc, '26201002111212' nls, '304665' kf, 123163813 rnk from dual union all
select 236106013 acc, '26207002095912' nls, '304665' kf, 7332813 rnk from dual union all
select 236209413 acc, '26205002105912' nls, '304665' kf, 65755113 rnk from dual union all
select 496854813 acc, '26204076842912' nls, '304665' kf, 15146913 rnk from dual union all
select 184544713 acc, '26203000714512' nls, '304665' kf, 108024613 rnk from dual union all
select 184806813 acc, '26209000715612' nls, '304665' kf, 112807613 rnk from dual union all
select 184828213 acc, '26206000715712' nls, '304665' kf, 112807913 rnk from dual union all
select 211477313 acc, '26200000995312' nls, '304665' kf, 38332813 rnk from dual union all
select 211885113 acc, '26206001024112' nls, '304665' kf, 99124313 rnk from dual union all
select 208848513 acc, '26205000960212' nls, '304665' kf, 12382613 rnk from dual union all
select 209596613 acc, '26200000972012' nls, '304665' kf, 68071413 rnk from dual union all
select 208912213 acc, '26206000960512' nls, '304665' kf, 118034013 rnk from dual union all
select 208949213 acc, '26205000961512' nls, '304665' kf, 1122813 rnk from dual union all
select 209526013 acc, '26207000969512' nls, '304665' kf, 118216313 rnk from dual union all
select 209593013 acc, '26204000971912' nls, '304665' kf, 41181513 rnk from dual union all
select 209240213 acc, '26201000964212' nls, '304665' kf, 35493413 rnk from dual union all
select 208832313 acc, '26204000959912' nls, '304665' kf, 5517313 rnk from dual union all
select 207318613 acc, '26208000954612' nls, '304665' kf, 25128513 rnk from dual union all
select 209541513 acc, '26204000970612' nls, '304665' kf, 118221213 rnk from dual union all
select 208867613 acc, '26202000960312' nls, '304665' kf, 118041813 rnk from dual union all
select 209562813 acc, '26205000971212' nls, '304665' kf, 118044213 rnk from dual union all
select 207212313 acc, '26204000953112' nls, '304665' kf, 14165913 rnk from dual union all
select 207139613 acc, '26204000948912' nls, '304665' kf, 27525013 rnk from dual union all
select 207170013 acc, '26206000951112' nls, '304665' kf, 68057713 rnk from dual union all
select 207146413 acc, '26206000949812' nls, '304665' kf, 59825513 rnk from dual union all
select 234991513 acc, '26203002072412' nls, '304665' kf, 123027613 rnk from dual union all
select 234918513 acc, '26209002066712' nls, '304665' kf, 122962913 rnk from dual union all
select 236439413 acc, '26207002126212' nls, '304665' kf, 123066313 rnk from dual union all
select 234964713 acc, '26209002070612' nls, '304665' kf, 122979313 rnk from dual union all
select 234620513 acc, '26202002049112' nls, '304665' kf, 122889113 rnk from dual union all
select 183136313 acc, '26206000710212' nls, '304665' kf, 101213413 rnk from dual union all
select 207214313 acc, '26202000953512' nls, '304665' kf, 5161513 rnk from dual union all
select 207224013 acc, '26206000953712' nls, '304665' kf, 97510713 rnk from dual union all
select 207175913 acc, '26208000951712' nls, '304665' kf, 68057713 rnk from dual union all
select 207369513 acc, '26200000958412' nls, '304665' kf, 88632113 rnk from dual union all
select 207211913 acc, '26207000953012' nls, '304665' kf, 99841513 rnk from dual union all
select 206931613 acc, '26206000945612' nls, '304665' kf, 67577613 rnk from dual union all
select 207085613 acc, '26202000948312' nls, '304665' kf, 75143013 rnk from dual union all
select 206421713 acc, '26206000933312' nls, '304665' kf, 14200313 rnk from dual union all
select 206348713 acc, '26209000930312' nls, '304665' kf, 117152113 rnk from dual union all
select 206031713 acc, '26204000922712' nls, '304665' kf, 87490213 rnk from dual union all
select 206566513 acc, '26203000936312' nls, '304665' kf, 12151213 rnk from dual union all
select 206469613 acc, '26204000935312' nls, '304665' kf, 38883613 rnk from dual union all
select 206563413 acc, '26202000936012' nls, '304665' kf, 106675113 rnk from dual union all
select 206763313 acc, '26209000941312' nls, '304665' kf, 24932413 rnk from dual union all
select 206428113 acc, '26204000934012' nls, '304665' kf, 86174913 rnk from dual union all
select 206831013 acc, '26208000945212' nls, '304665' kf, 117898813 rnk from dual union all
select 206363213 acc, '26207000931012' nls, '304665' kf, 26477313 rnk from dual union all
select 206069913 acc, '26200000923812' nls, '304665' kf, 9402213 rnk from dual union all
select 206475513 acc, '26205000935612' nls, '304665' kf, 117490813 rnk from dual union all
select 205858313 acc, '26204000918812' nls, '304665' kf, 5955013 rnk from dual union all
select 206352013 acc, '26206000930412' nls, '304665' kf, 89796113 rnk from dual union all
select 205134713 acc, '26204000906512' nls, '304665' kf, 110125313 rnk from dual union all
select 205114613 acc, '26209000905712' nls, '304665' kf, 117038113 rnk from dual union all
select 204556913 acc, '26205000889412' nls, '304665' kf, 12805413 rnk from dual union all
select 203875213 acc, '26208000876712' nls, '304665' kf, 116800913 rnk from dual union all
select 204559113 acc, '26202000889512' nls, '304665' kf, 116949113 rnk from dual union all
select 206360713 acc, '26204000930812' nls, '304665' kf, 88676213 rnk from dual union all
select 204666713 acc, '26209000893512' nls, '304665' kf, 5979613 rnk from dual union all
select 204559413 acc, '26209000889612' nls, '304665' kf, 116847813 rnk from dual union all
select 204561213 acc, '26207000890012' nls, '304665' kf, 35280913 rnk from dual union all
select 232328113 acc, '26207001968512' nls, '304665' kf, 122466013 rnk from dual union all
select 234446613 acc, '26203002037112' nls, '304665' kf, 122684113 rnk from dual union all
select 234231913 acc, '26201002022312' nls, '304665' kf, 27774113 rnk from dual union all
select 234245813 acc, '26209002023012' nls, '304665' kf, 53996713 rnk from dual union all
select 231465413 acc, '26205001883912' nls, '304665' kf, 122163113 rnk from dual union all
select 231582513 acc, '26207001893212' nls, '304665' kf, 122204613 rnk from dual union all
select 231585413 acc, '26209001893812' nls, '304665' kf, 80330913 rnk from dual union all
select 232397313 acc, '26201001975512' nls, '304665' kf, 122479813 rnk from dual union all
select 232301413 acc, '26205001964712' nls, '304665' kf, 120650513 rnk from dual union all
select 232314313 acc, '26204001965712' nls, '304665' kf, 38081513 rnk from dual union all
select 231686613 acc, '26209001900512' nls, '304665' kf, 122253913 rnk from dual union all
select 231740213 acc, '26206001906412' nls, '304665' kf, 122277913 rnk from dual union all
select 233457413 acc, '26206001987312' nls, '304665' kf, 14640113 rnk from dual union all
select 232138513 acc, '26209001948712' nls, '304665' kf, 34928813 rnk from dual union all
select 232270413 acc, '26204001959212' nls, '304665' kf, 122441213 rnk from dual union all
select 231706613 acc, '26202001902012' nls, '304665' kf, 114152913 rnk from dual union all
select 232059213 acc, '26204001939812' nls, '304665' kf, 111469013 rnk from dual union all
select 232294213 acc, '26203001962512' nls, '304665' kf, 121720013 rnk from dual union all
select 231692913 acc, '26200001901112' nls, '304665' kf, 122262513 rnk from dual union all
select 232208513 acc, '26203001952812' nls, '304665' kf, 122400613 rnk from dual union all
select 232300113 acc, '26201001964512' nls, '304665' kf, 96676213 rnk from dual union all
select 231727913 acc, '26205001904512' nls, '304665' kf, 40235713 rnk from dual union all
select 232073913 acc, '26204001942412' nls, '304665' kf, 34970813 rnk from dual union all
select 231973113 acc, '26204001930112' nls, '304665' kf, 122341413 rnk from dual union all
select 231526013 acc, '26209001888612' nls, '304665' kf, 37916613 rnk from dual union all
select 231504713 acc, '26209001886012' nls, '304665' kf, 122143913 rnk from dual union all
select 231669713 acc, '26209001898312' nls, '304665' kf, 122246113 rnk from dual union all
select 231709413 acc, '26200001902412' nls, '304665' kf, 88787113 rnk from dual union all
select 232376613 acc, '26209001973312' nls, '304665' kf, 38857113 rnk from dual union all
select 231967613 acc, '26205001929412' nls, '304665' kf, 122303713 rnk from dual union all
select 231921013 acc, '26205001925212' nls, '304665' kf, 86962513 rnk from dual union all
select 232035913 acc, '26201001937312' nls, '304665' kf, 34015613 rnk from dual union all
select 232120913 acc, '26206001945912' nls, '304665' kf, 122384213 rnk from dual union all
select 232087413 acc, '26204001944012' nls, '304665' kf, 97816813 rnk from dual union all
select 231270013 acc, '26207001873812' nls, '304665' kf, 36469713 rnk from dual union all
select 231743313 acc, '26201001907212' nls, '304665' kf, 65326313 rnk from dual union all
select 232007513 acc, '26209001933512' nls, '304665' kf, 122346213 rnk from dual union all
select 232139113 acc, '26206001948812' nls, '304665' kf, 28039813 rnk from dual union all
select 231567713 acc, '26205001891012' nls, '304665' kf, 122181413 rnk from dual union all
select 232271013 acc, '26208001959412' nls, '304665' kf, 43395613 rnk from dual union all
select 231724713 acc, '26204001903912' nls, '304665' kf, 114687213 rnk from dual union all
select 230481213 acc, '26207001844012' nls, '304665' kf, 38850913 rnk from dual union all
select 229133513 acc, '26201001822212' nls, '304665' kf, 2257213 rnk from dual union all
select 229076913 acc, '26204001817912' nls, '304665' kf, 72326113 rnk from dual union all
select 229187813 acc, '26209001828412' nls, '304665' kf, 121919913 rnk from dual union all
select 229134913 acc, '26208001822312' nls, '304665' kf, 11368813 rnk from dual union all
select 229031613 acc, '26204001814012' nls, '304665' kf, 121789513 rnk from dual union all
select 231273913 acc, '26207001874112' nls, '304665' kf, 24556413 rnk from dual union all
select 232422413 acc, '26206001978912' nls, '304665' kf, 42216313 rnk from dual union all
select 204773713 acc, '26207000897112' nls, '304665' kf, 117039913 rnk from dual union all
select 204493713 acc, '26203000885612' nls, '304665' kf, 116854013 rnk from dual union all
select 203906613 acc, '26209000877312' nls, '304665' kf, 26565913 rnk from dual union all
select 204560013 acc, '26203000889812' nls, '304665' kf, 34863413 rnk from dual union all
select 204513313 acc, '26208000886412' nls, '304665' kf, 116370113 rnk from dual union all
select 204275713 acc, '26207000880312' nls, '304665' kf, 116845613 rnk from dual union all
select 204513513 acc, '26205000886512' nls, '304665' kf, 36471513 rnk from dual union all
select 203269113 acc, '26205000870012' nls, '304665' kf, 36070513 rnk from dual union all
select 203270813 acc, '26202000870112' nls, '304665' kf, 89184713 rnk from dual union all
select 203212913 acc, '26202000867512' nls, '304665' kf, 116585113 rnk from dual union all
select 204967413 acc, '26200000899612' nls, '304665' kf, 36790513 rnk from dual union all
select 200596213 acc, '26204000850312' nls, '304665' kf, 8308013 rnk from dual union all
select 203167313 acc, '26208000865712' nls, '304665' kf, 36892813 rnk from dual union all
select 203148713 acc, '26205000864512' nls, '304665' kf, 26248713 rnk from dual union all
select 229149213 acc, '26201001823512' nls, '304665' kf, 15512813 rnk from dual union all
select 230448313 acc, '26201001841312' nls, '304665' kf, 104101313 rnk from dual union all
select 230353613 acc, '26204001831512' nls, '304665' kf, 5248813 rnk from dual union all
select 230161913 acc, '26208001830412' nls, '304665' kf, 97375213 rnk from dual union all
select 228958513 acc, '26204001806912' nls, '304665' kf, 46356213 rnk from dual union all
select 230371313 acc, '26206001833712' nls, '304665' kf, 94568913 rnk from dual union all
select 229082513 acc, '26209001818712' nls, '304665' kf, 120681713 rnk from dual union all
select 230353813 acc, '26201001831612' nls, '304665' kf, 121926713 rnk from dual union all
select 230380613 acc, '26205001835012' nls, '304665' kf, 5317413 rnk from dual union all
select 229000813 acc, '26207001810712' nls, '304665' kf, 79097513 rnk from dual union all
select 226758713 acc, '26207001730212' nls, '304665' kf, 121346213 rnk from dual union all
select 227942213 acc, '26204001762012' nls, '304665' kf, 84901513 rnk from dual union all
select 226715213 acc, '26208001727912' nls, '304665' kf, 121203413 rnk from dual union all
select 228252813 acc, '26203001775312' nls, '304665' kf, 38418813 rnk from dual union all
select 228292113 acc, '26204001777212' nls, '304665' kf, 121658513 rnk from dual union all
select 228870113 acc, '26200001801212' nls, '304665' kf, 35032613 rnk from dual union all
select 227098613 acc, '26204001742612' nls, '304665' kf, 121386513 rnk from dual union all
select 226758913 acc, '26204001730312' nls, '304665' kf, 53176613 rnk from dual union all
select 228989013 acc, '26209001810312' nls, '304665' kf, 121719213 rnk from dual union all
select 227940713 acc, '26208001761912' nls, '304665' kf, 109741413 rnk from dual union all
select 226835213 acc, '26202001734912' nls, '304665' kf, 24398713 rnk from dual union all
select 228970913 acc, '26207001808412' nls, '304665' kf, 99425513 rnk from dual union all
select 227423113 acc, '26205001756812' nls, '304665' kf, 36818913 rnk from dual union all
select 228602413 acc, '26200001785112' nls, '304665' kf, 121653613 rnk from dual union all
select 226746513 acc, '26200001729112' nls, '304665' kf, 1007613 rnk from dual union all
select 228116113 acc, '26200001768612' nls, '304665' kf, 65831013 rnk from dual union all
select 227413813 acc, '26206001756112' nls, '304665' kf, 121476913 rnk from dual union all
select 228822013 acc, '26206001796912' nls, '304665' kf, 35527913 rnk from dual union all
select 225369113 acc, '26202001725512' nls, '304665' kf, 113099213 rnk from dual union all
select 226765713 acc, '26206001730912' nls, '304665' kf, 121346313 rnk from dual union all
select 226777413 acc, '26200001732712' nls, '304665' kf, 43971013 rnk from dual union all
select 106977021 acc, '26200000352834' nls, '351823' kf, 69651621 rnk from dual union all
select 427208121 acc, '26209043584820' nls, '351823' kf, 160062521 rnk from dual union all
select 510466021 acc, '26207056437320' nls, '351823' kf, 167711821 rnk from dual union all
select 1096786421 acc, '26200018408521' nls, '351823' kf, 48530021 rnk from dual union all
select 427362721 acc, '26209043616420' nls, '351823' kf, 5749721 rnk from dual union all
select 338178021 acc, '26208025872120' nls, '351823' kf, 144634621 rnk from dual union all
select 363011821 acc, '26204028765120' nls, '351823' kf, 144785021 rnk from dual) x;

commit;

end;  
/

declare 
l_kf mv_kf.kf%type;
title varchar(50) := 'recovery 2620: ';
l_dptid number;
begin 
  bars_audit.info('Start recovery 2620');
  l_kf := '/';
  bc.go(l_kf);
  
  for i in (select * from tmp_recovery2620_220218 order by kf) loop 
  if l_kf <> i.kf then
    l_kf := i.kf;
     bars_audit.info(title||' kf = '||l_kf);
    bc.go(l_kf);
  end if;
  
  --bars_audit.trace('%s acc = %s nls = %s', title, to_char(i.acc), i.nls);
  update bars.accounts set dazs = null where acc = i.acc and nls = i.nls;
  
  begin --#1
  select deposit_id 
  into l_dptid
  from bars.dpt_deposit
  where acc = i.acc;
  
  update tmp_recovery2620_220218 
  set note = 'депозит '||to_char(l_dptid)||' дл€ счета '||to_char(i.acc)||' не закрыт!'
  where acc = i.acc;
  
  exception when no_data_found then --#1
   
   begin --#2
     select deposit_id 
     into l_dptid
     from bars.dpt_deposit_clos
     where acc = i.acc
     and action_id in (1,2)
     and trunc(bdate) = to_date('22.02.2018','DD.MM.YYYY'); 
     
     dpt_utils.RECOVERY_CONTRACT(l_dptid);
     
     update tmp_recovery2620_220218 
     set note = 'OK. ƒепозит '||to_char(l_dptid)||' и счет '||to_char(i.acc)||' восстановлены!'
     where acc = i.acc;

   exception when no_data_found then --#2
     update tmp_recovery2620_220218 
     set note = 'Ќе найден депозит дл€ счета '||to_char(i.acc)||' закрытый 22.02.2018'
     where acc = i.acc;
   end; --#2  
 
  end; --#1
   
   commit;
   end loop;

   bc.home;   

end;
/
