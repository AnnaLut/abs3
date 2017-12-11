

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/_BRS_***_REP_199.sql =========*** Run *
PROMPT ===================================================================================== 
prompt ===================================== 
prompt == ������ ��� ���� �������
prompt ===================================== 

set serveroutput on
set feed off       
declare                               

   nlchr       char(2):=chr(13)||chr(10);
   l_zpr       zapros%rowtype;    
   l_zprr      zapros%rowtype;    
   l_rep       reports%rowtype;   
   l_repfolder number;            
   l_isnew     smallint:=0;       
   l_isnewr    smallint:=0;       
   l_message   varchar2(1000);    

begin     
   l_zpr.name := '������ ��� ���� �������';
   l_zpr.pkey := '\BRS\***\REP\199';

   l_message  := '���� �������: '||l_zpr.pkey||'  '||nlchr;

   begin                                                   
      select kodz, kodr into l_zpr.kodz, l_zpr.kodr        
      from zapros where pkey=l_zpr.pkey;                   
   exception when no_data_found then                       
      l_isnew:=1;                                          
      select s_zapros.nextval into l_zpr.kodz from dual;   
      if (0>0) then                  
         select s_zapros.nextval into l_zpr.kodr from dual;
         l_zprr.kodz:=l_zpr.kodr;           
      end if;                               
   end;                                     
                                            

    ------------------------    
    --  main query        --    
    ------------------------    
                                
    l_zpr.id           := 1;
    l_zpr.name         := '������ ��� ���� �������';
    l_zpr.namef        := 'dov.txt';
    l_zpr.bindvars     := ':sFdat1='''',:Param0=''�����. � ��. (0-��i)'',:Param1=''����� ������� (%-��i)'',:Param2=''���������� (0-��i)''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := 'AG_31.qrp';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := ':Param0=''0'',:Param1=''%'',:Param2=''0''';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'SELECT SUBSTR(F_DAT_LIT (to_date(:sFdat1,''DD-MM-YYYY'')),1,25) DAT_LIT,
       C.RNK, C.OKPO, R.RUK, R.BUH, C.NMK,     
       A.KV , A.NLS, SUBSTR(A.NMS,1,38) NMS,    
       T.NAME, T.LCV,
       (S.OSTF-S.DOS+S.KOS) S,    
       to_char(abs((S.OSTF-S.DOS+S.KOS)/100),''999G999G999G990D99'') AS_STR,
       SUBSTR( F_SUMPR(abs(S.OSTF-S.DOS+S.KOS),
                       TO_CHAR(T.KV),
                       NVL(T.Gender,''M''),
                       NVL(T.DIG,2) ),1,250) SUMPR,    
       SUBSTR(F_DAT_LIT(sysdate),1,25) SYS_LIT, 
       F.FIO     
FROM CORPS  R, CUSTOMER C, CUST_ACC U, 
     ACCOUNTS A, TABVAL T, SALDOA S, STAFF$BASE F    
WHERE C.RNK = R.RNK(+) 
  AND C.RNK = U.RNK 
  AND U.ACC = A.ACC 
  AND A.KV  = T.KV     
  AND A.ACC = S.ACC 
  AND A.ISP = F.ID 
  AND (A.ISP=to_number(:Param2) OR :Param2=''0'')
  AND (S.ACC,S.FDAT) = (SELECT ACC,MAX(FDAT) 
                          FROM SALDOA    
                         WHERE ACC=A.ACC 
                           AND FDAT<to_date(:sFdat1,''DD-MM-YYYY'') GROUP BY ACC)    
  AND A.NLS LIKE :Param1 
  AND A.DAZS IS NULL     
  AND C.RNK = DECODE(0,TO_NUMBER(:Param0),C.RNK,TO_NUMBER(:Param0))    
ORDER BY C.RNK, A.NLS, A.KV';
    l_zpr.xsl_data     := '';
    l_zpr.xsd_data     := '';

    if l_isnew = 1 then           
       insert into zapros values l_zpr;  
       l_message:=l_message||'�������� ����� ���.������ �'||l_zpr.kodz||'.'; 
    else                           
       update zapros set name         = l_zpr.name,        
                         namef        = l_zpr.namef,       
                         bindvars     = l_zpr.bindvars,    
                         create_stmt  = l_zpr.create_stmt, 
                         rpt_template = l_zpr.rpt_template,
                         form_proc    = l_zpr.form_proc,   
                         default_vars = l_zpr.default_vars,
                         bind_sql     = l_zpr.bind_sql,    
                         xml_encoding = l_zpr.xml_encoding,
                         txt          = l_zpr.txt,         
                         xsl_data     = l_zpr.xsl_data,    
                         xsd_data     = l_zpr.xsd_data     
       where pkey=l_zpr.pkey;                              
       l_message:=l_message||'���.������ c ����� ������ ��� ���������� ��� �'||l_zpr.kodz||', ��� ��������� ��������.'; 
                                                           
    end if;                                                

    ------------------------    
    --  report            --    
    ------------------------    
                                

    l_rep.name        :='Empty';
    l_rep.description :='������ ��� ���� �������';
    l_rep.form        :='frm_UniReport';
    l_rep.param       :=l_zpr.kodz||',3,sFdat,sFdat,"",TRUE,TRUE';
    l_rep.ndat        :=1;
    l_rep.mask        :='dov.txt';
    l_rep.usearc      :=0;
    begin                                                                        
        select idf into l_repfolder from reportsf where idf = 30; 
    exception when no_data_found then                                            
        l_repfolder := null;                                                     
    end;                         
    l_rep.idf := l_repfolder;    

    -- ������������� � ��������� ������   
    l_rep.id          := 380;


    if l_isnew = 1 then                     
       begin                                
          insert into reports values l_rep;        
          l_message:=l_message||nlchr||'�������� ����� ���. ����� ��� �'||l_rep.id;
       exception when dup_val_on_index then  
           bars_error.raise_error('REP',14, to_char(l_rep.id));
       end;                                    
    else                                            
       begin                                        
          insert into reports values l_rep;         
          l_message:=l_message||nlchr||'�������� ����� ���. ����� ��� �'||l_rep.id;
       exception when dup_val_on_index then         
          l_message:=l_message||nlchr||'�������� ����� ��� �'||l_rep.id||' �������.';
          update reports set                
             name        = l_rep.name,       
             description = l_rep.description,
             form        = l_rep.form,       
             param       = l_rep.param,      
             ndat        = l_rep.ndat,       
             mask        = l_rep.mask,       
             usearc      = l_rep.usearc,     
             idf         = l_rep.idf         
          where id=l_rep.id;                 
       end;                                  
    end if;                                  
    bars_report.print_message(l_message);   
end;                                        
/                                           
                                            
commit;                                     



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/_BRS_***_REP_199.sql =========*** End *
PROMPT ===================================================================================== 