
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/fin_nbu.sql =========*** Run *** ===
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.FIN_NBU IS
   G_HEADER_VERSION  CONSTANT VARCHAR2(64)  := 'version 1.4.0  20.06.2017';
   
   G_DATE_VAL DATE := to_date('04-03-2012','dd-mm-yyyy'); --����  ������ ���.�� �� ��� �� ����������� ������� �������
   
/*

20-06-2017 - correction_parameters �������� VKR
27.07.2012 

  ���������� ��������� �� ������ ����� ����������� � ����� �����:
  FIN_NBU_RV  (params) 1 - ����� �1(���)
                       2 - ����� �2(���)
				       3 - ��� 

*/

  FNL_BAL_    number;   -- ��������� ���
  aOKPO_      int;      -- �������� ��� ����
  aND_       int;      -- �������� ��� ND
  aRNK_      int;      -- �������� ��� RNK
  aDAT_       date;     -- ������� ���� 
  
  FZ_  char(1);
  spPKdR_   number                ;

  ern CONSTANT POSITIVE   := 208; 
  err EXCEPTION; 
  erm VARCHAR2(80);

  
 
  type tp_kod  is table of varchar2(4) index by pls_integer;
  type tp_s    is table of number      index by pls_integer;
  type tp_zero is table of varchar2(3) index by pls_integer;
  type tp_indic is record
    ( kod    tp_kod
    , p_s    tp_s
    , p_zero tp_zero
    ) ;
  tp_indics tp_indic;

  
  type t_col_KVED
       is record(             KVED         fin_kved.kved%type,
                              NAME         ved.name%type,
                              VOLME_SALES  fin_kved.VOLME_SALES%type,
                              WEIGHT       fin_kved.WEIGHT%type,
                              FLAG         fin_kved.flag%type,
							  ord          int
                );

  TYPE t_KVED iS TABLE OF t_col_KVED;
  
  
  ---��� �������
  
  type tp_nds is record
    (  acc          number    
	  ,ostc         number    
	  ,nd           number
	  ,ost_pawn     number
    );
  type tp_nd is table of tp_nds index by pls_integer;
  
  type tp_accs is record
    (  acc          number    
	  ,ostc         number 
      ,kl           number 	  
	  ,kof          number
	  ,pawn         number
	  ,nd           tp_nd  
    );  
  type tp_acc  is table of tp_accs  index by pls_integer;
  
  type tp_pawn is record ( acc    tp_acc) ;
  tp_pawns tp_pawn;
  
  -- ����� �������� ������������ ����� ����
    type t_col_logk is record(  DAT  fin_fm.fdat%type    
                               ,OKPO fin_fm.okpo%type
                               ,IDF  fin_rnk.idf%type
                               ,err  int  );
    TYPE t_logk iS TABLE OF t_col_logk index by pls_integer;
	
    type tp_logk is record ( logk    t_logk) ;
	
    tp_logks tp_logk;
  
 function f_kpz_nd(p_nd number, p_dat date) return number;
 
 -- �������������� ���������� ���������	 type 3					   
procedure get_subpok_fo (RNK_  number,
                         ND_   number,
					     DAT_  date);
 
procedure calc_pd_fl(RNK_ number,
                     ND_  number,
                     DAT_ date,
					 CLS_ number,
					 VNCR_ varchar2);
					  
					  
-- �������������� ���������� ���������						   
procedure get_subpok_bud (RNK_  number,
                          ND_   number,
					      DAT_  date);

-- ����������� ����� ������������ (��������� 351)				  BUD  
procedure adjustment_class_bud(RNK_  number,
                               ND_   number,
					           DAT_  date);						  
---------------------------------------------------------------				 
--
-- ���������� ���������� �����������
--				 
---------------------------------------------------------------				  
/* 
 FUNCTION Calculation_KAT23 (aOBS_   int, 
                              CLASS_  int  
						      ) RETURN  number; 
  */
  
  
     FUNCTION ZN_rep (KOD_   char,
                 IDF_   int default 1,
                 DAT_   date default aDAT_,
                 OKPO_  int default aOKPO_
                 ) RETURN  number;
				 
---------------------------------------------------------------				 
--
-- ���������� ���������� �����������
--				 
---------------------------------------------------------------				  
  FUNCTION Calculation_FP (KOD_   char, 
                           OKPO_  int default aOKPO_, 
						   DAT_   date default aDAT_
						 ) RETURN  number; 


PROCEDURE Calc_FP (
	 		       OKPO_  int default aOKPO_, 
				   DAT_   date default aDAT_
				  ) ;
---
--
--   VED
--
---
 FUNCTION GET_VED (RNK_   number, fdat_max_ date default null) RETURN  number;
 
 FUNCTION GET_KVED (RNK_   number, fdat_max_ date, p_type number default 0) RETURN  varchar2;
 
 FUNCTION GET_GVED (RNK_   char,  fdat_max_ date default null ) RETURN  number;
---------------------------------------------------------------				 
--
-- ������������ �������� ��������
--				 
---------------------------------------------------------------							 
 PROCEDURE  ZN_IPB ( rnk_  in number,
                     ved   in int default 0, 
					 DAT_  in  date default aDAT_
					 ) ;

-- ���������� ������������� ��������� �� ����������� ����� �� �������� 351
PROCEDURE  calculation_class (rnk_  in number,
					          DAT_  in  date default aDAT_
					          ) ;					 
					 
 FUNCTION ZN_sql_p (KOD_   char, 
                 IDF_   int default 1,
				 DAT_   date default aDAT_,
				 OKPO_  int default aOKPO_
                 ) RETURN  number;	

 FUNCTION ZN_sql (KOD_   char, 
                 IDF_   int default 1,
				 DAT_   date default aDAT_,
				 OKPO_  int default aOKPO_,
				 p_null number default 0
                 ) RETURN  number;			
--===========================================================
FUNCTION ZN_P_ND_HIST (KOD_   char, 
                       IDF_   int default 1,
	    			   DAT_   date default aDAT_,
				       ND_    int default aND_,
				       RNK_   int default aRNK_
                      ) RETURN  number;

FUNCTION ZN_P_ND_REPL_HIST (KOD_   char,
						    IDF_   int default 1,
						    DAT_   date default aDAT_,
					    	ND_    int default  aND_,
						    RNK_   int default aRNK_
						) RETURN  fin_question_reply.name%type;
						

FUNCTION ZN_P_ND_date_hist (KOD_   char,
						    IDF_   int default 1,
						    DAT_   date default aDAT_,
						    ND_    int default aND_,
						    RNK_   int default aRNK_
						    ) RETURN  date ;



				 
---------------------------------------------------------------				 
--
-- �������� �������� ���������
--				 
---------------------------------------------------------------				  
  FUNCTION ZN_P (KOD_   char, 
                 IDF_   int default 1,
				 DAT_   date default aDAT_,
				 OKPO_  int default aOKPO_,
                 p_null number default 0				 
			   ) RETURN  number ; --result_cache; 	   

  FUNCTION ZN_P_ND (KOD_   char, 
                    IDF_   int default 1,
				    DAT_   date default aDAT_,
				    ND_    int default  aND_,
					RNK_   int default aRNK_,
				    p_null number default 0
					) RETURN  number;
					
  FUNCTION ZN_P_ND_date (KOD_   char,
						 IDF_   int default 1,
						 DAT_   date default aDAT_,
						 ND_    int default aND_,
						 RNK_   int default aRNK_
						 ) RETURN  date;					
---------------------------------------------------------------				 
--
-- �������� �������� ��������� �����1 �����
--				 
---------------------------------------------------------------				   
FUNCTION ZN_F1    (KOD_   char, 
                   GR_   char,    
                   DAT_   date default aDAT_,
				   OKPO_  int default aOKPO_
                    ) RETURN  number ;


---------------------------------------------------------------				 
--
-- �������� �������� ��������� �����2 �����
--				 
---------------------------------------------------------------	

FUNCTION ZN_F2    (KOD_   char, 
                   GR_   char,  
                   DAT_   date default aDAT_,
				   OKPO_  int default aOKPO_
                    ) RETURN  number;

---------------------------------------------------------------				 
--
-- �������� �������� ��������� �����2 �� �������
--				 
---------------------------------------------------------------			
   FUNCTION ZN_FDK (KOD_   char, 
                   DAT_   date ,
				   OKPO_  int default aOKPO_
                    ) RETURN  number;
---------------------------------------------------------------
--
--    �������� ��� ����� ��?�����? �� ��?���� ���?��
--
---------------------------------------------------------------
  FUNCTION F_FM ( 
                  OKPO_ int, 
                  DAT_ date  ) RETURN char RESULT_CACHE ;
				  
				  
---------------------------------------------------------------
--
--���?���� �������� ����� �1 �� ����� �2
--
----------------------------------------------------------------
  function logk_  ( DAT_ date, OKPO_ int , IDF_ int ) RETURN number ;
  
  FUNCTION LOGK ( 
                   DAT_ date, 
                   OKPO_ int, 
                   IDF_  int) RETURN number ;

---------------------------------------------------------------
--
--�������� ����� 2 �� �����������
--
---------------------------------------------------------------

  FUNCTION LOGK_D (
                    DAT_ date, 
                    OKPO_ int, 
                    IDF_  int)  RETURN number;


---------------------------------------------------------------
--
--  ����� �������� ���������
--
----------------------------------------------------------------

PROCEDURE record_fp(KOD_   IN  char, 
                     S_    IN  number,  
                     IDF_  IN  int,
				     DAT_  IN  date default aDAT_,
				     OKPO_ IN  int default aOKPO_  );
					
					
PROCEDURE record_fp_ND(KOD_   IN  char, 
                       S_    IN  number,  
                       IDF_  IN  int,
				       DAT_  IN  date default aDAT_,
				       ND_ IN  int default aND_,
                       RNK_   int default aRNK_ );	

PROCEDURE record_fp_ND_date(KOD_         IN  char,
    						val_date_    IN  date,
							IDF_         IN  int,
							DAT_         IN  date default aDAT_,
							ND_          IN  int  default aND_,
							RNK_         IN  int  default aRNK_ );					   

---------------------------------------------------------------
--
--  �����/����������  ����� ������ �� ����� ��������
--
----------------------------------------------------------------
				
PROCEDURE get_class(ND_ in number,
                    OKPO_ in number,
                    DAT_ in date,
					RNK_ in number
					);
					
PROCEDURE get_class_fl (ND_ in number,
	                    OKPO_ in number,
						DAT_ in date,
				     	RNK_ in number);

						
  FUNCTION LOGK_read (
                   DAT_ date,
                   OKPO_ int,
                   IDF_  int,
				   mode_ int ) RETURN number;

 FUNCTION CC_val 
              ( ND_ number,
			    RNK_ number,
				DAT_ date,
				l_pos varchar2 default '23'
              ) return number;

---------------------------------------------------------------
--
-- ϳ������ �������� � ��������� ����������
--
----------------------------------------------------------------
procedure Load_testND (
			Rnk_   number,
			ND_    number,
			DAT_   date  
	 	) ;

procedure correction_parameters (                    p_mod     Varchar2,
                                                     p_nd      Nbu23_Cck_Ul_Kor.nd%type,
                                                     p_zdat    varchar2,
                                                     p_fin23   Nbu23_Cck_Ul_Kor.fin23%type,
                                                     p_obs23   Nbu23_Cck_Ul_Kor.obs23%type,
                                                     p_kat23   Nbu23_Cck_Ul_Kor.kat23%type,
                                                     p_k23     Nbu23_Cck_Ul_Kor.k23%type,
                                                     p_fin_351 Nbu23_Cck_Ul_Kor.fin_351%type,
                                                     p_pd      Nbu23_Cck_Ul_Kor.pd%type,
                                                     p_comm    Nbu23_Cck_Ul_Kor.comm%type,
                                                     p_vkr     Nbu23_Cck_Ul_Kor.vkr%type);
													 
													 
 Procedure get_adjustment (p_mod   in  Varchar2,
                           p_nd    in  Nbu23_Cck_Ul_Kor.nd%type,
						   p_flag  Out number, 
						   p_fin23 Out Nbu23_Cck_Ul_Kor.fin23%type,
                           p_obs23 Out Nbu23_Cck_Ul_Kor.obs23%type,
                           p_kat23 Out Nbu23_Cck_Ul_Kor.kat23%type,
                           p_k23   Out Nbu23_Cck_Ul_Kor.k23%type
						   );
						   
 --  �������� ������� ��� WEB  �� ������� FIN_KVED
FUNCTION f_fin_kved  (p_rnk  customer.rnk%type,
                      p_okpo fin_kved.okpo%type,
                      p_dat  fin_kved.dat%type
                      )   					  
            RETURN t_kved PIPELINED  PARALLEL_ENABLE;

procedure determ_kved(p_rnk         customer.rnk%type,
                      p_okpo        fin_kved.okpo%type,
                      p_dat         fin_kved.dat%type				 	   
                      );
					  
Procedure save_volmesales (p_rnk         customer.rnk%type,
                           p_okpo        fin_kved.okpo%type,
                           p_dat         fin_kved.dat%type,  
                           p_kved        fin_kved.kved%type,
                           p_volme_sales fin_kved.VOLME_SALES%type 					 	   
                          );			

						  
Procedure del_volmesales (p_rnk         customer.rnk%type,
                          p_okpo        fin_kved.okpo%type,
                          p_dat         fin_kved.dat%type,  
                          p_kved        fin_kved.kved%type
                          );

						  
Procedure add_findat (p_rnk         fin_dat.rnk%type,
                      p_nd          fin_dat.nd%type,
                      p_dat         fin_dat.fdat%type);  

-- �������������� ���������� �� ������� �볺�� �� �����	
procedure rnk_group  (RNK_  number,
                      ND_   number,
					  DAT_  date,
					  zDAT_ date,
					  okpo_ varchar2);
					  
-- �������������� ���������� ���������
procedure get_subpok (RNK_  number,
                      ND_   number,
					  DAT_  date,
					  zDAT_ date);
					  
procedure get_restr  (RNK_  number,
                      ND_   number,
					  DAT_  date,
					  zDAT_ date);					  

-- ����������� ����� ������������ (��������� 351)				   
procedure adjustment_class (RNK_  number,
                            ND_   number,
					        DAT_  date,
					        zDAT_ date);

-- ������� ���������� �������� ����������� PD
function  get_pd (  p_rnk   IN  number,
                    p_nd    IN  number,
					p_dat   IN  date,   
					p_clas  in  number,
					p_vncr  in  varchar2,
					p_idf   in  number
                   ) return number;


/* **********************************************
*  ���������� ��������� ��� �볺���  ������������ �������
**************************************************/ 
procedure get_subpok_kons (RNK_  number,
                           ND_ number,
					       DAT_  date );				   

-- ����������� ����� �볺��� ������������ ������� (��������� 351)
procedure adjustment_class_kons (RNK_  number,
                                 ND_   number,
					             DAT_  date);


--� ������� �������� ���� �� ������ ���� ���� ������� ������ ������ ���������� 180 ���
-- elimination_events(p_rnk, p_nd, p_fdat, '53,54', 55)
procedure  elimination_events (  p_rnk        fin_nd.rnk%type 
                                ,p_nd         fin_nd.nd%type 
								,p_fdat       date
								,p_idf_list   varchar2
								,p_idf        number
                               );

	--*ֳ�� ������   (����������)

-- �������������� ���������� ���������						   
procedure get_subpok_bud_cp (RNK_  number,
                             ND_   number,
					         DAT_  date);
							 
-- ����������� ����� ������������ (��������� 351)				  BUD  
procedure adjustment_class_bud_cp(RNK_  number,
                                  ND_   number,
					              DAT_  date);

								 
function get_vnkr_cp (RNK_  number,
                      ND_   number, 
					  DAT_  date   ,
					  p_idf   number ) return varchar2;								 
								 
procedure set_vnkr_cp (RNK_   number,
                       ND_    number, 
				 	   DAT_   date   ,
					   p_idf  number ,
					   p_vnkr varchar2);


					   
function header_version return varchar2;

function body_version   return varchar2;		
			  
END fin_nbu;
/
CREATE OR REPLACE PACKAGE BODY BARS.FIN_NBU IS

 G_BODY_VERSION  CONSTANT VARCHAR2(64)  :=  'version 1.4.0  20.06.2017';
 G_coun    int;
 g_pawn    int;
 -------------------------------------------
 procedure trace ( p_mod  varchar2,
                   p_msg  SEC_AUDIT.REC_MESSAGE%type)
 as
 begin
 
 if user_id in( 1, 20094) then   logger.info  (p_mod||' '||p_msg);
                                 dbms_output.put_line(p_mod||' '||p_msg);
                          else   logger.trace (p_mod||' '||p_msg);
 end if; 
 
 end;
  
 FUNCTION ZN_rep (KOD_   char,
                 IDF_   int default 1,
                 DAT_   date default aDAT_,
                 OKPO_  int default aOKPO_
                 ) RETURN  number is
 sTmp_ number := 0 ;
 l_sql varchar2(4000) ;
 l_sql2 varchar2(4000) ;
 FM_ fin_fm.fm%type;

 BEGIN

 --   DEB.TRACE(1, KOD_||'-'||'Start',1);

    BEGIN
            select NVL(SS,s)
              into sTmp_
              from fin_rnk
             where okpo = OKPO_
               and fdat = DAT_
               and kod  = KOD_
               and idf  = IDF_;
 --   DEB.TRACE(1, KOD_||'-'||sTmp_||' Return',1);
           RETURN sTmp_;
           
                  exception when NO_DATA_FOUND
                         THEN   null;
    END;



FM_ := FIN_NBU.F_FM(OKPO_, DAT_);


 begin
 select kod_old
  into  l_sql
  from (
         select kod_old from fin_forma1 where kod = KOD_ and 1 = IDF_ and fm = 'N' and fm = decode(FM_,'N',FM_,' ','N')
         union all
         select kod_old from fin_forma2 where kod = KOD_ and 2 = IDF_ and fm = 'N' and fm = decode(FM_,'N',FM_,' ','N')
		  union all
		 select kod_old from fin_forma1m where kod = KOD_ and 1 = IDF_ and fm = 'R' and fm = decode(FM_,'R',FM_,'M','R')
		 union all 
		 select kod_old from fin_forma2m where kod = KOD_ and 2 = IDF_ and fm = 'R' and fm = decode(FM_,'R',FM_,'M','R')
        );
  exception when NO_DATA_FOUND
    then l_sql := 0;
   end;

    
 --  DEB.TRACE(1, KOD_||'-'||DAT_||'-kod_old-'||l_sql||'='||FIN_NBU.F_FM(OKPO_, DAT_)||'*'||OKPO_,1);
   
 l_sql :=  nvl(replace(replace(l_sql, '#(','fin_nbu.ZN_sql_p('''),')',''',IDF_, DAT_, OKPO_)'),0);
 l_sql2 := 'Select '||l_sql||' from (select :IDF_ as idf_, :DAT_ as dat_, :OKPO_ as okpo_, :FM_ as FM from dual)';


         begin
          execute immediate l_sql2 into sTmp_ using IDF_, DAT_, OKPO_, FM_;
          exception when NO_DATA_FOUND
                 THEN sTmp_ :=0;
         end;

    return sTmp_;



end ZN_rep;


 FUNCTION ZN_sql_p (KOD_   char, 
                 IDF_   int default 1,
				 DAT_   date default aDAT_,
				 OKPO_  int default aOKPO_
                 ) RETURN  number IS

 sTmp_ number := 0 ;
 
			   
BEGIN

     BEGIN	
    select NVL(SS,s) 
	  into sTmp_ 
	  from fin_rnk
	 where okpo = OKPO_
       and fdat = DAT_
       and kod  = KOD_
	   and idf  = IDF_;
          exception when NO_DATA_FOUND 
	 THEN  sTmp_ := 0;
    END;
  RETURN sTmp_;		   

end ZN_sql_p;

 FUNCTION ZN_sql (KOD_   char, 
                 IDF_   int default 1,
				 DAT_   date default aDAT_,
				 OKPO_  int default aOKPO_,
				 p_null number default 0
                 ) RETURN  number is
 sTmp_ number := p_null ;
 l_sql varchar2(4000) ;
 l_sql2 varchar2(4000) ;
 FM_ fin_fm.fm%type;
 
 BEGIN				 

 FM_ := FIN_NBU.F_FM(OKPO_, DAT_);
 
 --logger.info('ERROR_0 FIN_parse+sql '||KOD_||' '||IDF_||' '||FIN_NBU.F_FM(OKPO_, aDAT_)||' '||aDAT_);
 begin
 select kod_old
  into  l_sql
  from (
         select kod_old from fin_forma1 where kod = KOD_ and 1 = IDF_ and fm = FIN_NBU.F_FM(OKPO_, aDAT_)
		 union all 
		 select kod_old from fin_forma2 where kod = KOD_ and 2 = IDF_ and fm = FIN_NBU.F_FM(OKPO_, aDAT_)
		 union all
		 select kod_old from fin_forma1m where kod = KOD_ and 1 = IDF_ and fm = FIN_NBU.F_FM(OKPO_, aDAT_)
		 union all 
		 select kod_old from fin_forma2m where kod = KOD_ and 2 = IDF_ and fm = FIN_NBU.F_FM(OKPO_, aDAT_)
        );
  exception when NO_DATA_FOUND
    then l_sql := p_null;
--   logger.info('ERROR_1 FIN_parse+sql '||KOD_||' '||IDF_||' '||FIN_NBU.F_FM(OKPO_, aDAT_)||' '||aDAT_);
   end; 
    
	
 l_sql :=  nvl(replace(replace(l_sql, '#(','fin_nbu.ZN_sql_p('''),')',''',IDF_, DAT_, OKPO_)'), nvl(to_char(p_null),'null as s '));
 l_sql2 := 'Select '||l_sql||' from (select :IDF_ as idf_, :DAT_ as dat_, :OKPO_ as okpo_, :FM_ as FM from dual)';

-- logger.info('FIN_parse+sql  '||kod_||' - '||l_sql);
-- logger.info('FIN_parse+sql2 '||l_sql2);
         trace('ZN_sql','sTmp_4='||l_sql2);
		 begin
          execute immediate l_sql2 into sTmp_ using IDF_, DAT_, OKPO_, FM_; 
		  exception when NO_DATA_FOUND
		         THEN sTmp_ := p_null;
		 end;

	trace('ZN_sql','sTmp_3='||sTmp_);
    return sTmp_;
   


end ZN_sql;


  FUNCTION ZN_P (KOD_   char, 
                 IDF_   int default 1,
				 DAT_   date default aDAT_,
				 OKPO_  int default aOKPO_,
				 p_null number default 0				 
                 ) RETURN  number  is --result_cache relies_on (fin_rnk) IS

 sTmp_ number := 0 ;
 --nFM varchar2(1) := FIN_NBU.F_FM(OKPO_, aDAT_);
			   
BEGIN
  trace('ZN_P','sTmp_1='||p_null);
     BEGIN	
    select NVL(SS,S) 
	  into sTmp_ 
	  from fin_rnk
	 where okpo = OKPO_
       and fdat = DAT_
       and kod  = KOD_
	   and idf  = IDF_;
	   trace('ZN_P','sTmp_='||sTmp_);
          exception when NO_DATA_FOUND 
		         THEN 
				sTmp_:= fin_nbu.ZN_sql(KOD_, IDF_,  DAT_, OKPO_, p_null) ;
				trace('ZN_P','sTmp_2='||sTmp_);
				 
    END;
  RETURN sTmp_;		   

end ZN_P;

  FUNCTION ZN_P_ND (KOD_   char, 
                 IDF_   int default 1,
				 DAT_   date default aDAT_,
				 ND_    int default aND_,
				 RNK_   int default aRNK_,
				 p_null number default 0	
                 ) RETURN  number IS

 sTmp_ number := 0 ;
			   
BEGIN

    BEGIN	
    select s 
	  into sTmp_ 
	  from fin_nd
	 where nd = ND_ and rnk = RNK_
       --and fdat = DAT_
       and kod  = KOD_
	   and idf  = IDF_;
          exception when NO_DATA_FOUND 
		         THEN sTmp_ := p_null;
		--raise_application_error(-(20000),'\' ||'     '||KOD_||'³����� ��� �� ������ ����� - '||DAT_,TRUE); 
    END;
  RETURN sTmp_;		   

end ZN_P_ND;

FUNCTION ZN_P_ND_date (KOD_   char,
						 IDF_   int default 1,
						 DAT_   date default aDAT_,
						 ND_    int default aND_,
						 RNK_   int default aRNK_
						 ) RETURN  date IS

 sTmp_ date := null ;

BEGIN

    BEGIN
    select val_date
	  into sTmp_
	  from fin_nd
	 where nd = ND_ and rnk = RNK_
       and (fdat = DAT_ or DAT_ =DAT_)
       and kod  = KOD_
	   and idf  = IDF_;
          exception when NO_DATA_FOUND
		         THEN sTmp_ := null;
		--raise_application_error(-(20000),'/' ||'     '||KOD_||'³����� ��� �� ������ ����� - '||DAT_,TRUE);
    END;
  RETURN sTmp_;

end ZN_P_ND_date;

  FUNCTION ZN_P_ND_HIST (KOD_   char, 
                 IDF_   int default 1,
				 DAT_   date default aDAT_,
				 ND_    int default aND_,
				 RNK_   int default aRNK_
                 ) RETURN  number IS

 sTmp_ number := 0 ;
			   
BEGIN

    BEGIN	
    select s 
	  into sTmp_ 
	  from fin_nd_hist
	 where nd = ND_ and rnk = RNK_
       and fdat = DAT_
       and kod  = KOD_
	   and idf  = IDF_;
          exception when NO_DATA_FOUND 
		         THEN sTmp_ := null;
		--raise_application_error(-(20000),'\' ||'     '||KOD_||'³����� ��� �� ������ ����� - '||DAT_,TRUE); 
    END;
  RETURN sTmp_;		   

end ZN_P_ND_HIST;

FUNCTION ZN_P_ND_REPL_HIST (KOD_   char,
						    IDF_   int default 1,
						    DAT_   date default aDAT_,
					    	ND_    int default  aND_,
						    RNK_   int default aRNK_
						) RETURN  fin_question_reply.name%type is

sTmp_ fin_question_reply.name%type;

BEGIN

    BEGIN
  

	select  nvl(r.namep,R.NAME) as name
     into sTmp_
      from fin_question_reply r
     where r.kod = kod_
       and r.idf = idf_
       and r.val = ZN_P_ND_HIST(KOD_, IDF_, DAT_, ND_, RNK_);

	   exception when NO_DATA_FOUND
		         THEN return null;
    END;
  RETURN sTmp_;
end ZN_P_ND_REPL_HIST;


FUNCTION ZN_P_ND_date_hist (KOD_   char,
						 IDF_   int default 1,
						 DAT_   date default aDAT_,
						 ND_    int default aND_,
						 RNK_   int default aRNK_
						 ) RETURN  date IS

 sTmp_ date := null ;

BEGIN

    BEGIN
    select val_date
	  into sTmp_
	  from fin_nd_hist
	 where nd = ND_ and rnk = RNK_
       and fdat = DAT_
       and kod  = KOD_
	   and idf  = IDF_;
          exception when NO_DATA_FOUND
		         THEN sTmp_ := null;
		--raise_application_error(-(20000),'/' ||'     '||KOD_||'³����� ��� �� ������ ����� - '||DAT_,TRUE);
    END;
 
 if  (sTmp_ = to_date('01-01-0001','dd-mm-yyyy') or sTmp_ is null ) then return null;
                                           else return sTmp_;
 end if;

 
end ZN_P_ND_date_hist;
FUNCTION MIN_MAX_SCOR (    ID_   int,
                           KOD_  char,
                           ZN_   char
                          )
                          RETURN number is
    max_    number;
    min_    number;
    BEGIN

    Begin
                select max((min_val+ max_val)/2),  min((max_val+min_val)/2) --max(min_val), min(max_val)
                  into   max_,         min_
                  from FIN_NBU_SCORING
                 where  kod = KOD_ and
                        id = ID_   and
						fm = Case FZ_ when 'C' then 'R' else FZ_ end
              group by kod;
        exception when NO_DATA_FOUND
                     THEN
                        raise_application_error(-(20000),'/' ||'     '||KOD_||'³������ ���������� ������ ��� - '||ID_,TRUE);
                          return null;
    end;

       if ZN_ = 'MAX' then return max_;
    elsif ZN_ = 'MIN' then return min_;
    else  raise_application_error(-(20000),'/' ||'     '||KOD_||' Not correctly specified ZN_ - '||ZN_,TRUE);
    end if;

END MIN_MAX_SCOR;

procedure get_indic (p_kod fin_rnk.kod%type, p_s number, p_zero varchar2 default 'RZN')
as
t_ind pls_integer;
begin
 
   t_ind := tp_indics.kod.count()+1;
   tp_indics.kod( t_ind )    := p_kod;
   tp_indics.p_s( t_ind )    := p_s;
   tp_indics.p_zero( t_ind ) := p_zero;
 
end;

FUNCTION CALC_SCOR_BAL (KOD_   char,
                        l_val  number,
                        id_     number
                 ) RETURN  number IS

 sTmp_ number := null ;

 l_mins FIN_OBU_SIGN_TYPES.sign%type;
 l_maxs FIN_OBU_SIGN_TYPES.sign%type;
 l_sql varchar2(4000);

BEGIN

   trace('CALC_SCOR_BAL>',KOD_||' FZ_='||FZ_|| ' id_='||id_ );

for c in (select *
                  from FIN_NBU_SCORING t
                 where t.id = id_
                   and t.kod = kod_
                   and fm = Case FZ_ when 'C' then 'R' else FZ_ end
                   order by t.ord) loop
        -- �����
        select s.sign
          into l_mins
          from FIN_OBU_SIGN_TYPES s
         where s.id = c.min_sign;
        select s.sign
          into l_maxs
          from FIN_OBU_SIGN_TYPES s
         where s.id = c.max_sign;

       
   
        l_sql := 'select 1 from dual where :min_val '|| l_mins || ':l_val and :l_val '||l_maxs ||' :max_val';
      

         trace('CALC_SCOR_BAL>',KOD_||' sql > '||'select 1 from dual where '|| c.min_val || ' '|| l_mins || ' '|| l_val || ' and '|| l_val || ' '||l_maxs ||' '|| c.max_val || '');

         begin
                execute immediate l_sql into sTmp_ using c.min_val, l_val, l_val, c.max_val; 
         exception when NO_DATA_FOUND
                 THEN null;
         end;

          if sTmp_ = 1  then  return c.SCORE;   	 end if;

        END LOOP;

	   return null; 
    

end CALC_SCOR_BAL;


-- ����� �������� � ��������
function set_indic (p_id  fin_nbu_scoring.id%type, 
                    p_kod fin_rnk.kod%type) return number
as
sTmp number;
begin

 FOR f IN 1 .. tp_indics.kod.COUNT()
 LOOP
  if tp_indics.kod(f) = p_kod then
      case when tp_indics.p_zero(f) != 'RZN' 
	       then sTmp :=  CALC_SCOR_BAL(p_kod, MIN_MAX_SCOR(p_id, tp_indics.kod(f), tp_indics.p_zero(f)), p_id ) ;
	       else sTmp :=  CALC_SCOR_BAL(p_kod, tp_indics.p_s(f)*100, p_id);
	  end case;
	   record_fp(regexp_replace(p_kod,'PK','X'), sTmp, 6, aDAT_, aOKPO_);
	  return sTmp;
  end if;
 
 END LOOP;
 
end;

  FUNCTION GET_VED (RNK_   number, fdat_max_ date default null ) RETURN  number IS
ved_  varchar2(5);
OKPO_ varchar2(12);
v_ number;

k111_ varchar2(2);
k112_ varchar2(1);

sumk_ number;
Sumv_ number; 

begin

     select ved , okpo
        into ved_ , OKPO_
      from fin_customer 
    where rnk = rnk_;

	ved_ := GET_KVED(RNK_,fdat_max_);
	
	Begin
    select k111, k112 
       into k111_, k112_  
     from kl_k110 
   where k110 = ved_ --and d_open < sysdate 
               and (d_close is null )
			   and rownum = 1
               order by d_close desc;			   
    exception when NO_DATA_FOUND THEN 
             --raise_application_error(-(20000),'\ ' ||'     ������� ���� ��� ��� -'||rnk_||' (���� '||ved_||' �� ���� � �������� (KL_K110) ��� ��������',TRUE);  
		--k111_ := 0; 
		--k112_ := 0;	
                begin
				   select k111, k112 
					   into k111_, k112_  
					 from kl_k110 
				   where k110 = ved_ --and d_open < sysdate 
							   and rownum = 1
							   order by d_close desc;
		exception when NO_DATA_FOUND THEN
		      raise_application_error(-(20000),'\ ' ||'     ������� ���� ��� ��� -'||rnk_||' (���� '||ved_||' �� ���� � �������� (KL_K110) ',TRUE);  
		end;


		
    end;

if substr(ved_,1,1) != 'N' then
	

			if   k111_ in ('01','02','03','04','05') and k112_ in ('A', 'B')                                                               then     v_:=1;
		 elsif   k111_ in ('15', '16') and k112_ in ('D')                                                                                  then     v_:=2;
		 elsif   k111_ in ('17','18','19','20','21','22', '36') and k112_ in ('D')                                                         then     v_:=3;
		 elsif   (k111_ in ('40','41') and k112_ in ('E') ) or
				 (k111_ in ('23','24','25','26','27','28','29','30','31','32','33','34','35','37') and k112_ in ('C','D') )                then     v_:=4;
		 elsif   k111_ in ('45') and k112_ in ('F')                                                                                        then     v_:=5;
		 elsif   k111_ in ('50','51','52','53','54','55') and k112_ in ('G','H')                                                           then     v_:=6;
		 elsif   k111_ in ('60','61','62','63','64') and k112_ in ('I')                                                                    then     v_:=7;
		 elsif   k111_ in ('65','67') and k112_ in ('J')                                                                                   then     v_:=8;
		 else    v_:=9;
		 end if; 
 
 else
 /*
 ³������� � ���������� ������
 */

			if   k111_ in ('01','02','03')                                                                                   then     v_:=1;
		 elsif   k111_ in ('10', '11', '12')                                                                                 then     v_:=2;
		 elsif   k111_ in ('13','14','15','16','17','18', '31', '32')                                                        then     v_:=3;
		 elsif   (k111_ between '05' and '09' 
			   or k111_ between '19' and '30' or k111_ in ('33','35')
			   or k111_ between '36' and '39')                                                                               then     v_:=4;
		elsif (k111_ between '41' and '43')                                                                                  then     v_:=5;
		elsif (k111_ between '45' and '47' or k111_ between '55' and '56')                                                   then     v_:=6;
		elsif (k111_ between '49' and '53' or k111_ between '61' and '61')                                                   then     v_:=7;
		elsif (k111_ between '64' and '66' )                                                                                 then     v_:=8;
		elsif (k111_ between '58' and '60' or k111_ between '62' and '63'
			   or k111_ between '68' and '99')                                                                               then     v_:=9;

		 else                                                                                                                         v_:=9;
		 end if;
 
end if;

    IF      fdat_max_ IS NULL THEN RETURN v_;
      ELSE

SELECT SUM (s)
  INTO sumk_
  FROM fin_rnk
 WHERE okpo = OKPO_ AND idf IN (1, 2) AND fdat = fdat_max_;

                      IF sumk_ != 0 THEN
                         IF    f_fm(okpo_, fdat_max_) = ' '  THEN Sumv_ :=  ZN_P ('035'    ,   2 ,   fdat_max_  ,  OKPO_);
						 elsIF f_fm(okpo_, fdat_max_) = 'N'  THEN Sumv_ :=  ZN_P ('2000'   ,   2 ,   fdat_max_  ,  OKPO_);
						 elsIF f_fm(okpo_, fdat_max_) in('R','C')  THEN Sumv_ :=  ZN_P ('2000'   ,   2 ,   fdat_max_  ,  OKPO_);
                         ELSE                                     Sumv_ :=  ZN_P ('030'    ,   2 ,   fdat_max_  ,  OKPO_);
                      END IF;

                          IF    Sumv_ = 0 THEN RETURN 9;
                          ELSE                 RETURN v_;
                          END IF;

              ELSE  RETURN v_;
              END IF;

    END IF;

 
 
--    RETURN v_;
 	   

end GET_VED;

-- ���������� ����� ���� ��������� �������� (��������� 351)
FUNCTION GET_GVED (RNK_   char, 
                   fdat_max_ date default null ) RETURN  number IS
	ved_  varchar2(5);
	OKPO_ varchar2(12);
	v_ number;

	k111_ varchar2(2);
	k112_ varchar2(1);

begin

	ved_ := GET_KVED(RNK_,fdat_max_, 1);
	
 
       begin		
		select   okpo
		   into   OKPO_
		   from fin_customer 
		  where rnk = rnk_;
        exception when NO_DATA_FOUND THEN  null;		   
	   end;
 

	Begin
		select k111, k112 
		  into k111_, k112_  
	 	  from kl_k110 
  	     where k110 = ved_ 
		   and (d_close is null )
		   and rownum = 1
		 order by d_close desc;			   
	exception when NO_DATA_FOUND THEN  
	    if ved_ is null 
		  then  null; --raise_application_error(-(20000),'\ ' ||'     �� ������� ���������� ��� ������������� �2 ����� 2000  ��� ��� -'||rnk_||'  ',TRUE);  
          else  raise_application_error(-(20000),'\ ' ||'     ������� ���� ��� ��� -'||rnk_||' (���� '||ved_||' �� ���� � �������� (KL_K110) ��� ��������',TRUE);  
		end if;
	end;


		 case	
		    when k112_ in ('A')          then     v_:=1;
		    when k112_ in ('B','C','F')  then     v_:=2;
            when k112_ in ('G')          then     v_:=3;			
		    else                                  v_:=4;
		 end case;

		 /*
		  ���� �2,2000 = 0 ��    v_:=4;
		 */
		  if  zn_p('2000', 2, fdat_max_, okpo_) = 0
		     then   v_:=4;
		 end if;
		  
		 
   RETURN v_;

end GET_GVED;

FUNCTION GET_KVED (RNK_   number, fdat_max_ date, p_type number default 0) RETURN  varchar2 IS
  p_kved fin_fm.ved%type;
  p_ved  varchar2(5);
  okpo_  varchar2(14);
  begin
     -- 967081 , 948050
  		  begin
			  select ved, okpo
				into p_ved, okpo_
				from fin_customer
			   where rnk = rnk_;
			 exception when NO_DATA_FOUND THEN p_ved := null;
		  end;
 
 if  p_type = 0 then   return p_ved; end if;
  
		  begin
			  select ved
				into p_kved
				from fin_fm
			   where okpo = okpo_ and fdat = trunc(fdat_max_,'YYYY');
			 exception when NO_DATA_FOUND THEN  p_kved := null;
		  end;

		    if p_kved is null then
			    begin
						  select ved
							into p_kved
							from fin_fm
						   where okpo = okpo_ and fdat = fdat_max_;
						 exception when NO_DATA_FOUND THEN p_kved := null;
					  end;
			 end if;			  

 
if p_kved is not null then  return p_kved;
else return null;
end if;

end get_kved;

  PROCEDURE  ZN_IPB (rnk_  in number,
                     ved  in int default 0, 
					 DAT_  in  date default aDAT_
					 ) 
	IS

 sTmp_ number := 0 ;
 K1  number := 0 ;
 K2  number := 0 ;
 K3  number := 0 ;
 K4  number := 0 ;
 K5  number := 0 ;
 K6  number := 0 ;
 K7  number := 0 ;
 K8  number := 0 ;
 K9  number := 0 ;
 K10  number := 0 ;
 OKPO_ number;
 ved_ number;
 sum_s_ number;
 
k_  number := 0 ;
			   
BEGIN

 calculation_class(rnk_, dat_);
 
	if nvl(VED, 0) = 0 or nvl(VED, 0) > 9 then        ved_ :=GET_VED(RNK_ , DAT_);
     else  ved_ := VED;
	end if; 

	/*���� ��� ����� � 2 ���� ��� �������� ���������� (����� 035) ��� ���� � 2-�   
	  (� 2-��) ���� ��� �������� ���������� (����� 030) ������ ������� ��������, 
	  ���� ��� ���������� ������������� ��������� �������� � �������� ����� ����������� 
	  ������ ���������� � 9 ����� ������� �� ���������;*/
	
	
	select okpo
	  into OKPO_
	  from fin_customer
	 where rnk = rnk_;
	
	begin
    select sum(s) 
	  into sum_s_
	  from fin_rnk 
	 where idf in (1,2) 
	   and okpo = OKPO_ 
	   and fdat = DAT_;
  exception when NO_DATA_FOUND THEN sum_s_ := 0;
  END;  
	
  aOKPO_ :=  OKPO_;
  aDAT_  :=  trunc(DAT_);
  FZ_    := fin_nbu.F_FM (aOKPO_, aDAT_ ) ; 
 

	  
  if  sum_s_ = 0 then goto exit_prc;   end if;   --���� �������� ������� ����� �� ������������� ���� = 8
 
 K1 :=  Calculation_FP('K1');    case when K1 >= 100 then k1 := 100; else K1 := K1; end case;     record_fp('K1', K1, 6, DAT_, OKPO_);
 K2 :=  Calculation_FP('K2');    case when K2 >= 100 then k2 := 100; else K2 := K2; end case;     record_fp('K2', K2, 6, DAT_, OKPO_);
 K3 :=  Calculation_FP('K3');    case when K3 >= 100 then k3 := 100; else K3 := K3; end case;     record_fp('K3', K3, 6, DAT_, OKPO_);
 K4 :=  Calculation_FP('K4');    case when K4 >= 100 then k4 := 100; else K4 := K4; end case;     record_fp('K4', K4, 6, DAT_, OKPO_);
 K5 :=  Calculation_FP('K5');    case when K5 >= 100 then k5 := 100; else K5 := K5; end case;     record_fp('K5', K5, 6, DAT_, OKPO_);
 K6 :=  Calculation_FP('K6');    case when K6 >= 100 then k6 := 100; else K6 := K6; end case;     record_fp('K6', K6, 6, DAT_, OKPO_);
 K7 :=  Calculation_FP('K7');    case when K7 >= 100 then k7 := 100; else K7 := K7; end case;     record_fp('K7', K7, 6, DAT_, OKPO_);
 K8 :=  Calculation_FP('K8');    case when K8 >= 100 then k8 := 100; else K8 := K8; end case;     record_fp('K8', K8, 6, DAT_, OKPO_);
 K9 :=  Calculation_FP('K9');    case when K9 >= 100 then k9 := 100; else K9 := K9; end case;     record_fp('K9', K9, 6, DAT_, OKPO_);
 K10 :=  Calculation_FP('K10');  case when K10 >= 100 then k10 := 100; else K10 := K10; end case; record_fp('K10', K10, 6, DAT_, OKPO_);
 
 if FZ_ in (' ', 'N') then
    
	       if ved_ = 1  then sTmp_ := (( 1.3*K3) + (0.03*K4) + (0.001*K5) + (0.61*K6) + ( 0.75*K7) + ( 2.5*K8) + (0.04*K9) - 0.2);
		                     --RETURN sTmp_;	 
	
        elsif ved_ = 2  then sTmp_ := ((0.035*K1) +(0.04*K2) + (2.7*K3) +( 0.1*K6) + (1.1*K7) +( 1.2*K8) + (0.05*K9) -  0.8);
		                     --RETURN sTmp_;	 
 
        elsif ved_ = 3  then sTmp_ := ((0.95*K3)  + (0.03*K4) + ( 1.1*K6)  + ( 1.4*K7) + ( 3.1*K8)  + (0.04*K9) + (0.03*K10) -  0.45);
		                     --RETURN sTmp_; 

	    elsif ved_ = 4  then sTmp_ := ((0.025*K1) + (1.9*K3) +( 0.45*K6) + (1.5*K8) +( 0.03*K9) -  0.5);
		                     --RETURN sTmp_; 

	    elsif ved_ = 5  then sTmp_ := ((0.02*K1) + (1.7*K3) + (0.01*K4) + (0.3*K6) + ( 0.4*K7) + (2.9*K8) - 0.1);
		                     --RETURN sTmp_; 


	    elsif ved_ = 6  then sTmp_ := ((1.03*K3) + (0.001*K4) + (0.16*K6) + (  0.6*K7) + ( 2.9*K8) + ( 0.08*K9) - 0.14);
		                     --RETURN sTmp_; 

	    elsif ved_ = 7  then sTmp_ := ((0.07*K2) + (1.27*K3) + (0.32*K6) + (1.98*K8) +(0.04*K9) + (0.04*K10) - 0.15);
		                     --RETURN sTmp_; 

	    elsif ved_ = 8  then sTmp_ := ((0.025*K1) + ( 2.7*K3) + (0.005*K4) + (0.13*K7) + (  2.4*K8) -  0.93);
		                     --RETURN sTmp_; 

	    elsif ved_ = 9  then sTmp_ := ((0.03*K1) + (  0.9*K3) + (0.01*K4) + (0.002*K5) + (0.15*K6) + (  0.5*K7) + ( 2.9*K8) -   0.05);
		                     --RETURN sTmp_; 
		
        							 
    	 end if;		
		 
		 
  else
                                          
  	       if ved_ = 1  then sTmp_ := ((0.02*K1) + (0.02*K2) + (1.5*K3) + (0.6*K7) + (2.6*K8) + (0.008*K9) -1.1);
		                     --RETURN sTmp_;	 
	 
        elsif ved_ = 2  then sTmp_ := ((0.01*K1) + (0.03*K2) + (2.2*K3) + (0.03*K4) + (0.95*K7) + (1.3*K8) + (0.06*K9) + (0.2*K10) - 0.7);
		                     --RETURN sTmp_;	 
 
        elsif ved_ = 3  then sTmp_ := ((0.03*K2) + (1.95*K3) + (0.01*K4) + (0.002*K6) + (2.5*K7) + (0.8*K8) + (0.05*K9) - 0.9);
		                     --RETURN sTmp_; 

	    elsif ved_ = 4  then sTmp_ := ((0.01*K1) + (2.42*K3) + (0.01*K4) + (0.05*K7) + (1.35*K8) + (0.05*K9) - 0.7);
		                     --RETURN sTmp_; 

	    elsif ved_ = 5  then sTmp_ := ((0.02*K1) + (2.2*K3) + (0.001*K5) + (0.01*K6) + (0.009*K7) + (1.4*K8) + (0.2*K10) - 0.27);
		                     --RETURN sTmp_; 


	    elsif ved_ = 6  then sTmp_ := ((0.03*K1) + (1.85*K3) + (0.004*K4) + (0.001*K5) + (0.1*K6) + (0.2*K7) + (2.2*K8) + (0.009*K9) - 0.35);
		                     --RETURN sTmp_; 

	    elsif ved_ = 7  then sTmp_ := ((0.04*K1) + (0.01*K2) + (1.8*K3) + (0.002*K5) + (0.6*K6) + (0.85*K7) + (1.7*K8) + (0.03*K9) - 0.8);
		                     --RETURN sTmp_; 

	    elsif ved_ = 8  then sTmp_ := ((0.02*K1) + (1.7*K3) + (0.001*K4) + (0.001*K5) + (0.15*K6) + (3.1*K8) + (0.02*K9) - 0.4);
		                     --RETURN sTmp_; 

	    elsif ved_ = 9  then sTmp_ := ((0.01*K1) + (1.92*K3) + (0.01*K6) + (0.02*K7) + (1.2*K8) + (0.01*K9) - 0.35);
		                     --RETURN sTmp_; 

         end if;
  
  
 -- return 0;
end if;  
	
 
   <<exit_prc>>
   
   record_fp('IPB',  round(sTmp_,2), 6, DAT_, OKPO_);
/*  if  sum_s_ = 0 then  record_fp('IPB',  0, 6, DAT_, OKPO_);
else                 record_fp('IPB',  sTmp_, 6, DAT_, OKPO_);
 end if; */    
 --���� �������� ������� ����� �� ������������� ���� = 8
   
  
   
  -- get_class(RNK_ ,	OKPO_ ,	DAT_ ,	VED_  );

   
end ZN_IPB;

-- ���������� ������������� ��������� �� ����������� ����� �� �������� 351
PROCEDURE  calculation_class (rnk_  in number,
					          DAT_  in  date default aDAT_
					          ) 
IS
	 sTmp_ number := 0 ;
	 OKPO_ number;
	 ved_ number;
	 sum_s_ number;
	 l_cls_DB  number;
	 k_  number := 0 ;
	 l_clas number;
	 l_mod varchar2(254) := 'fin_nbu.calculation_class >>';		   
  BEGIN

		ved_ :=GET_GVED(RNK_ , DAT_);

		select okpo
		  into OKPO_
		  from fin_customer
		 where rnk = rnk_;
		
		begin
		select sum(s) 
		  into sum_s_
		  from fin_rnk 
		 where idf in (1,2) 
		   and okpo = OKPO_ 
		   and fdat = DAT_;
	  exception when NO_DATA_FOUND THEN sum_s_ := 0;
	  END;  
		
	  aOKPO_ :=  OKPO_;
	  aDAT_  :=  trunc(DAT_);
	  FZ_    :=  fin_nbu.F_FM (aOKPO_, aDAT_ ) ; 

	   Delete from fin_rnk where okpo = aOKPO_  and fdat = aDAT_ and idf = 6 and kod like 'X%';
	   
     	if  (LOGK_read (DAT_,OKPO_,1,1)=0) 
		   then null;
		   else    record_fp('PIPB',  -1, 6, DAT_, OKPO_);
	               record_fp('CLAS',  10, 6, DAT_, OKPO_);
				   record_fp('GVED',  ved_, 6, DAT_, OKPO_);
				   return;
		end if;
		 
	  
	  
	   -- ���������� ���������  
		Calc_FP();
		
	 --  if  sum_s_ = 0 then goto exit_prc;   end if;   --���� �������� ������� ����� �� ������������� ���� = 8
	  
	      if ved_ = 1 and FZ_ = 'N' then
			  sTmp_ := 2.767 + (0.309 * set_indic(1,'PK11')) +  (0.821 * set_indic(1,'PK15')) + (0.577 * set_indic(1,'PK1')) + (0.504 * set_indic(1,'PK10')) + (0.291 * set_indic(1,'PK16'));
	          --trace(l_mod, '2.767 + (0.309 * '||set_indic(1,'PK11')||') +  (0.821 * '||set_indic(1,'PK15')||') + (0.577 * '||set_indic(1,'PK1')||') + (0.504 * '||set_indic(1,'PK10')||') + (0.291 * '||set_indic(1,'PK16')||')');
	   elsif ved_ = 2 and FZ_ = 'N' then
	          sTmp_ := 1.884 + (0.240 * set_indic(2,'PK11')) +  (0.288 * set_indic(2,'PK4'))  + (0.557 * set_indic(2,'PK15')) + (0.335 * set_indic(2,'PK2')) + (0.678 * set_indic(2,'PK13')) 
			                 + (0.457 * set_indic(2,'PK7') ) +  (0.342 * set_indic(2,'PK1'))  + (0.203 * set_indic(2,'PK3'));
              
	   elsif ved_ = 3 and FZ_ = 'N' then
	          sTmp_ := 2.366 + (0.430 * set_indic(3,'PK1'))  + (0.656 * set_indic(3,'PK15')) + (0.517 * set_indic(3,'PK8')) + (0.630 * set_indic(3,'PK16')) 
			                 + (0.228 * set_indic(3,'PK10')) + (0.489 * set_indic(3,'PK12')) + (0.437 * set_indic(3,'PK6'));

	   elsif ved_ = 4 and FZ_ = 'N' then
	          sTmp_ := 2.042 + (0.686 * set_indic(4,'PK6')) +  (0.473 * set_indic(4,'PK14')) + (0.272 * set_indic(4,'PK5')) +  (0.816 * set_indic(4,'PK9')) + (0.902 * set_indic(4,'PK10')) + (0.494 * set_indic(4,'PK3'));
							 

       -- ����� ���������� ������������� ��������� �������� � �������� ����� ��� ������ ����������							        

       elsif ved_ = 1 and FZ_ in ('R','C') then
	          sTmp_ := 2.844 + (0.650 * set_indic(1,'PK11')) + (0.506 * set_indic(1,'PK3')) + (1.689 * set_indic(1,'PK10')) + (0.287 * set_indic(1,'PK4')) 
			                 + (0.656 * set_indic(1,'PK7'))  + (0.608 * set_indic(1,'PK5')) + (0.373 * set_indic(1,'PK2')) ;

       elsif ved_ = 2 and FZ_ in ('R','C') then
	          sTmp_ := 2.177 + (0.523 * set_indic(2,'PK1')) + (0.471 * set_indic(2,'PK5')) + (0.426 * set_indic(2,'PK2')) + (0.318 * set_indic(2,'PK11'))+ (0.246 * set_indic(2,'PK12'));
			 
       elsif ved_ = 3 and FZ_ in ('R','C') then
	          sTmp_ := 2.427 + (0.490 * set_indic(3,'PK11'))  + (0.717 * set_indic(3,'PK8')) + (0.393 * set_indic(3,'PK6')) + (0.637 * set_indic(3,'PK3')) + (0.380 * set_indic(3,'PK5'));

	   elsif ved_ = 4 and FZ_ in ('R','C') then
	          sTmp_ := 1.798 + (0.486 * set_indic(4,'PK9')) + (0.436 * set_indic(4,'PK6')) + (0.345 * set_indic(4,'PK1')) +  (0.365 * set_indic(4,'PK13')) + (0.333 * set_indic(4,'PK3')) ;
 
	   else	 sTmp_ := null;
	         --raise_application_error(-(20000),'/' ||'     '||'�� ��������� ����� ���������� ������������� ��������� �������� '||ved_,TRUE);				  
			   
	   end if;   

	   trace(l_mod,'��� ��������� �������� = '||ved_);
       record_fp('GVED',  ved_, 6, DAT_, OKPO_);	   
       trace(l_mod,'������������ �������� = '||to_char(sTmp_, '9999990.999'));	
	   record_fp('PIPB',  round(sTmp_,3), 6, DAT_, OKPO_);
	   
	   -- ��������� ���� �� ������������� ���������.
	   l_clas := CALC_SCOR_BAL('CLAS',sTmp_,ved_);
	   trace(l_mod,'���� ������������ = '||l_clas);	

       record_fp('CLAS',  l_clas, 6, DAT_, OKPO_);
  

	  -- <<exit_prc>>
 end calculation_class;

FUNCTION ZN_F1    (KOD_   char, 
                   GR_   char,    
                   DAT_   date default aDAT_,
				   OKPO_  int default aOKPO_
                    ) RETURN  number  IS

dat0_ date					;
k_ number;
BEGIN
if gr_ = 4 then dat0_ := DAT_;
elsif gr_ = 3 then dat0_ := trunc( (DAT_ - 1) , 'Y' ); 
else  return 0;
end if;

 begin
   select 1
     into k_
     from fin_fm
    where okpo = OKPO_
      and fdat = DAT0_;
  exception when NO_DATA_FOUND THEN  raise_application_error(-(20000),'\ '||'     ��� ��������� (������) '||KOD_||' ³����� ��� �� ������ ����� - '||DAT0_,TRUE); 
  END; 

  
  if LOGK_(DAT_, OKPO_, 1) > 0 
   then  raise_application_error(-(20000),'\ '||'      ������ ����� �1 ���������� � ��������� �� ����� - '||DAT0_,TRUE);  
 null;
  end if;


return ZN_P(KOD_, 1, DAT0_, OKPO_) ;

END ZN_F1;


FUNCTION ZN_F2    (KOD_   char, 
                   GR_   char,  
                   DAT_   date default aDAT_,
				   OKPO_  int default aOKPO_
                    ) RETURN  number IS
dat0_     date					;
dat1_     date					;

Q_        number ;                   -- � ������� ��������
l_        number ;        -- 0  -  ��������� ���� ������� �� ������ 5 ������ ������
                          -- >0 - not ��������� ���� ������� �� ������ 5 ������ ������
BEGIN

FZ_ :=  FIN_NBU.F_FM(OKPO_, DAT_);
	/*
	��� ��� ����� ����������..........
	���� ��������� ����� ������� � ����� � ����.....
	
	
	�������� �������� ������������ ���������� ��������� �� ������ ��������.

���������� ��������� �� ������ ����� ����������� � ����� �����:
�) � ��� �������� � ����� ��������� ���� ������� �� ������ 5 ������ ������ - ������ 
   ������������� ����� �� ������ ������ ��������, ���������� �� ������ ���� ��������� �������;
�) � ��� ��������� � ����� ��������� ���� ������� �� ������ 5 ������ ������ � ������ ����������� 
   �����, ��������� �� ������������ ���������� ������� ������, �� ���������� ��������� 4/N, �� N - ���������� ����� ���������� ������� ������ (��������);
�) � ��� ��������� ��������� ������� ��� ���������� ����� �� �.�) �� ���������� ���������� � 
   ����������� ���� �.�.3.10.2. ���� ��������

   */
   
   -- ������� �������
   
   
 select count(*)
  into l_ 
from fin_fm 
where okpo =  OKPO_
   and fdat between  add_months(trunc( DAT_),-12) and DAT_
   --and Fm <> FIN_NBU.F_FM(OKPO_, DAT_);  
   and Fm not in ( FZ_, decode(FZ_,'N',' ',' ','N','-') ); 
 
	
	if l_ > 0 or FZ_ not in ( ' ', 'N') then spPKdR_ := 1;
	else 
	   
	    select count(*)
		  into l_ 
		from fin_fm 
		where okpo =  OKPO_
		   and fdat between  add_months(trunc( DAT_),-12) and DAT_
		   --and Fm = FIN_NBU.F_FM(OKPO_, DAT_); 
		   and fm in ( FZ_, decode(FZ_,'N',' ',' ','N','-')  );
	   if l_ < 5 then spPKdR_ := 1;
	   end if;
	
	
	end if; 
	
	-- ������� �����
	
	
	 IF spPKdR_ = 1  
	 -- ����� �1 �������������� ���

	    then   

		if LOGK_(DAT_, OKPO_, 2) > 0 
        then  raise_application_error(-(20000),'\ '||'       ����� �2 ��������� � ��������� �� ����� - '||DAT_,TRUE);  end if;

		if gr_ = 4 
				   then 
				    dat0_ := DAT_;
					Q_    := to_char( (dat0_ - 1) , 'Q'); 
				        return         round(  (zn_p(KOD_, 2, DAT0_, OKPO_)/Q_)*4);
					
				elsif gr_ = 3 
				   then dat0_ := DAT_ ; 
						return          ZN_P(KOD_, 2, DAT0_, OKPO_) ; 
				 else  return           0;
				 end if;
		
		
  elsIF spPKdR_ = 2
     -- ����� �2 �������������� ���
        then   
		
			    if gr_ = 4 
				   then 
				    dat0_ := DAT_;
      				 dat1_ := trunc( (DAT_ - 1) , 'Y' ); 
					 Q_    := to_char( (dat0_ - 1) , 'Q'); 
 	 if LOGK_(DAT_, OKPO_, 2) > 0 then  raise_application_error(-(20000),'\ '||'       ����� �2 ��������� � ��������� �� ����� - '||DAT_,TRUE);  end if;
	 if LOGK_(DAT1_, OKPO_, 2) > 0 then  raise_application_error(-(20000),'\ '||'       ����� �2 ��������� � ��������� �� ����� - '||DAT1_,TRUE);  end if;	 
					 return  round((ZN_P(KOD_, 2, DAT1_, OKPO_)+ZN_P(KOD_, 2, DAT0_, OKPO_))/(4 + Q_))*4;
					
				elsif gr_ = 3 
			 	    then            dat0_ := DAT_ ; 
						            if LOGK_(DAT_, OKPO_, 2) > 0 then  raise_application_error(-(20000),'\ '||'       ����� �2 ��������� � ��������� �� ����� - '||DAT_,TRUE);  end if;
		    		return          ZN_P(KOD_, 2, DAT0_, OKPO_) ; 
				 else  return           0;
				 end if;
		
				
		
  elsIF spPKdR_ = 3
     -- ����� �3 �������������� ���
        then  
				if gr_ = 4 
				   then dat0_ := DAT_;
				   return (ZN_FDK(KOD_,DAT_, OKPO_) +  ZN_FDK(KOD_,add_months(trunc(DAT_),-3), OKPO_) + ZN_FDK(KOD_,add_months(trunc(DAT_),-6), OKPO_) + ZN_FDK(KOD_,add_months(trunc(DAT_),-9), OKPO_));
  	 if LOGK_(DAT_, OKPO_, 2) > 0                       then  raise_application_error(-(20000),'\ '||'       ����� �2 ��������� � ��������� �� ����� - '||DAT_,TRUE);  end if;
	 if LOGK_(add_months(trunc(DAT_),-3), OKPO_, 2) > 0 then  raise_application_error(-(20000),'\ '||'       ����� �2 ��������� � ��������� �� ����� - '||add_months(trunc(DAT_),-3),TRUE);  end if;
	 if LOGK_(add_months(trunc(DAT_),-6), OKPO_, 2) > 0 then  raise_application_error(-(20000),'\ '||'       ����� �2 ��������� � ��������� �� ����� - '||add_months(trunc(DAT_),-6),TRUE);  end if;
	 if LOGK_(add_months(trunc(DAT_),-9), OKPO_, 2) > 0 then  raise_application_error(-(20000),'\ '||'       ����� �2 ��������� � ��������� �� ����� - '||add_months(trunc(DAT_),-9),TRUE);  end if;	 
				elsif gr_ = 3 
				   then dat0_ := DAT_ ; 
				   	    if LOGK_(DAT_, OKPO_, 2) > 0 then  raise_application_error(-(20000),'\ '||'       ����� �2 ��������� � ��������� �� ����� - '||DAT_,TRUE);  end if;
						return ZN_P(KOD_, 2, DAT0_, OKPO_) ; 
				else  return 0;
				end if;
	
	END IF;


END ZN_F2;


  FUNCTION ZN_FDK (KOD_   char, 
                   DAT_   date ,
				   OKPO_  int default aOKPO_
                    ) RETURN  number IS

    sTmp_ number := 0 ;
	sTmp1_ number := 0 ;
	k_ number ; 
	k1_ number ;
	
	/* ��������� ���������� �������� �2 ����������
	   ��� ����� ��������� �� ������������ ��������� ���� �� ����.
    */
	
	
	
  DAT0_ date;                     -- ���� �����         
  DAT1_ date;      -- ���� �������������� ��������
  Q_ number ;       -- � ������� ��������
 
 
 
 BEGIN

  DAT0_ :=  trunc(DAT_);                     -- ���� �����         
  DAT1_ :=  add_months(trunc(DAT_),-3);      -- ���� �������������� ��������
  Q_    := to_char( (DAT0_ - 1) , 'Q');     -- � ������� ��������
  
  
 
   
   --  �������� ����� �� ��������� ������� 1 - Yes, 0 - No
 begin
   select 1
     into k_
     from fin_fm
    where okpo = OKPO_
      and fdat = DAT1_;
  exception when NO_DATA_FOUND THEN k_ := 0;
  END;  
	
   sTmp_ := zn_p(KOD_, 2, DAT0_, OKPO_);
    begin
   select 1
     into k1_
     from fin_fm
    where okpo = OKPO_
      and fdat = DAT0_;
  exception when NO_DATA_FOUND THEN raise_application_error(-(20000),'\ ' ||'     '||KOD_||' ³����� ��� �� ������ ����� - '||DAT0_,TRUE); 
  END; 
		 							
    IF k_ = 0 or Q_ = 1    -- ���� � ������� ��� ������ ��� �� ��������� ������� 
	                       -- �� �������� ��������� ������ �� � ��������
               THEN   
					sTmp_ := sTmp_ / Q_;
	ELSE   
	   sTmp1_ := zn_p(KOD_, 2, DAT1_, OKPO_);
	   
	       begin
			   select 1
				 into k_
				 from fin_fm
				where okpo = OKPO_
				  and fdat = DAT0_;
			  exception when NO_DATA_FOUND THEN 
			       sTmp_ := sTmp_ / Q_;  
				   sTmp1_ := 0; 
		   END; 
	 		/* 		BEGIN	
						select s
						  into sTmp1_ 
						  from fin_rnk
						 where okpo = OKPO_
						   and fdat = DAT1_
						   and kod  = KOD_
						   and idf  = 2;
							  exception when NO_DATA_FOUND 
							      THEN sTmp_ := sTmp_ / Q_;  sTmp1_ := 0;   -- �� ������ ������ ��� �� �� ��� ����� ��������
						END;  */
		    
			-- ����� �������� ����� �������� ������ �������� ������������ ��������
		   sTmp_ := sTmp_ - sTmp1_;
		   
    END IF;	   
	  
	  RETURN round(sTmp_,5);		   

end ZN_FDK;




FUNCTION Calculation_FP (KOD_   char, 
						 OKPO_  int default aOKPO_, 
						 DAT_   date default aDAT_
						 ) RETURN  number IS
sTmp_ number := 0 ;
N1_   number := 0 ;
N2_   number := 0 ;
SEZ_   number;    -- ���������  1 ���, 0- �

GR4_ date;
GR3_ date;
GR2_ date;
GR1_ date;

BEGIN




  aOKPO_ :=  OKPO_;
  aDAT_  :=  trunc(DAT_);
  FZ_    :=  fin_nbu.F_FM (aOKPO_, aDAT_ ) ;  -- (��� ����� ������� �������� ' ', 'M', 'C')

 
  /*
  2.Գ������ ����������� ������������ ����� � �������� 3 ����� �������  �� ������
  ����� ��������� ������� �� 
             - ������� ������ ����� 
			 - �� ����� ������� ���������� ������� ����:
  
  3. � ����� ��������� ��������� ������ ���������� ����������� �� ������������ �������� 
  ����������� ����� �������� �� ���������� �� ����������� �������� �� ����� 100. 

  4.   ���� �� ��� ���������� ����������� ����������� ��������� ������� ������� ����, 
  �� �� ��� ���������� ������������� ��������� �������� �������� ����������� �����������, 
  �� ������� 1 
  
  (�� �������� ���������� ����������� �5, �6, �7, ��6, ��7, �� ����� �������� ��������, �� ������� 0). 
  
  ���� ��������� ����������� �5 ������� ���� ��� �� �䒺��� ��������, 
  �� ��� ���������� �������� �������� �����������, �� ������� ����. 
  
  ϳ� ��� ���������� ���������� ����������� �5, �8, �9, �10, ��5, ��8, ��9, ��10 �� ������ ���������� �������, 
  � ���� ���� � ����� ���������� ��������� �� ���������, ����������� ���������� ��������� ����� � 2 (� 2-�) ���� ��� �������� ���������� 
  �� ������ �����. 

���������� ��������� �� ������ ����� ����������� � ����� �����:

�) ������������  ����������� ��������� ����� � 2 (� 2-�) ���� ��� �������� ���������� 
   �� ���������� ��������� (4/N, �� N � ���������� ����� ���������� ������� ��������), ���

�) �� ����� ���������� ������������������� ��������� � ����������� ���������� ������� �������� 
   �� ���������� ������� ����. ������� ����������������� �������� ��������� �������������� �� 4, ���

�) � ������������� ������ ������, �� ��������� ���������� ��������� �� ������ �����. � ��� ������������ ������ 
    ������ ������ ���������� ��������� �� ������ ����� ������� ��������� ���������� �� ���� ������������ 
	�� ������� ���� ������, �� 10% �� ������� ���������, ��������� � ��������� ������������ ����-����� � ������, ��������� ����.    

	� ��� ������������ ����� ���� ������� ���������� ��������� �� ������ ����� �� �����������. 

  
  */
  

	IF KOD_ = 'K1'  --    K1 (���������� �������� (����-���� �������� �������))      = B260/B620
		    THEN
			   CASE      WHEN FZ_ = ' ' THEN   
								   case when ZN_F1('620', 4) = 0 then RETURN 1;
										else sTmp_ :=  ZN_F1('260',4)/ZN_F1('620',4);       RETURN sTmp_;
								   end case;
						 WHEN FZ_ = 'N' THEN   
								   case when ZN_F1('1695', 4) = 0 then RETURN 1;
										else sTmp_ :=  ZN_F1('1195',4)/(ZN_F1('1600',4)+ZN_F1('1605',4)+ZN_F1('1610',4)+ZN_F1('1615',4)+ZN_F1('1620',4)+ZN_F1('1625',4)+ZN_F1('1630',4)+ZN_F1('1690',4));       RETURN sTmp_;
								   end case;  
						WHEN FZ_ in ('R','C') THEN   
								   case when (ZN_F1('1695', 4)-ZN_F1('1665', 4)) = 0 then RETURN 1;
										else sTmp_ :=  (ZN_F1('1195',4)-ZN_F1('1170',4))/(ZN_F1('1695', 4)-ZN_F1('1665', 4));       RETURN sTmp_;
								   end case;  		   
			 	     	ELSE       case when ZN_F1('620',4) = 0 then RETURN 1;
										else sTmp_ :=  ZN_F1('260',4)/ZN_F1('620',4);       RETURN sTmp_;
								   end case;
			END CASE;
			
	ELSIF KOD_ = 'K2'  --    K1 (�������� ���������� ��������)      = (�.1 �.150+�.160+�.220+�.230+�. 240 ��. 4)/620 ��. 4
		                     --              M                              = (�.1-� �.160+�.220+�.230+�.240��.4)       /�.1-��.620 ��.4
							 --              C                              =  (�.1-���.210+�.230+�.240��.4)/�.-���.620 ��.4

		     THEN
                 CASE    WHEN FZ_ = ' ' THEN   
											   case when ZN_F1('620',4) = 0 then RETURN 1;
													else sTmp_ :=  (ZN_F1('150',4)+ZN_F1('160',4)+ZN_F1('220',4)+ZN_F1('230',4)+ZN_F1('240',4))/ZN_F1('620',4);       RETURN sTmp_;
											   end case;
						 WHEN FZ_ = 'N' THEN   
											   case when ZN_F1('1695',4) = 0 then RETURN 1;
													else sTmp_ :=  (ZN_F1('1120',4)+ZN_F1('1125',4)+ZN_F1('1160',4)+ZN_F1('1165',4))/(ZN_F1('1600',4)+ZN_F1('1605',4)+ZN_F1('1610',4)+ZN_F1('1615',4)+ZN_F1('1620',4)+ZN_F1('1625',4)+ZN_F1('1630',4)+ZN_F1('1690',4));       RETURN sTmp_;
											   end case;
						 WHEN FZ_ in ('R','C') THEN   
											   case when (ZN_F1('1695', 4)-ZN_F1('1665', 4)) = 0 then RETURN 1;
													else sTmp_ :=  (ZN_F1('1125',4)+ZN_F1('1160',4)+ZN_F1('1165',4))/(ZN_F1('1695', 4)-ZN_F1('1665', 4));       RETURN sTmp_;
											   end case;											   
						 WHEN FZ_ = 'M' THEN
											   case when ZN_F1('620',4) = 0 then RETURN 1;
													else sTmp_ :=  (ZN_F1('160',4)+ZN_F1('220',4)+ZN_F1('230',4)+ZN_F1('240',4))/ZN_F1('620',4);                   RETURN sTmp_;
											   end case;						 
						ELSE                   case when ZN_F1('620',4) = 0 then RETURN 1;
													else sTmp_ :=  (ZN_F1('210',4)+ZN_F1('230',4)+ZN_F1('240',4))/ZN_F1('620',4);                               RETURN sTmp_;
											   end case;
			    END CASE;
				
				
    ELSIF KOD_ = 'K3' -- K3 (���������� ��������� ���������-�� )                            =  �.1�.380��.4/�.1�.640��.4
            THEN
			   CASE      WHEN FZ_ = ' ' THEN   
								   case when ZN_F1('640',4) = 0 then RETURN 1;
										else sTmp_ :=  ZN_F1('380',4)/ZN_F1('640',4);       RETURN sTmp_;
								   end case;
						 WHEN FZ_ = 'N' THEN   
								   case when ZN_F1('1900',4) = 0 then RETURN 1;
										else sTmp_ :=  ZN_F1('1495',4)/ZN_F1('1900',4);       RETURN sTmp_;
								   end case;   
						 WHEN FZ_ in ('R','C') THEN   
								   case when ZN_F1('1900',4) = 0 then RETURN 1;
										else sTmp_ :=  ZN_F1('1495',4)/ZN_F1('1900',4);       RETURN sTmp_;
								   end case; 								   
			 	     	ELSE       case when ZN_F1('640',4) = 0 then RETURN 1;
										else sTmp_ :=  ZN_F1('380',4)/ZN_F1('640',4);       RETURN sTmp_;
								   end case;
			END CASE;
			
			
	ELSIF KOD_ = 'K4' -- K3 (���������� �������� ��������-��� ������ ������� ��������  )    = �.1 �.380 ��.4/�.1 �.080��.4

		
            THEN
			   CASE      WHEN FZ_ = ' ' THEN   
								   case when ZN_F1('080',4) = 0 then RETURN 1;
										else sTmp_ :=  ZN_F1('380',4)/ZN_F1('080',4);       RETURN sTmp_;
								   end case;
						WHEN FZ_ = 'N' THEN   
								   case when ZN_F1('1095',4) = 0 then RETURN 1;
										else sTmp_ :=  ZN_F1('1495',4)/ZN_F1('1095',4);       RETURN sTmp_;
								   end case;   
						WHEN FZ_ in ('R','C') THEN   
								   case when ZN_F1('1095',4) = 0 then RETURN 1;
										else sTmp_ :=  ZN_F1('1495',4)/ZN_F1('1095',4);       RETURN sTmp_;
								   end case;   
								   
			 	     	ELSE       case when ZN_F1('080',4) = 0 then RETURN 1;
										else sTmp_ :=  ZN_F1('380',4)/ZN_F1('080',4);       RETURN sTmp_;
								   end case;
			END CASE;

			
	ELSIF KOD_ = 'K5' -- K5 (���������� ���������-���� �������� �������  )    
            THEN 
                    --  K5 ' ' --                 //=             (�. 2 ��. 220�225 ��. 3) /
                    --                                �. 1 [(�. 300+�. 310+�. 320+�. 330���. 360�370 ��. 3)+
					--                                      (�. 300+�. 310+�. 320+�. 330��. 360��. 370 ��. 4)]:2 
					
			CASE  WHEN FZ_ = ' ' THEN   		
			      N1_ := ( (ZN_F1('300', 3)+ZN_F1('310', 3)+ZN_F1('320',3)+ZN_F1('330',3) - (ZN_F1('360',3)+ZN_F1('370', 3))) + 
			              (ZN_F1('300', 4)+ZN_F1('310', 4)+ZN_F1('320',4)+ZN_F1('330',4) - (ZN_F1('360',4)+ZN_F1('370', 4))) ) / 2;
				  WHEN FZ_ = 'N' THEN   
				 N1_ := ( (ZN_F1('1400', 3)+ZN_F1('1405', 3)+ZN_F1('1410',3) - ZN_F1('1425',3)-ZN_F1('1430', 3)) + 
			              (ZN_F1('1400', 4)+ZN_F1('1405', 4)+ZN_F1('1410',4) - ZN_F1('1425',4)-ZN_F1('1430', 4)) ) / 2; 
                  WHEN FZ_ in ('R','C') THEN   
				 N1_ :=  (ZN_F1('1615', 3) +  ZN_F1('1615', 4) ) / 2; 						  
			     ELSE
			     N2_ := (ZN_F1('530', 3)+ZN_F1('530',4))/2;
			
			END CASE;	
			
                    ---  K5  to  'M' and 'MC'     //  = (�.2-���.030��.3/�.1-���.530(��. 3+��. 4):2
				    --   N2_ := (ZN_F1('530', 3)+ZN_F1('530',4))/2;

				 
                	   CASE      WHEN FZ_ = ' ' THEN   
									   case when N1_ <= 0 then RETURN 0;
											else sTmp_ :=  (ZN_F2('220', 4)-ZN_F2('225', 4))/N1_;       RETURN sTmp_;
									   end case;
								WHEN FZ_ = 'N' THEN   
									   case when N1_ <= 0 then RETURN 0;
											else sTmp_ :=  (ZN_F2('2350', 4)-ZN_F2('2355', 4))/N1_;       RETURN sTmp_;
									   end case;	   
								WHEN FZ_ in ('R','C') THEN   
									   case when N1_ = 0 then RETURN 1;
											else sTmp_ :=  (ZN_F2('2000', 4))/N1_;       RETURN sTmp_;
									   end case;	   
									   
							     ELSE
									   case when N2_ = 0 then RETURN 1;
											else sTmp_ :=  ZN_F2('030', 4)/N2_;       RETURN sTmp_;
									   end case;					 
			          END CASE;
	ELSIF KOD_ = 'K6' --		�. 2 ��. 100�105 ��. 3/�. 2 �. 035 ��. 3
	
	             -- 'M'    (�. 2-� �. 030��. 090��. 100��. 110��. 120��. 140��. 3 )/�. 2-� �. 030 ��. 3
            THEN
				   	   CASE      WHEN FZ_ = ' ' THEN   
									   case when ZN_F2('035',3) = 0 then RETURN 0;
											else sTmp_ :=  (ZN_F2('100', 3)-ZN_F2('105', 3))/ZN_F2('035', 3);       RETURN sTmp_;
									   end case;
								 WHEN FZ_ = 'N' THEN   
									   case when ZN_F2('2000',3) = 0 then RETURN 0;
											else sTmp_ :=  (ZN_F2('2190', 3)-ZN_F2('2195', 3))/ZN_F2('2000', 3);       RETURN sTmp_;
									   end case;	
								 WHEN FZ_ in ('R','C') THEN   
									   case when ZN_F2('2000',3) = 0 then RETURN 0;
											else sTmp_ :=  (ZN_F2('2000', 3)-ZN_F2('2050', 3))/ZN_F2('2000', 3);       RETURN sTmp_;
									   end case;									   
							     ELSE
									   case when ZN_F2('030',3) = 0  then RETURN 0;
											else sTmp_ :=  (ZN_F2('030', 3)-ZN_F2('080', 3))/ZN_F2('030',3);       RETURN sTmp_;
									   end case;					 
			          END CASE;

					  
    	ELSIF KOD_ = 'K7' --		�. 2 ��. 220�225+�. 260+�. 210+��. 180+�. 140 ��.3/�. 2 �. 035+�. 060 ��. 3

	
	                     -- 'M'    (�. 2-� �. 070��. 180+�. 120+�. 150+�. 170 ��. 3)/�. 2-� �. 030+�. 040 ��. 3

            THEN
				   	   CASE      WHEN FZ_ = ' ' THEN   
									   case when (ZN_F2('035',3)+ZN_F2('060',3)) = 0 then RETURN 0;
											else sTmp_ :=  (ZN_F2('220', 3)-ZN_F2('225', 3)+ZN_F2('260',3)+ZN_F2('210',3)+ZN_F2('180',3)+ZN_F2('140',3))/(ZN_F2('035',3)+ZN_F2('060',3));       RETURN sTmp_;
									   end case;
								 WHEN FZ_ = 'N' THEN   
									   case when (ZN_F2('2000',3)+ZN_F2('2120',3)) = 0 then RETURN 0;
											else sTmp_ :=  (ZN_F2('2290', 3)-ZN_F2('2295', 3)+ZN_F2('2250',3)+ZN_F2('2515',3))/(ZN_F2('2000',3)+ZN_F2('2120',3));       RETURN sTmp_;
									   end case;	 
								 WHEN FZ_ in ('R','C') THEN   
									   case when (ZN_F2('2280',3)) = 0 then RETURN 0;
											else sTmp_ :=  (ZN_F2('2290', 3))/(ZN_F2('2280',3));       RETURN sTmp_;
									   end case;										   
							     ELSE
									   case when (ZN_F2('030',3)+ZN_F2('040',3)+ZN_F2('050',3)) = 0  then RETURN 0;
											else sTmp_ :=  ZN_F2('130',3)/(ZN_F2('030',3)+ZN_F2('040',3)+ZN_F2('050',3)) ;       RETURN sTmp_;
									   end case;					 
			          END CASE;
					  
	    ELSIF KOD_ = 'K8' --		  �. 2 ��. 220�225 ��. 3/�. 1 �. 280 (��. 3+��. 4):2
	                     -- 'M'    �. 2-� ��. 070�180 ��. 3 / �. 1-� �. 280 (��. 3+��. 4):2
            THEN
			
			
				   	   CASE      WHEN FZ_ = ' ' THEN   
									   case when (ZN_F1('280',3)+ZN_F1('280',4))/2 = 0 then RETURN 1;
											else sTmp_ := (ZN_F2('220', 4)-ZN_F2('225', 4)) /((ZN_F1('280',3)+ZN_F1('280',4))/2);       RETURN sTmp_;
									   end case;
								WHEN FZ_ = 'N' THEN   
									   case when (ZN_F1('1300',3)+ZN_F1('1300',4))/2 = 0 then RETURN 1;
											else sTmp_ := (ZN_F2('2350', 4)-ZN_F2('2355', 4)) /((ZN_F1('1300',3)+ZN_F1('1300',4))/2);       RETURN sTmp_;
									   end case;
								WHEN FZ_ in ('R','C') THEN   
									   case when (ZN_F1('1300',3)+ZN_F1('1300',4))/2 = 0 then RETURN 1;
											else sTmp_ := (ZN_F2('2350', 4)) /((ZN_F1('1300',3)+ZN_F1('1300',4))/2);       RETURN sTmp_;
									   end case;									   
							     ELSE
									   case when (ZN_F1('280',3)+ZN_F1('280',4))/2 = 0  then RETURN 1;
											else sTmp_ :=  (ZN_F2('150', 4))/((ZN_F1('280',3)+ZN_F1('280',4))/2) ;       RETURN sTmp_;
									   end case;					 
			          END CASE;
		
		
		
		
		ELSIF KOD_ = 'K9' --		  �. 2 �. 035 ��. 3   / �. 1 �. 260 (��. 3+��. 4):2

	                     -- 'M'     �. 2-� �. 030 ��. 3 /�. 1-� �. 260 (��. 3+��. 4):2

            THEN
				   	   CASE      WHEN FZ_ = ' ' THEN   
									   case when (ZN_F1('260',3)+ZN_F1('260',4))/2 = 0 then RETURN 1;
											else sTmp_ := (ZN_F2('035', 4)) /((ZN_F1('260',3)+ZN_F1('260',4))/2);       RETURN sTmp_;
									   end case;
								 WHEN FZ_ = 'N' THEN   
									   case when (ZN_F1('1195',3)+ZN_F1('1195',4))/2 = 0 then RETURN 1;
											else sTmp_ := (ZN_F2('2000', 4)) /((ZN_F1('1195',3)+ZN_F1('1195',4))/2);       RETURN sTmp_;
									   end case;	   
								 WHEN FZ_ in ('R','C') THEN   
									   case when (ZN_F1('1195',3)-ZN_F1('1170',3))+(ZN_F1('1195',4)-ZN_F1('1170',4))/2 = 0 then RETURN 1;
											else sTmp_ := (ZN_F2('2000', 4)) /((ZN_F1('1195',3)-ZN_F1('1170',3)+ZN_F1('1195',4)-ZN_F1('1170',4))/2);       RETURN sTmp_;
									   end case;									   
							     ELSE
									   case when (ZN_F1('260',3)+ZN_F1('260',4))/2 = 0  then RETURN 1;
											else sTmp_ :=  (ZN_F2('030', 4))/((ZN_F1('260',3)+ZN_F1('260',4))/2) ;       RETURN sTmp_;
									   end case;					 
			          END CASE;
					  
					  
					  
	    ELSIF KOD_ = 'K10' --		  (�. 2 ��. 220�225+�. 260+�. 210+�. 180+�. 140 ��. 3 ) /   �. 1 �. 480+�. 620 ��. 4


	                     -- 'M'     (�. 2-� �. 070��. 180+�. 120+�. 150+�. 170 ��. 3) / �. 1-� �. 480+�. 620 ��. 4


            THEN
				   	   CASE      WHEN FZ_ = ' ' THEN   
									   case when (ZN_F1('480',4)+ZN_F1('620',4)) = 0 then RETURN 1;
											else sTmp_ := (ZN_F2('220', 4)-ZN_F2('225', 4)+ZN_F2('260', 4)+ZN_F2('210', 4)+ZN_F2('180', 4)+ZN_F2('140', 4)) /(ZN_F1('480',4)+ZN_F1('620',4));       RETURN sTmp_;
									   end case;
								WHEN FZ_ = 'N' THEN   
									   case when (ZN_F1('1500',4)+ZN_F1('1510',4)+ZN_F1('1515',4)+ZN_F1('1600',4)+ZN_F1('1605',4)+ZN_F1('1610',4)+ZN_F1('1615',4)+ZN_F1('1620',4)+ZN_F1('1625',4)+ZN_F1('1630',4)+ZN_F1('1690',4)) = 0 then RETURN 1;
											else sTmp_ := (ZN_F2('2290', 4)-ZN_F2('2295', 4)+ZN_F2('2250', 4)+ZN_F2('2515', 4)) /(ZN_F1('1500',4)+ZN_F1('1510',4)+ZN_F1('1515',4)+ZN_F1('1600',4)+ZN_F1('1605',4)+ZN_F1('1610',4)+ZN_F1('1615',4)+ZN_F1('1620',4)+ZN_F1('1625',4)+ZN_F1('1630',4)+ZN_F1('1690',4));   --    RETURN sTmp_;
									   end case;	   
									       RETURN sTmp_;
								WHEN FZ_ in ('R','C') THEN   
									   case when (ZN_F1('1595',4)+ZN_F1('1695',4)+ZN_F1('1665',4)) = 0 then RETURN 1;
											else sTmp_ := (ZN_F2('2290', 4)) /(ZN_F1('1595',4)+ZN_F1('1695',4)+ZN_F1('1665',4));   --    RETURN sTmp_;
									   end case;	   
									       RETURN sTmp_;										   
							     ELSE
									   case when (ZN_F1('480',4)+ZN_F1('620',4)) = 0  then RETURN 1;
											else sTmp_ :=  (ZN_F2('130', 4))/(ZN_F1('480',4)+ZN_F1('620',4)) ;       RETURN sTmp_;
										end case;					 
			          END CASE;			  
					  
  
	else return null;
		
	END IF;

	
END Calculation_FP;

-- ����� ��������� ��� ������������ ������� �� ��������


PROCEDURE Calc_FP (
	 		       OKPO_  int default aOKPO_, 
				   DAT_   date default aDAT_
				  ) 
as
sTmp_ number;
l_rzn varchar2(3) :='RZN';
l_min varchar2(3) :='MIN';
l_max varchar2(3) :='MAX';
l_mod varchar2(254) := 'fin.Calc_FP>>';
BEGIN
  tp_indics := null;
  
  aOKPO_ :=  OKPO_;
  aDAT_  :=  trunc(DAT_);
  FZ_    :=  fin_nbu.F_FM (aOKPO_, aDAT_ ) ;  -- (��� ����� ������� �������� ' ', 'M', 'C')


  --'PK1' then	    -- �1, ��1 � ��������� �������� �����  
            CASE 
			  WHEN FZ_ = 'N' THEN
			               begin   
						            sTmp_ :=     ( ZN_F1('1510',4) + ZN_F1('1515',4) + ZN_F1('1600',4) + ZN_F1('1610',4) - ZN_F1('1165',4) )  /  (ZN_F2('2000',4) + ZN_F2('2010',4));
									get_indic('PK1',sTmp_,l_rzn);
							exception when ZERO_DIVIDE then 
                                    sTmp_ :=  null;	get_indic('PK1',sTmp_,l_min);	
						   end;
			  WHEN FZ_ = 'R' THEN
			                begin    
						            sTmp_ :=     ( ZN_F1('1595',4) + ZN_F1('1600',4) + ZN_F1('1610',4) - ZN_F1('1165',4) )  /  (ZN_F2('2000',4));
									get_indic('PK1',sTmp_,l_rzn);
							exception when ZERO_DIVIDE then 
                                    sTmp_ :=  null;	get_indic('PK1',sTmp_,l_min);		
						   end;
			  WHEN FZ_ = 'C' THEN
			                begin    
						            sTmp_ :=     ( ZN_F1('1595',4) + ZN_F1('1600',4) - ZN_F1('1165',4) )  /  (ZN_F2('2000',4));
									get_indic('PK1',sTmp_,l_rzn);
							exception when ZERO_DIVIDE then 
                                    sTmp_ :=  null;	get_indic('PK1',sTmp_,l_min);		
						   end;
			  ELSE sTmp_:= null;
			END CASE;
 
  --'PK2' then	   -- �2,  ��2 � ��������� ������������� ������   
            CASE 
			  WHEN FZ_ = 'N' THEN
			               begin    
						            sTmp_ :=     ( ZN_F2('2350',4) - ZN_F2('2355',4)  )  /  ZN_F1('1300',4);
									get_indic('PK2',sTmp_,l_rzn);
							exception when ZERO_DIVIDE then 
                                    sTmp_ :=  null; 	get_indic('PK2',sTmp_,l_min);		
						   end;
			  WHEN FZ_ IN ('R','C') THEN
			                begin    
						            sTmp_ :=     ( ZN_F2('2000',4) - ZN_F2('2050',4)  )  /  ZN_F1('1300',4);
									get_indic('PK2',sTmp_,l_rzn);
							exception when ZERO_DIVIDE then 
                                    sTmp_ := null; get_indic('PK2',sTmp_,l_min);
						   end;
 		      ELSE sTmp_:= null;
			END CASE;
  -- 'PK3' then	    -- �3 ��������� �������� ���������� ������ �� ������������  ���������� �������� 
            CASE 
			  WHEN FZ_ = 'N' THEN 
			                   
                                if ( ZN_F2('2250',4) - ZN_F2('2220',4)   ) <= 0	 then sTmp_ :=  null; 	get_indic('PK3',sTmp_,l_max);		
                                 else								
						            sTmp_ :=     ( ZN_F2('2190',4) - ZN_F2('2195',4)  )  /  ( ZN_F2('2250',4) - ZN_F2('2220',4)  );
									get_indic('PK3',sTmp_,l_rzn);
								end if;
							 
			               
			  WHEN FZ_ = 'R' THEN 
			  			    begin    
						            sTmp_ :=     ( ZN_F2('2000',4) - ZN_F2('2050',4)  )  /   ZN_F2('2270',4);
									get_indic('PK3',sTmp_,l_rzn);
							exception when ZERO_DIVIDE then 
                                    sTmp_ := null; get_indic('PK3',sTmp_,l_max);
						   end;
			                 
			  WHEN FZ_ = 'C' THEN 
			  			    begin    
						            sTmp_ :=     ( ZN_F2('2000',4) - ZN_F2('2050',4)  )  /   ZN_F2('2165',4);
									get_indic('PK3',sTmp_,l_rzn);
							exception when ZERO_DIVIDE then 
                                    sTmp_ := null; get_indic('PK3',sTmp_,l_max);
						   end;
			                 
			  ELSE sTmp_:= null;
			END CASE; 
 
   -- 'PK4' then	    -- �4, MK4 �  ��������� �������
            CASE 
			  WHEN FZ_ = 'N' THEN 
			  			    begin    
						            sTmp_ :=      ZN_F1('1495',4)  /   ZN_F1('1300',4);
									get_indic('PK4',sTmp_,l_rzn);
							exception when ZERO_DIVIDE then 
                                    sTmp_ := null; get_indic('PK4',sTmp_,l_min);
						   end;
							 
			               
			  WHEN FZ_ in ('R','C') THEN 
			  			    begin    
						            sTmp_ :=      ZN_F1('1495',4)  /   ZN_F1('1300',4);
									get_indic('PK4',sTmp_,l_rzn);
							exception when ZERO_DIVIDE then 
                                    sTmp_ := null; get_indic('PK4',sTmp_,l_min);
						   end;
			                 
			  ELSE sTmp_:= null;
			END CASE; 
 
 
    -- 'PK5' then	    -- . �5, MK5 � ��������� ����������� �������� �������
            CASE 
			  WHEN FZ_ = 'N' THEN 
			  			    begin    
						            sTmp_ :=   (ZN_F1('1195',4) - ZN_F1('1695',4))  /   ZN_F1('1300',4);
									get_indic('PK5',sTmp_,l_rzn);
							exception when ZERO_DIVIDE then 
                                    sTmp_ := null; get_indic('PK5',sTmp_,l_max);
						   end;
							 
			               
			  WHEN FZ_ in ('R','C') THEN 
			  			    begin    
						            sTmp_ :=   (ZN_F1('1195',4) - ZN_F1('1695',4))  /   ZN_F1('1300',4);
									get_indic('PK5',sTmp_,l_rzn);
							exception when ZERO_DIVIDE then 
                                    sTmp_ := null; get_indic('PK5',sTmp_,l_min);
						   end;
			                 
			  ELSE sTmp_:= null;
			END CASE; 
 
   -- 'PK6' then	    -- �6 ,��6 � ��������� �������� �������� ����� 
            CASE 
			  WHEN FZ_ = 'N' THEN 
			                   
                                if ( ZN_F1('1510',4) + ZN_F1('1515',4)  + ZN_F1('1600',4) + ZN_F1('1610',4) - ZN_F1('1165',4) ) <= 0	 then sTmp_ :=  null; 	get_indic('PK6',sTmp_,l_max);		
                                 else								
						            sTmp_ :=      ZN_F1('1495',4)   /  ( ZN_F1('1510',4) + ZN_F1('1515',4)  + ZN_F1('1600',4) + ZN_F1('1610',4) - ZN_F1('1165',4) );
									get_indic('PK6',sTmp_,l_rzn);
								end if;
							 
			               
			  WHEN FZ_ = 'R' THEN 
                                if ( ZN_F1('1595',4) + ZN_F1('1600',4)  + ZN_F1('1610',4) - ZN_F1('1165',4) ) <= 0	 then sTmp_ :=  null; 	get_indic('PK6',sTmp_,l_max);		
                                 else								
						            sTmp_ :=      ZN_F1('1495',4)   /  ( ZN_F1('1595',4) + ZN_F1('1600',4)  + ZN_F1('1610',4) - ZN_F1('1165',4) );
									get_indic('PK6',sTmp_,l_rzn);
								end if;
			                 
			  WHEN FZ_ = 'C' THEN 
                                if ( ZN_F1('1595',4) + ZN_F1('1600',4) - ZN_F1('1165',4) ) <= 0	 then sTmp_ :=  null; 	get_indic('PK6',sTmp_,l_max);		
                                 else								
						            sTmp_ :=      ZN_F1('1495',4)   /  ( ZN_F1('1595',4) + ZN_F1('1600',4) - ZN_F1('1165',4) );
									get_indic('PK6',sTmp_,l_rzn);
								end if;
			                 
			  ELSE sTmp_:= null;
			END CASE; 
 
     -- 'PK7' then	    -- . �7 ,��7 � ��������� ������ ��������
            CASE 
			  WHEN FZ_ in ( 'N','R') THEN 
			  			    begin    
						            sTmp_ :=   (ZN_F1('1125',4) + ZN_F1('1165',4))  /   ZN_F1('1695',4);
									get_indic('PK7',sTmp_,l_rzn);
							exception when ZERO_DIVIDE then 
                                    sTmp_ := null; get_indic('PK7',sTmp_,l_max);
						   end;
							 
			               
			  WHEN FZ_ in ('C') THEN 
			  			    begin    
						            sTmp_ :=   (ZN_F1('1155',4) + ZN_F1('1165',4))  /   ZN_F1('1695',4);
									get_indic('PK7',sTmp_,l_rzn);
							exception when ZERO_DIVIDE then 
                                    sTmp_ := null; get_indic('PK7',sTmp_,l_max);
						   end;
			                 
			  ELSE sTmp_:= null;
			END CASE; 
			
     -- 'PK8' then	    -- �8, ��8 � ��������� ���������� ������ 
            CASE 
			  WHEN FZ_ in ( 'N') THEN 
			  			    begin    
						            sTmp_ :=   ZN_F1('1300',4)   /   (ZN_F2('2000',4) + ZN_F2('2010',4) );
									get_indic('PK8',sTmp_,l_rzn);
							exception when ZERO_DIVIDE then 
                                    sTmp_ := null; get_indic('PK8',sTmp_,l_min);
						   end;
							 
			               
			  WHEN FZ_ in ('R','C') THEN 
			  			    begin    
						            sTmp_ :=   ZN_F1('1300',4)   /   ZN_F2('2000',4) ;
									get_indic('PK8',sTmp_,l_rzn);
							exception when ZERO_DIVIDE then 
                                    sTmp_ := null; get_indic('PK8',sTmp_,l_min);
						   end;
			                 
			  ELSE sTmp_:= null;
			END CASE; 			
			
     -- 'PK9' then	    -- . �9,  ��9 ���������� ���������� �������� ������
            CASE 
			  WHEN FZ_ in ( 'N') THEN 
			  			    begin    
						            sTmp_ :=   ZN_F1('1195',4) *365  /   (ZN_F2('2000',4) + ZN_F2('2010',4) );
									get_indic('PK9',sTmp_,l_rzn);
							exception when ZERO_DIVIDE then 
                                    sTmp_ := null; get_indic('PK9',sTmp_,l_min);
						   end;
							 
			               
			  WHEN FZ_ in ('R','C') THEN 
			  			    begin    
						            sTmp_ :=   ZN_F1('1195',4)*365   /   ZN_F2('2000',4) ;
									get_indic('PK9',sTmp_,l_rzn);
							exception when ZERO_DIVIDE then 
                                    sTmp_ := null; get_indic('PK9',sTmp_,l_min);
						   end;
			                 
			  ELSE sTmp_:= null;
			END CASE; 				
			
    -- 'PK10' then	    -- �10  ��������� �������� ��������, MK10 � �������� ���������� �������� �������
            CASE 
			  WHEN FZ_ in ( 'N') THEN 
			  			    begin    
						            sTmp_ :=   ZN_F1('1195',4) /   ZN_F1('1695',4);
									get_indic('PK10',sTmp_,l_rzn);
							exception when ZERO_DIVIDE then 
                                    sTmp_ := null; get_indic('PK10',sTmp_,l_max);
						   end;
							 
			               
			  WHEN FZ_ in ('R','C') THEN 
			  			    begin    
						            sTmp_ :=   (  ZN_F1('1195',4) - ZN_F1('1695',4) )   /   ZN_F2('2000',4) ;
									get_indic('PK10',sTmp_,l_rzn);
							exception when ZERO_DIVIDE then 
                                    sTmp_ := null; get_indic('PK10',sTmp_,l_min);
						   end;
			                 
			  ELSE sTmp_:= null;
			END CASE; 				
			
  -- 'PK11' then	    -- �11- �������� �������� �������������� �����, M�11 � �������� �������� ����� ����������� ���������
            CASE 
			  WHEN FZ_ = 'N' THEN 
			                   
                                if ( ZN_F1('1510',4) + ZN_F1('1515',4)  + ZN_F1('1600',4) + ZN_F1('1610',4) - ZN_F1('1165',4) ) <= 0	 then sTmp_ :=  null; 	get_indic('PK11',sTmp_,l_max);		
                                 else								
						            sTmp_ :=     ( ZN_F2('2190',4) - ZN_F2('2195',4) + ZN_F2('2515',4) + ZN_F2('2220',4) - ZN_F2('2250',4) )   /  ( ZN_F1('1510',4) + ZN_F1('1515',4)  + ZN_F1('1600',4) + ZN_F1('1610',4) - ZN_F1('1165',4) );
									get_indic('PK11',sTmp_,l_rzn);
								end if;
							 
			               
			  WHEN FZ_ = 'R' THEN 
                                if ( ZN_F1('1595',4) + ZN_F1('1600',4)  + ZN_F1('1610',4) - ZN_F1('1165',4) ) <= 0	 then sTmp_ :=  null; 	get_indic('PK11',sTmp_,l_max);		
                                 else								
						            sTmp_ :=    (ZN_F2('2000',4) - ZN_F2('2050',4) )   /  ( ZN_F1('1595',4) + ZN_F1('1600',4)  + ZN_F1('1610',4) - ZN_F1('1165',4) );
									get_indic('PK11',sTmp_,l_rzn);
								end if;
			                 
			  WHEN FZ_ = 'C' THEN 
                                if ( ZN_F1('1595',4) + ZN_F1('1600',4) - ZN_F1('1165',4) ) <= 0	 then sTmp_ :=  null; 	get_indic('PK11',sTmp_,l_max);		
                                 else								
						            sTmp_ :=       (ZN_F2('2000',4) - ZN_F2('2050',4) )   /  ( ZN_F1('1595',4) + ZN_F1('1600',4) - ZN_F1('1165',4) );
									get_indic('PK11',sTmp_,l_rzn);
								end if;
			                 
			  ELSE sTmp_:= null;
			END CASE; 
 
 
    -- 'PK12' then	    -- . K12 � �������� ���������� �������� �������, ��12 � �������� ���������� �������� ������ 
            CASE 
			  WHEN FZ_ in ( 'N') THEN 
			  			    begin    
						            sTmp_ :=  (      ZN_F1('1100',4)*365 /    ZN_F2('2050',4)                          )   +
                                              (      ZN_F1('1125',4)*365 /  ( ZN_F2('2000',4)  + ZN_F2('2010',3)    )  )  -
											  (      ZN_F1('1615',4)*365 /    ZN_F2('2050',4)                          );
									get_indic('PK12',sTmp_,l_rzn);
							exception when ZERO_DIVIDE then 
                                    sTmp_ := null; get_indic('PK12',sTmp_,l_min);
						   end;
							 
			               
			  WHEN FZ_ in ('R','C') THEN 
			  			    begin    
						            sTmp_ :=  ZN_F1('1010',4)    /   ZN_F2('2000',4) ;
									get_indic('PK12',sTmp_,l_rzn);
							exception when ZERO_DIVIDE then 
                                    sTmp_ := null; get_indic('PK12',sTmp_,l_min);
						   end;
			                 
			  ELSE sTmp_:= null;
			END CASE; 		
 
 --'PK13' then	    -- . �13� �������� ���������� ���������� �������������, MK13 � �������� ������� �������� �� ������������� 
            CASE 
			  WHEN FZ_ = 'N' THEN
			               begin   
						            sTmp_ :=     ( ZN_F1('1125',4)*365)  /  (ZN_F2('2000',4) + ZN_F2('2010',4));
									get_indic('PK13',sTmp_,l_rzn);
							exception when ZERO_DIVIDE then 
                                    sTmp_ :=  null;	get_indic('PK13',sTmp_,l_min);	
						   end;
			  WHEN FZ_ = 'R' THEN
			                begin    
						            sTmp_ :=     ( ZN_F2('2000',4) + ZN_F2('2120',4) - ZN_F2('2050',4) - ZN_F2('2180',4) + ZN_F2('2240',4) - ZN_F2('2270',4)  )  /  (ZN_F2('2000',4));
									get_indic('PK13',sTmp_,l_rzn);
							exception when ZERO_DIVIDE then 
                                    sTmp_ :=  null;	get_indic('PK13',sTmp_,l_min);		
						   end;
			  WHEN FZ_ = 'C' THEN
			                begin    
						            sTmp_ :=     (  ZN_F2('2000',4) +  ZN_F2('2160',4) -  ZN_F2('2050',4) -  ZN_F2('2165',4) )  /  (ZN_F2('2000',4));
									get_indic('PK13',sTmp_,l_rzn);
							exception when ZERO_DIVIDE then 
                                    sTmp_ :=  null;	get_indic('PK13',sTmp_,l_min);		
						   end;
			  ELSE sTmp_:= null;
			END CASE; 
 
  --'PK14' then	    -- �14 � �������� ���������� ������������ �������������
           sTmp_ := null;
           CASE 
			  WHEN FZ_ = 'N' THEN
			               begin   
						            sTmp_ :=     ( ZN_F1('1615',4)*365)  /  ZN_F2('2050',4);
									get_indic('PK14',sTmp_,l_rzn);
							exception when ZERO_DIVIDE then 
                                    sTmp_ :=  null;	get_indic('PK14',sTmp_,l_min);	
						   end;
			  ELSE sTmp_:= null;
			END CASE; 
 
   --'PK15' then	    -- �15 � �������� ������ ������������� �������� �������
            CASE 
			  WHEN FZ_ = 'N' THEN
			               begin   
						            sTmp_ :=     ( ZN_F1('1000',4) + ZN_F1('1030',4) + ZN_F1('1040',4) + ZN_F1('1050',4) + ZN_F1('1155',4) + ZN_F1('1160',4) )  /  ZN_F1('1300',4);
									get_indic('PK15',sTmp_,l_rzn);
							exception when ZERO_DIVIDE then 
                                    sTmp_ :=  null;	get_indic('PK15',sTmp_,l_min);	
						   end;
			  ELSE sTmp_:= null;
			END CASE; 


 
  --'PK16' then	    -- �16 � �������� ������������ �������� �� ����������� ����������� 
            CASE 
			  WHEN FZ_ = 'N' THEN
			               begin   
						            sTmp_ :=     ( ZN_F2('2190',4) - ZN_F2('2195',4) + ZN_F2('2515',4) )  /  ( ZN_F2('2000',4) + ZN_F2('2010',4) );
									get_indic('PK16',sTmp_,l_rzn);
							exception when ZERO_DIVIDE then 
                                    sTmp_ :=  null;	get_indic('PK16',sTmp_,l_min);	
						   end;
			  ELSE sTmp_:= null;
			END CASE; 			
  
 for f in 1 .. tp_indics.kod.count()
 loop
 record_fp(tp_indics.kod(f), tp_indics.p_s(f), 6, DAT_, OKPO_);
 trace(l_mod, aOKPO_||' - '||rpad(f,3,' ')||' ~ '||lpad(tp_indics.kod(f),5,' ')||' = '||lpad(to_char(tp_indics.p_s(f),'9999990.999'),15,' ')||' >'||tp_indics.p_zero(f));
 end loop;
  
null;
end;
  
  
FUNCTION F_FM ( OKPO_ int, DAT_ date  )   RETURN char 
  RESULT_CACHE  relies_on (fin_fm)
IS
  sTmp_ char(1):=' ';
  l_mod varchar2(254) := 'fin_nbu.fm >>';	
begin
  begin 
    select f.FM into sTmp_ from FIN_FM f  where f.okpo = OKPO_  and  fdat = DAT_;
   exception when NO_DATA_FOUND THEN 
       select max(f.FM) into sTmp_ from FIN_FM f  where f.okpo = OKPO_  and 
                         (f.okpo,f.fdat) = ( select okpo,max(fdat) from FIN_FM 
                             where okpo=f.OKPO and fdat <= DAT_ group by okpo );
  end;
    --TRACE(l_mod,'FIN_FM-'||OKPO_||':'||TO_CHAR(DAT_,'DD-MM-YYYY'));
  RETURN sTmp_;
end F_FM;
-----------

function logk_  ( DAT_ date, OKPO_ int , IDF_ int ) RETURN number 
   is 
   t_ind pls_integer;
   l_mod varchar2(254) := 'fin_nbu.logk_ >>';	
begin
   --return logk ( DAT_ , OKPO_  , IDF_ );
   
  if tp_logks.logk.COUNT() > 0 then  

  	  FOR f IN 1 .. tp_logks.logk.COUNT()
		 LOOP
		 
		  if tp_logks.logk(f).okpo = OKPO_ and tp_logks.logk(f).dat = DAT_ and tp_logks.logk(f).idf = IDF_
		      then --trace(l_mod,'read tp_logks-'||tp_logks.logk(f).okpo||'-'||TO_CHAR(tp_logks.logk(f).DAT,'DD-MM-YYYY')); 
			       return tp_logks.logk(f).err;
		  end if;
		  
         END LOOP;
  end if;
  
  
   t_ind := tp_logks.logk.COUNT()+1;
   tp_logks.logk(t_ind).dat    := DAT_;
   tp_logks.logk(t_ind).okpo   := OKPO_;
   tp_logks.logk(t_ind).idf    := IDF_;
   tp_logks.logk(t_ind).err    := LOGK      (DAT_  => tp_logks.logk(t_ind).dat,
 										     OKPO_ => tp_logks.logk(t_ind).okpo ,
										     IDF_  => tp_logks.logk(t_ind).idf);

   /*tp_logks.logk(t_ind).err    := LOGK_read (DAT_  => tp_logks.logk(t_ind).dat,
 										     OKPO_ => tp_logks.logk(t_ind).okpo ,
										     IDF_  => tp_logks.logk(t_ind).idf,
										     mode_ => 1);*/											 
 
    --trace(l_mod,'read table-'||tp_logks.logk(t_ind).okpo||'-'||TO_CHAR(tp_logks.logk(t_ind).DAT,'DD-MM-YYYY')); 
    return tp_logks.logk(t_ind).err;
	
end;



FUNCTION LOGK ( DAT_ date, OKPO_ int , IDF_ int ) RETURN number is
 n2_ number :=0;
begin
 --    FZ_:= NVL(FZ_,' ');
 FZ_:= fin_nbu.F_FM (OKPO_, DAT_ ) ;

 If IDF_ = 2 then
     
	If FZ_ in ('R','C') then /* ���_���� �������� ����� 2-R */
       select count (*) into N2_
       from (  --  2280	����� ������ (2000 + 2120 + 2240)	
	         select 1 KOL, NVL(SUM(decode(KOD,'2280',S,0)),0) SL,
                           NVL(SUM(decode(KOD,'2280',0,S)),0) SR
             from fin_rnk 
             where OKPO=OKPO_ and FDAT=DAT_ and idf=IDF_ 
               and  kod in ('2280','2000','2120','2240')
             having NVL(SUM(decode(KOD,'2280',S,0)),0)<>
                    NVL(SUM(decode(KOD,'2280',0,S)),0)
	UNION ALL		--  2285	����� ������� (2050 + 2180 + 2270)	
			select 1 KOL, NVL(SUM(decode(KOD,'2285',S,0)),0) SL,
                          NVL(SUM(decode(KOD,'2288',0,S)),0) SR
             from fin_rnk 
             where OKPO=OKPO_ and FDAT=DAT_ and idf=IDF_ 
               and  kod in ('2285','2050','2180','2270')
             having NVL(SUM(decode(KOD,'2285',S,0)),0)<>
                    NVL(SUM(decode(KOD,'2285',0,S)),0)		
    UNION ALL		--  2290	Գ�������� ��������� �� ������������� (2280 - 2285)	
			select 1 KOL, NVL(SUM(decode(KOD,'2290',S,0)),0) SL,
                          NVL(SUM(decode(KOD,'2290',0,decode(KOD,'2285',-1,1)*S)),0) SR
             from fin_rnk 
             where OKPO=OKPO_ and FDAT=DAT_ and idf=IDF_ 
               and  kod in ('2290','2280','2285')
             having NVL(SUM(decode(KOD,'2290',S,0)),0)<>
                    NVL(SUM(decode(KOD,'2290',0,decode(KOD,'2285',-1,1)*S)),0)
     UNION ALL		--  2350	������ �������� (������) (2290 - 2300)	
			select 1 KOL, NVL(SUM(decode(KOD,'2350',S,0)),0) SL,
                          NVL(SUM(decode(KOD,'2350',0,decode(KOD,'2300',-1,1)*S)),0) SR
             from fin_rnk 
             where OKPO=OKPO_ and FDAT=DAT_ and idf=IDF_ 
               and  kod in ('2350','2290','2300','2310')
             having NVL(SUM(decode(KOD,'2350',S,0)),0)<>
                    NVL(SUM(decode(KOD,'2350',0,decode(KOD,'2300',-1,1)*S)),0)	
	union all
	select 1 kol,NVL(SUM(decode(KOD,'2285',S,0)),0),
			 greatest(NVL(SUM(decode(KOD,'2285',0,S)),0),NVL(SUM(decode(KOD,'2285',S,0)),0))
	from fin_rnk where OKPO=OKPO_ and FDAT=DAT_ and idf=IDF_ and
		 kod in ('2285','2250')
	  having NVL(SUM(decode(KOD,'2285',S,0)),0)<>
			 greatest(NVL(SUM(decode(KOD,'2285',0,S)),0),NVL(SUM(decode(KOD,'2285',S,0)),0))					
					);
					
					
    elsIf FZ_ = 'N' then /* ���_���� �������� ����� 2-N */
       select count (*) into N2_
       from (  --  ������� (��������\������)  2090=2000+2010-2050-2070+2095
	         select 1 KOL, NVL(SUM(decode(KOD,'2090',S,0)),0) SL,
                           NVL(SUM(decode(KOD,'2090',0,decode(KOD,'2050',-1,'2070',-1,'2095',1,1)*S)),0) SR
             from fin_rnk 
             where OKPO=OKPO_ and FDAT=DAT_ and idf=IDF_ 
               and  kod in ('2090','2095','2000','2010','2050','2070')
             having NVL(SUM(decode(KOD,'2090',S,0)),0)<>
                    NVL(SUM(decode(KOD,'2090',0,decode(KOD,'2050',-1,'2070',-1,'2095',1,1)*S)),0)
	UNION ALL		--  Գ�������� ��������� �� ���������� �������� (��������\������)  2190 = 2090-2095+2105+2110+2120-2130-2150-2180+2195
			select 1 KOL, NVL(SUM(decode(KOD,'2190',S,0)),0) SL,
                           NVL(SUM(decode(KOD,'2190',0,decode(KOD,'2095',-1,'2130',-1,'2150',-1,'2180',-1,'2195',1,1)*S)),0) SR
             from fin_rnk 
             where OKPO=OKPO_ and FDAT=DAT_ and idf=IDF_ 
               and  kod in ('2190','2090','2095','2105','2110','2120','2130','2150','2180','2195')
             having NVL(SUM(decode(KOD,'2190',S,0)),0)<>
                    NVL(SUM(decode(KOD,'2190',0,decode(KOD,'2095',-1,'2130',-1,'2150',-1,'2180',-1,'2195',1,1)*S)),0)		
	UNION ALL		--  Գ�������� ��������� �� ������������� (��������\������)  2290 = 2190-2195+2200+2220+2240-2250-2255-2270+2275+2295
			select 1 KOL, NVL(SUM(decode(KOD,'2290',S,0)),0) SL,
                           NVL(SUM(decode(KOD,'2290',0,decode(KOD,'2195',-1,'2250',-1,'2255',-1,'2270',-1,'2295',1,1)*S)),0) SR
             from fin_rnk 
             where OKPO=OKPO_ and FDAT=DAT_ and idf=IDF_ 
               and  kod in ('2290','2190','2195','2200','2220','2240','2250','2255','2270','2275','2295')
             having NVL(SUM(decode(KOD,'2290',S,0)),0)<>
                    NVL(SUM(decode(KOD,'2290',0,decode(KOD,'2195',-1,'2250',-1,'2255',-1,'2270',-1,'2295',1,1)*S)),0)	
	UNION ALL		--  ������ ���������� ��������� (��������\������)  2350 = 2290-2295-2300-2355+2305
			select 1 KOL, NVL(SUM(decode(KOD,'2350',S,0)),0) SL,
                           NVL(SUM(decode(KOD,'2350',0,decode(KOD,'2305',1,'2290',1,'2355',1,-1)*S)),0) SR
             from fin_rnk 
             where OKPO=OKPO_ and FDAT=DAT_ and idf=IDF_ 
               and  kod in ('2350','2290','2295','2300','2355','2305')
             having NVL(SUM(decode(KOD,'2350',S,0)),0)<>
                    NVL(SUM(decode(KOD,'2350',0,decode(KOD,'2305',1,'2290',1,'2355',1,-1)*S)),0)						
	UNION ALL		--  ����� ������� ����� �� �������������  2450 = 2400+2405+2410+2415+2445
			select 1 KOL, NVL(SUM(decode(KOD,'2450',S,0)),0) SL,
                           NVL(SUM(decode(KOD,'2450',0,S)),0) SR
             from fin_rnk 
             where OKPO=OKPO_ and FDAT=DAT_ and idf=IDF_ 
               and  kod in ('2450','2400','2405','2410','2415','2445')
             having NVL(SUM(decode(KOD,'2450',S,0)),0)<>
                    NVL(SUM(decode(KOD,'2450',0,S)),0)									
	UNION ALL		--  ����� ������� ����� ���� �������������  2460 = 2450-2455
			select 1 KOL, NVL(SUM(decode(KOD,'2460',S,0)),0) SL,
                           NVL(SUM(decode(KOD,'2460',0,decode(KOD,'2450',1,-1)*S)),0) SR
             from fin_rnk 
             where OKPO=OKPO_ and FDAT=DAT_ and idf=IDF_ 
               and  kod in ('2460','2450','2455')
             having NVL(SUM(decode(KOD,'2460',S,0)),0)<>
                    NVL(SUM(decode(KOD,'2460',0,decode(KOD,'2450',1,-1)*S)),0)					
	UNION ALL		--  �������� ����� (���� ����� 2350, 2355 �� 2460)  2465 = 2350-2355+2460
			select 1 KOL, NVL(SUM(decode(KOD,'2465',S,0)),0) SL,
                           NVL(SUM(decode(KOD,'2465',0,decode(KOD,'2355',-1,1)*S)),0) SR
             from fin_rnk 
             where OKPO=OKPO_ and FDAT=DAT_ and idf=IDF_ 
               and  kod in ('2465','2350','2355','2460')
             having NVL(SUM(decode(KOD,'2465',S,0)),0)<>
                    NVL(SUM(decode(KOD,'2465',0,decode(KOD,'2355',-1,1)*S)),0)	
	UNION ALL		--  ����� (��� �������� �����ֲ���� ������)  2550 = 2500+2505+2510+2515+2520
			select 1 KOL, NVL(SUM(decode(KOD,'2550',S,0)),0) SL,
                           NVL(SUM(decode(KOD,'2550',0,S)),0) SR
             from fin_rnk 
             where OKPO=OKPO_ and FDAT=DAT_ and idf=IDF_ 
               and  kod in ('2550','2500','2505','2510','2515','2520')
             having NVL(SUM(decode(KOD,'2550',S,0)),0)<>
                    NVL(SUM(decode(KOD,'2550',0,S)),0)					
					);
					
    elsIf FZ_ = 'M' then /* ���_���� �������� ����� 2-M */
       select count (*) into N2_
       from (select 1 KOL, NVL(SUM(decode(KOD,'010',S,0)),0) SL,
                           NVL(SUM(decode(KOD,'010',0,S)),0) SR
             from fin_rnk 
             where OKPO=OKPO_ and FDAT=DAT_ and idf=IDF_ 
               and  kod in ('030','010','020')
             having NVL(SUM(decode(KOD,'010',S,0)),0)<>
                    NVL(SUM(decode(KOD,'010',0,S)),0)
          UNION ALL
		    select 1 KOL, NVL(SUM(decode(KOD,'070',S,0)),0) SL,
                           NVL(SUM(decode(KOD,'070',0,S)),0) SR
             from fin_rnk 
             where OKPO=OKPO_ and FDAT=DAT_ and idf=IDF_ 
               and  kod in ('070','030','040','050')
             having NVL(SUM(decode(KOD,'070',S,0)),0)<>
                    NVL(SUM(decode(KOD,'070',0,S)),0)
          UNION ALL
		    select 1 KOL, NVL(SUM(decode(KOD,'120',S,0)),0) SL,
                           NVL(SUM(decode(KOD,'120',0,S)),0) SR
             from fin_rnk 
             where OKPO=OKPO_ and FDAT=DAT_ and idf=IDF_ 
               and  kod in ('120','080','090','100')
             having NVL(SUM(decode(KOD,'120',S,0)),0)<>
                    NVL(SUM(decode(KOD,'120',0,S)),0)
		UNION ALL		
			select 1 KOL, NVL(SUM(decode(KOD,'130',S,0)),0) SL,
                           NVL(SUM(decode(KOD,'130',0,decode(KOD,'070',1,-1)*S)),0) SR
             from fin_rnk 
             where OKPO=OKPO_ and FDAT=DAT_ and idf=IDF_ 
               and  kod in ('130','070','120')
             having NVL(SUM(decode(KOD,'130',S,0)),0)<>
                    NVL(SUM(decode(KOD,'130',0,decode(KOD,'070',1,-1)*S)),0)
		UNION ALL		
			select 1 KOL, NVL(SUM(decode(KOD,'150',S,0)),0) SL,
                           NVL(SUM(decode(KOD,'150',0,decode(KOD,'130',1,'145',1,-1)*S)),0) SR
             from fin_rnk 
             where OKPO=OKPO_ and FDAT=DAT_ and idf=IDF_ 
               and  kod in ('150','130','140','145')
             having NVL(SUM(decode(KOD,'150',S,0)),0)<>
                    NVL(SUM(decode(KOD,'150',0,decode(KOD,'130',1,'145',1,-1)*S)),0)					
        
				
        );
    else /* ���_���� �������� ����� 2 */

       select count (*) into N2_
       from ( /* 1) 035 = 010 - 015 - 020 - 030. */
         select 1 KOL,
           NVL(SUM( decode(KOD,'035',S,0)),0) SL,
           NVL(SUM( decode(KOD,'035',0, Decode(KOD,'010',1,-1)*S)),0) SR
         from fin_rnk where OKPO=OKPO_ and FDAT=DAT_ and idf=IDF_ and
           kod in ('030','010','020','025','035','015')
         having
           NVL(SUM( decode(KOD,'035',S,0)),0) <>
           NVL(SUM( decode(KOD,'035',0, Decode(KOD,'010',1,-1)*S)),0)
       UNION ALL  /*  2) 050 = 035-040+055 */
         select 1, 
           NVL(SUM(decode(KOD,'050',S,0)), 0) ,
           NVL(SUM(decode(KOD,'050',0,decode(KOD,'040',-1,1)*S)),0)
         from fin_rnk where OKPO=OKPO_ and FDAT=DAT_ and idf=IDF_ and
           kod in ('050','055','035','040')
           having
             NVL(SUM(decode(KOD,'050',S,0)), 0) <>
             NVL(SUM(decode(KOD,'050',0,decode(KOD,'040',-1,1)*S)),0)
       UNION ALL /* 3) 100= 050-055 + 060 - 070 - 080 - 090+105 */
         select 1 ,
           NVL(SUM(decode(KOD,'100',S,0)),0),
           NVL(SUM(decode(KOD,'100',0,decode(kod,'050',1,'060',1,'105',1,-1)*S)),0)
         from fin_rnk where OKPO=OKPO_ and FDAT=DAT_ and idf=IDF_ and
           kod in ('050','060','105', '100','055','070','080','090')
           having
           NVL(SUM(decode(KOD,'100',S,0)),0)<>
           NVL(SUM(decode(KOD,'100',0,decode(kod,'050',1,'060',1,'105',1,-1)*S)),0)
       UNION ALL /*  4) */
         select 1 ,
           nvl(SUM(decode(KOD,'170',S,0)),0),
           nvl(SUM(decode(KOD,'170',0,decode(kod,'100',1,'110',1,'120',1,'130',1,'165',1,'175',1,-1)*S)),0)
         from fin_rnk where OKPO=OKPO_ and FDAT=DAT_ and idf=IDF_ and
           kod in ('170','105','140','150','160','165',
                   '100','110','120','130','175')
           having
           nvl(SUM(decode(KOD,'170',S,0)),0)<>
           nvl(SUM(decode(KOD,'170',0,decode(kod,'100',1,'110',1,'120',1,'130',1,'165',1,'175',1,-1)*S)),0)
       UNION ALL /*  5) 190 = 170-175 - 180+195+185 */
         select 1 ,
           nvl(SUM(decode(KOD,'190',S,0)),0),
           nvl(SUM(decode(KOD,'190',0,decode(kod,'170',1,'195',1,'185',1,-1)*S)),0)
         from fin_rnk where OKPO=OKPO_ and FDAT=DAT_ and idf=IDF_ and
           kod in ('170','175','195','190','180','185')
		   having
           nvl(SUM(decode(KOD,'190',S,0)),0)<>
           nvl(SUM(decode(KOD,'190',0,decode(kod,'170',1,'195',1,'185',1,-1)*S)),0)
       UNION ALL /* 6)  220-225 = 190-195 + 200 - 205 - 210+225 */
         select 1 ,
          nvl(SUM(decode(KOD,'220',S,0)),0),
          nvl(SUM(decode(KOD,'220',0,decode(kod,'190',1,'200',1,'225',1,-1)*S)),0)
         from fin_rnk where OKPO=OKPO_ and FDAT=DAT_ and idf=IDF_ and
          kod in ('220','195','205','210','190','200','225','215')
          having
          nvl(SUM(decode(KOD,'220',S,0)),0) <>
          nvl(SUM(decode(KOD,'220',0,decode(kod,'190',1,'200',1,'225',1,-1)*S)),0)
		  UNION ALL /* )  280=230+240+250+260+270+280 */
         select 1 ,
          nvl(SUM(decode(KOD,'280',S,0)),0),
          nvl(SUM(decode(KOD,'280',0,S)),0)
         from fin_rnk where OKPO=OKPO_ and FDAT=DAT_ and idf=IDF_ and
          kod in ('280','230','240','250','260','270','280')
          having
          nvl(SUM(decode(KOD,'280',S,0)),0) <>
          nvl(SUM(decode(KOD,'280',0,S)),0)
       );
   end if;
   FIN_nbu.aOKPO_ := OKPO_;
   return N2_;
end if;
If IDF_<> 1 then 
   FIN_nbu.aOKPO_ := OKPO_;
   RETURN 0; 
end if;
------------
---����� � 1 �� 8 ������� ���������
If (FZ_ = ' ' or FZ_ = 'M') then /* ���_���� �������� ����� 1 ����� + 1-M */ 
select count (*) into N2_
from (
select 1 KOL, NVL(SUM(decode(KOD,'010',S,0)),0) SL,
              NVL(SUM(decode(KOD,'010',0,decode(kod,'011',1,-1)*S)),0) SR
from fin_rnk where OKPO=OKPO_ and FDAT=DAT_ and idf=IDF_ and
     kod in ('010','011','012')
       having NVL(SUM(decode(KOD,'010',S,0)),0)<>
              NVL(SUM(decode(KOD,'010',0,decode(kod,'011',1,-1)*S)),0)
 UNION ALL
 select 1,NVL(SUM(decode(KOD,'035',S,0)),0),
         NVL(SUM(decode(KOD,'035',0,decode(KOD,'036',1,-1)*S)),0)
from fin_rnk where OKPO=OKPO_ and FDAT=DAT_ and idf=IDF_ and
     kod in ('035','036','037')
  having NVL(SUM(decode(KOD,'035',S,0)),0)<>
         NVL(SUM(decode(KOD,'035',0,decode(KOD,'036',1,-1)*S)),0)
UNION ALL
select 1 KOL, NVL(SUM(decode(KOD,'080',S,0)),0) SL,
              NVL(SUM(decode(KOD,'080',0,S)),0) SR
from fin_rnk where OKPO=OKPO_ and FDAT=DAT_ and idf=IDF_ and
     kod in ('080','010','020','030','035','040','045','050','055','060','065','070','075')
       having NVL(SUM(decode(KOD,'080',S,0)),0)<>
              NVL(SUM(decode(KOD,'080',0,S)),0)
 UNION ALL
 select 1,NVL(SUM(decode(KOD,'160',S,0)),0),
         NVL(SUM(decode(KOD,'160',0,decode(KOD,'161',1,-1)*S)),0)
from fin_rnk where OKPO=OKPO_ and FDAT=DAT_ and idf=IDF_ and
     kod in ('160','161','162')
  having NVL(SUM(decode(KOD,'160',S,0)),0)<>
         NVL(SUM(decode(KOD,'160',0,decode(KOD,'161',1,-1)*S)),0)
UNION ALL
select 1,NVL(SUM(decode(KOD,'260',S,0)),0),
         NVL(SUM(decode(KOD,'260',0,S)),0)
from fin_rnk where OKPO=OKPO_ and FDAT=DAT_ and idf=IDF_ and
     kod in ('260','100','110','120','130','140','150','160','170',
             '180','190','200','210','220','230','240','250')
  having NVL(SUM(decode(KOD,'260',S,0)),0)<>
         NVL(SUM(decode(KOD,'260',0,S)),0)
UNION ALL
select 1,NVL(SUM(decode(KOD,'280',S,0)),0),
         NVL(SUM(decode(KOD,'280',0,S)),0)
from fin_rnk where OKPO=OKPO_ and FDAT=DAT_ and idf=IDF_ and
     kod in ('280', '080','260','270','275')
  having NVL(SUM(decode(KOD,'280',S,0)),0)<>
         NVL(SUM(decode(KOD,'280',0,S)),0)
UNION ALL
select 1,NVL(SUM(decode(KOD,'380',S,0)),0),
         NVL(SUM(decode(KOD,'380',0,decode(KOD,'360',-S,'370',-S,S))),0)
from fin_rnk where OKPO=OKPO_ and FDAT=DAT_ and idf=IDF_ and
     kod in ('380','300','310','320','330','340','350','360','370','375')
  having NVL(SUM(decode(KOD,'380',S,0)),0)<>
         NVL(SUM(decode(KOD,'380',0,decode(KOD,'360',-S,'370',-S,S))),0)
UNION ALL
select 1,NVL(SUM(decode(KOD,'430',S,0)),0),
         NVL(SUM(decode(KOD,'430',0,decode(KOD,'416',-S,S))),0)
from fin_rnk where OKPO=OKPO_ and FDAT=DAT_ and idf=IDF_ and FZ_<>'M' and
     kod in ('430','400','410','420','415','416','417','418')
  having NVL(SUM(decode(KOD,'430',S,0)),0)<>
         NVL(SUM(decode(KOD,'430',0,decode(KOD,'416',-S,S))),0)
UNION ALL
select 1,NVL(SUM(decode(KOD,'480',S,0)),0),
         NVL(SUM(decode(KOD,'480',0,S)),0)
from fin_rnk
where NVL(FZ_,' ')<>'M' and OKPO=OKPO_ and FDAT=DAT_ and idf=IDF_ and
     kod in ('480','440','450','460','470')
  having NVL(SUM(decode(KOD,'480',S,0)),0)<>
         NVL(SUM(decode(KOD,'480',0,S)),0)
UNION ALL
select 1,NVL(SUM(decode(KOD,'620',S,0)),0),
         NVL(SUM(decode(KOD,'620',0,S)),0)
from fin_rnk where OKPO=OKPO_ and FDAT=DAT_ and idf=IDF_ and
     kod in ('620','500','510','520','530','540','550','560','570','580','590','600','610','605')
  having NVL(SUM(decode(KOD,'620',S,0)),0)<>
         NVL(SUM(decode(KOD,'620',0,S)),0)
UNION ALL
select 1,NVL(SUM(decode(KOD,'640',S,0)),0),
         NVL(SUM(decode(KOD,'640',0,S)),0)
from fin_rnk where OKPO=OKPO_ and FDAT=DAT_ and idf=IDF_ and
     kod in ('640','380','430','480','620','630')
  having NVL(SUM(decode(KOD,'640',S,0)),0)<>
         NVL(SUM(decode(KOD,'640',0,S)),0)
UNION ALL
select 1,NVL(SUM(decode(KOD,'640',S,0)),0),
         NVL(SUM(decode(KOD,'640',0,S)),0)
from fin_rnk where OKPO=OKPO_ and FDAT=DAT_ and idf=IDF_ and
     kod in ('640','280')
  having NVL(SUM(decode(KOD,'640',S,0)),0)<>
         NVL(SUM(decode(KOD,'640',0,S)),0)
) ;
elsIf (FZ_ = 'N' or FZ_ = 'R') then  /*���_���� �������� ����� 1   ����� ����*/
select count (*) into N2_
from (
select 1 KOL, NVL(SUM(decode(KOD,'1000',S,0)),0) SL,
              NVL(SUM(decode(KOD,'1000',0,decode(kod,'1001',1,-1)*S)),0) SR
from fin_rnk where OKPO=OKPO_ and FDAT=DAT_ and idf=IDF_ and
     kod in ('1000','1001','1002')
       having NVL(SUM(decode(KOD,'1000',S,0)),0)<>
              NVL(SUM(decode(KOD,'1000',0,decode(kod,'1001',1,-1)*S)),0)
 UNION ALL
select 1 KOL, NVL(SUM(decode(KOD,'1010',S,0)),0) SL,
              NVL(SUM(decode(KOD,'1010',0,decode(kod,'1011',1,-1)*S)),0) SR
from fin_rnk where OKPO=OKPO_ and FDAT=DAT_ and idf=IDF_ and
     kod in ('1010','1011','1012')
       having NVL(SUM(decode(KOD,'1010',S,0)),0)<>
              NVL(SUM(decode(KOD,'1010',0,decode(kod,'1011',1,-1)*S)),0)
 UNION ALL
select 1 KOL, NVL(SUM(decode(KOD,'1095',S,0)),0) SL,
              NVL(SUM(decode(KOD,'1095',0,S)),0) SR
from fin_rnk where OKPO=OKPO_ and FDAT=DAT_ and idf=IDF_ and
     kod in ('1095','1000','1005','1010','1015','1020','1030','1035','1040','1045','1050','1060','1005','1065','1090')
       having NVL(SUM(decode(KOD,'1095',S,0)),0)<>
              NVL(SUM(decode(KOD,'1095',0,S)),0)
UNION ALL
select 1 KOL, NVL(SUM(decode(KOD,'1195',S,0)),0) SL,
              NVL(SUM(decode(KOD,'1195',0,S)),0) SR
from fin_rnk where OKPO=OKPO_ and FDAT=DAT_ and idf=IDF_ and
     kod in ('1195','1100','1110','1115','1120','1125','1130','1135','1140','1145','1155','1160','1165','1170','1180','1190')
       having NVL(SUM(decode(KOD,'1195',S,0)),0)<>
              NVL(SUM(decode(KOD,'1195',0,S)),0)
   UNION ALL
select 1 KOL, NVL(SUM(decode(KOD,'1300',S,0)),0) SL,
              NVL(SUM(decode(KOD,'1300',0,S)),0) SR
from fin_rnk where OKPO=OKPO_ and FDAT=DAT_ and idf=IDF_ and
     kod in ('1300','1095','1195','1200')
       having NVL(SUM(decode(KOD,'1300',S,0)),0)<>
              NVL(SUM(decode(KOD,'1300',0,S)),0)
UNION ALL
select 1 KOL, NVL(SUM(decode(KOD,'1495',S,0)),0) SL,
              NVL(SUM(decode(KOD,'1495',0,S)),0) SR
from fin_rnk where OKPO=OKPO_ and FDAT=DAT_ and idf=IDF_ and
     kod in ('1495','1400','1405','1410','1415','1420','1425','1430','1435')
       having NVL(SUM(decode(KOD,'1495',S,0)),0)<>
              NVL(SUM(decode(KOD,'1495',0,S)),0)
UNION ALL
select 1 KOL, NVL(SUM(decode(KOD,'1595',S,0)),0) SL,
              NVL(SUM(decode(KOD,'1595',0,S)),0) SR
from fin_rnk where OKPO=OKPO_ and FDAT=DAT_ and idf=IDF_ and
     kod in ('1595','1500','1505','1510','1515','1520','1525','1530','1535','1540','1545') and FZ_ = 'N'
       having NVL(SUM(decode(KOD,'1595',S,0)),0)<>
              NVL(SUM(decode(KOD,'1595',0,S)),0)
UNION ALL
select 1 KOL, NVL(SUM(decode(KOD,'1695',S,0)),0) SL,
              NVL(SUM(decode(KOD,'1695',0,S)),0) SR
from fin_rnk where OKPO=OKPO_ and FDAT=DAT_ and idf=IDF_ and
     kod in ('1695','1600','1605','1610','1615','1620','1625','1630','1635','1640','1645','1650','1660','1665','1670','1690')
       having NVL(SUM(decode(KOD,'1695',S,0)),0)<>
              NVL(SUM(decode(KOD,'1695',0,S)),0)
UNION ALL
select 1 KOL, NVL(SUM(decode(KOD,'1900',S,0)),0) SL,
              NVL(SUM(decode(KOD,'1900',0,S)),0) SR
from fin_rnk where OKPO=OKPO_ and FDAT=DAT_ and idf=IDF_ and
     kod in ('1900','1495','1595','1695','1700','1800') 
       having NVL(SUM(decode(KOD,'1900',S,0)),0)<>
              NVL(SUM(decode(KOD,'1900',0,S)),0)
UNION ALL
select 1,NVL(SUM(decode(KOD,'1300',S,0)),0),
         NVL(SUM(decode(KOD,'1300',0,S)),0)
from fin_rnk where OKPO=OKPO_ and FDAT=DAT_ and idf=IDF_ and
     kod in ('1300','1900')
  having NVL(SUM(decode(KOD,'1300',S,0)),0)<>
         NVL(SUM(decode(KOD,'1300',0,S)),0)
	 
			);  
end if;

FIN_nbu.aOKPO_ := OKPO_;
RETURN N2_;

end LOGK;
----

---------------
FUNCTION LOGK_D (DAT_ date    , OKPO_ int, IDF_  int)  RETURN number Is
 N1_ int :=0; KOL_ int :=0;
 M0_ char(1); M1_  char(1); M2_ char(1); M3_ char(1); M4_ char(1);
begin

  If IDF_ <> 2 then 
     FIN_nbu.aOKPO_ := OKPO_;
     return 0; 
  end if;

  M0_:= fin_nbu.F_FM(OKPO_,           DAT_    );
  M1_:= fin_nbu.F_FM(OKPO_,add_months(DAT_,- 3));
  M2_:= fin_nbu.F_FM(OKPO_,add_months(DAT_,- 6));
  M3_:= fin_nbu.F_FM(OKPO_,add_months(DAT_,- 9));
  M4_:= fin_nbu.F_FM(OKPO_,add_months(DAT_,-12));
  ---����� � 2 �� ����������� ����� ������� ��
  If M0_ = M1_  then 
     select count(*) into KOL_
     from fin_rnk f0 , fin_rnk f1
     where f0.OKPO = OKPO_   and f0.FDAT = DAT_  and f0.idf=IDF_
       and f1.OKPO = f0.OKPO and f1.FDAT = add_months(f0.FDAT,-3) 
       and f1.idf  = f0.idf  and f0.kod  = f1.kod 
       and f0.s    < f1.s
       and to_char( DAT_-1,'Q')<>'1'
       and (f0.kod<>'190' or M0_<>'M');
  end if;
  N1_:= N1_ + KOL_;

  If M1_ = M2_   then 
     select count(*) into KOL_ 
     from fin_rnk f0 , fin_rnk f1
     where f0.OKPO = OKPO_   and f0.FDAT = add_months(DAT_,-3)  and f0.idf=IDF_
       and f1.OKPO = f0.OKPO and f1.FDAT = add_months(f0.FDAT,-3) 
       and f1.idf  = f0.idf  and f0.kod  = f1.kod 
       and f0.s    < f1.s
       and to_char( DAT_-1,'Q')<>'2'
       and (f0.kod<>'190' or M1_<>'M');
  end if;
  N1_:= N1_ + KOL_;

  If M2_ = M3_   then 
     select count(*) into KOL_
     from fin_rnk f0 , fin_rnk f1
     where f0.OKPO = OKPO_   and f0.FDAT = add_months(DAT_,-6)  and f0.idf=IDF_
       and f1.OKPO = f0.OKPO and f1.FDAT = add_months(f0.FDAT,-3) 
       and f1.idf  = f0.idf  and f0.kod  = f1.kod 
       and f0.s    <f1.s
       and to_char( DAT_-1,'Q')<>'3'
       and (f0.kod<>'190' or M2_<>'M');
  end if;
  N1_:= N1_ + KOL_;

  If M3_ = M4_   then 
     select count(*) into KOL_
     from fin_rnk f0 , fin_rnk f1
     where f0.OKPO = OKPO_   and f0.FDAT = add_months(DAT_,-9)    and f0.idf=IDF_
       and f1.OKPO = f0.OKPO and f1.FDAT = add_months(f0.FDAT,-3) 
       and f1.idf  = f0.idf  and f0.kod  = f1.kod 
       and f0.s    < f1.s
       and to_char( DAT_-1,'Q')<>'4'
       and (f0.kod<>'190' or M3_<>'M');
  end if;
  N1_:= N1_ + KOL_;
  fin_nbu.aOKPO_ := OKPO_;
  RETURN N1_;

end LOGK_D;

PROCEDURE record_fp(KOD_   IN  char, 
                     S_    IN  number,  
                     IDF_  IN  int,
				     DAT_  IN  date default aDAT_,
				     OKPO_ IN  int default aOKPO_ )
	IS				 
Begin					 
					 
UPDATE FIN_RNK
  SET S = round(S_,3)
    WHERE fdat = DAT_
	  AND okpo = OKPO_
	  AND kod = KOD_
	  AND idf = IDF_;
if SQL%rowcount = 0 then
   INSERT INTO FIN_RNK (FDAT,  IDF, KOD, S,  OKPO) VALUES (DAT_,  IDF_, KOD_, round(S_,3),  OKPO_);
end if;   
					 
END record_fp;
  
  
  PROCEDURE record_fp_ND(KOD_   IN  char, 
                         S_    IN  number,  
                         IDF_  IN  int,
				         DAT_  IN  date default aDAT_,
				         ND_   IN  int default aND_,
                         RNK_  IN  int default aRNK_ )
	IS				 
Begin					 
					 
UPDATE FIN_ND
  SET S = round(S_,3), fdat = DAT_ 
    WHERE --fdat = DAT_  AND 
	  ND = ND_ and rnk = RNK_
	  AND kod = KOD_
	  AND idf = IDF_;
if SQL%rowcount = 0 then
   INSERT INTO FIN_ND (FDAT,  IDF, KOD, S,  ND, RNK) VALUES (DAT_,  IDF_, KOD_, round(S_,3),  ND_, RNK_);
end if;   

 
 MERGE INTO BARS.FIN_ND_HIST A USING  (SELECT DAT_ as FDAT,  IDF_ as IDF, KOD_ as KOD, round(S_,3) as S, ND_ as ND, RNK_ as RNK, null as VAL_DATE   FROM DUAL) B
                               ON (A.RNK = B.RNK and A.ND = B.ND and A.IDF = B.IDF and A.KOD = B.KOD and A.FDAT = B.FDAT)
        WHEN NOT MATCHED THEN 
                  INSERT (FDAT, IDF, KOD, S, ND, RNK, VAL_DATE)
                  VALUES (B.FDAT, B.IDF, B.KOD, B.S, B.ND, B.RNK, B.VAL_DATE)
        WHEN MATCHED THEN
                   UPDATE SET  A.S = B.S,  A.VAL_DATE = B.VAL_DATE;
				   
	 				 
END record_fp_ND;

PROCEDURE record_fp_ND_date(KOD_         IN  char,
    						val_date_    IN  date,
							IDF_         IN  int,
							DAT_         IN  date default aDAT_,
							ND_          IN  int  default aND_,
							RNK_         IN  int  default aRNK_ )
	IS
l_val_date_ date;
Begin

case when val_date_= to_date('01-01-0001','dd-mm-yyyy')
     then l_val_date_ := null;
	 else l_val_date_ := val_date_;
end case;


UPDATE FIN_ND
  SET val_date = l_val_date_,
      fdat = DAT_
    WHERE
	  ND = ND_ and rnk = RNK_
	  AND kod = KOD_
	  AND idf = IDF_;
if SQL%rowcount = 0 then
   INSERT INTO FIN_ND (FDAT,  IDF, KOD, val_date,  ND, RNK)
      VALUES (DAT_,  IDF_, KOD_, l_val_date_,  ND_, RNK_);
end if;
	  
	   MERGE INTO BARS.FIN_ND_HIST A USING  (SELECT DAT_ as FDAT,  IDF_ as IDF, KOD_ as KOD, null as S, ND_ as ND, RNK_ as RNK, l_val_date_ as VAL_DATE   FROM DUAL) B
                               ON (A.RNK = B.RNK and A.ND = B.ND and A.IDF = B.IDF and A.KOD = B.KOD and A.FDAT = B.FDAT)
        WHEN NOT MATCHED THEN 
                  INSERT (FDAT, IDF, KOD, S, ND, RNK, VAL_DATE)
                  VALUES (B.FDAT, B.IDF, B.KOD, B.S, B.ND, B.RNK, B.VAL_DATE)
        WHEN MATCHED THEN
                   UPDATE SET  A.S = B.S,  A.VAL_DATE = B.VAL_DATE;
				   
				   


END record_fp_ND_date;
  
	PROCEDURE get_class(ND_ in number,
	                    OKPO_ in number,
						DAT_ in date,
						RNK_ in number)
  IS
  aIPB_  number;
  v_     number;  
  kv_     number; 
  class_ number;
  obs_ number;
  l_col number:=-1;	
  --rnk_ number;

    
  BEGIN
  
  aDAT_  := DAT_;
  aOKPO_ := OKPO_;
  aND_   := ND_;
  aRNK_ := rnk_;
  
  
    BEGIN	
    select s 
	  into aIPB_  
	  from fin_rnk
	 where okpo = OKPO_
       and fdat = DAT_
       and kod  = 'IPB'
	   and idf  = 6;
          exception when NO_DATA_FOUND THEN --goto next1_ ;
		  if ZN_P_ND ('KP3', 5) = 2 then class_ := 8; goto next1_;
		  else  raise_application_error(-(20000),'\ ' ||'     �� �����������  ������������ �������� �������� ��  ������ ����� - '||DAT_,TRUE);  
		  end if;
    END;
  
    
    
      v_ :=GET_VED(RNK_ , DAT_);

  
  
  
 IF fin_nbu.F_FM(OKPO_, DAT_ ) in (' ', 'N') then 
 
		  IF v_ = 1 then
				if aIPB_ >   1.25   then  class_ := 1;
			 elsif aIPB_ >=  0.81   then  class_ := 2;
			 elsif aIPB_ >=  0.60   then  class_ := 3;
			 elsif aIPB_ >=  0.35   then  class_ := 4;
			 elsif aIPB_ >=  0.05   then  class_ := 5;
			 elsif aIPB_ >= -0.25   then  class_ := 6;
			 elsif aIPB_ >= -0.70   then  class_ := 7;
			 elsif aIPB_ >  -3.20   then  class_ := 8;
			 else                         class_ := 9;
			 end if;
			 
		elsif v_ = 2 then 
				if aIPB_ >   1.35   then  class_ := 1;
			 elsif aIPB_ >=  0.71   then  class_ := 2;
			 elsif aIPB_ >=  0.35   then  class_ := 3;
			 elsif aIPB_ >=  0.00   then  class_ := 4;
			 elsif aIPB_ >= -0.36   then  class_ := 5;
			 elsif aIPB_ >= -0.70   then  class_ := 6;
			 elsif aIPB_ >= -1.20   then  class_ := 7;
			 elsif aIPB_ >  -3.50   then  class_ := 8;
			 else                         class_ := 9;
			 end if;
			 
		elsif v_ = 3 then
				if aIPB_ >   1.35   then  class_ := 1;
			 elsif aIPB_ >=  0.81   then  class_ := 2;
			 elsif aIPB_ >=  0.51   then  class_ := 3;
			 elsif aIPB_ >=  0.17   then  class_ := 4;
			 elsif aIPB_ >= -0.20   then  class_ := 5;
			 elsif aIPB_ >= -0.50   then  class_ := 6;
			 elsif aIPB_ >= -1.04   then  class_ := 7;
			 elsif aIPB_ >  -3.70   then  class_ := 8;
			 else                         class_ := 9;
			 end if;
			 
		elsif v_ = 4 then
				if aIPB_ >   1.35   then  class_ := 1;
			 elsif aIPB_ >=  0.80   then  class_ := 2;
			 elsif aIPB_ >=  0.51   then  class_ := 3;
			 elsif aIPB_ >=  0.04   then  class_ := 4;
			 elsif aIPB_ >= -0.40   then  class_ := 5;
			 elsif aIPB_ >= -0.75   then  class_ := 6;
			 elsif aIPB_ >= -1.34   then  class_ := 7;
			 elsif aIPB_ >  -4.70   then  class_ := 8;
			 else                         class_ := 9;
			 end if;
			 
		elsif v_ = 5 then
				if aIPB_ >   0.60   then  class_ := 1;
			 elsif aIPB_ >=  0.07   then  class_ := 2;
			 elsif aIPB_ >= -0.15   then  class_ := 3;
			 elsif aIPB_ >= -0.40   then  class_ := 4;
			 elsif aIPB_ >= -0.67   then  class_ := 5;
			 elsif aIPB_ >= -0.90   then  class_ := 6;
			 elsif aIPB_ >= -1.30   then  class_ := 7;
			 elsif aIPB_ >  -3.80   then  class_ := 8;
			 else                         class_ := 9;
			 end if;


		elsif v_ = 6 then
				if aIPB_ >   1.50   then  class_ := 1;
			 elsif aIPB_ >=  0.91   then  class_ := 2;
			 elsif aIPB_ >=  0.62   then  class_ := 3;
			 elsif aIPB_ >=  0.16   then  class_ := 4;
			 elsif aIPB_ >= -0.27   then  class_ := 5;
			 elsif aIPB_ >= -0.60   then  class_ := 6;
			 elsif aIPB_ >= -1.20   then  class_ := 7;
			 elsif aIPB_ >  -4.70   then  class_ := 8;
			 else                         class_ := 9;
			 end if;
			 
		elsif v_ = 7 then
				if aIPB_ >   1.55   then  class_ := 1;
			 elsif aIPB_ >=  1.01   then  class_ := 2;
			 elsif aIPB_ >=  0.76   then  class_ := 3;
			 elsif aIPB_ >=  0.35   then  class_ := 4;
			 elsif aIPB_ >= -0.05   then  class_ := 5;
			 elsif aIPB_ >= -0.37   then  class_ := 6;
			 elsif aIPB_ >= -0.95   then  class_ := 7;
			 elsif aIPB_ >  -3.50   then  class_ := 8;
			 else                         class_ := 9;
			 end if;
			 
		elsif v_ = 8 then
				if aIPB_ >   2.00   then  class_ := 1;
			 elsif aIPB_ >=  1.20   then  class_ := 2;
			 elsif aIPB_ >=  0.95   then  class_ := 3;
			 elsif aIPB_ >=  0.52   then  class_ := 4;
			 elsif aIPB_ >=  0.10   then  class_ := 5;
			 elsif aIPB_ >= -0.25   then  class_ := 6;
			 elsif aIPB_ >= -0.83   then  class_ := 7;
			 elsif aIPB_ >  -4.20   then  class_ := 8;
			 else                         class_ := 9;
			 end if;
			 
		elsif v_ = 9 then
				if aIPB_ >   1.15   then  class_ := 1;
			 elsif aIPB_ >=  0.70   then  class_ := 2;
			 elsif aIPB_ >=  0.45   then  class_ := 3;
			 elsif aIPB_ >=  0.09   then  class_ := 4;
			 elsif aIPB_ >= -0.26   then  class_ := 5;
			 elsif aIPB_ >= -0.55   then  class_ := 6;
			 elsif aIPB_ >= -1.10   then  class_ := 7;
			 elsif aIPB_ >  -3.30   then  class_ := 8;
			 else                         class_ := 9;
			 end if;
		else  class_ := 9999;
		end if;
 ELSE
		  IF v_ = 1 then
				if aIPB_ >   1.00   then  class_ := 1;
			 elsif aIPB_ >=  0.50   then  class_ := 2;
			 elsif aIPB_ >=  0.28   then  class_ := 3;
			 elsif aIPB_ >= -0.10   then  class_ := 4;
			 elsif aIPB_ >= -0.45   then  class_ := 5;
			 elsif aIPB_ >= -0.75   then  class_ := 6;
			 elsif aIPB_ >= -1.26   then  class_ := 7;
			 elsif aIPB_ >  -4.20   then  class_ := 8;
			 else                         class_ := 9;
			 end if;
			 
		elsif v_ = 2 then 
				if aIPB_ >   2.00   then  class_ := 1;
			 elsif aIPB_ >=  1.40   then  class_ := 2;
			 elsif aIPB_ >=  1.05   then  class_ := 3;
			 elsif aIPB_ >=  0.55   then  class_ := 4;
			 elsif aIPB_ >=  0.01   then  class_ := 5;
			 elsif aIPB_ >= -0.40   then  class_ := 6;
			 elsif aIPB_ >= -1.10   then  class_ := 7;
			 elsif aIPB_ >  -4.40   then  class_ := 8;
			 else                         class_ := 9;
			 end if;
			 
		elsif v_ = 3 then
				if aIPB_ >   1.70   then  class_ := 1;
			 elsif aIPB_ >=  1.11   then  class_ := 2;
			 elsif aIPB_ >=  0.81   then  class_ := 3;
			 elsif aIPB_ >=  0.35   then  class_ := 4;
			 elsif aIPB_ >= -0.10   then  class_ := 5;
			 elsif aIPB_ >= -0.50   then  class_ := 6;
			 elsif aIPB_ >= -1.14   then  class_ := 7;
			 elsif aIPB_ >  -4.10   then  class_ := 8;
			 else                         class_ := 9;
			 end if;
			 
		elsif v_ = 4 then
				if aIPB_ >   2.20   then  class_ := 1;
			 elsif aIPB_ >=  1.25   then  class_ := 2;
			 elsif aIPB_ >=  0.90   then  class_ := 3;
			 elsif aIPB_ >=  0.42   then  class_ := 4;
			 elsif aIPB_ >= -0.05   then  class_ := 5;
			 elsif aIPB_ >= -0.50   then  class_ := 6;
			 elsif aIPB_ >= -1.20   then  class_ := 7;
			 elsif aIPB_ >  -4.90   then  class_ := 8;
			 else                         class_ := 9;
			 end if;
			 
		elsif v_ = 5 then
				if aIPB_ >   2.10   then  class_ := 1;
			 elsif aIPB_ >=  1.40   then  class_ := 2;
			 elsif aIPB_ >=  0.81   then  class_ := 3;
			 elsif aIPB_ >=  0.53   then  class_ := 4;
			 elsif aIPB_ >=  0.04   then  class_ := 5;
			 elsif aIPB_ >= -0.35   then  class_ := 6;
			 elsif aIPB_ >= -1.10   then  class_ := 7;
			 elsif aIPB_ >  -4.20   then  class_ := 8;
			 else                         class_ := 9;
			 end if;


		elsif v_ = 6 then
				if aIPB_ >   1.60   then  class_ := 1;
			 elsif aIPB_ >=  0.96   then  class_ := 2;
			 elsif aIPB_ >=  0.71   then  class_ := 3;
			 elsif aIPB_ >=  0.20   then  class_ := 4;
			 elsif aIPB_ >= -0.24   then  class_ := 5;
			 elsif aIPB_ >= -0.59   then  class_ := 6;
			 elsif aIPB_ >= -1.25   then  class_ := 7;
			 elsif aIPB_ >  -5.20   then  class_ := 8;
			 else                         class_ := 9;
			 end if;
			 
		elsif v_ = 7 then
				if aIPB_ >   1.40   then  class_ := 1;
			 elsif aIPB_ >=  0.86   then  class_ := 2;
			 elsif aIPB_ >=  0.61   then  class_ := 3;
			 elsif aIPB_ >=  0.20   then  class_ := 4;
			 elsif aIPB_ >= -0.19   then  class_ := 5;
			 elsif aIPB_ >= -0.50   then  class_ := 6;
			 elsif aIPB_ >= -1.10   then  class_ := 7;
			 elsif aIPB_ >  -4.40   then  class_ := 8;
			 else                         class_ := 9;
			 end if;
			 
		elsif v_ = 8 then
				if aIPB_ >   2.50   then  class_ := 1;
			 elsif aIPB_ >=  1.51   then  class_ := 2;
			 elsif aIPB_ >=  1.20   then  class_ := 3;
			 elsif aIPB_ >=  0.75   then  class_ := 4;
			 elsif aIPB_ >=  0.32   then  class_ := 5;
			 elsif aIPB_ >= -0.10   then  class_ := 6;
			 elsif aIPB_ >= -0.75   then  class_ := 7;
			 elsif aIPB_ >  -3.40   then  class_ := 8;
			 else                         class_ := 9;
			 end if;
			 
		elsif v_ = 9 then
				if aIPB_ >   1.60   then  class_ := 1;
			 elsif aIPB_ >=  0.98   then  class_ := 2;
			 elsif aIPB_ >=  0.62   then  class_ := 3;
			 elsif aIPB_ >=  0.23   then  class_ := 4;
			 elsif aIPB_ >= -0.20   then  class_ := 5;
			 elsif aIPB_ >= -0.55   then  class_ := 6;
			 elsif aIPB_ >= -1.19   then  class_ := 7;
			 elsif aIPB_ >  -4.20   then  class_ := 8;
			 else                         class_ := 9;
			 end if;
		else  class_ := 9999;
		end if;
  
  END IF;
  
 <<next1_>>
  
  if ZN_P_ND ('KP5', 5) = 1 then class_ := 9;
  else  
        if ZN_P_ND ('KP4', 5) = 1 or  ZN_P_ND ('KP3', 5) = 2 then class_ := GREATEST(8,class_);
        else 
			  if  ZN_P_ND ('KP1', 5) = 1 then
				   if ZN_P_ND ('KP2', 5) = 2 then class_ := GREATEST(8,class_);
			       end if;	
			   else class_ := GREATEST(8,class_);	   
              end if;  			  
        end if;  		
  
  end if;
  
 -- record_fp('110', class_, 6, DAT_, OKPO_ );
  
  
  if nd_ = 0 then 
					  update v_fin_cc_deal  
						 set fin23 = class_
					   where  rnk = rnk_
						 --and sos < 15 
						-- and vidd in (1,2,3)
	                                                 ;
  else
					update v_fin_cc_deal  
					 set fin23 = class_
				   where  nd = nd_   and rnk = rnk_
					 --and sos < 15 -- 
					 --and vidd in (1,2,3)
                                                	 ;
               --	record_fp_nd('110', class_, 6, DAT_, ND_, RNK_ );											 
   end if;	 

   record_fp_nd('110', class_, 6, DAT_, ND_, RNK_ );
/*    if rnk_ > 0 then
   kl.setCustomerElement(RNK_, 'FIN23', class_, 0);
   end if; */
   
   	    if  class_ is not null and rnk_ > 0   then
				-------- ������� � �������� �볺���
		select count(1) into l_col from customerw where rnk=RNK_ and tag='FIN23' and isp !=0;
		if l_col >= 1 then 
		   delete from customerw where rnk=RNK_ and tag='FIN23';
		   kl.setCustomerElement(RNK_, 'FIN23', class_, 0);
		else 
		   kl.setCustomerElement(RNK_, 'FIN23', class_, 0);
		end if;
        end if; 
		
/*
������� � �������� �����
*/


  
  

if ZN_P_ND ('KP6', 5) = 2 
    then class_ := GREATEST(8,class_);
end if;



  if nd_ = 0 then 

	  begin 
			select max(CC_val( nd,RNK,DAT_))
			  into kv_
			  from v_fin_cc_deal
			 where  rnk = rnk_ ;

			  update v_fin_cc_deal c
				 set fin23 = class_
			   where rnk = rnk_  
			   and CC_val( nd,RNK,DAT_) = 1
			  -- and (sdate > G_DATE_VAL  or (sdate <= G_DATE_VAL and exists (select 1 from cck_restr where nd = c.nd and fdat > G_DATE_VAL))	 )	
			 ; 
			 
    	if kv_ = 1 then  record_fp_nd('110', class_, 6, DAT_, ND_, RNK_ );
		                 record_fp('110', class_, 6, DAT_, OKPO_);
		 end if;
		 
		exception when NO_DATA_FOUND THEN
			  null;
		end;
				 
  else
   
             kv_ := CC_val( nd_,RNK_,DAT_);
	 
			  update v_fin_cc_deal c
				 set fin23 = class_
			   where nd = nd_ and rnk = rnk_
--				 and  kv != 980
                and kv_ = 1
--      		and (sdate > G_DATE_VAL or (sdate <= G_DATE_VAL and exists (select 1 from cck_restr where nd = c.nd and fdat > G_DATE_VAL)) )
				 ; 

    	if kv_ = 1 then  record_fp_nd('110', class_, 6, DAT_, ND_, RNK_ );
		                 record_fp('110', class_, 6, DAT_, OKPO_);
		 end if;
				 
   end if;	

	 
	 if  class_ is not null and rnk_ > 0  and kv_ = 1 then 
				-------- ������� � �������� �볺���
				      select count(1) into l_col from customerw where rnk=RNK_ and tag='FIN23' and isp !=0;
		if l_col >= 1 then 
		   delete from customerw where rnk=RNK_ and tag='FIN23';
		   kl.setCustomerElement(RNK_, 'FIN23', class_, 0);
		else 
		   kl.setCustomerElement(RNK_, 'FIN23', class_, 0);
		end if;
		/* 
    update customerw set value = class_, isp = 0 where rnk=RNK_ and tag='FIN23' returning count(rnk) into l_col;
    if l_col=0 then
       insert into customerw (rnk, tag, value, isp) values (RNK_, 'FIN23', class_, 0);
    end if; */
	
	end if; 
	 
	 
	        begin   
                   select max(obs23)
				     into obs_
			         from v_fin_cc_deal 
				    where rnk = rnk_ --and sos<15 
					  --and vidd in (1,2,3)
					  ;
 			  exception when NO_DATA_FOUND THEN 
					obs_ := null;
		     END; 
  
            if obs_ is not null then 
			              fin_nbu.record_fp('OBS', obs_, 6, DAT_, OKPO_ );
					--	  fin_nbu.record_fp_nd('OBS', obs_, 6, DAT_, ND_, RNK_ ); 
			end if;
  
  
 
 
  null;
END get_class;

PROCEDURE get_class_fl (ND_ in number,
	                    OKPO_ in number,
						DAT_ in date,
				     	RNK_ in number)
  IS
  
  class_ number;
  class_r number;
  l_col number:=-1;
  kv_     number;   
  --rnk_ number;

    
  BEGIN
  
  aDAT_  := DAT_;
  aOKPO_ := OKPO_;
  aND_   := ND_;
  aRNK_ := rnk_;

     BEGIN	
    select max(fin23)
	  into class_ 
	  from v_fin_cc_deal
	 where (nd = nd_ or nd_ = 0) and rnk = rnk_;
          exception when NO_DATA_FOUND THEN --goto next1_ ;
		                                    raise_application_error(-(20000),'\ ' ||'     �� �������� REF KD = '||ND_,TRUE);  
    END;
  
  
  if ZN_P_ND ('KP5', 5) = 1 then class_ := 4;
  else  
        if ZN_P_ND ('KP4', 5) = 1 or  ZN_P_ND ('KP3', 5) = 2 then class_ := GREATEST(4,class_);
        else 
			  if  ZN_P_ND ('KP1', 5) = 1 then
				   if ZN_P_ND ('KP2', 5) = 2 then class_ := GREATEST(4,class_);
			       end if;	
			   elsif ZN_P_ND ('KP1', 5) = 2 then class_ := GREATEST(4,class_);	   
			   end if;  			  
        end if;  		
  
  end if;
  
  
  if nd_ = 0 then 
					  update v_fin_cc_deal  
						 set fin23 = class_
					   where  rnk = rnk_

	                                                 ;
  else
					update v_fin_cc_deal  
					 set fin23 = class_
				   where  nd = nd_   and rnk = rnk_
                                                	 ;
   end if;	

/*
������� � �������� �����
*/

if ZN_P_ND ('KP6', 5) = 2 
    then class_ := GREATEST(4,class_);
end if;

  if nd_ = 0 then 
			  update v_fin_cc_deal c
				 set fin23 = class_
			   where rnk = rnk_  
			     and CC_val( nd,RNK,DAT_) = 1
			                    and (sdate > G_DATE_VAL
				                     or (sdate <= G_DATE_VAL and exists (select 1 from cck_restr where nd = c.nd and fdat > G_DATE_VAL))
									 ); 
		begin 
			select max(CC_val( nd,RNK,DAT_))
			  into kv_
			  from v_fin_cc_deal
			 where nd = nd_ and rnk = rnk_ and sdate > G_DATE_VAL;
		 
    	if kv_ = 1 then  record_fp_nd('110', class_, 6, DAT_, ND_, RNK_ );
		                 record_fp('110', class_, 6, DAT_, OKPO_);
		 end if;
		 
		exception when NO_DATA_FOUND THEN
			  null;
		end;
  else
           kv_ := CC_val( nd_,RNK_,DAT_);
		   
			  update v_fin_cc_deal c
				 set fin23 = class_
			   where nd = nd_ and rnk = rnk_ and kv_ = 1
				 and  kv != 980  and (sdate > G_DATE_VAL
				                     or (sdate <= G_DATE_VAL and exists (select 1 from cck_restr where nd = c.nd and fdat > G_DATE_VAL))
									 ); 
   end if;	
	 
	if  class_ is not null and kv_ = 1 then 
				-------- ������� � �������� �볺���
      select count(1) into l_col from customerw where rnk=RNK_ and tag='FIN23' and isp !=0;
		if l_col >= 1 and class_ is not null and rnk_ > 0 then 
		   delete from customerw where rnk=RNK_ and tag='FIN23';
		   kl.setCustomerElement(RNK_, 'FIN23', class_, 0);
		else 
		   kl.setCustomerElement(RNK_, 'FIN23', class_, 0);
		end if;
		
    /* update customerw set value = class_, isp = 0 where rnk=RNK_ and tag='FIN23' returning count(rnk) into l_col;
    if l_col=0 then
       insert into customerw (rnk, tag, value, isp) values (RNK_, 'FIN23', class_, 0);
    end if; */
	end if; 
 
  null;
END get_class_fl;



  FUNCTION LOGK_read (
                   DAT_ date,
                   OKPO_ int,
                   IDF_  int,
				   mode_ int ) RETURN number
  is
coun_ number;
sum_  number;
kont_ number;
 
 begin
 
 
 select nvl(count(s),0), nvl(sum(abs(s)),0)
   into     coun_, sum_
   from fin_rnk
  where  okpo = okpo_
    and idf = idf_
    and fdat = dat_;

    kont_ := LOGK( DAT_ , OKPO_ , IDF_ );
	
	if mode_ = 1 then
	      if kont_ = 0  and coun_ !=0 and sum_ != 0 then return 0;           -- ������� ���������� ����� �� �������� �����
	   elsif kont_ = 0  and coun_ !=0 and sum_  = 0 then return 1;           -- �������� ����� , �볺�� ������� �����
	   elsif kont_ != 0 and coun_ !=0 and sum_ != 0 then return 2;         -- �������� ����� , ������� � ���������
	   elsif kont_ = 0  and coun_ =0  and sum_  = 0 then RETURN 3;            ---�²�Ͳ��� �� ���������
	   end if;
	elsif mode_ = 2 then 
	   if kont_ = 0 and coun_ !=0 and sum_ != 0 
	        then return 0;      -- ���������� �����������
			else return 1;      -- ��������� �����������  
	   end if;
	else return -1;
	end if;
			return -1;	 
end LOGK_read;


FUNCTION CC_val 
              ( ND_ number,
			    RNK_ number,
				DAT_ date,
				l_pos varchar2 default '23'
              ) return number
is
p_vidd number;
p_kv number;
p_sdate date;
i number;
l_date_val date;
begin
 /*
 3.	������ ��������� ������ ����������� ������� ������� �.�  ������������� �� ���������� ���������:
���� � ����� �������� �� �������� �������� SS �� SP � ������� � �����, �� �� ������ �������������,
� ����  � ����� ��������  �� �������� �������� SS �� SP � ������� ����� � �����, �� �� �������������.
����� �� ������ ������� 8999 �� ��������.
 G_DATE_VAL DATE := to_date('04-03-2012','dd-mm-yyyy');
 */
 
 if l_pos = '23' 
    then  l_date_val := G_DATE_VAL;
	else  l_date_val := to_date('01-01-1900','dd-mm-yyyy');
 end if;
 
 begin
	 select  vidd, kv, (select nvl(max(fdat),c.sdate) from cck_restr where nd = c.nd and vid_restr = 5 and pr_no = 0) as sdate
	   into  p_vidd, p_kv, p_sdate
	   from  v_fin_cc_deal c
	  where  rnk =  RNK_
		and  nd = ND_ and rownum = 1
		order by decode(kv,980,null, kv) asc NULLS LAST;  
		exception when NO_DATA_FOUND THEN 
			 p_vidd    :=  0;
			 p_kv      :=  fin_nbu.zn_p_nd('VAL', '30', dat_, nd_, rnk_);
			 p_sdate   :=  sysdate;
 end;

    if p_vidd != 3 then
    
			if p_kv != 980 and p_sdate > L_DATE_VAL then return 1;
						                            else return 0;
			end if;
    
   else    
		   
		   begin
		   for k in (
			  select a.kv, (select nvl(max(fdat),c.sdate) from cck_restr where nd = c.nd and vid_restr = 5 and pr_no = 0) as sdate
				from cc_deal c, nd_acc nd, accounts a  
			   where c.nd = ND_
				 and c.nd = nd.nd    
				 and nd.acc = a.acc and a.dazs is null
				 --and a.ostc != 0
				 and a.tip in ('SS ','SP ') 
				 order by decode(a.kv,980,null, a.kv) asc NULLS LAST
			)
			loop
			/*���� �������� �� ��������� �������� � �������� �����, �� ������ �� 04.03.2012 ���� (�������) �� �� ���� �� ��������� 
			  ���� ���� 04.03.2012 ���� �� ����������� ��� ���������� ��������� ���������� � ��������, ����� ������ ������ � 
			  �������� �����, ������������� ������������ ���������� ���������� �������/������ � �������� ����� � �����, 
			  ����������� ��� ��������� ����� �������� 䳿 ��������.*/
			   if k.kv != 980 and k.sdate >  L_DATE_VAL then return 1;
			elsif k.kv != 980 and k.sdate <= L_DATE_VAL then return 0;
			elsif k.kv  = 980 then return 0;
			end if;
			
			end loop;
			end;
		 
			if  fin_nbu.zn_p_nd('VAL', '30', dat_, nd_, rnk_) = 980 then return 0;
																	else return 1;
			end if;
			
 	end if; 
     
	 

 

end cc_val;			  

procedure Load_testND (
			Rnk_   number,
			ND_    number,
			DAT_   date  
	 	) 
  is
p_Rnk    number;
p_Sos_   number;
p_Col_   number;
p_Okpo   number;

Begin



Begin
Select sos 
  into p_Sos_
  from cc_deal
 where nd  = Nd_
   and rnk = Rnk_;
EXCEPTION WHEN no_data_found  THEN return;
  End;
   
  
 /*
 �������� ����� ���� ������� ��������� ��������� �볺���
 */


  Select count(1)
    Into p_Col_ 
    from fin_nd
   where nd  = -1
     and rnk = Rnk_;   
     

  Select -okpo
    Into p_Okpo
    From Customer
   Where rnk = Rnk_;
    



   If   p_Col_ >= 10 then p_Rnk := Rnk_;    
                     else p_Rnk := p_Okpo; 
   End If;                        



   
   
    /*
        ���� ������ � ���� "�����" �������� �������� ��������� ����������
   */

   
if  p_Sos_ = 0  
   
   then    
   
        For k in (select rowid as Id_row  from fin_nd where rnk = p_Rnk and nd = -1 and fdat = Dat_) 
        Loop 
              Begin
                   update fin_nd
                      set nd = Nd_,
                          rnk = Rnk_
                    where rowid = k.Id_row;

            EXCEPTION WHEN DUP_VAL_ON_INDEX  THEN null;
           End;  
		End loop;   
   
   else null;
end if;      

End Load_testND;

procedure correction_parameters (                    p_mod     Varchar2,
                                                     p_nd      Nbu23_Cck_Ul_Kor.nd%type,
                                                     p_zdat    varchar2,
                                                     p_fin23   Nbu23_Cck_Ul_Kor.fin23%type,
                                                     p_obs23   Nbu23_Cck_Ul_Kor.obs23%type,
                                                     p_kat23   Nbu23_Cck_Ul_Kor.kat23%type,
                                                     p_k23     Nbu23_Cck_Ul_Kor.k23%type,
                                                     p_fin_351 Nbu23_Cck_Ul_Kor.fin_351%type,
                                                     p_pd      Nbu23_Cck_Ul_Kor.pd%type,
                                                     p_comm    Nbu23_Cck_Ul_Kor.comm%type,
                                                     p_vkr     Nbu23_Cck_Ul_Kor.vkr%type)
as
l_nbu23_kor   Nbu23_Cck_Ul_Kor%rowtype;
l_customer    customer%rowtype;
l_prod        cc_deal.prod%type;
l_i           number;
l_min         number;
l_max         number;

begin
    l_nbu23_kor.mod     :=   p_mod;
    l_nbu23_kor.nd      :=   p_nd;
    l_nbu23_kor.zdat    :=   trunc(to_date(p_zdat,'dd/mm/yyyy'),'MM');
    l_nbu23_kor.pdat    :=   sysdate;
    l_nbu23_kor.fin23   :=   p_fin23;
    l_nbu23_kor.obs23   :=   p_obs23;
    l_nbu23_kor.kat23   :=   p_kat23;
    l_nbu23_kor.k23     :=   p_k23;
    l_nbu23_kor.fin_351 :=   p_fin_351;
    l_nbu23_kor.pd      :=   p_pd;
    l_nbu23_kor.isp     :=   user_id;
    l_nbu23_kor.comm    :=   p_comm;
    l_nbu23_kor.vkr     :=   p_vkr;
    l_nbu23_kor.kf      :=   sys_context('bars_context','user_mfo');

    if BARSUPL.IS_T0_OK(l_nbu23_kor.zdat) = 1 THEN
       raise_application_error(-20000,'���� ��������� ����������! ³������� �������� ������ T0 '); 
    end if;

   Case  p_mod
      When 'CCK'  then    select rnk, prod    into l_customer.rnk, l_prod   from cc_deal  where  nd = p_nd;
      else return;
   End case;


     select * into l_customer  from  customer where  rnk = l_customer.rnk;

    --  ������ ��� �볺��� ��� ��������� ����
     case  WHEN substr(l_prod,1,2) = '21' THEN  l_customer.custtype := 4; else null; END CASE;


   -- �������� ����� ������������ 351
   if l_customer.custtype  =  2    and p_fin_351 not in (1,2,3,4,5,6,7,8,9,10) or
      l_customer.custtype in (3,4) and p_fin_351 not in (1,2,3,4,5)  THEN l_min := 1;
      if l_customer.custtype = 2 THEN l_max := 10;
      else                            l_max := 5;
      end if;
      raise_application_error(-(20001),'\      �� ���� ������� ���� ������������. ��������� �������� �� '||l_min||' �� '||l_max ,TRUE);
   end if;
   
 -- ��������� ���������	
   if  regexp_like (l_nbu23_kor.comm, '[�������������������������������]') and length(l_nbu23_kor.comm) >5 then null;
       else  raise_application_error(-(20001),'\      ��������� ������� ������� ����������� (>5 �����) ' ,TRUE);
   end if;

   insert into  Nbu23_Cck_Ul_Kor values l_nbu23_kor;

   Case  p_mod

      When 'CCK'  then
                    update cc_deal
                       set fin_351 = l_nbu23_kor.fin_351,
                           pd      = l_nbu23_kor.pd
                     where nd      = l_nbu23_kor.nd;
                    CCK_APP.Set_ND_TXT (l_nbu23_kor.nd, 'VNCRR', l_nbu23_kor.vkr);

       else return;

   End case;


end;


 Procedure get_adjustment (p_mod   in  Varchar2,
                           p_nd    in  Nbu23_Cck_Ul_Kor.nd%type,
						   p_flag  Out number, 
						   p_fin23 Out Nbu23_Cck_Ul_Kor.fin23%type,
                           p_obs23 Out Nbu23_Cck_Ul_Kor.obs23%type,
                           p_kat23 Out Nbu23_Cck_Ul_Kor.kat23%type,
                           p_k23   Out Nbu23_Cck_Ul_Kor.k23%type
						   )
as
l_zdat date;
l_d number;  
begin
  if  to_char(sysdate,'mm') = '01'
      then l_d := 20;
	  else l_d := 10;
  End if;

/*
 if  to_number(to_char(sysdate,'dd')) < l_d 
      then l_zdat := trunc(sysdate-l_d,'MM');
	  else l_zdat := trunc(sysdate,'MM');
 End if;
*/
 
 l_zdat := round(sysdate,'MM');

  begin 
	select fin23, obs23, kat23, k23
	  into p_fin23, p_obs23,p_kat23, p_k23  
	  from Nbu23_Cck_Ul_Kor
	 where id = (select max(id) from Nbu23_Cck_Ul_Kor where nd = p_nd and mod = p_mod and zdat = l_zdat);
   p_flag := 1;
  exception when no_data_found then  p_flag := 0;
  end;  
end;

 --  �������� ������� ��� WEB  �� ������� FIN_KVED
FUNCTION f_fin_kved  (  p_rnk  customer.rnk%type
                       ,p_okpo fin_kved.okpo%type
                       ,p_dat  fin_kved.dat%type
                      )   					  
            RETURN t_kved PIPELINED  PARALLEL_ENABLE iS 
  l_kved t_col_kved;
  l_vols number := 0;
  l_volp number := 0;
  l_max number;
  l_2000 number;
  l_ss   number;
  l_CK   varchar2(1);
BEGIN
     --   'N_CK'    1 - �������� �������
 l_ck := substr(nvl(kl.get_customerw(P_RNK => p_rnk, 
	                          P_TAG => 'N_CK', 
					          P_ISP => 0),0),1,1);
							  
    if l_ck = '0' then  l_2000 :=  ZN_F2(2000, 3, p_dat, p_okpo);
	              else  l_2000 :=  ZN_F2(2010, 3, p_dat, p_okpo); 
	end if;
	 
	 
	 select max(nvl(volme_sales,0)), sum(nvl(volme_sales,0))
	   into l_max, l_ss
	   from fin_kved
	   where okpo = p_okpo and 
			 dat  = p_dat;
	  
   
     for x in ( select a.kved, v.name, volme_sales, weight, flag 
	              from fin_kved a, ved v  
				 where okpo = p_okpo and 
				       dat = p_dat and 
					   a.kved = v.ved
					) 
     loop   
            l_kved.kved        := x.kved;
			l_kved.name        := x.name;
			l_kved.volme_sales := nvl(x.volme_sales,0);
			case  when l_2000 != 0 then l_kved.weight      := round(nvl(x.volme_sales,0)*100/l_2000,12);
			                       else l_kved.weight      := null;
            end case;
            l_kved.flag        := x.flag;
			l_kved.ord         := 0;
            l_vols := l_vols + l_kved.volme_sales;
			l_volp := l_volp + l_kved.weight;
			
            PIPE ROW(l_kved);   
 
     end loop;
   
            l_kved.kved        := null;
			l_kved.name        := '������:';
			l_kved.volme_sales := l_vols;
			l_kved.weight      := l_volp;
			l_kved.flag        := null;
			l_kved.ord         := 1;
		
            PIPE ROW(l_kved); 
   
   
 RETURN;

 END; 

 procedure determ_kved(p_rnk         customer.rnk%type,
                       p_okpo        fin_kved.okpo%type,
                       p_dat         fin_kved.dat%type				 	   
                      )
as
  l_max number;
  l_2000 number;
  l_ss   number;
  l_kved  fin_kved.kved%type;
  l_coun  number := 0;
  l_CK   varchar2(1);
BEGIN
     --   'N_CK'    1 - �������� �������
 l_ck := substr(nvl(kl.get_customerw(P_RNK => p_rnk, 
	                          P_TAG => 'N_CK', 
					          P_ISP => 0),0),1,1);
							  
    if l_ck = '0' then  l_2000 :=  ZN_F2(2000, 3, p_dat, p_okpo);
	              else  l_2000 :=  ZN_F2(2010, 3, p_dat, p_okpo); 
	end if;

	 
	 
	 select max(nvl(volme_sales,0)), sum(nvl(volme_sales,0))
	   into l_max, l_ss
	   from fin_kved
	   where okpo = p_okpo and 
			 dat  = p_dat;
			 
    
	
 If  l_2000 = l_ss then

     select max(kved) kved, count(kved) coun
	   into l_kved, l_coun
	   from fin_kved
      where okpo        = p_okpo and
            dat         = p_dat  and	  
			volme_sales = l_max;
   
     -- ������������ ���� ��� ���� � ������������ ��������� ������ ����
		update fin_kved a
           set  flag         = case when  a.volme_sales = l_max then 1 else 0 end
         where  okpo         = p_okpo         and
                dat          = p_dat; 
		
    -- ���������� ���� ��� ���� �� ������� �������� ������ ����		
    case 
	    when l_coun = 1 then
		     update fin_fm
			    set ved = l_kved
			  where okpo = p_okpo and
                    fdat = p_dat;			  
		else null;
    end case;
 
 else
    update fin_kved a
           set  flag         = 0
         where  okpo         = p_okpo         and
                dat          = p_dat;

     update fin_fm
			    set ved = null
			  where okpo = p_okpo and
                    fdat = p_dat;				
 
 end if; 
			 
		 
end;

	
Procedure save_volmesales (p_rnk         customer.rnk%type,
                           p_okpo        fin_kved.okpo%type,
                           p_dat         fin_kved.dat%type,  
                           p_kved        fin_kved.kved%type,
                           p_volme_sales fin_kved.VOLME_SALES%type 					 	   
                          )
as
  l_max number;
  l_2000 number;
  l_ss   number;
  l_kved  fin_kved.kved%type;
  l_coun  number := 0;
begin
  
begin      
 insert into fin_kved (okpo,   dat,   kved,   volme_sales ) 
              values (p_okpo, p_dat, p_kved, p_volme_sales);
exception when dup_val_on_index then 
  update fin_kved
    set  volme_sales  = p_volme_sales
  where  okpo         = p_okpo         and
         dat          = p_dat          and
         kved         = p_kved; 
end;
		 determ_kved(p_rnk,p_okpo,p_dat);
end;
	
					  
  

Procedure del_volmesales (p_rnk         customer.rnk%type,
                          p_okpo        fin_kved.okpo%type,
                          p_dat         fin_kved.dat%type,  
                          p_kved        fin_kved.kved%type
                          )
as
begin
  
 delete from fin_kved  
  where  okpo         = p_okpo         and
         dat          = p_dat          and
         kved         = p_kved; 
	
determ_kved(p_rnk,p_okpo,p_dat);
					
end;  
  

  
Procedure add_findat (p_rnk         fin_dat.rnk%type,
                      p_nd          fin_dat.nd%type,
                      p_dat         fin_dat.fdat%type)
as
begin      
 insert into fin_dat  (rnk, nd, fdat) 
               values (p_rnk, p_nd, p_dat);
exception when dup_val_on_index then  null;
end;  

-- �������������� ���������� �� ������� �볺�� �� �����			   
procedure rnk_group  (RNK_  number,
                      ND_   number,
					  DAT_  date,
					  zDAT_ date,
					  okpo_ varchar2)
Is
 	l_okpo_rel number;
	l_NGRK   number := 0;
	l_NGRP   number := 0;
	l_fin_cust fin_cust%rowtype;
	l_ int;
	
begin


  aND_     := ND_ ;      -- �������� ��� ND
  aRNK_    := RNK_;      -- �������� ��� RNK
  aDAT_    := zDAT_;     -- ������� ���� �������
  
    
  
 
 /*
 * ���������� �� ���� ���������
 */
 
		 begin
				select 1
				  into 	l_NGRP
				  from D8_cust_link_Groups 
				 where okpo    = okpo_ and
					   rownum = 1;
				 fin_nbu.record_fp_nd('NGRP', l_NGRP, 51, DAT_); 
		 exception when no_data_found then 
		         fin_nbu.record_fp_nd('NGRP', 0,      51, DAT_); 
		 end;
 
  /*
   ��������� �볺��� �� ���� �������������
  */
  
       fin_nbu.record_fp_nd('NGRK', l_NGRK, 51, DAT_); 
	   fin_nbu.record_fp_nd('GRKL', null, 51, DAT_); 
	   fin_nbu.record_fp_nd('CLS1', null, 56, DAT_); 
	   
	   --fin_nbu.record_fp_nd('GRCL', null, 51, zDAT_); 
	  
	  for cur in ( select * from (
					select rel_id, rel_rnk, rel_intext 
					  from BARS.CUSTOMER_REL 
					 where rnk    = RNK_      and 
						   rel_id in (51)   and
						   sysdate between nvl(bdate,sysdate) and nvl(edate,sysdate)
                      order by rel_id desc, rel_intext desc
                           ) where rownum = 1

				  )
	  loop
	     
		 if cur.rel_id = 51       then  l_NGRK :=  1;
		 else CONTINUE;
		 end if;
		 
	  case cur.rel_intext
	       when 1 then --customer
		        begin 
					Select rnk , (cur.rel_intext+1)||lpad(lpad(rnk,10,'0'),11,'9') okpo, nmkk, ved, datea
					  into l_okpo_rel, l_fin_cust.okpo, l_fin_cust.nmk, l_fin_cust.ved, l_fin_cust.datea
					  from customer
					 Where rnk = cur.rel_rnk and custtype = 2;  
					 fin_nbu.record_fp_nd('NGRK', l_NGRK, 51, DAT_); 
					 fin_nbu.record_fp_nd('NUMG', l_okpo_rel, 51, DAT_); 
				exception when no_data_found then 
				  null;
				end;
		   when 0 then -- CUSTOMER_EXTERN
		        begin 
					Select id , (cur.rel_intext+1)||lpad(lpad(id,10,'0'),11,'9') okpo, substr(name,1,38) nmk, ved, null datea
					  into l_okpo_rel, l_fin_cust.okpo, l_fin_cust.nmk, l_fin_cust.ved, l_fin_cust.datea
					  from CUSTOMER_EXTERN
					 Where id = cur.rel_rnk and custtype = 1;  
					 fin_nbu.record_fp_nd('NGRK', l_NGRK, 51, DAT_); 
					 fin_nbu.record_fp_nd('NUMG', l_okpo_rel, 51, DAT_); 
				exception when no_data_found then 
				  null;
				end;		   
		   else null;
	  end case;
	  
	  
	Begin  
	  l_ :=  ZN_P_ND('CLS', 59, DAT_,-2,-l_fin_cust.okpo, null);
	   exception when others then 
	       raise_application_error (-20000,  '\9999       �� ����� ������� ���� ���� ����� �� ������� ���������:' || -l_fin_cust.okpo);
	end;
	   -- ���� ����� ����������
	   fin_nbu.record_fp_nd('GRKL', ZN_P_ND('CLS', 59, DAT_,-2,-l_fin_cust.okpo, null), 51, DAT_); 
	   --fin_nbu.record_fp_nd('GRCL', l_, 51, zDAT_); 
	   
	   if   LOGK_read (trunc(add_months(DAT_,-9),'YYYY'),l_fin_cust.okpo,1,1) = 0   then   fin_nbu.record_fp_nd('NKZV', 1, 51, DAT_); 
	                                                                                else   fin_nbu.record_fp_nd('NKZV', 0, 51, DAT_);   
       End if;
	  
	  begin
	    l_fin_cust.okpo := to_number(l_fin_cust.okpo);
	   
			  if l_fin_cust.okpo is not null and cur.rel_id = 51  then 
				  begin
				   l_fin_cust.custtype := 5;
				   l_fin_cust.kf   := sys_context('bars_context','user_mfo');
				   insert into  fin_cust values l_fin_cust;
					   exception when dup_val_on_index then  null;
				  end;
			  end if;
  	   exception when others then  null;
	   end;
	   
	  end loop;
	  
	  
	end;
-- �������������� ���������� ���������						   
procedure get_subpok (RNK_  number,
                      ND_   number,
					  DAT_  date,
					  zDAT_ date)
Is
	okpo_  number;
	datea_ date;
	sdate_ date;
	sdatey_ date;
	sTmp    number := 0;
	sTmp0   number := 0;
	sTmp1   number := 0;
	sTmp2   number := 0;
	sTmp3   number := 0;
	l_dat  date;
	
	l_bv  number;
	l_rez number;
	l_period int;
	l_okpo_rel number;
	l_NGRK   number := 0;
	l_fin_cust fin_cust%rowtype;
	l_ int;
	x_ int;
	l_dat_ date;
	
begin


	begin
		select okpo, datea
   		into okpo_, datea_
		from fin_customer
		where rnk = rnk_;
	exception when NO_DATA_FOUND THEN
					     raise_application_error(-(20000),'\ ' ||'     �� �������� �볺��� � RNK - '||rnk_,TRUE);
	END;

	begin
	   select sdate
   		 into sdate_
		 from cc_deal
		where nd = nd_;
	exception when NO_DATA_FOUND THEN
					     null; --raise_application_error(-(20000),'\ ' ||'     �� �������� ����� � ND - '||nd_,TRUE);
	END;
	
	    -- ����� �������
    Begin
		SELECT s
		  into l_period
		  from fin_rnk
		 where kod = 'TZVT' 
		   and okpo = okpo_
		   and fdat = zDAT_ and s in (3,6,12);
	  exception when NO_DATA_FOUND THEN  
             l_period := fin_obu.p_zvt(RNK_, zDAT_);
    end;	

	   record_fp('TZVT',  l_period, 6, zDAT_, OKPO_);
        	
	
  aOKPO_   := okpo_;      -- �������� ��� ����
  aND_     := ND_ ;      -- �������� ��� ND
  aRNK_    := RNK_;      -- �������� ��� RNK
  aDAT_    := zDAT_;     -- ������� ���� �������
  
  FZ_    :=  fin_nbu.F_FM (aOKPO_, aDAT_ ) ;   -- ����� �������
  
   
 --���������� �� ��`���� �������� ������� �������� 3 ������� ����', 'KVZK', 52
  case
    -- < 1  ���� ���������� < 1 ����  
    when  add_months(sysdate,-12) < datea_        
	     then   sTmp0 := 0; -- ͳ
	-- ���� �������    
	when zDAT_ = trunc(zDAT_,'YYYY')  
	     then 
		      if  (
			       ZN_P(1495,1) < 0 and 
			       ZN_P(1495,1, add_months(zDAT_,-12)) < 0 and 
				   ZN_P(1495,1, add_months(zDAT_,-24)) < 0 
				   ) or
				  (
				   ZN_P(1495,1) < 0 and 
				   LOGK_read (add_months(zDAT_,-12),OKPO_,1,1) = 1 and 
				   LOGK_read (add_months(zDAT_,-24),OKPO_,1,1) = 0
				   )
				then  sTmp1:= 1 ; -- ���
			  end if; 
	else 
	        if  (
			     ZN_P(1495,1) < 0 and 
			     ZN_P(1495,1, add_months(trunc(zDAT_,'YYYY'),-12)) < 0 and 
				 ZN_P(1495,1, add_months(trunc(zDAT_,'YYYY'),-24)) < 0 and 
				 ZN_P(1495,1, add_months(trunc(zDAT_,'YYYY'),-36)) < 0  
				 )  or
				(
				 ZN_P(1495,1) < 0 and 
				 LOGK_read (add_months(trunc(zDAT_,'YYYY'),0),OKPO_,1,1)   = 1 and 
				 LOGK_read (add_months(trunc(zDAT_,'YYYY'),-12),OKPO_,1,1) = 0 and
				 LOGK_read (add_months(trunc(zDAT_,'YYYY'),-24),OKPO_,1,1) = 0
				) or
				(
				 ZN_P(1495,1) < 0 and 
				 LOGK_read (add_months(trunc(zDAT_,'YYYY'),0),OKPO_,1,1)   = 0 and  -- ���������
				 LOGK_read (add_months(trunc(zDAT_,'YYYY'),-12),OKPO_,1,1) = 1 and  --�� ���������
				 LOGK_read (add_months(trunc(zDAT_,'YYYY'),-24),OKPO_,1,1) = 0
				)
            then sTmp2:= 1 ; -- ���
            end if;			
  end case;		 
  
  fin_nbu.record_fp_nd('KVZK', greatest(0, sTmp0, sTmp1, sTmp2), 52, DAT_); 
  

  
  -- ��������� ��������� ����������� ��������� ����������� ����� �������� ������������� �� ����� ������� �� ���������', 4,'PVKZ', 52, null, 1 );
     
	 sTmp0 := null;
	 sTmp1 := null;
	 if FZ_ = 'N' then
	 --����� �������� ������������� �� ����� ������� �� ��������� 
	     
		begin
		            sTmp0 :=     ( ZN_F1('1510',4) + ZN_F1('1515',4) + ZN_F1('1600',4) + ZN_F1('1610',4) - ZN_F1('1165',4) )  /  
					             ( ZN_F2('2000',4) + ZN_F2('2010',4) );
			exception when ZERO_DIVIDE then
                    sTmp0 :=  null;	
		end; 

      --����� �������� ������������� �� �������� EBITDA  	    
		begin
		            sTmp1 :=     ( ZN_F1('1510',4) + ZN_F1('1515',4) + ZN_F1('1600',4) + ZN_F1('1610',4) - ZN_F1('1165',4) )  /  
					             ( ZN_F2('2190',4) - ZN_F2('2195',4) + ZN_F2('2515',4) );
			exception when ZERO_DIVIDE then   sTmp1 :=  null;	
		end; 		
	 
	 else
	  --����� �������� ������������� �� ����� ������� �� ��������� 
		begin
		          sTmp0 :=     ( ZN_F1('1595',4) + ZN_F1('1600',4) + ZN_F1('1610',4) - ZN_F1('1165',4) )  /  
				               ( ZN_F2('2000',4) );
		exception when ZERO_DIVIDE then  sTmp0 :=  null;	
		 		  when others  then
					    if sqlcode=-20000  then sTmp0 :=  null; -- ������ ���
						                   else raise;
					    end if;
		 end;	 
	 
	 
	  --����� �������� ������������� �� �������� EBITDA 
		begin
		          sTmp1 :=     ( ZN_F1('1595',4) + ZN_F1('1600',4) + ZN_F1('1610',4) - ZN_F1('1165',4) )  /  
				               ( ZN_F2('2000',4) - ZN_F2('2050',4) );
		exception when ZERO_DIVIDE then sTmp1 :=  null;	
				  when others  then
					    if sqlcode=-20000  then sTmp1 :=  null; -- ������ ���
						                   else raise;
					    end if;
		 end;	 
	 end if;

    fin_nbu.record_fp_nd('KZDV', sTmp0, 52, DAT_); 
    fin_nbu.record_fp_nd('KZDE', sTmp1, 52, DAT_); 


	if  sdate_ < to_date('03-01-2017','dd-mm-yyyy') 
	    then x_ := 7;
	    else x_ := 5;
	end if;
	
	if  sTmp0 > 2.5 and (sTmp1 > x_ or sTmp1 <= 0) then sTmp2:= 1;
	                                               else sTmp2:= 0;
    end if;
	
	fin_nbu.record_fp_nd('PVKZ', sTmp2, 52, DAT_);
	
	
	
	/*
	��������� ������ ���� ����������� ��������� �� 01.01.2018 ���� �� ������������� ���� �� ������ ������� 
	������� �������� ����� �������� ������������� �� �������� EBITDA ���� ����� 7 �� �� ���� ���������� 
	������ ������ ���������� ������ ������ � ������������������.
	*/
	
	
	sdatey_ := trunc(sdate_,'YYYY');
	
	/*   �������� 23/01/2017
    if FZ_ = 'N' then
      --����� �������� ������������� �� �������� EBITDA  	    
		begin
		            sTmp3 :=     ( ZN_F1('1510',4, sdatey_) + ZN_F1('1515',4, sdatey_) + ZN_F1('1600',4,sdatey_) + ZN_F1('1610',4,sdatey_) - ZN_F1('1165',4,sdatey_) )  /  
					             ( ZN_F2('2190',4,sdatey_) - ZN_F2('2195',4,sdatey_) + ZN_F2('2515',4,sdatey_) );
			exception when ZERO_DIVIDE then  sTmp3 :=     null;	 -- ������ �� 0
			          when others  then
					    if sqlcode=-20000  then sTmp3 :=  null; -- ������ ���
						                   else raise;
					    end if;
		end; 		
	 
	 else
	 
	  --����� �������� ������������� �� �������� EBITDA 
		begin
		          sTmp3 :=     ( ZN_F1('1595',4,sdatey_) + ZN_F1('1600',4,sdatey_) + ZN_F1('1610',4,sdatey_) - ZN_F1('1165',4,sdatey_) )  /  
				               ( ZN_F2('2000',4,sdatey_) - ZN_F2('2050',4,sdatey_) );
		exception when ZERO_DIVIDE then  sTmp3 :=     null;	  -- ������ �� 0
		          when others  then
					    if sqlcode=-20000  then sTmp3 :=  null; -- ������ ���
						                   else raise;
					    end if;
		 end;	 
	 end if;
	 
    if  DAT_ < to_date('01/01/2018','DD/MM/YYYY') and sTmp3 < 7  and ZN_P_ND('KRES', 51, DAT_)  >  0   
         then fin_nbu.record_fp_nd('PVKZ',     0, 52, DAT_); 
         else fin_nbu.record_fp_nd('PVKZ', sTmp2, 52, DAT_); 		 
	end if;
	*/
	
	 
  -- 17. � ����� ������ ��������� ������� ����������� �� ������� ������ ����� ����� 3 ����� ���� ������ ������� 
  -- 17,'PD17', 53 ,
 

    -- �������� �� ���������� ����������� ����� 2000 
	  if GET_KVED(RNK_, case when (sysdate-datea_) < 366 then zDAT_ else TRUNC(zDAT_,'YYYY') end , 1) is null
		 then sTmp0 := 1;
		 else sTmp0 := 0;
	  end if;
	  fin_nbu.record_fp_nd('PD20', sTmp0, 53, DAT_); 
	  
   -- �������� ������ �������   
/*    if to_char(dat_,'MM') = '05' then l_ := 5;
	                             else l_ := 4;
    end if;
   

   case l_period 
      when 3  then l_dat := trunc(add_months(DAT_, -l_),'Q');
      when 12 then l_dat := trunc(add_months(DAT_, -5 ),'YYYY');
      else if to_char(add_months(DAT_,-4),'MM')>=6 then l_dat := add_months(trunc(add_months(DAT_,-4),'YYYY'),5);
                                                   else l_dat := trunc(add_months(DAT_,-4),'YYYY');
           end if;
   end case;
 */   
 
   l_dat_ := trunc(sysdate); 
   if to_char(l_dat_-19,'MM')    = '04' then l_ := 4;
                                        else l_ := 3;
   end if;
   

   case l_period 
      when 3  then l_dat := greatest(trunc(add_months(l_DAT_, -l_)-19,'Q'),zDAT_);
      when 12 then l_dat := greatest(trunc(add_months(l_DAT_, -4 )-19,'YYYY'),zDAT_);
      else if to_char(add_months(l_DAT_,-3)-19,'MM')>=6 then l_dat := add_months(trunc(add_months(l_DAT_,-3)-19,'YYYY'),5);
                                                        else l_dat := trunc(add_months(l_DAT_,-3)-19,'YYYY');
           end if;
   end case;
  
    case 
      when 	LOGK_read(l_dat, OKPO_,1,1) != 0   
      then  fin_nbu.record_fp_nd('PD17', 1, 53, DAT_); 
      else  fin_nbu.record_fp_nd('PD17', 0, 53, DAT_); 
    end case;	  
   
  
  --  ������ ����� ������������ � �����, �������, �� ����� ������, �������� ������', 1,'VD1', 54,
    sTmp0 := 0;
    --fin_obu.days_of_delay(ND_);
	/*
	if  fin_obu.g_kol_dely > 0
	    then sTmp0 := 1;
	end if;
	   
	if  (greatest(0, sTmp0) = 1 and
	    ZN_P_ND ('INV', 32, DAT_)  != 2 and
		ZN_P_ND ('TIP', 32, DAT_)  != 1 and
		ZN_P_ND ('NGRK',51, DAT_)  not in ( 1, 2)  ) 
	then fin_nbu.record_fp_nd('VD1', 1, 54, DAT_); 
	else fin_nbu.record_fp_nd('VD1', 0, 54, DAT_); 
	end if;
  */
  -- ��������� ��������� ������ ���� �� �� 30% �� ��������� ���� ��������
  /* 
    If  ZN_P_ND('KRES', 51, DAT_) = 0 then
			Begin
				select  acrn.fprocn (a.acc, 0, ''), a.acc
				  into  sTmp0, sTmp2
				  from nd_acc n, accounts a
				 where n.acc = a.acc
				   and n.nd = ND_ 
				   and a.tip = 'LIM';
			 exception when NO_DATA_FOUND THEN null;
			END;	   
		  
			BEGIN
			  SELECT ir
				INTO sTmp1
				FROM int_ratn 
			   WHERE acc=sTmp2 AND id=0 AND
				     bdat = (SELECT MIN(bdat) 
					           FROM int_ratn
						      WHERE acc=sTmp2 AND id=0);
		   EXCEPTION WHEN NO_DATA_FOUND THEN null;
		   END;
  
        if    sTmp0 > 0  then       
		     sTmp3 := sTmp1*100/sTmp0; 
		else sTmp3 := 0;
		end if;
		
		if sTmp3 < 70 then fin_nbu.record_fp_nd('VD4', 1, 54, DAT_); 
		              else fin_nbu.record_fp_nd('VD4', 0, 54, DAT_);           
		end if;
  
    else fin_nbu.record_fp_nd('VD4', 0, 54, DAT_);           
    end if;
  */
  
  --  ���������� ������� �������� ������
         fin_nbu.record_fp_nd('ZD1', 1, 55, DAT_);   
		 If  ZN_P_ND('KRES', 51, DAT_) > 0 then
					   sTmp0 := 0;
					   sTmp1 := 0;
						for k in 1..12
						loop 
						fin_obu.days_of_delay(ND_, add_months(trunc(sdate_ , 'MM'), -k) );

							if k<= 6 
							  then sTmp0:= greatest(sTmp0,FIN_OBU.G_KOL_DELY); 
							end if;

							if  add_months(trunc(sdate_ , 'MM'), -k) =  trunc(add_months(trunc(sdate_ , 'MM'), -k),'MM')
							  then sTmp1:= greatest(sTmp1,FIN_OBU.G_KOL_DELY); 
							end if;
						end loop;    

					 If  sTmp0>0 or sTmp1> 0
						 then fin_nbu.record_fp_nd('ZD1', 0, 55, DAT_);
						 else fin_nbu.record_fp_nd('ZD1', 1, 55, DAT_);
					 End if; 		 

		End if;
	  
  
  -- ����� � ���������� ����������� �� ���� ��������� ������ ��� ���������� �������� ������� �� � ������������ ����� �� �� 30 ����������� ��� 
      fin_obu.days_of_delay(ND_);
	  fin_nbu.record_fp_nd('KKDP', fin_obu.g_kol_dely, 56, DAT_);     
      if fin_obu.g_kol_dely > 30 then  fin_nbu.record_fp_nd('ZD2', 0, 55, DAT_);            
	                             else  fin_nbu.record_fp_nd('ZD2', 1, 55, DAT_);            
      end if;
  
 -- ����������� ������ � ��������
        Begin
          select sum(nvl(bv,0)),  sum(nvl(rez39,0))
		    into l_bv   ,  l_rez
            from nbu23_rez 
           where rnk = RNK_          and 
                 nd  = ND_           and
                 tip in ('SS', 'SP','SN','SPN','SNO','SL') and    --,'CR9'
                 fdat = add_months(DAT_,-1);
           exception when NO_DATA_FOUND then l_bv := 0; l_rez := 0;
		end; 
		
	If 	l_bv!= 0 then
          sTmp0 := 	(l_rez*100) / l_bv;
	else  sTmp0 := 	0;
    end if;	
	
	fin_nbu.record_fp_nd('SRKA', sTmp0, 52, DAT_);            
	
    if  sTmp0 > 50 	
			then  fin_nbu.record_fp_nd('PD1', 1, 53, DAT_); 
			else  fin_nbu.record_fp_nd('PD1', 0, 53, DAT_); 
	End if;
		
		
		------------------------------------------------------------------------------------
		--��������� ��� PD
		------------------------------------------------------------------------------------
	-- 2.1.	������� ��������� ������� ������������� ��������� 	 
 
     sTmp0 := zn_p('PIPB', 6, zDAT_, OKPO_) - zn_p('PIPB', 6, add_months(zDAT_,-l_period), OKPO_ );
	       trace('get_subpok ', ' l_period='|| l_period);
	       trace('get_subpok ', sTmp0||' PIPB='|| zn_p('PIPB', 6, zDAT_, OKPO_)||' PIPB-period= '||zn_p('PIPB', 6, add_months(zDAT_, -l_period), OKPO_));
	 case  when  sTmp0>0 then fin_nbu.record_fp_nd('IP1', 1, 50, DAT_);            
           when  sTmp0<0 then fin_nbu.record_fp_nd('IP1', 3, 50, DAT_);            
           when  sTmp0=0 then fin_nbu.record_fp_nd('IP1', 2, 50, DAT_);            
		   else               fin_nbu.record_fp_nd('IP1', 2, 50, DAT_);            
	 end case;

	 
	 --  2.3.	�������� �� ��������� ����� ����� ���������  ( � ���������� ������� ������������ ����)
	         -- ����� ������� �� ���������
		Begin
			IF FZ_ = 'N'      THEN
						   sTmp0 := fin_nbu.ZN_FDK('2000', zDAT_, okpo_)- fin_nbu.ZN_FDK('2010', zDAT_, okpo_)-
						            fin_nbu.ZN_FDK('2000',add_months(zDAT_,-12), okpo_)- fin_nbu.ZN_FDK('2010',add_months(zDAT_,-12), okpo_) ;
			ElsIF FZ_ in ('R','C')   THEN
						   sTmp0 := fin_nbu.ZN_FDK('2000', zDAT_, okpo_) -
						            fin_nbu.ZN_FDK('2000', add_months(zDAT_,-12), okpo_);
			ELSE
						   sTmp0 := 0;
			END IF;
		exception  when others  then
					    if sqlcode=-20000  then sTmp0 :=  0; -- ������ ���
						                   else raise;
					    end if;
		end;
	 
		 case  when  sTmp0>0 then fin_nbu.record_fp_nd('IP3', 1, 50, DAT_);            
               when  sTmp0<0 then fin_nbu.record_fp_nd('IP3', 3, 50, DAT_);            
               when  sTmp0=0 then fin_nbu.record_fp_nd('IP3', 2, 50, DAT_);            
		       else               fin_nbu.record_fp_nd('IP3', 2, 50, DAT_);            
	     end case; 
	 
	 --  2.4.	����� ����������� 
	    
		fin_nbu.record_fp_nd('IP4', ZN_P_ND('PKR', 31, DAT_), 50, DAT_);            
	    
	  if fin_obu.g_kol_dely between 30 and 90 
	                             then  fin_nbu.record_fp_nd('FP6', 1, 32, DAT_);
		                         else  fin_nbu.record_fp_nd('FP6', 0, 32, DAT_);
      end if; 	 
	 
	 
	  if fin_obu.g_kol_dely > 90 then  fin_nbu.record_fp_nd('FP7', 1, 32, DAT_);
		                         else  fin_nbu.record_fp_nd('FP7', 0, 32, DAT_);
      end if; 
	
	 
end get_subpok;						   


procedure get_restr  (RNK_  number,
                      ND_   number,
					  DAT_  date,
					  zDAT_ date)
Is
	sTmp    number := 0;
	sTmp1   number := 0;
 	l_dat  date;
begin
  return; -- ��������� ������� ����������
  
  aND_     := ND_ ;      -- �������� ��� ND
  aRNK_    := RNK_;      -- �������� ��� RNK
  aDAT_    := zDAT_;     -- ������� ���� �������
  
    -- ����������������
	   sTmp  := 0;
	   sTmp1 := null;
       l_dat := null;
	   
 	   -- ������� � ���� ����������������
	   select count(fdat)  kol, max(fdat) dat 
	     into             sTmp,         l_dat
         from CCK_RESTR_V 
        where nd    = ND_
		  and rnk   = RNK_
          and fdat <= DAT_;
	
	
	-- ���� �� ������� ���� �����������������
	begin
        select s
		  into sTmp1 
          from (
                   select a.*, ROW_NUMBER() OVER(ORDER BY fdat desc) num
                     from fin_nd_hist a
                    where kod   = 'CLSP' 
                      and rnk   = RNK_
                      and nd    =  ND_
					  and fdat <= l_dat
                ) where num = 1;
		exception when no_data_found then
               sTmp1 := null;   		
    end;    
	
	   -- �������� ��� ���������� �� ���� ����������������.
	   fin_obu.days_of_delay(ND_, l_dat);
	    --fin_obu.g_kol_dely
	
	fin_nbu.record_fp_nd('KRES', sTmp, 51, DAT_);
	fin_nbu.record_fp_nd_DATE('DRES', l_dat, 51, DAT_);
	fin_nbu.record_fp_nd('CRES', sTmp1, 51, DAT_);
	fin_nbu.record_fp_nd('PRES', fin_obu.g_kol_dely, 51, DAT_);
	
end;



-- ����������� ����� ������������ (��������� 351)				   
procedure adjustment_class (RNK_  number,
                            ND_   number,
					        DAT_  date,
					        zDAT_ date)
Is
    l_klass int := 0;
	okpo_  number;
	datea_ date;
	sdate_ date;
	l_cls int;
begin

	begin
		select okpo, datea
   		into okpo_, datea_
		from fin_customer
		where rnk = rnk_;
	exception when NO_DATA_FOUND THEN
					     raise_application_error(-(20000),'\ ' ||'     �� �������� �볺��� � RNK - '||rnk_,TRUE);
	END;

	begin
	   select sdate
   		 into sdate_
		 from cc_deal
		where nd = nd_;
	exception when NO_DATA_FOUND THEN
					    null; -- raise_application_error(-(20000),'\ ' ||'     �� �������� ����� � ND - '||nd_,TRUE);
	END;
	
  aOKPO_   := okpo_;      -- �������� ��� ����
  aND_     := ND_ ;      -- �������� ��� ND
  aRNK_    := RNK_;      -- �������� ��� RNK
  aDAT_    := zDAT_;     -- ������� ���� �������

  -- 3.3.���� ��������� ����������� ����� ������ ���� � ���� �������� ��������� 
  
   Case
      when ZN_P_ND('INV', 32, DAT_) = 2 then null;  -- ������������� ������
	  when ZN_P_ND('KSR', 52, DAT_) = 1 then null;  -- �볺�� ���������� ������ ������������
      when ZN_P_ND('NGRK', 51, DAT_) = 1 and ZN_P_ND('NKZV', 51, DAT_) = 1 then null;  -- �볺�� �������� �� ����� �� ������� ���������	                                               
	  when ZN_P_ND('NGRK', 51, DAT_) = 1 and ZN_P_ND('NKZV', 51, DAT_) = 0 then null;  -- �볺�� �������� �� ����� �� ������ ������� ���������� �����
	  when (sysdate-datea_) < 366  then l_klass := greatest(l_klass, 5); -- ���� �� ����� 5
      else null;
   end case;	  
	  
	  
  -- 3.4. ����������� �������, �������� ����������� �, �� ��������� ������� ����������� �, �� ��� ������������ ������������ �   
	case 
       when ZN_P_ND('SKK', 52, DAT_) = 1 then l_klass := greatest(l_klass, 8); -- �� ����� 8	
	   else null;
	end case;
	  
  -- 3.5. ����������� �� ��'���� �������� ������� �� ����� ���� �������� ����� ������� ���� �������. 	  
	case 
       when ZN_P_ND('KVZK', 52, DAT_) = 1 and  sysdate > to_date('01-01-2019','dd-mm-yyyy') then l_klass := greatest(l_klass, 8); -- �� ����� 8	
	   else null;
	end case;	
	  
  -- 3.6 ��������� ������ ���� ����������� ���������	  
	case 
       when ZN_P_ND('PVKZ', 52, DAT_) = 1 then l_klass := greatest(l_klass, 8); -- �� ����� 8	
	   else null;
	end case;		  
	  
	  
  -- 3.7 ������� ������������ � �������� �����, ����� ������������� ������������ ���������� ���������� ������� � �������� �����	  
  -- �������� �������� 23/01/2017
  /*   case
         when  CC_val( ND_ , RNK_, zDAT_,'351') = 1 and  ZN_P_ND('KP61', 5, DAT_) = 0 then  l_klass := greatest(l_klass, 9);
	     else null;
     end case;		 
  */	  
  -- 3.8 �������� ��������� �������������� ���ʻ �� ����������� �������������� ���� 10 ���� ��������� ���� � ���� �� ����� ��������� ��� ��������� ��������� ����� ��� �������� ��䳿 ������� ����������� �������� ���ʻ:	  
     -- ���� ������ ���������� ������� �� ��� �� �� �������� �� 10  
	 -- 180 ��������� ��� �������������� 
	 -- ���� ����� 180 ���  �� �������� �� 10 ������ �������� �� 10
	if   ZN_P_ND('ZD1', 55, DAT_) = 1 and ZN_P_ND('ZD2', 55, DAT_) = 1  and ZN_P_ND('ZD3', 55, DAT_)  = 1  
	    then  null;
		else
	  
			case 
				when  ZN_P_ND('RK1', 56, DAT_) = 1  then l_klass := greatest(l_klass, 10);
				else null;
			end case;		
	end if;
  
  
  -- 3.11. ���� �������� ��������� ����������� �������� ������� - ���ʻ, �� ����������� ����� �� ���������, �������� � ����� 3.9., �� ����������. ���� �������� ��������� ����������� �������� ������� - �Ͳ� - ���� 10.
    if   ZN_P_ND('ZD1', 55, DAT_) = 1 and ZN_P_ND('ZD2', 55, DAT_) = 1  and ZN_P_ND('ZD3', 55, DAT_)  = 1  
	    then  null;
		else
				case 
					when  ZN_P_ND('RK2', 56, DAT_) = 1  and ZN_P_ND('RK3', 56, DAT_) = 0 then l_klass := greatest(l_klass, 10);
					else null;
				end case;		
	end if;
	 
 
 -- 3.12. � ��� �������� � ����� ���������� ���� �������� ����� ����������� � ������ ���� ������������ �� ������ 10 � ���������� ���� ������ ����������� �� ��� �����.
    -- ���� ���������� �� ����� ������������� ��������� (����� ��� ����) 
	l_cls := ZN_P('CLAS', 6, zDAT_);
	fin_nbu.record_fp_nd('CLAS', l_cls, 56, DAT_);
	
	-- ���� ������������ �� ����� �� ������� ���������
	if ( ZN_P_ND('NGRK', 51, DAT_) = 1)
	    then  l_cls := ZN_P_ND('CLS1', 56, DAT_);
		else  fin_nbu.record_fp_nd('CLS1', null, 56, DAT_);
	end if;
	
	-- ���� ������������ �� ����� ��������� �����������
	if ( ZN_P_ND('NGRP', 51, DAT_) = 1)
	    then  l_cls := ZN_P_ND('CLS2', 56, DAT_);
		else fin_nbu.record_fp_nd('CLS2', null, 56, DAT_);
	end if;	
	
	 
    l_cls := least(greatest(nvl(l_cls,0),  l_klass),10);
   
    --�������� � ����� ���������� ���� �������� ����� ����������� � ������ ���� ������������ �� ������ 10 
	-- 23/01/2017 ��������� �����
	/*
    case 
	    when  ZN_P_ND('KIKK', 52, DAT_) = 1  then l_cls := LEAST(l_cls + 3, 10);
        else null;
    end case;	
    */
	
 --   �������� ������������ ����. CLS/56  
     fin_nbu.record_fp_nd('CLS', l_cls, 56, DAT_);
    
	
  -- ���������� ������� ��� ����������	
	fin_obu.days_of_delay(ND_, gl.bd);
  
  Case  
	when FIN_OBU.G_KOL_DELY  between 31 and 60 then  fin_nbu.record_fp_nd('CLSP', greatest(l_cls,  5 ), 56, DAT_);
	when FIN_OBU.G_KOL_DELY  between 61 and 90 then  fin_nbu.record_fp_nd('CLSP', greatest(l_cls,  8 ), 56, DAT_);
	when FIN_OBU.G_KOL_DELY  >  90             then  fin_nbu.record_fp_nd('CLSP', greatest(l_cls,  10), 56, DAT_);
	                                           else  fin_nbu.record_fp_nd('CLSP',                l_cls, 56, DAT_);
  end case;	     
	
	
	
	record_fp_ND_date('GLBD',gl.bd, 32, DAT_);
	
	

end adjustment_class; 						   



function  get_pd (  p_rnk   IN  number,
                    p_nd    IN  number,
					p_dat   IN  date,   
					p_clas  in  number,
					p_vncr  in  varchar2,
					p_idf   in  number
                   ) return number
as
l_vncr  cck_rating.ord%type;
l_repl  number;
l_k   fin_pd.k%type;
l_k2  fin_pd.k2%type;

l_idf number;
l_cls_max number;

l_Y    number :=0 ;
l_N    number :=0 ;
l_tmp  number :=0;
begin

  case 
    when p_idf = 50               then l_idf := 50;    l_cls_max:=10;  -- �������
	when p_idf between 60 and 65  then l_idf := 60;    l_cls_max:=5;   -- ��� ����� 
	when p_idf between 80 and 81  then l_idf := 80;    l_cls_max:=5;   -- ����� ����� 
	                              else l_idf := p_idf; l_cls_max:=5;   -- ����
  end case;

   begin
        Select ord
		  into l_vncr
		  from cck_rating
		 where code = p_vncr;
      exception when no_data_found then 
	    if p_vncr is null then  l_vncr := 33;
		 else raise_application_error(-(20001),'/' ||'     ������� �� �������� �������� ��������� ������� - '||p_vncr,TRUE);  	  
		End if;
   end;

    if nvl(p_clas,l_cls_max) not between 1 and l_cls_max then return null; end if;
	
   for x in (
                    select  kod, val, IDF, k, k2     
              from fin_pd UNPIVOT INCLUDE NULLS (VAL FOR KOD IN (ip1, ip2, ip3, ip4, ip5))
                where (idf,fin, vncrr) in (select idf, fin, max(vncrr)
                                             from fin_pd p 
                                            where idf = p_idf and
                                                  fin = nvl(p_clas,l_cls_max) and vncrr <= l_vncr
                                            group by idf, fin   
                                                       )
				and val is not null									   
             )
	loop
    l_k  := x.k;
    l_k2 := x.k2;   	
    
		begin

           select  s
		     into  l_repl
			 from fin_nd
			where rnk = p_rnk    and
			      nd  = p_nd     and
				  kod  = x.kod   and
				  idf  = l_idf;										  
		   exception when no_data_found then 
		      l_repl := 100;
		end;
		 
	    if l_repl <= x.val then  l_Y := l_Y+1;
		                   else  l_N := l_N+1;
        end if;						   
	
	end loop;

   Begin	 
	l_tmp := l_Y/(l_Y+l_N);
    exception when ZERO_DIVIDE          
         then raise_application_error(-(20000),'      '||'³����� ������� ��� idf='||p_idf,TRUE);
   End;		

	if l_tmp >= 0.5 then  return  l_k;
	                else  return  l_k2;
	end if;

end get_pd;


function f_kpz_nd(p_nd number, p_dat date) return number
as
 l_mod     varchar2(50) := 'FIN_NBU.PAWN >> ';
 t_row_ind pls_integer;
 t_pawn    number;
 p_s       number;
 l_kpz     cc_pawn23add.kpz_351%type;
 l_kl      cc_pawn23add.kl_351%type;
 l_zb      number :=0;
 l_kpzi    number :=0;
 l_rez     number;
 l_ost     number :=0;
 l_datb    date;
 
begin
  
	  select max(fdat)
		into l_datb
		from fdat 
	   where fdat < p_dat;
	   
    tp_pawns.acc.delete();
	tp_pawns := null;
	
	-- ������ �������� �����������
    t_pawn := tp_pawns.acc.count();
    for x in (SELECT distinct pp.acc, pp.pawn, nvl(sv,GL.P_ICURVAL(a.kv, abs(fost(a.acc, l_datb)), l_datb)) AS ostc               
                FROM pawn_acc pp, cc_accp cc, accounts a
               WHERE cc.acc = pp.acc AND pp.acc = a.acc 
                 and nd = p_nd)
    loop
	        Begin
	             select kl_351, kpz_351
                   into l_kl, l_kpz
                  from CC_PAWN23ADD
                  where pawn = x.pawn;
	         exception when no_data_found then null;
            end;		 
				  
		CONTINUE when l_kpz=0;		  
				  
	t_pawn:=t_pawn+1;
	tp_pawns.acc(t_pawn).acc  := x.acc;
	tp_pawns.acc(t_pawn).ostc := x.ostc;
	tp_pawns.acc(t_pawn).kof  := l_kpz;
	tp_pawns.acc(t_pawn).kl   := l_kl;
	tp_pawns.acc(t_pawn).pawn := x.pawn;
	
	
	         --������ ���������� �� �������� �������
		   t_row_ind :=tp_pawns.acc(t_pawn).nd.count();
		   for k in(SELECT cc.nd
					  FROM pawn_acc pp, cc_accp cc
					 WHERE cc.acc = pp.acc
					   and pp.acc = x.acc 
				     group by nd) 
			loop
				t_row_ind:= t_row_ind+1;
				tp_pawns.acc(t_pawn).nd(t_row_ind).nd   := k.nd;
				
				select sum( GL.P_ICURVAL(a.kv, -1* fost(a.acc,l_datb), l_datb)) ostc
				  into l_ost
				  from cc_deal c , nd_acc n, accounts a
				 where c.nd = n.nd and n.acc = a.acc
				   and c.nd = k.nd and tip in ('SNO','SN ','SL ','SLN','SPN','SS ','SP ','SK9','SK0');
				   
				  tp_pawns.acc(t_pawn).nd(t_row_ind).ostc := nvl(l_ost,0); 
				   
			end loop;
	end loop;


    G_coun := 0;	
	
  for f in 1 .. tp_pawns.acc.count()
  loop
	   --������� �������� 
	   G_coun := greatest(G_coun,  tp_pawns.acc(f).nd.count() );
       -- �������� ���� ����������������� �� �������� �������
	   p_s := 0;
	   for s in 1 .. tp_pawns.acc(f).nd.count()
	   loop
	   p_s := p_s + tp_pawns.acc(f).nd(s).ostc;
	   end loop;
	   
	   --���� ������� �� �������� ����������������   
	   for s in 1 .. tp_pawns.acc(f).nd.count()
	   loop
	      begin
	        tp_pawns.acc(f).nd(s).ost_pawn := round( tp_pawns.acc(f).ostc * (tp_pawns.acc(f).nd(s).ostc * 100/ p_s )/100);
		  exception when ZERO_DIVIDE 
		    then tp_pawns.acc(f).nd(s).ost_pawn := 0;
		  end;
	   end loop;
  end loop;
  
      
 for f in 1 .. tp_pawns.acc.count()
 loop
       trace(l_mod,'  > ������� acc='||tp_pawns.acc(f).acc||' ostc='||tp_pawns.acc(f).ostc||' kof='||tp_pawns.acc(f).kof );
	   for s in 1 .. tp_pawns.acc(f).nd.count()
	   loop
	     trace(l_mod,'   nd> ������ �������  nd='||tp_pawns.acc(f).nd(s).nd||' ostc='||tp_pawns.acc(f).nd(s).ostc||' ost_pawn='||tp_pawns.acc(f).nd(s).ost_pawn);
		if tp_pawns.acc(f).nd(s).nd = p_nd and tp_pawns.acc(f).kof != 0 then 
		   
		   case 
		       when tp_pawns.acc(f).pawn in (11,13,14,16,17,19,26)   then g_pawn := greatest(nvl(g_pawn,0),1);
		       when tp_pawns.acc(f).pawn in (12,18)                  then g_pawn := greatest(nvl(g_pawn,0),2);
		                                                             else g_pawn := greatest(nvl(g_pawn,0),3);
           end case;
		   
		   l_zb := tp_pawns.acc(f).nd(s).ostc;
		   l_kpzi:= l_kpzi + round( ( tp_pawns.acc(f).nd(s).ost_pawn * tp_pawns.acc(f).kl)/tp_pawns.acc(f).kof );
		 -- trace(l_mod,'   nd> ������ �������  nd='||tp_pawns.acc(f).nd(s).nd||' ostc='||tp_pawns.acc(f).nd(s).ostc||' ost_pawn='||tp_pawns.acc(f).nd(s).ost_pawn);
		end if;
	   end loop;
  end loop;
 
    g_pawn := nvl(g_pawn,3);
	
    trace(l_mod,'   nd= '||p_nd||'>  l_kpzi='||l_kpzi||' l_zb='||l_zb||' G_coun='||G_coun); 
	
    begin
      l_rez := round(l_kpzi/(l_zb),2);
	exception when ZERO_DIVIDE 
	  then  l_rez := null;
	end;
	
	return l_rez;
	
 
end;

-- �������������� ���������� ���������	 type 3					   
procedure get_subpok_fo (RNK_  number,
                         ND_   number,
					     DAT_  date)
as
l_kpz number;
begin
  aND_     := ND_ ;      -- �������� ��� ND
  aRNK_    := RNK_;      -- �������� ��� RNK
  aDAT_    := DAT_;     -- ������� ���� �������
l_kpz := f_kpz_nd(ND_,DAT_);
fin_nbu.record_fp_nd('KPZ', l_kpz, 60, DAT_);
--�������� ���������� �������� ����� �������������
  if  1.3 <= l_kpz                 then   fin_nbu.record_fp_nd('IP2', 1, 60, DAT_); 
  elsif 1 <= l_kpz and l_kpz < 1.3 then   fin_nbu.record_fp_nd('IP2', 2, 60, DAT_);
                                   else   fin_nbu.record_fp_nd('IP2', 3, 60, DAT_);
  end if;
 
  --ZKD 1 checked  ������ �������
 if g_coun > 1 then  fin_nbu.record_fp_nd('ZKD', 1, 60, DAT_);
               else  fin_nbu.record_fp_nd('ZKD', 0, 60, DAT_);
 end if;

 -- ��� �������
 fin_nbu.record_fp_nd('PAWN', g_pawn, 60, DAT_); 
 
 
 
end;

procedure calc_pd_fl(RNK_ number,
                     ND_  number,
                     DAT_ date,
					 CLS_ number,
					 VNCR_ varchar2)	
as
l_pd   number;
l_val  number;
L_PAWN number;
L_IDF  number;
begin
  aND_     := ND_ ;      -- �������� ��� ND
  aRNK_    := RNK_;      -- �������� ��� RNK
  aDAT_    := DAT_;      -- ������� ���� �������
  
  
  l_val := CC_val( ND_ , RNK_, DAT_,'351');
  l_pawn:= ZN_P_ND('PAWN', 60, DAT_);
  
  case 
      when  l_val = 0 and l_pawn = 1 then l_idf := 60;
	  when  l_val = 0 and l_pawn = 2 then l_idf := 61;
	  when  l_val = 0 and l_pawn = 3 then l_idf := 62;
      when  l_val = 1 and l_pawn = 1 then l_idf := 63;
	  when  l_val = 1 and l_pawn = 2 then l_idf := 64;
	  when  l_val = 1 and l_pawn = 3 then l_idf := 65;
	                                 else l_idf := 62;
  end case;
  

 -- ���������� ������� ��� ����������
	fin_obu.days_of_delay(ND_, gl.bd);
    fin_nbu.record_fp_nd('KKDP', nvl(FIN_OBU.G_KOL_DELY,0), 60, DAT_);
  Case
    when FIN_OBU.G_KOL_DELY  between 8  and 30 then  fin_nbu.record_fp_nd('CLSP', greatest(CLS_,  2 ), 60, DAT_);
	when FIN_OBU.G_KOL_DELY  between 31 and 60 then  fin_nbu.record_fp_nd('CLSP', greatest(CLS_,  3 ), 60, DAT_);
	when FIN_OBU.G_KOL_DELY  between 61 and 90 then  fin_nbu.record_fp_nd('CLSP', greatest(CLS_,  4 ), 60, DAT_);
	when FIN_OBU.G_KOL_DELY  >  90             then  fin_nbu.record_fp_nd('CLSP', greatest(CLS_,  5 ), 60, DAT_);
	                                           else  fin_nbu.record_fp_nd('CLSP',               CLS_ , 60, DAT_);
  end case;

  
  
    
  l_pd := get_pd (  p_rnk   => RNK_,
                    p_nd    => ND_,
					p_dat   => DAT_,   
					p_clas  => ZN_P_ND('CLSP', 60, DAT_),
					p_vncr  => VNCR_,
					p_idf   => l_idf);

fin_nbu.record_fp_nd('PD', l_pd, 60, DAT_);



end;					 


-- �������������� ���������� ���������						   
procedure get_subpok_bud (RNK_  number,
                          ND_   number,
					      DAT_  date)
Is
	okpo_  number;
	datea_ date;
	sdate_ date;
	sdatey_ date;
	sTmp    number := 0;
	sTmp0   number := 0;
	sTmp1   number := 0;
	sTmp2   number := 0;
	sTmp3   number := 0;
	
	l_bv  number;
	l_rez number;
	l_period int;
	l_okpo_rel number;
	l_NGRK   number := 0;
	l_fin_cust fin_cust%rowtype;
	l_kpz number;
begin

	begin
		select okpo, datea
   		into okpo_, datea_
		from fin_customer
		where rnk = rnk_;
	exception when NO_DATA_FOUND THEN
					     raise_application_error(-(20000),'\ ' ||'     �� �������� �볺��� � RNK - '||rnk_,TRUE);
	END;

	begin
	   select sdate
   		 into sdate_
		 from cc_deal
		where nd = nd_;
	exception when NO_DATA_FOUND THEN
					     null; --raise_application_error(-(20000),'\ ' ||'     �� �������� ����� � ND - '||nd_,TRUE);
	END;
	
  aOKPO_   := okpo_;    -- �������� ��� ����
  aND_     := ND_ ;     -- �������� ��� ND
  aRNK_    := RNK_;     -- �������� ��� RNK
  aDAT_    := DAT_;     -- ������� ���� �������
  
  --� ���� ������������� ����� 1-�� ���� (��� ������� ������������ �������� �� �������� �������������)', 1,'KR1', 72
   if add_months(sysdate,-12) < datea_  and 
      ZN_P_ND('INV', 71, DAT_) != 2    and
	  ZN_P_ND('KSR', 71, DAT_) != 1  
	  then  fin_nbu.record_fp_nd('KR1', 1, 72, DAT_);
      else  fin_nbu.record_fp_nd('KR1', 0, 72, DAT_); 
   end if;	  
  
  fin_obu.days_of_delay(ND_, gl.bd);
 
 
  fin_nbu.record_fp_nd('BO1', 0, 71, DAT_); 
  fin_nbu.record_fp_nd('KR2', 0, 72, DAT_); 
  fin_nbu.record_fp_nd('KR4', 0, 72, DAT_); 
 
  /*
  Case  
	when FIN_OBU.G_KOL_DELY  between  31 and 60   then   fin_nbu.record_fp_nd('KR2', 1, 72, DAT_);  --������������ ����� �� 31 �� 60 ��� (�������) � ���� ��������� ����������� �� ��������� (������������� �� ���������� �������� �� �����������)', 2,'KR2', 72, '', 1 );
	when FIN_OBU.G_KOL_DELY  between  61 and 90   then   fin_nbu.record_fp_nd('KR4', 1, 72, DAT_);  --������������ ����� �� 61 �� 90 ��� (�������) � ���� ��������� ����������� �� ��������� (������������� �� ���������� �������� �� �����������)', 4,'KR4', 72, '', 1 );
	when FIN_OBU.G_KOL_DELY  between  91 and 9999 then   fin_nbu.record_fp_nd('BO1', 1, 73, DAT_);  -- ������������ ����� ���� �� �� 90 ���, �.�. �� ���������� �������� �� ����������� (� ���� ��������� ����������� �� ���������)
    else null;
  End case;
   */
	 
	 
  
  l_kpz := f_kpz_nd(ND_,DAT_);
  fin_nbu.record_fp_nd('KPZ', l_kpz, 70, DAT_);
--�������� ���������� �������� ����� �������������
  if  1.3 <= l_kpz                 then   fin_nbu.record_fp_nd('IP2', 1, 70, DAT_); 
  elsif 1 <= l_kpz and l_kpz < 1.3 then   fin_nbu.record_fp_nd('IP2', 2, 70, DAT_);
                                   else   fin_nbu.record_fp_nd('IP2', 3, 70, DAT_);
  end if;
 
  --ZKD 1 checked  ������ �������
 if g_coun > 1 then  fin_nbu.record_fp_nd('ZKD', 1, 70, DAT_);
               else  fin_nbu.record_fp_nd('ZKD', 0, 70, DAT_);
 end if;
  
  
   -- ����������� ������ � ��������
        Begin
          select sum(bv),  sum(rez39)
		    into l_bv   ,  l_rez
            from nbu23_rez 
           where rnk = RNK_          and 
                 nd  = ND_           and
                 tip in ('SS', 'SP','SN','SPN','SNO','SL') and 
                 fdat = add_months(DAT_,-1);
           exception when NO_DATA_FOUND then l_bv := 0; l_rez := 0;
		end; 
		
	If 	l_bv!= 0 then
          sTmp0 := 	(l_rez*100) / l_bv;
	else  sTmp0 := 	0;
    end if;	
	
	if sTmp0>50 then fin_nbu.record_fp_nd('BO2', 1, 73, DAT_);  
	            else fin_nbu.record_fp_nd('BO2', 0, 73, DAT_);  
    end if;	
  
 
 --  ������ ����� ������������ � �����, �������, �� ����� ������, �������� ������', 1,'VD1', 54,
    sTmp0 := 0;
	if  fin_obu.g_kol_dely > 0
	    then sTmp0 := 1;
	end if;
	   
	if  (greatest(0, sTmp0) = 1 and
	    ZN_P_ND ('INV', 70, DAT_)  != 2 --and  ZN_P_ND ('TIP', 70, DAT_)  != 1 
		) 
	then fin_nbu.record_fp_nd('VD1', 1, 74, DAT_); 
	else fin_nbu.record_fp_nd('VD1', 0, 74, DAT_); 
	end if; 
  
  
   -- ��������� ��������� ������ ���� �� �� 30% �� ��������� ���� ��������
   
    If  ZN_P_ND('KRES', 71, DAT_) > 0 then
			Begin
				select  acrn.fprocn (a.acc, 0, ''), a.acc
				  into  sTmp0, sTmp2
				  from nd_acc n, accounts a
				 where n.acc = a.acc
				   and n.nd = ND_ 
				   and a.tip = 'LIM';
			 exception when NO_DATA_FOUND THEN null;
			END;	   
		  
			BEGIN
			  SELECT ir
				INTO sTmp1
				FROM int_ratn 
			   WHERE acc=sTmp2 AND id=0 AND
				     bdat = (SELECT MIN(bdat) 
					           FROM int_ratn
						      WHERE acc=sTmp2 AND id=0);
		   EXCEPTION WHEN NO_DATA_FOUND THEN null;
		   END;
  
        if    sTmp0 > 0  then       
		     sTmp3 := sTmp1*100/sTmp0; 
		else sTmp3 := 0;
		end if;
		
		if sTmp3 < 70 then fin_nbu.record_fp_nd('VD4', 1, 74, DAT_); 
		              else fin_nbu.record_fp_nd('VD4', 0, 74, DAT_);           
		end if;
  
    else fin_nbu.record_fp_nd('VD4', 0, 74, DAT_);           
    end if;
	
	--  ���������� ������� �������� ������  
		 If  ZN_P_ND('KRES', 71, DAT_) > 0 then
					   sTmp0 := 0;
					   sTmp1 := 0;
						for k in 1..12
						loop 
						fin_obu.days_of_delay(ND_, add_months(trunc(sdate_ , 'MM'), k) );

							if k<= 6 
							  then sTmp0:= greatest(sTmp0,FIN_OBU.G_KOL_DELY); 
							end if;

							if  add_months(trunc(sdate_ , 'MM'), k) =  trunc(add_months(trunc(sdate_ , 'MM'), k),'MM')
							  then sTmp1:= greatest(sTmp1,FIN_OBU.G_KOL_DELY); 
							end if;
						end loop;    

					 If  sTmp0>0 or sTmp1> 0
						 then fin_nbu.record_fp_nd('ZD1', 0, 75, DAT_);
						 else fin_nbu.record_fp_nd('ZD1', 1, 75, DAT_);
					 End if; 		 

		End if;
	  
  
  -- ����� � ���������� ����������� �� ���� ��������� ������ ��� ���������� �������� ������� �� � ������������ ����� �� �� 30 ����������� ��� 
      if fin_obu.g_kol_dely > 30 then  fin_nbu.record_fp_nd('ZD1', 0, 75, DAT_);            
	                             else  fin_nbu.record_fp_nd('ZD1', 1, 75, DAT_);            
      end if;
  
  
End get_subpok_bud;


-- ����������� ����� ������������ (��������� 351)				  BUD  
procedure adjustment_class_bud(RNK_  number,
                               ND_   number,
					           DAT_  date)
Is
    l_klass int := 0;
	okpo_  number;
	datea_ date;
	sdate_ date;
	l_cls int;
	l_cs int; l_cy int; l_cn int;
	l_pd number;
begin

	begin
		select okpo, datea
   		into okpo_, datea_
		from fin_customer
		where rnk = rnk_;
	exception when NO_DATA_FOUND THEN
					     raise_application_error(-(20000),'\ ' ||'     �� �������� �볺��� � RNK - '||rnk_,TRUE);
	END;

	begin
	   select sdate
   		 into sdate_
		 from cc_deal
		where nd = nd_;
	exception when NO_DATA_FOUND THEN
					    null; -- raise_application_error(-(20000),'\ ' ||'     �� �������� ����� � ND - '||nd_,TRUE);
	END;
	
  aOKPO_   := okpo_;      -- �������� ��� ����
  aND_     := ND_ ;      -- �������� ��� ND
  aRNK_    := RNK_;      -- �������� ��� RNK
  aDAT_    := DAT_;     -- ������� ���� �������

  -- 3.3.���� ��������� ����������� ����� ������ ���� � ���� �������� ��������� 
  
   Case
      when  ZN_P_ND('KR1', 72, DAT_) = 1  or ZN_P_ND('KR2', 72, DAT_) = 1 
      	  then l_klass := greatest(l_klass, 3); -- ���� �� ����� 5
      else null;
   end case;	  
	  
   if sysdate < to_date('01-01-2019','dd-mm-yyyy')
       then
	    Case
			  when  ZN_P_ND('KR3', 72, DAT_) = 1  or ZN_P_ND('KR4', 72, DAT_) = 1     
				  then l_klass := greatest(l_klass, 4); -- ���� �� ����� 5
			  else null;
		   end case;
       else
		   Case
			  when  ZN_P_ND('KR3', 72, DAT_) = 1  or ZN_P_ND('KR4', 72, DAT_) = 1  or ZN_P_ND('KR5', 72, DAT_) = 1    
				  then l_klass := greatest(l_klass, 4); -- ���� �� ����� 5
			  else null;
		   end case;	  
    end if;		
	  
	  
  -- 3.7 ������� ������������ � �������� �����, ����� ������������� ������������ ���������� ���������� ������� � �������� �����	  
/*  -- �������� 23/01/2017    
	case
         when  CC_val( ND_ , RNK_, DAT_,'351') = 1 and  ZN_P_ND('KR6', 72, DAT_) = 0 then  l_klass := greatest(l_klass, 4);
	     else null;
     end case;		 
*/	 
	 
	  
  -- 2.2 �������� ��������� �������������� ���ʻ �� ����������� �������������� ���� 10 ���� ��������� ���� � ���� �� ����� ��������� ��� ��������� ��������� ����� ��� �������� ��䳿 ������� ����������� �������� ���ʻ:	  
    case 
	    when  ZN_P_ND('RK1', 76, DAT_) = 1  then l_klass := greatest(l_klass, 5);
        else null;
    end case;		

  
  -- 2.3. ���� �������� ��������� ����������� �������� ������� - ���ʻ, �� ����������� ����� �� ���������, �������� � ����� 3.9., �� ����������. ���� �������� ��������� ����������� �������� ������� - �Ͳ� - ���� 10.
    case 
	    when  ZN_P_ND('RK2', 76, DAT_) = 1  and ZN_P_ND('RK3', 76, DAT_) = 0  then l_klass := greatest(l_klass, 5);
        else null;
    end case;		
	 
	 
  ---2.4  
   /* 
	select count(1) cs, count(case when s = 1 then s else null end) cy, count(case when s = 0 then s else null end) cn
	  into  l_cs, l_cy, l_cn
      from fin_nd
     where rnk = aRNK_
       and nd =  aND_
       and kod like  'ZD_'
       and idf = 75;

	     
	if l_cs = l_cy and  ZN_P_ND('RK1', 76, DAT_) = 1  and (ZN_P_ND('RK2', 76, DAT_) = 1 and ZN_P_ND('RK22', 76, DAT_) = 0)
	                        then  l_klass := nvl(ZN_P_ND('CLAS', 71, DAT_),0);
    elsif l_cs != l_cy and l_cs != l_cn and  ZN_P_ND('RK1', 76, DAT_) = 1  and (ZN_P_ND('RK2', 76, DAT_) = 1 and ZN_P_ND('RK22', 76, DAT_) = 1)
	                        then   l_klass := greatest(l_klass, 5);
    elsif l_cs = l_cn      then null;
	                       else null;
	end if;
  */
	 
 
 -- 3.12. � ��� �������� � ����� ���������� ���� �������� ����� ����������� � ������ ���� ������������ �� ������ 10 � ���������� ���� ������ ����������� �� ��� �����.
    l_cls := greatest(nvl(ZN_P_ND('CLAS', 71, DAT_),0),  l_klass);
    /*  �������� �� 23/01/2017
    case 
	    when  ZN_P_ND('RK4', 76, DAT_) = 1  then l_cls := LEAST((l_cls + 2), 5); 
        else null;
    end case;	
    */
 --   �������� ������������ ����. CLS/56  
     fin_nbu.record_fp_nd('CLS', l_cls, 56, DAT_);
     fin_nbu.record_fp_nd('CLS', l_cls, 70, DAT_); 
	 fin_nbu.record_fp_nd('CLS', l_cls, 76, DAT_);
    
	
  -- ���������� ������� ��� ����������	
	fin_obu.days_of_delay(ND_, gl.bd);
    fin_nbu.record_fp_nd('KKDP', FIN_OBU.G_KOL_DELY, 76, DAT_);
  Case  
    when FIN_OBU.G_KOL_DELY  between 8  and 30 then  fin_nbu.record_fp_nd('CLSP', greatest(l_cls,  2 ), 76, DAT_);
	when FIN_OBU.G_KOL_DELY  between 31 and 60 then  fin_nbu.record_fp_nd('CLSP', greatest(l_cls,  3 ), 76, DAT_);
	when FIN_OBU.G_KOL_DELY  between 61 and 90 then  fin_nbu.record_fp_nd('CLSP', greatest(l_cls,  4 ), 76, DAT_);
	when FIN_OBU.G_KOL_DELY  >  90             then  fin_nbu.record_fp_nd('CLSP', greatest(l_cls,  5 ), 76, DAT_);
	                                           else  fin_nbu.record_fp_nd('CLSP',               l_cls , 76, DAT_);
  end case;	     
 
 
 
    l_pd :=get_pd (  p_rnk   => aRNK_,
                     p_nd    => aND_,
		   			 p_dat   => aDAT_,   
					 p_clas  => l_cls,
					 p_vncr  => fin_zp.zn_vncrr(aRNK_, aND_),
					 p_idf   => 70
					);
  
  fin_nbu.record_fp_nd('PD', l_pd, 76, DAT_);
	

end adjustment_class_bud; 


/* **********************************************
*  ���������� ��������� ��� �볺���  ������������ �������
**************************************************/ 
procedure get_subpok_kons (RNK_  number,
                           ND_ number,
					       DAT_  date )
as
	sTmp    number := 0;
	sTmp0   number := 0;
	sTmp1   number := 0;
	sTmp2   number := 0;
	sTmp3   number := 0;
	x_ int;
begin

  aOKPO_   := RNK_*-1;   -- �������� ��� ����
  aND_     := ND_ ;      -- �������� ��� ND
  aRNK_    := RNK_;      -- �������� ��� RNK
  aDAT_    := DAT_;      -- ������� ���� �������
  
  
  fin_nbu.calculation_class(RNK_, DAT_);
  
  
   --���������� �� ��`���� �������� ������� �������� 3 ������� ����'
  
		 if  (
					   ZN_P(1495,1) < 0 and
					   ZN_P(1495,1, add_months(DAT_,-12)) < 0 and
					   ZN_P(1495,1, add_months(DAT_,-24)) < 0
					   ) or
					  (
					    LOGK_read (DAT_,aOKPO_,1,1) > 0 or
					    LOGK_read (add_months(DAT_,-12),aOKPO_,1,1) > 0 or
					    LOGK_read (add_months(DAT_,-24),aOKPO_,1,1) > 0
					   )
					then  fin_nbu.record_fp_nd('RG1', 1, 59, DAT_); -- ���
					else  fin_nbu.record_fp_nd('RG1', 0, 59, DAT_); -- No
		end if;
		
		
  
  
	 --����� �������� ������������� �� ����� ������� �� ���������
		begin
		            sTmp0 :=     ( ZN_F1('1510',4) + ZN_F1('1515',4) + ZN_F1('1600',4) + ZN_F1('1610',4) - ZN_F1('1165',4) )  /
					             ( ZN_F2('2000',4) + ZN_F2('2010',4) );
			exception when ZERO_DIVIDE then
                    sTmp0 :=  null;
		end;

		fin_nbu.record_fp_nd('KZDV', sTmp0, 59, DAT_);
		
		if  sTmp0 > 2.5   then  fin_nbu.record_fp_nd('RG2', 1, 59, DAT_);
		                  else  fin_nbu.record_fp_nd('RG2', 0, 59, DAT_);
        End if;
		
		
		
      --����� �������� ������������� �� �������� EBITDA
		begin
		            sTmp1 :=     ( ZN_F1('1510',4) + ZN_F1('1515',4) + ZN_F1('1600',4) + ZN_F1('1610',4) - ZN_F1('1165',4) )  /
					             ( ZN_F2('2190',4) - ZN_F2('2195',4) + ZN_F2('2515',4) );
			exception when ZERO_DIVIDE then   sTmp1 :=  null;
		end;
	    
        fin_nbu.record_fp_nd('KZDE', sTmp1, 59, DAT_);	
		
	if  DAT_ < to_date('03-01-2017','dd-mm-yyyy')
	    then x_ := 7;
	    else x_ := 5;
	end if;
	
        if  sTmp1 > x_ or  sTmp1 <=0 
                   		then  fin_nbu.record_fp_nd('RG3', 1, 59, DAT_);
		                else  fin_nbu.record_fp_nd('RG3', 0, 59, DAT_);
        End if;
		
		
		
		
		
end get_subpok_kons;




-- ����������� ����� �볺��� ������������ ������� (��������� 351)
procedure adjustment_class_kons (RNK_  number,
                                 ND_   number,
					             DAT_  date)
as
   l_klass int := 0;
   l_cls int;
begin

  aOKPO_   := RNK_*-1;   -- �������� ��� ����
  aND_     := ND_ ;      -- �������� ��� ND
  aRNK_    := RNK_;      -- �������� ��� RNK
  aDAT_    := DAT_;      -- ������� ���� �������

  l_cls := ZN_P('CLAS', 6, DAT_);
  
  
    -- ����������� �� ��'���� �������� ������� �� ����� ���� �������� ����� ������� ���� �������.
	/*
	case
       when ZN_P_ND('RG1', 59, DAT_) = 1 then l_klass := greatest(l_klass, 8); -- �� ����� 8
	   else null;
	end case;  
	*/

    -- ����� �������� ������������� �� ����� ������� �� ��������� >2.5
	case
       when ZN_P_ND('RG2', 59, DAT_) = 1 then l_klass := greatest(l_klass, 8); -- �� ����� 8
	   else null;
	end case; 
	
	    -- ����� �������� ������������� �� �������� EBITDA >5 or <=0
	case
       when ZN_P_ND('RG3', 59, DAT_) = 1 then l_klass := greatest(l_klass, 8); -- �� ����� 8
	   else null;
	end case; 
	
	    -- ³�������� ���������� �������
 /*	case
       when ZN_P_ND('RG4', 59, DAT_) = 1 then l_klass := greatest(l_klass, 9); -- �� ����� 9
	   else null;
	end case; 
 */ 
  
fin_nbu.record_fp_nd('CLS', greatest(l_cls,l_klass), 59, DAT_);



end;



--� ������� �������� ���� �� ������ ���� ���� ������� ������ ������ ���������� 180 ���
-- elimination_events(p_rnk, p_nd, p_fdat, '53,54', 55)
procedure  elimination_events (  p_rnk        fin_nd.rnk%type 
                                ,p_nd         fin_nd.nd%type 
								,p_fdat       date
								,p_idf_list   varchar2
								,p_idf        number
                               )
is
l_events      number := 0;
l_passed180   number := 6;
begin
 
   for k in (
         Select nd, rnk, idf, kod, sum(s) kol_m
		   from fin_nd_hist
		  where fdat between add_months(p_fdat,-12) and p_fdat 
			and  (nd, rnk, idf, kod) in (       
											select nd, rnk, idf, kod           
											 from fin_nd_hist h
											where h.idf in  ( select column_value from table(gettokens(p_idf_list)))
											  and nd   = p_nd
											  and rnk  = p_rnk
											  and fdat = p_fdat
											  and h.s= 1)  
		  Group by nd, rnk, idf, kod 
             )
    loop
	l_events    := 1;
	l_passed180 :=  least(l_passed180,k.kol_m);
    end loop;
	
  if  l_events = 0 
   then  fin_nbu.record_fp_nd('ZD5', 0, p_idf, p_fdat, p_nd, p_rnk);     -- ���� ���� �������
         fin_nbu.record_fp_nd('ZD4', null, p_idf, p_fdat, p_nd, p_rnk);
   else                     -- ����� ��䳿 �������   
         fin_nbu.record_fp_nd('ZD5', 1, p_idf, p_fdat, p_nd, p_rnk);
			if l_passed180 >= 6    
			 then   fin_nbu.record_fp_nd('ZD4', 1, p_idf, p_fdat, p_nd, p_rnk);   -- 6 ������ ����� �� ���� ������� � �����
			 else   fin_nbu.record_fp_nd('ZD4', 0, p_idf, p_fdat, p_nd, p_rnk);   -- ����� 180 ��� ���� �������
			end if;
  end if;

end;

	
	--*ֳ�� ������   (����������)

-- �������������� ���������� ���������						   
procedure get_subpok_bud_cp (RNK_  number,
                             ND_   number,
					         DAT_  date)
							 
Is
	okpo_  number;
	datea_ date;
	sdate_ date;
	sdatey_ date;
	sTmp    number := 0;
	sTmp0   number := 0;
	sTmp1   number := 0;
	sTmp2   number := 0;
	sTmp3   number := 0;
	
	l_bv  number;
	l_rez number;
	l_period int;
	l_okpo_rel number;
	l_NGRK   number := 0;
	l_fin_cust fin_cust%rowtype;
	l_kpz number;
begin

	begin
		select okpo, datea
   		into okpo_, datea_
		from fin_customer
		where rnk = rnk_;
	exception when NO_DATA_FOUND THEN
					     raise_application_error(-(20000),'\ ' ||'     �� �������� �볺��� � RNK - '||rnk_,TRUE);
	END;

	
  aOKPO_   := okpo_;    -- �������� ��� ����
  aND_     := ND_ ;     -- �������� ��� ND
  aRNK_    := RNK_;     -- �������� ��� RNK
  aDAT_    := DAT_;     -- ������� ���� �������
  
  --'KR1', 82
  case
      when datea_ between  add_months(sysdate,-12) and sysdate                   then fin_nbu.record_fp_nd('KR1', 0, 82, DAT_); 
      when datea_ between  add_months(sysdate,-24) and add_months(sysdate,-12)   then fin_nbu.record_fp_nd('KR1', 1, 82, DAT_);
	  when datea_ between  add_months(sysdate,-36) and add_months(sysdate,-24)   then fin_nbu.record_fp_nd('KR1', 2, 82, DAT_);
	                                                                             else fin_nbu.record_fp_nd('KR1', 3, 82, DAT_);
  end case; 
  
  
End get_subpok_bud_cp;


-- ����������� ����� ������������ (��������� 351)				  BUD  
procedure adjustment_class_bud_cp(RNK_  number,
                                  ND_   number,
					              DAT_  date)
Is
    l_klass int := 0;
	okpo_  number;
	datea_ date;
	sdate_ date;
	l_cls int;
	l_cs int; l_cy int; l_cn int;
	l_pd number;
begin

	begin
		select okpo, datea
   		into okpo_, datea_
		from fin_customer
		where rnk = rnk_;
	exception when NO_DATA_FOUND THEN
					     raise_application_error(-(20000),'\ ' ||'     �� �������� �볺��� � RNK - '||rnk_,TRUE);
	END;

	
  aOKPO_   := okpo_;      -- �������� ��� ����
  aND_     := ND_ ;      -- �������� ��� ND
  aRNK_    := RNK_;      -- �������� ��� RNK
  aDAT_    := DAT_;     -- ������� ���� �������

  -- 3.3.���� ��������� ����������� ����� ������ ���� � ���� �������� ��������� 
  
   Case
      when  ZN_P_ND('KR1', 82, DAT_) = 0  
      	  then l_klass := greatest(l_klass, 3); -- ���� �� ����� 5
      else null;
   end case;	  
	  
     
	  
  -- 2.2 �������� ��������� �������������� ���ʻ �� ����������� �������������� ���� 10 ���� ��������� ���� � ���� �� ����� ��������� ��� ��������� ��������� ����� ��� �������� ��䳿 ������� ����������� �������� ���ʻ:	  
    case 
	    when  ZN_P_ND('RK1', 86, DAT_) = 1  then l_klass := greatest(l_klass, 5);
        else null;
    end case;		

  
  -- 2.3. ���� �������� ��������� ����������� �������� ������� - ���ʻ, �� ����������� ����� �� ���������, �������� � ����� 3.9., �� ����������. ���� �������� ��������� ����������� �������� ������� - �Ͳ� - ���� 10.
    case 
	    when  ZN_P_ND('RK2', 86, DAT_) = 1  and ZN_P_ND('RK3', 86, DAT_) = 0  then l_klass := greatest(l_klass, 5);
        else null;
    end case;		
	  
 
 -- 3.12. � ��� �������� � ����� ���������� ���� �������� ����� ����������� � ������ ���� ������������ �� ������ 10 � ���������� ���� ������ ����������� �� ��� �����.
    l_cls := greatest(nvl(ZN_P_ND('CLAS', 81, DAT_),0),  l_klass);

-- �������� ��  ������ �������� ���������� ������
    for k in 
         (   Select r.repl_s
			  from fin_question q,
				   fin_question_reply r,
				   fin_nd n
			 Where q.idf  = n.idf    and q.idf  = r.idf  and n.idf  = 82
			   and q.kod  = n.kod    and q.kod  = r.kod  and n.s    = r.val
			   and n.rnk  = RNK_
			   and n.nd   = ND_
			   and n.fdat = DAT_
							   )   
	loop
	    l_cls := greatest( k.repl_s,  l_cls);
	end loop;
  
  

    
 --   �������� ������������ ����. CLS/56  
     fin_nbu.record_fp_nd('CLS', l_cls, 81, DAT_); 
    
	
  -- ���������� ������� ��� ����������
/*
select  accexpr into l_accexpr from cp_deal where ref = d.ref AND ACCEXPR IS NOT NULL;
         l_kol := f_days_past_due (p_dat01, l_accexpr,0);
*/  
        select max(f_days_past_due (DAT_, accexpr,0))
	      into FIN_OBU.G_KOL_DELY
		  from cp_deal d
		  join cp_kod  k on d.id = k.id
		  join accounts a on d.acc = a.acc
		  join customer c on a.rnk = c.rnk
		where d.dazs is null
		  and c.rnk = RNK_
		  and d.id  = case ND_ when -1 then d.id else ND_ end;


/*	fin_obu.days_of_delay(ND_, gl.bd);
    fin_nbu.record_fp_nd('KKDP', FIN_OBU.G_KOL_DELY, 76, DAT_);*/
  Case  
    when FIN_OBU.G_KOL_DELY  between 8  and 30 then  fin_nbu.record_fp_nd('CLSP', greatest(l_cls,  2 ), 86, DAT_);
	when FIN_OBU.G_KOL_DELY  between 31 and 60 then  fin_nbu.record_fp_nd('CLSP', greatest(l_cls,  3 ), 86, DAT_);
	when FIN_OBU.G_KOL_DELY  between 61 and 90 then  fin_nbu.record_fp_nd('CLSP', greatest(l_cls,  4 ), 86, DAT_);
	when FIN_OBU.G_KOL_DELY  >  90             then  fin_nbu.record_fp_nd('CLSP', greatest(l_cls,  5 ), 86, DAT_);
	                                           else  fin_nbu.record_fp_nd('CLSP',               l_cls , 86, DAT_);
  end case;	     
 
   fin_nbu.record_fp_nd('CLSP',               l_cls , 86, DAT_); 
 
 /*
    if      d.custtype = 1 and d.RZ =2   THEN l_idf := 80; l_tip := 1;
      elsif d.custtype = 1 and d.RZ =1   THEN l_idf := 80; l_tip := 1;
      elsif d.custtype = 2               THEN l_idf := 50; l_tip := 2;
      elsif d.custtype = 3 and d.kv<>980 THEN l_idf := 60; l_tip := 1;
      else                                    l_idf := 60; l_tip := 1;
      end if;
 */
 
 /*
    l_pd :=get_pd (  p_rnk   => aRNK_,
                     p_nd    => aND_,
		   			 p_dat   => aDAT_,   
					 p_clas  => l_cls,
					 p_vncr  => fin_zp.zn_vncrr(aRNK_, aND_),
					 p_idf   => 86
					);
  */
  fin_nbu.record_fp_nd('PD', l_pd, 86, DAT_);
	

end adjustment_class_bud_cp; 	
	
function get_vnkr_cp (RNK_  number,
                      ND_   number, 
					  DAT_  date   ,
					  p_idf   number ) return varchar2
as
l_vncrr    cck_rating.code%type; 
l_id_vnkr  cck_rating.ord%type;
begin
    l_id_vnkr :=  ZN_P_ND('VNKR', p_idf, DAT_, ND_, RNK_, null);
    case 
	when l_id_vnkr is not null then 
	     null; 
    when nd_ = -1 then

		  select max(V.ORD) 
			into l_id_vnkr 
			from cp_deal d
			join cp_kod  k on d.id = k.id
			join accounts a on d.acc = a.acc
			join customer c on a.rnk = c.rnk
			join cck_rating v on k.vncrr = V.CODE
		   where d.dazs is null
			 and c.rnk = RNK_; 

    else     
		  select max(V.ORD) 
			into l_id_vnkr 
			from cp_deal d
			join cp_kod  k on d.id = k.id
			join accounts a on d.acc = a.acc
			join customer c on a.rnk = c.rnk
			join cck_rating v on k.vncrr = V.CODE
		   where d.dazs is null
			 and c.rnk = RNK_
			 and d.id  = ND_;
    end case;
	
	 Begin 
		select code
		  into l_vncrr	
		  from cck_rating
		  where ord = l_id_vnkr;
		exception when no_data_found then 
		  null;
	 end;   
        
	return 	l_vncrr;

end;
	
procedure set_vnkr_cp (RNK_   number,
                       ND_    number, 
				 	   DAT_   date   ,
					   p_idf  number, 
					   p_vnkr varchar2)
as
l_id_vnkr  cck_rating.ord%type;
begin

	 Begin 
		select ord
		  into l_id_vnkr	
		  from cck_rating
		  where code = p_vnkr;
		exception when no_data_found then 
		  null;
	 end;

	record_fp_ND(KOD_   => 'VNKR', 
                 S_     => l_id_vnkr,  
                 IDF_   => p_idf,
				 DAT_   => DAT_,
				 ND_    => ND_,
                 RNK_   => RNK_
				 );
	 
	 --//************************************
	 --  ��������� � ��������

end;					   
	

/**
 * header_version - ���������� ������ ��������� ������ FIN_NBU
 */
function header_version return varchar2 is
begin
  return 'Package header FIN_NBU '||G_HEADER_VERSION;
end header_version;

/**
 * body_version - ���������� ������ ���� ������ FIN_NBU
 */
function body_version return varchar2 is
begin
  return 'Package body FIN_NBU '||G_BODY_VERSION;
end body_version;
--------------

Begin
       	 select val
		   into spPKdR_
		   from params
		  where PAR = 'FIN_NBU_RV';  -- ��� ���������� �� ������ �����
      exception when NO_DATA_FOUND THEN 
	        spPKdR_:= 3;

END fin_nbu;
/
 show err;
 
PROMPT *** Create  grants  FIN_NBU ***
grant EXECUTE                                                                on FIN_NBU         to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/fin_nbu.sql =========*** End *** ===
 PROMPT ===================================================================================== 
 