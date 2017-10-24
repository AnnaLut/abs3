prompt ===================================== 
prompt == Розрахунок фінстану по клієнтах Кримського РУ (351)
prompt ===================================== 

set serveroutput on
set feed off       
declare                               

   nlchr       char(2):=chr(13)||chr(10);
   l_reports       DWH_REPORTS%rowtype;    
   l_reportsr      DWH_REPORTS%rowtype;    
   l_isnew     smallint:=0;       

begin     
   l_reports.name := 'Розрахунок фінстану по клієнтах Кримського РУ (351)';
   l_reports.id := '4';

   begin                                                   
      select id into l_reportsr.id                      
      from DWH_REPORTS where id=l_reports.id;             
   exception when no_data_found then                       
      l_isnew:=1;                                          
   end;                                     
                                            

    ---------------------------    
    --  main dku_zvt zapros  --    
    ---------------------------    
                                  
    l_reports.name                 := 'Розрахунок фінстану по клієнтах Кримського РУ (351)';
    l_reports.TYPEID               := '2';
    l_reports.PARAMS               := '[{"Name":"p_sFdat1","Type":"Date","Value":"","Label":"Дата"}]';
    l_reports.TEMPLATE_NAME        := '';
    l_reports.RESULT_FILE_NAME     := 'substr(F_OURMFO,1,6)||substr(p_sFdat1,1,2)||substr(p_sFdat1,4,2)||substr(p_sFdat1,7,4)||''.rar''';
    l_reports.SQLPREPARE          := '';
    l_reports.DESCRIPTION         := '';
    l_reports.FORM_PROC           := 'declare
l_cbirep_q DWH_CBIREP_QUERIES%rowtype;
l_reports  DWH_REPORTS%rowtype;
p_cbirep_queries_id number := #P_ID#;
l_file_name varchar2(254);
l_sqlprepare varchar2(32000);
l_file varchar2(50);
l_blob blob;
p_dat date := trunc(to_date(p_sFdat1,''dd-mm-yyyy''),''MM'');
fm_dat date ;
l_chr varchar2(2) := chr(13)||chr(10);
l_txt varchar2(4000);
begin

    
select *
  into l_cbirep_q
  from DWH_CBIREP_QUERIES
 where id =  p_cbirep_queries_id;
 
select *
  into l_reports
  from DWH_REPORTS
 where id = l_cbirep_q.rep_id;
 
     dwh_cbirep.set_status(p_cbirep_queries_id, ''startcreatedfile'');
     commit;
     

 BEGIN
      dbms_lob.createtemporary(l_blob,  true);
      l_txt := ''   ПРОТОКОЛ розрахунку фінстану по клієнтах КРИМ  за   ''||to_char( p_dat,''dd/mm/yyyy'')||l_chr||l_chr||l_chr;
      dbms_lob.append(l_blob, UTL_RAW.CAST_TO_RAW(l_txt));
         
         for  x in (
                         Select *
                          from v_fin_cc_deal
                         where  vidd between 1 and 3 
                           and branch like  ''/324805%''
                           and branch like  ''/''||f_ourmfo ||''%''
                    )
        LOOP 
            l_txt := ''    RHK=''||rpad(x.rnk,14,'' '')||''ND=''||rpad(x.nd,15,'' '')||''угода №''||rpad(x.cc_id,15,'' '')||'' від ''||to_char(x.sdate,''dd-mm-yyyy'')||''   ''||x.branch||'' ''||l_chr;
            dbms_lob.append(l_blob, UTL_RAW.CAST_TO_RAW(l_txt));
            
            select nvl(max(fdat),p_dat) into fm_dat
              from fin_fm
             where okpo = (select okpo from customer where rnk = x.rnk);   
           
           fin_nbu.record_fp_ND_date(''ZVTP'', fm_dat, 51, p_dat, x.nd, x.rnk);
           fin_nbu.add_findat(x.rnk, x.nd, p_dat);
           fin_nbu.calculation_class(x.rnk, fm_dat);
           FIN_ZP.SET_ND_VNCRR(x.nd, x.rnk, ''Г'');
           fin_nbu.get_subpok(x.rnk, x.nd, p_dat, fm_dat);
		   
           for i in (select * from BARS.FIN_QUESTION where idf between 52 and 56)
           loop
		      if (i.idf = 53 and i.kod in (''PD1'',''PD20'', ''PD17'', ''PD117'') ) or   (i.idf = 54 and i.kod in (''VD7'', ''VD8'') )
			     then FIN_NBU.RECORD_FP_ND(i.kod, 1, i.idf, p_dat, x.nd, x.rnk);
			     else FIN_NBU.RECORD_FP_ND(i.kod, 0, i.idf, p_dat, x.nd, x.rnk);
			  end if;
           end loop;
           
           if x.rnk in (31602, 777302, 4567802, 13075902, 13077302, 13078802, 130811202, 123039102, 133286002,123039602,123039902,123040002,13081202,133286202,133286302,32402,4568502,777402,777502)
            then    
			        FIN_NBU.RECORD_FP_ND(''NGRK'', 0, 51, P_DAT, X.ND, X.RNK); 
			        FIN_NBU.RECORD_FP_ND(''NGRP'', 1, 51, P_DAT, X.ND, X.RNK); 
           end if; 
           
           fin_nbu.adjustment_class(x.rnk, x.nd, p_dat, fm_dat);
           FIN_NBU.RECORD_FP_ND(''PD'', FIN_NBU.GET_PD(x.rnk, x.nd, p_dat, 10, ''Г'', 50), 56, p_dat, x.nd, x.rnk);
           
           commit;
        END LOOP;
 
 
 
  
   
 
 END;

   
   l_file_name          :=  ''select ''||dwh_cbirep.bind_variables(l_reports.file_name,l_cbirep_q.KEY_PARAMS)||'' from dual''; 
                           
   EXECUTE IMMEDIATE   l_file_name into l_file_name;

 Insert into BARS.DWH_CBIREP_QUERIES_DATA  (  CBIREP_QUERIES_ID, RESULT_FILE_NAME, LENGTH_FILE, fil)
  Values  (  p_cbirep_queries_id, l_file_name, DBMS_LOB.GETLENGTH (l_blob)   , l_blob);

  
  dbms_lob.freetemporary(l_blob);

end;                          ';
    l_reports.stmt                := '';
    l_reports.FILE_NAME           := 'substr(F_OURMFO,1,6)||substr(p_sFdat1,1,2)||substr(p_sFdat1,4,2)||substr(p_sFdat1,7,4)||''.txt''';
    l_reports.encoding            := 'UKG';

    ----------------------------------    
    --  main dku_zvt insert/update  --    
    ----------------------------------    
                                          

    if l_isnew = 1 then           
       insert into DWH_REPORTS values l_reports;  
    else                           
      update DWH_REPORTS set name         = l_reports.name,        
                         TYPEID           = l_reports.TYPEID, 
                         PARAMS           = l_reports.PARAMS,    
                         TEMPLATE_NAME    = l_reports.TEMPLATE_NAME,        
                         RESULT_FILE_NAME = l_reports.RESULT_FILE_NAME,   
                         SQLPREPARE       = l_reports.SQLPREPARE,     
                         DESCRIPTION      = l_reports.DESCRIPTION,      
                         FORM_PROC        = l_reports.FORM_PROC,     
                         STMT             = l_reports.STMT,          
                         FILE_NAME        = l_reports.FILE_NAME,          
                         ENCODING         = l_reports.ENCODING   
       where id=l_reports.id;                                
                                                           
    end if;                                                
end;                                        
/                                           
                                            
commit;                 

begin 
  execute immediate 
    ' Insert into BARS.DWH_REPORT_LINKS  (REPORT_ID, MODULE_ID)'||
    '  Values   (4, ''$RM_RISK'')';
exception when dup_val_on_index then 
  null;
end;
/
commit;                    
