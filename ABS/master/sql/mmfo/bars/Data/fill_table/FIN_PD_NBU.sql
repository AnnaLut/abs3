
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Data/patch_data_FIN_PD_NBU.sql =========*** 
PROMPT ===================================================================================== 

declare
l_FIN_PD_NBU  FIN_PD_NBU%rowtype;

procedure p_merge(p_FIN_PD_NBU FIN_PD_NBU%rowtype) 
as
Begin
   insert into FIN_PD_NBU
      values p_FIN_PD_NBU; 
 exception when dup_val_on_index then  
   update FIN_PD_NBU
      set row = p_FIN_PD_NBU
    where IDF = p_FIN_PD_NBU.IDF
      and FIN = p_FIN_PD_NBU.FIN
      and VED = p_FIN_PD_NBU.VED
      and DATE_BEGIN = p_FIN_PD_NBU.DATE_BEGIN;
End;
Begin

delete from  FIN_PD_NBU;

l_FIN_PD_NBU.IDF :=50;
l_FIN_PD_NBU.FIN :=1;
l_FIN_PD_NBU.VED :=1;
l_FIN_PD_NBU.K_MIN :=.005;
l_FIN_PD_NBU.K_MAX :=.007;
l_FIN_PD_NBU.K_AVER :=.006;
l_FIN_PD_NBU.DATE_BEGIN :=to_date('20.06.2018','DD.MM.YYYY');
l_FIN_PD_NBU.DATE_CLOSE :=to_date('01.01.2099','DD.MM.YYYY');

 p_merge( l_FIN_PD_NBU);


l_FIN_PD_NBU.IDF :=50;
l_FIN_PD_NBU.FIN :=1;
l_FIN_PD_NBU.VED :=2;
l_FIN_PD_NBU.K_MIN :=.005;
l_FIN_PD_NBU.K_MAX :=.006;
l_FIN_PD_NBU.K_AVER :=.006;
l_FIN_PD_NBU.DATE_BEGIN :=to_date('20.06.2018','DD.MM.YYYY');
l_FIN_PD_NBU.DATE_CLOSE :=to_date('01.01.2099','DD.MM.YYYY');

 p_merge( l_FIN_PD_NBU);


l_FIN_PD_NBU.IDF :=50;
l_FIN_PD_NBU.FIN :=1;
l_FIN_PD_NBU.VED :=3;
l_FIN_PD_NBU.K_MIN :=.005;
l_FIN_PD_NBU.K_MAX :=.008;
l_FIN_PD_NBU.K_AVER :=.007;
l_FIN_PD_NBU.DATE_BEGIN :=to_date('20.06.2018','DD.MM.YYYY');
l_FIN_PD_NBU.DATE_CLOSE :=to_date('01.01.2099','DD.MM.YYYY');

 p_merge( l_FIN_PD_NBU);


l_FIN_PD_NBU.IDF :=50;
l_FIN_PD_NBU.FIN :=1;
l_FIN_PD_NBU.VED :=4;
l_FIN_PD_NBU.K_MIN :=.005;
l_FIN_PD_NBU.K_MAX :=.033;
l_FIN_PD_NBU.K_AVER :=.019;
l_FIN_PD_NBU.DATE_BEGIN :=to_date('20.06.2018','DD.MM.YYYY');
l_FIN_PD_NBU.DATE_CLOSE :=to_date('01.01.2099','DD.MM.YYYY');

 p_merge( l_FIN_PD_NBU);


l_FIN_PD_NBU.IDF :=50;
l_FIN_PD_NBU.FIN :=1;
l_FIN_PD_NBU.VED :=5;
l_FIN_PD_NBU.K_MIN :=.005;
l_FIN_PD_NBU.K_MAX :=.015;
l_FIN_PD_NBU.K_AVER :=.01;
l_FIN_PD_NBU.DATE_BEGIN :=to_date('20.06.2018','DD.MM.YYYY');
l_FIN_PD_NBU.DATE_CLOSE :=to_date('01.01.2099','DD.MM.YYYY');

 p_merge( l_FIN_PD_NBU);


l_FIN_PD_NBU.IDF :=50;
l_FIN_PD_NBU.FIN :=2;
l_FIN_PD_NBU.VED :=1;
l_FIN_PD_NBU.K_MIN :=.008;
l_FIN_PD_NBU.K_MAX :=.019;
l_FIN_PD_NBU.K_AVER :=.014;
l_FIN_PD_NBU.DATE_BEGIN :=to_date('20.06.2018','DD.MM.YYYY');
l_FIN_PD_NBU.DATE_CLOSE :=to_date('01.01.2099','DD.MM.YYYY');

 p_merge( l_FIN_PD_NBU);


l_FIN_PD_NBU.IDF :=50;
l_FIN_PD_NBU.FIN :=2;
l_FIN_PD_NBU.VED :=2;
l_FIN_PD_NBU.K_MIN :=.007;
l_FIN_PD_NBU.K_MAX :=.039;
l_FIN_PD_NBU.K_AVER :=.023;
l_FIN_PD_NBU.DATE_BEGIN :=to_date('20.06.2018','DD.MM.YYYY');
l_FIN_PD_NBU.DATE_CLOSE :=to_date('01.01.2099','DD.MM.YYYY');

 p_merge( l_FIN_PD_NBU);


l_FIN_PD_NBU.IDF :=50;
l_FIN_PD_NBU.FIN :=2;
l_FIN_PD_NBU.VED :=3;
l_FIN_PD_NBU.K_MIN :=.009;
l_FIN_PD_NBU.K_MAX :=.019;
l_FIN_PD_NBU.K_AVER :=.014;
l_FIN_PD_NBU.DATE_BEGIN :=to_date('20.06.2018','DD.MM.YYYY');
l_FIN_PD_NBU.DATE_CLOSE :=to_date('01.01.2099','DD.MM.YYYY');

 p_merge( l_FIN_PD_NBU);


l_FIN_PD_NBU.IDF :=50;
l_FIN_PD_NBU.FIN :=2;
l_FIN_PD_NBU.VED :=4;
l_FIN_PD_NBU.K_MIN :=.034;
l_FIN_PD_NBU.K_MAX :=.049;
l_FIN_PD_NBU.K_AVER :=.042;
l_FIN_PD_NBU.DATE_BEGIN :=to_date('20.06.2018','DD.MM.YYYY');
l_FIN_PD_NBU.DATE_CLOSE :=to_date('01.01.2099','DD.MM.YYYY');

 p_merge( l_FIN_PD_NBU);


l_FIN_PD_NBU.IDF :=50;
l_FIN_PD_NBU.FIN :=2;
l_FIN_PD_NBU.VED :=5;
l_FIN_PD_NBU.K_MIN :=.016;
l_FIN_PD_NBU.K_MAX :=.029;
l_FIN_PD_NBU.K_AVER :=.023;
l_FIN_PD_NBU.DATE_BEGIN :=to_date('20.06.2018','DD.MM.YYYY');
l_FIN_PD_NBU.DATE_CLOSE :=to_date('01.01.2099','DD.MM.YYYY');

 p_merge( l_FIN_PD_NBU);


l_FIN_PD_NBU.IDF :=50;
l_FIN_PD_NBU.FIN :=3;
l_FIN_PD_NBU.VED :=1;
l_FIN_PD_NBU.K_MIN :=.02;
l_FIN_PD_NBU.K_MAX :=.04;
l_FIN_PD_NBU.K_AVER :=.03;
l_FIN_PD_NBU.DATE_BEGIN :=to_date('20.06.2018','DD.MM.YYYY');
l_FIN_PD_NBU.DATE_CLOSE :=to_date('01.01.2099','DD.MM.YYYY');

 p_merge( l_FIN_PD_NBU);


l_FIN_PD_NBU.IDF :=50;
l_FIN_PD_NBU.FIN :=3;
l_FIN_PD_NBU.VED :=2;
l_FIN_PD_NBU.K_MIN :=.04;
l_FIN_PD_NBU.K_MAX :=.06;
l_FIN_PD_NBU.K_AVER :=.05;
l_FIN_PD_NBU.DATE_BEGIN :=to_date('20.06.2018','DD.MM.YYYY');
l_FIN_PD_NBU.DATE_CLOSE :=to_date('01.01.2099','DD.MM.YYYY');

 p_merge( l_FIN_PD_NBU);


l_FIN_PD_NBU.IDF :=50;
l_FIN_PD_NBU.FIN :=3;
l_FIN_PD_NBU.VED :=3;
l_FIN_PD_NBU.K_MIN :=.02;
l_FIN_PD_NBU.K_MAX :=.4;
l_FIN_PD_NBU.K_AVER :=.21;
l_FIN_PD_NBU.DATE_BEGIN :=to_date('20.06.2018','DD.MM.YYYY');
l_FIN_PD_NBU.DATE_CLOSE :=to_date('01.01.2099','DD.MM.YYYY');

 p_merge( l_FIN_PD_NBU);


l_FIN_PD_NBU.IDF :=50;
l_FIN_PD_NBU.FIN :=3;
l_FIN_PD_NBU.VED :=4;
l_FIN_PD_NBU.K_MIN :=.05;
l_FIN_PD_NBU.K_MAX :=.059;
l_FIN_PD_NBU.K_AVER :=.055;
l_FIN_PD_NBU.DATE_BEGIN :=to_date('20.06.2018','DD.MM.YYYY');
l_FIN_PD_NBU.DATE_CLOSE :=to_date('01.01.2099','DD.MM.YYYY');

 p_merge( l_FIN_PD_NBU);


l_FIN_PD_NBU.IDF :=50;
l_FIN_PD_NBU.FIN :=3;
l_FIN_PD_NBU.VED :=5;
l_FIN_PD_NBU.K_MIN :=.03;
l_FIN_PD_NBU.K_MAX :=.04;
l_FIN_PD_NBU.K_AVER :=.035;
l_FIN_PD_NBU.DATE_BEGIN :=to_date('20.06.2018','DD.MM.YYYY');
l_FIN_PD_NBU.DATE_CLOSE :=to_date('01.01.2099','DD.MM.YYYY');

 p_merge( l_FIN_PD_NBU);


l_FIN_PD_NBU.IDF :=50;
l_FIN_PD_NBU.FIN :=4;
l_FIN_PD_NBU.VED :=1;
l_FIN_PD_NBU.K_MIN :=.05;
l_FIN_PD_NBU.K_MAX :=.09;
l_FIN_PD_NBU.K_AVER :=.07;
l_FIN_PD_NBU.DATE_BEGIN :=to_date('20.06.2018','DD.MM.YYYY');
l_FIN_PD_NBU.DATE_CLOSE :=to_date('01.01.2099','DD.MM.YYYY');

 p_merge( l_FIN_PD_NBU);


l_FIN_PD_NBU.IDF :=50;
l_FIN_PD_NBU.FIN :=4;
l_FIN_PD_NBU.VED :=2;
l_FIN_PD_NBU.K_MIN :=.07;
l_FIN_PD_NBU.K_MAX :=.09;
l_FIN_PD_NBU.K_AVER :=.08;
l_FIN_PD_NBU.DATE_BEGIN :=to_date('20.06.2018','DD.MM.YYYY');
l_FIN_PD_NBU.DATE_CLOSE :=to_date('01.01.2099','DD.MM.YYYY');

 p_merge( l_FIN_PD_NBU);


l_FIN_PD_NBU.IDF :=50;
l_FIN_PD_NBU.FIN :=4;
l_FIN_PD_NBU.VED :=3;
l_FIN_PD_NBU.K_MIN :=.05;
l_FIN_PD_NBU.K_MAX :=.06;
l_FIN_PD_NBU.K_AVER :=.055;
l_FIN_PD_NBU.DATE_BEGIN :=to_date('20.06.2018','DD.MM.YYYY');
l_FIN_PD_NBU.DATE_CLOSE :=to_date('01.01.2099','DD.MM.YYYY');

 p_merge( l_FIN_PD_NBU);


l_FIN_PD_NBU.IDF :=50;
l_FIN_PD_NBU.FIN :=4;
l_FIN_PD_NBU.VED :=4;
l_FIN_PD_NBU.K_MIN :=.06;
l_FIN_PD_NBU.K_MAX :=.07;
l_FIN_PD_NBU.K_AVER :=.065;
l_FIN_PD_NBU.DATE_BEGIN :=to_date('20.06.2018','DD.MM.YYYY');
l_FIN_PD_NBU.DATE_CLOSE :=to_date('01.01.2099','DD.MM.YYYY');

 p_merge( l_FIN_PD_NBU);


l_FIN_PD_NBU.IDF :=50;
l_FIN_PD_NBU.FIN :=4;
l_FIN_PD_NBU.VED :=5;
l_FIN_PD_NBU.K_MIN :=.05;
l_FIN_PD_NBU.K_MAX :=.07;
l_FIN_PD_NBU.K_AVER :=.06;
l_FIN_PD_NBU.DATE_BEGIN :=to_date('20.06.2018','DD.MM.YYYY');
l_FIN_PD_NBU.DATE_CLOSE :=to_date('01.01.2099','DD.MM.YYYY');

 p_merge( l_FIN_PD_NBU);


l_FIN_PD_NBU.IDF :=50;
l_FIN_PD_NBU.FIN :=5;
l_FIN_PD_NBU.VED :=1;
l_FIN_PD_NBU.K_MIN :=.1;
l_FIN_PD_NBU.K_MAX :=.16;
l_FIN_PD_NBU.K_AVER :=.13;
l_FIN_PD_NBU.DATE_BEGIN :=to_date('20.06.2018','DD.MM.YYYY');
l_FIN_PD_NBU.DATE_CLOSE :=to_date('01.01.2099','DD.MM.YYYY');

 p_merge( l_FIN_PD_NBU);


l_FIN_PD_NBU.IDF :=50;
l_FIN_PD_NBU.FIN :=5;
l_FIN_PD_NBU.VED :=2;
l_FIN_PD_NBU.K_MIN :=.1;
l_FIN_PD_NBU.K_MAX :=.13;
l_FIN_PD_NBU.K_AVER :=.115;
l_FIN_PD_NBU.DATE_BEGIN :=to_date('20.06.2018','DD.MM.YYYY');
l_FIN_PD_NBU.DATE_CLOSE :=to_date('01.01.2099','DD.MM.YYYY');

 p_merge( l_FIN_PD_NBU);


l_FIN_PD_NBU.IDF :=50;
l_FIN_PD_NBU.FIN :=5;
l_FIN_PD_NBU.VED :=3;
l_FIN_PD_NBU.K_MIN :=.07;
l_FIN_PD_NBU.K_MAX :=.11;
l_FIN_PD_NBU.K_AVER :=.09;
l_FIN_PD_NBU.DATE_BEGIN :=to_date('20.06.2018','DD.MM.YYYY');
l_FIN_PD_NBU.DATE_CLOSE :=to_date('01.01.2099','DD.MM.YYYY');

 p_merge( l_FIN_PD_NBU);


l_FIN_PD_NBU.IDF :=50;
l_FIN_PD_NBU.FIN :=5;
l_FIN_PD_NBU.VED :=4;
l_FIN_PD_NBU.K_MIN :=.08;
l_FIN_PD_NBU.K_MAX :=.09;
l_FIN_PD_NBU.K_AVER :=.085;
l_FIN_PD_NBU.DATE_BEGIN :=to_date('20.06.2018','DD.MM.YYYY');
l_FIN_PD_NBU.DATE_CLOSE :=to_date('01.01.2099','DD.MM.YYYY');

 p_merge( l_FIN_PD_NBU);


l_FIN_PD_NBU.IDF :=50;
l_FIN_PD_NBU.FIN :=5;
l_FIN_PD_NBU.VED :=5;
l_FIN_PD_NBU.K_MIN :=.08;
l_FIN_PD_NBU.K_MAX :=.11;
l_FIN_PD_NBU.K_AVER :=.095;
l_FIN_PD_NBU.DATE_BEGIN :=to_date('20.06.2018','DD.MM.YYYY');
l_FIN_PD_NBU.DATE_CLOSE :=to_date('01.01.2099','DD.MM.YYYY');

 p_merge( l_FIN_PD_NBU);


l_FIN_PD_NBU.IDF :=50;
l_FIN_PD_NBU.FIN :=6;
l_FIN_PD_NBU.VED :=1;
l_FIN_PD_NBU.K_MIN :=.17;
l_FIN_PD_NBU.K_MAX :=.21;
l_FIN_PD_NBU.K_AVER :=.19;
l_FIN_PD_NBU.DATE_BEGIN :=to_date('20.06.2018','DD.MM.YYYY');
l_FIN_PD_NBU.DATE_CLOSE :=to_date('01.01.2099','DD.MM.YYYY');

 p_merge( l_FIN_PD_NBU);


l_FIN_PD_NBU.IDF :=50;
l_FIN_PD_NBU.FIN :=6;
l_FIN_PD_NBU.VED :=2;
l_FIN_PD_NBU.K_MIN :=.14;
l_FIN_PD_NBU.K_MAX :=.17;
l_FIN_PD_NBU.K_AVER :=.155;
l_FIN_PD_NBU.DATE_BEGIN :=to_date('20.06.2018','DD.MM.YYYY');
l_FIN_PD_NBU.DATE_CLOSE :=to_date('01.01.2099','DD.MM.YYYY');

 p_merge( l_FIN_PD_NBU);


l_FIN_PD_NBU.IDF :=50;
l_FIN_PD_NBU.FIN :=6;
l_FIN_PD_NBU.VED :=3;
l_FIN_PD_NBU.K_MIN :=.12;
l_FIN_PD_NBU.K_MAX :=.17;
l_FIN_PD_NBU.K_AVER :=.145;
l_FIN_PD_NBU.DATE_BEGIN :=to_date('20.06.2018','DD.MM.YYYY');
l_FIN_PD_NBU.DATE_CLOSE :=to_date('01.01.2099','DD.MM.YYYY');

 p_merge( l_FIN_PD_NBU);


l_FIN_PD_NBU.IDF :=50;
l_FIN_PD_NBU.FIN :=6;
l_FIN_PD_NBU.VED :=4;
l_FIN_PD_NBU.K_MIN :=.1;
l_FIN_PD_NBU.K_MAX :=.12;
l_FIN_PD_NBU.K_AVER :=.11;
l_FIN_PD_NBU.DATE_BEGIN :=to_date('20.06.2018','DD.MM.YYYY');
l_FIN_PD_NBU.DATE_CLOSE :=to_date('01.01.2099','DD.MM.YYYY');

 p_merge( l_FIN_PD_NBU);


l_FIN_PD_NBU.IDF :=50;
l_FIN_PD_NBU.FIN :=6;
l_FIN_PD_NBU.VED :=5;
l_FIN_PD_NBU.K_MIN :=.12;
l_FIN_PD_NBU.K_MAX :=.16;
l_FIN_PD_NBU.K_AVER :=.14;
l_FIN_PD_NBU.DATE_BEGIN :=to_date('20.06.2018','DD.MM.YYYY');
l_FIN_PD_NBU.DATE_CLOSE :=to_date('01.01.2099','DD.MM.YYYY');

 p_merge( l_FIN_PD_NBU);


l_FIN_PD_NBU.IDF :=50;
l_FIN_PD_NBU.FIN :=7;
l_FIN_PD_NBU.VED :=1;
l_FIN_PD_NBU.K_MIN :=.22;
l_FIN_PD_NBU.K_MAX :=.3;
l_FIN_PD_NBU.K_AVER :=.26;
l_FIN_PD_NBU.DATE_BEGIN :=to_date('20.06.2018','DD.MM.YYYY');
l_FIN_PD_NBU.DATE_CLOSE :=to_date('01.01.2099','DD.MM.YYYY');

 p_merge( l_FIN_PD_NBU);


l_FIN_PD_NBU.IDF :=50;
l_FIN_PD_NBU.FIN :=7;
l_FIN_PD_NBU.VED :=2;
l_FIN_PD_NBU.K_MIN :=.18;
l_FIN_PD_NBU.K_MAX :=.24;
l_FIN_PD_NBU.K_AVER :=.21;
l_FIN_PD_NBU.DATE_BEGIN :=to_date('20.06.2018','DD.MM.YYYY');
l_FIN_PD_NBU.DATE_CLOSE :=to_date('01.01.2099','DD.MM.YYYY');

 p_merge( l_FIN_PD_NBU);


l_FIN_PD_NBU.IDF :=50;
l_FIN_PD_NBU.FIN :=7;
l_FIN_PD_NBU.VED :=3;
l_FIN_PD_NBU.K_MIN :=.18;
l_FIN_PD_NBU.K_MAX :=.24;
l_FIN_PD_NBU.K_AVER :=.21;
l_FIN_PD_NBU.DATE_BEGIN :=to_date('20.06.2018','DD.MM.YYYY');
l_FIN_PD_NBU.DATE_CLOSE :=to_date('01.01.2099','DD.MM.YYYY');

 p_merge( l_FIN_PD_NBU);


l_FIN_PD_NBU.IDF :=50;
l_FIN_PD_NBU.FIN :=7;
l_FIN_PD_NBU.VED :=4;
l_FIN_PD_NBU.K_MIN :=.13;
l_FIN_PD_NBU.K_MAX :=.16;
l_FIN_PD_NBU.K_AVER :=.145;
l_FIN_PD_NBU.DATE_BEGIN :=to_date('20.06.2018','DD.MM.YYYY');
l_FIN_PD_NBU.DATE_CLOSE :=to_date('01.01.2099','DD.MM.YYYY');

 p_merge( l_FIN_PD_NBU);


l_FIN_PD_NBU.IDF :=50;
l_FIN_PD_NBU.FIN :=7;
l_FIN_PD_NBU.VED :=5;
l_FIN_PD_NBU.K_MIN :=.17;
l_FIN_PD_NBU.K_MAX :=.23;
l_FIN_PD_NBU.K_AVER :=.2;
l_FIN_PD_NBU.DATE_BEGIN :=to_date('20.06.2018','DD.MM.YYYY');
l_FIN_PD_NBU.DATE_CLOSE :=to_date('01.01.2099','DD.MM.YYYY');

 p_merge( l_FIN_PD_NBU);


l_FIN_PD_NBU.IDF :=50;
l_FIN_PD_NBU.FIN :=8;
l_FIN_PD_NBU.VED :=1;
l_FIN_PD_NBU.K_MIN :=.31;
l_FIN_PD_NBU.K_MAX :=.37;
l_FIN_PD_NBU.K_AVER :=.34;
l_FIN_PD_NBU.DATE_BEGIN :=to_date('20.06.2018','DD.MM.YYYY');
l_FIN_PD_NBU.DATE_CLOSE :=to_date('01.01.2099','DD.MM.YYYY');

 p_merge( l_FIN_PD_NBU);


l_FIN_PD_NBU.IDF :=50;
l_FIN_PD_NBU.FIN :=8;
l_FIN_PD_NBU.VED :=2;
l_FIN_PD_NBU.K_MIN :=.25;
l_FIN_PD_NBU.K_MAX :=.34;
l_FIN_PD_NBU.K_AVER :=.295;
l_FIN_PD_NBU.DATE_BEGIN :=to_date('20.06.2018','DD.MM.YYYY');
l_FIN_PD_NBU.DATE_CLOSE :=to_date('01.01.2099','DD.MM.YYYY');

 p_merge( l_FIN_PD_NBU);


l_FIN_PD_NBU.IDF :=50;
l_FIN_PD_NBU.FIN :=8;
l_FIN_PD_NBU.VED :=3;
l_FIN_PD_NBU.K_MIN :=.25;
l_FIN_PD_NBU.K_MAX :=.34;
l_FIN_PD_NBU.K_AVER :=.295;
l_FIN_PD_NBU.DATE_BEGIN :=to_date('20.06.2018','DD.MM.YYYY');
l_FIN_PD_NBU.DATE_CLOSE :=to_date('01.01.2099','DD.MM.YYYY');

 p_merge( l_FIN_PD_NBU);


l_FIN_PD_NBU.IDF :=50;
l_FIN_PD_NBU.FIN :=8;
l_FIN_PD_NBU.VED :=4;
l_FIN_PD_NBU.K_MIN :=.17;
l_FIN_PD_NBU.K_MAX :=.23;
l_FIN_PD_NBU.K_AVER :=.2;
l_FIN_PD_NBU.DATE_BEGIN :=to_date('20.06.2018','DD.MM.YYYY');
l_FIN_PD_NBU.DATE_CLOSE :=to_date('01.01.2099','DD.MM.YYYY');

 p_merge( l_FIN_PD_NBU);


l_FIN_PD_NBU.IDF :=50;
l_FIN_PD_NBU.FIN :=8;
l_FIN_PD_NBU.VED :=5;
l_FIN_PD_NBU.K_MIN :=.24;
l_FIN_PD_NBU.K_MAX :=.33;
l_FIN_PD_NBU.K_AVER :=.285;
l_FIN_PD_NBU.DATE_BEGIN :=to_date('20.06.2018','DD.MM.YYYY');
l_FIN_PD_NBU.DATE_CLOSE :=to_date('01.01.2099','DD.MM.YYYY');

 p_merge( l_FIN_PD_NBU);


l_FIN_PD_NBU.IDF :=50;
l_FIN_PD_NBU.FIN :=9;
l_FIN_PD_NBU.VED :=1;
l_FIN_PD_NBU.K_MIN :=.38;
l_FIN_PD_NBU.K_MAX :=.99;
l_FIN_PD_NBU.K_AVER :=.685;
l_FIN_PD_NBU.DATE_BEGIN :=to_date('20.06.2018','DD.MM.YYYY');
l_FIN_PD_NBU.DATE_CLOSE :=to_date('01.01.2099','DD.MM.YYYY');

 p_merge( l_FIN_PD_NBU);


l_FIN_PD_NBU.IDF :=50;
l_FIN_PD_NBU.FIN :=9;
l_FIN_PD_NBU.VED :=2;
l_FIN_PD_NBU.K_MIN :=.35;
l_FIN_PD_NBU.K_MAX :=.99;
l_FIN_PD_NBU.K_AVER :=.67;
l_FIN_PD_NBU.DATE_BEGIN :=to_date('20.06.2018','DD.MM.YYYY');
l_FIN_PD_NBU.DATE_CLOSE :=to_date('01.01.2099','DD.MM.YYYY');

 p_merge( l_FIN_PD_NBU);


l_FIN_PD_NBU.IDF :=50;
l_FIN_PD_NBU.FIN :=9;
l_FIN_PD_NBU.VED :=3;
l_FIN_PD_NBU.K_MIN :=.35;
l_FIN_PD_NBU.K_MAX :=.99;
l_FIN_PD_NBU.K_AVER :=.67;
l_FIN_PD_NBU.DATE_BEGIN :=to_date('20.06.2018','DD.MM.YYYY');
l_FIN_PD_NBU.DATE_CLOSE :=to_date('01.01.2099','DD.MM.YYYY');

 p_merge( l_FIN_PD_NBU);


l_FIN_PD_NBU.IDF :=50;
l_FIN_PD_NBU.FIN :=9;
l_FIN_PD_NBU.VED :=4;
l_FIN_PD_NBU.K_MIN :=.24;
l_FIN_PD_NBU.K_MAX :=.99;
l_FIN_PD_NBU.K_AVER :=.615;
l_FIN_PD_NBU.DATE_BEGIN :=to_date('20.06.2018','DD.MM.YYYY');
l_FIN_PD_NBU.DATE_CLOSE :=to_date('01.01.2099','DD.MM.YYYY');

 p_merge( l_FIN_PD_NBU);


l_FIN_PD_NBU.IDF :=50;
l_FIN_PD_NBU.FIN :=9;
l_FIN_PD_NBU.VED :=5;
l_FIN_PD_NBU.K_MIN :=.34;
l_FIN_PD_NBU.K_MAX :=.99;
l_FIN_PD_NBU.K_AVER :=.665;
l_FIN_PD_NBU.DATE_BEGIN :=to_date('20.06.2018','DD.MM.YYYY');
l_FIN_PD_NBU.DATE_CLOSE :=to_date('01.01.2099','DD.MM.YYYY');

 p_merge( l_FIN_PD_NBU);


l_FIN_PD_NBU.IDF :=50;
l_FIN_PD_NBU.FIN :=10;
l_FIN_PD_NBU.VED :=1;
l_FIN_PD_NBU.K_MIN :=1;
l_FIN_PD_NBU.K_MAX :=1;
l_FIN_PD_NBU.K_AVER :=1;
l_FIN_PD_NBU.DATE_BEGIN :=to_date('20.06.2018','DD.MM.YYYY');
l_FIN_PD_NBU.DATE_CLOSE :=to_date('01.01.2099','DD.MM.YYYY');

 p_merge( l_FIN_PD_NBU);


l_FIN_PD_NBU.IDF :=50;
l_FIN_PD_NBU.FIN :=10;
l_FIN_PD_NBU.VED :=2;
l_FIN_PD_NBU.K_MIN :=1;
l_FIN_PD_NBU.K_MAX :=1;
l_FIN_PD_NBU.K_AVER :=1;
l_FIN_PD_NBU.DATE_BEGIN :=to_date('20.06.2018','DD.MM.YYYY');
l_FIN_PD_NBU.DATE_CLOSE :=to_date('01.01.2099','DD.MM.YYYY');

 p_merge( l_FIN_PD_NBU);


l_FIN_PD_NBU.IDF :=50;
l_FIN_PD_NBU.FIN :=10;
l_FIN_PD_NBU.VED :=3;
l_FIN_PD_NBU.K_MIN :=1;
l_FIN_PD_NBU.K_MAX :=1;
l_FIN_PD_NBU.K_AVER :=1;
l_FIN_PD_NBU.DATE_BEGIN :=to_date('20.06.2018','DD.MM.YYYY');
l_FIN_PD_NBU.DATE_CLOSE :=to_date('01.01.2099','DD.MM.YYYY');

 p_merge( l_FIN_PD_NBU);


l_FIN_PD_NBU.IDF :=50;
l_FIN_PD_NBU.FIN :=10;
l_FIN_PD_NBU.VED :=4;
l_FIN_PD_NBU.K_MIN :=1;
l_FIN_PD_NBU.K_MAX :=1;
l_FIN_PD_NBU.K_AVER :=1;
l_FIN_PD_NBU.DATE_BEGIN :=to_date('20.06.2018','DD.MM.YYYY');
l_FIN_PD_NBU.DATE_CLOSE :=to_date('01.01.2099','DD.MM.YYYY');

 p_merge( l_FIN_PD_NBU);


l_FIN_PD_NBU.IDF :=50;
l_FIN_PD_NBU.FIN :=10;
l_FIN_PD_NBU.VED :=5;
l_FIN_PD_NBU.K_MIN :=1;
l_FIN_PD_NBU.K_MAX :=1;
l_FIN_PD_NBU.K_AVER :=1;
l_FIN_PD_NBU.DATE_BEGIN :=to_date('20.06.2018','DD.MM.YYYY');
l_FIN_PD_NBU.DATE_CLOSE :=to_date('01.01.2099','DD.MM.YYYY');

 p_merge( l_FIN_PD_NBU);


l_FIN_PD_NBU.IDF :=60;
l_FIN_PD_NBU.FIN :=1;
l_FIN_PD_NBU.VED :=0;
l_FIN_PD_NBU.K_MIN :=.005;
l_FIN_PD_NBU.K_MAX :=.14;
l_FIN_PD_NBU.K_AVER :=.073;
l_FIN_PD_NBU.DATE_BEGIN :=to_date('20.06.2018','DD.MM.YYYY');
l_FIN_PD_NBU.DATE_CLOSE :=to_date('01.01.2099','DD.MM.YYYY');

 p_merge( l_FIN_PD_NBU);


l_FIN_PD_NBU.IDF :=60;
l_FIN_PD_NBU.FIN :=2;
l_FIN_PD_NBU.VED :=0;
l_FIN_PD_NBU.K_MIN :=.15;
l_FIN_PD_NBU.K_MAX :=.36;
l_FIN_PD_NBU.K_AVER :=.255;
l_FIN_PD_NBU.DATE_BEGIN :=to_date('20.06.2018','DD.MM.YYYY');
l_FIN_PD_NBU.DATE_CLOSE :=to_date('01.01.2099','DD.MM.YYYY');

 p_merge( l_FIN_PD_NBU);


l_FIN_PD_NBU.IDF :=60;
l_FIN_PD_NBU.FIN :=3;
l_FIN_PD_NBU.VED :=0;
l_FIN_PD_NBU.K_MIN :=.37;
l_FIN_PD_NBU.K_MAX :=.64;
l_FIN_PD_NBU.K_AVER :=.505;
l_FIN_PD_NBU.DATE_BEGIN :=to_date('20.06.2018','DD.MM.YYYY');
l_FIN_PD_NBU.DATE_CLOSE :=to_date('01.01.2099','DD.MM.YYYY');

 p_merge( l_FIN_PD_NBU);


l_FIN_PD_NBU.IDF :=60;
l_FIN_PD_NBU.FIN :=4;
l_FIN_PD_NBU.VED :=0;
l_FIN_PD_NBU.K_MIN :=.65;
l_FIN_PD_NBU.K_MAX :=.99;
l_FIN_PD_NBU.K_AVER :=.82;
l_FIN_PD_NBU.DATE_BEGIN :=to_date('20.06.2018','DD.MM.YYYY');
l_FIN_PD_NBU.DATE_CLOSE :=to_date('01.01.2099','DD.MM.YYYY');

 p_merge( l_FIN_PD_NBU);


l_FIN_PD_NBU.IDF :=60;
l_FIN_PD_NBU.FIN :=5;
l_FIN_PD_NBU.VED :=0;
l_FIN_PD_NBU.K_MIN :=1;
l_FIN_PD_NBU.K_MAX :=1;
l_FIN_PD_NBU.K_AVER :=1;
l_FIN_PD_NBU.DATE_BEGIN :=to_date('20.06.2018','DD.MM.YYYY');
l_FIN_PD_NBU.DATE_CLOSE :=to_date('01.01.2099','DD.MM.YYYY');

 p_merge( l_FIN_PD_NBU);


l_FIN_PD_NBU.IDF :=61;
l_FIN_PD_NBU.FIN :=1;
l_FIN_PD_NBU.VED :=0;
l_FIN_PD_NBU.K_MIN :=.005;
l_FIN_PD_NBU.K_MAX :=.12;
l_FIN_PD_NBU.K_AVER :=.063;
l_FIN_PD_NBU.DATE_BEGIN :=to_date('20.06.2018','DD.MM.YYYY');
l_FIN_PD_NBU.DATE_CLOSE :=to_date('01.01.2099','DD.MM.YYYY');

 p_merge( l_FIN_PD_NBU);


l_FIN_PD_NBU.IDF :=61;
l_FIN_PD_NBU.FIN :=2;
l_FIN_PD_NBU.VED :=0;
l_FIN_PD_NBU.K_MIN :=.13;
l_FIN_PD_NBU.K_MAX :=.32;
l_FIN_PD_NBU.K_AVER :=.225;
l_FIN_PD_NBU.DATE_BEGIN :=to_date('20.06.2018','DD.MM.YYYY');
l_FIN_PD_NBU.DATE_CLOSE :=to_date('01.01.2099','DD.MM.YYYY');

 p_merge( l_FIN_PD_NBU);


l_FIN_PD_NBU.IDF :=61;
l_FIN_PD_NBU.FIN :=3;
l_FIN_PD_NBU.VED :=0;
l_FIN_PD_NBU.K_MIN :=.33;
l_FIN_PD_NBU.K_MAX :=.62;
l_FIN_PD_NBU.K_AVER :=.475;
l_FIN_PD_NBU.DATE_BEGIN :=to_date('20.06.2018','DD.MM.YYYY');
l_FIN_PD_NBU.DATE_CLOSE :=to_date('01.01.2099','DD.MM.YYYY');

 p_merge( l_FIN_PD_NBU);


l_FIN_PD_NBU.IDF :=61;
l_FIN_PD_NBU.FIN :=4;
l_FIN_PD_NBU.VED :=0;
l_FIN_PD_NBU.K_MIN :=.63;
l_FIN_PD_NBU.K_MAX :=.99;
l_FIN_PD_NBU.K_AVER :=.81;
l_FIN_PD_NBU.DATE_BEGIN :=to_date('20.06.2018','DD.MM.YYYY');
l_FIN_PD_NBU.DATE_CLOSE :=to_date('01.01.2099','DD.MM.YYYY');

 p_merge( l_FIN_PD_NBU);


l_FIN_PD_NBU.IDF :=61;
l_FIN_PD_NBU.FIN :=5;
l_FIN_PD_NBU.VED :=0;
l_FIN_PD_NBU.K_MIN :=1;
l_FIN_PD_NBU.K_MAX :=1;
l_FIN_PD_NBU.K_AVER :=1;
l_FIN_PD_NBU.DATE_BEGIN :=to_date('20.06.2018','DD.MM.YYYY');
l_FIN_PD_NBU.DATE_CLOSE :=to_date('01.01.2099','DD.MM.YYYY');

 p_merge( l_FIN_PD_NBU);


l_FIN_PD_NBU.IDF :=62;
l_FIN_PD_NBU.FIN :=1;
l_FIN_PD_NBU.VED :=0;
l_FIN_PD_NBU.K_MIN :=.005;
l_FIN_PD_NBU.K_MAX :=.15;
l_FIN_PD_NBU.K_AVER :=.078;
l_FIN_PD_NBU.DATE_BEGIN :=to_date('20.06.2018','DD.MM.YYYY');
l_FIN_PD_NBU.DATE_CLOSE :=to_date('01.01.2099','DD.MM.YYYY');

 p_merge( l_FIN_PD_NBU);


l_FIN_PD_NBU.IDF :=62;
l_FIN_PD_NBU.FIN :=2;
l_FIN_PD_NBU.VED :=0;
l_FIN_PD_NBU.K_MIN :=.15;
l_FIN_PD_NBU.K_MAX :=.4;
l_FIN_PD_NBU.K_AVER :=.275;
l_FIN_PD_NBU.DATE_BEGIN :=to_date('20.06.2018','DD.MM.YYYY');
l_FIN_PD_NBU.DATE_CLOSE :=to_date('01.01.2099','DD.MM.YYYY');

 p_merge( l_FIN_PD_NBU);


l_FIN_PD_NBU.IDF :=62;
l_FIN_PD_NBU.FIN :=3;
l_FIN_PD_NBU.VED :=0;
l_FIN_PD_NBU.K_MIN :=.41;
l_FIN_PD_NBU.K_MAX :=.76;
l_FIN_PD_NBU.K_AVER :=.585;
l_FIN_PD_NBU.DATE_BEGIN :=to_date('20.06.2018','DD.MM.YYYY');
l_FIN_PD_NBU.DATE_CLOSE :=to_date('01.01.2099','DD.MM.YYYY');

 p_merge( l_FIN_PD_NBU);


l_FIN_PD_NBU.IDF :=62;
l_FIN_PD_NBU.FIN :=4;
l_FIN_PD_NBU.VED :=0;
l_FIN_PD_NBU.K_MIN :=.77;
l_FIN_PD_NBU.K_MAX :=.99;
l_FIN_PD_NBU.K_AVER :=.88;
l_FIN_PD_NBU.DATE_BEGIN :=to_date('20.06.2018','DD.MM.YYYY');
l_FIN_PD_NBU.DATE_CLOSE :=to_date('01.01.2099','DD.MM.YYYY');

 p_merge( l_FIN_PD_NBU);


l_FIN_PD_NBU.IDF :=62;
l_FIN_PD_NBU.FIN :=5;
l_FIN_PD_NBU.VED :=0;
l_FIN_PD_NBU.K_MIN :=1;
l_FIN_PD_NBU.K_MAX :=1;
l_FIN_PD_NBU.K_AVER :=1;
l_FIN_PD_NBU.DATE_BEGIN :=to_date('20.06.2018','DD.MM.YYYY');
l_FIN_PD_NBU.DATE_CLOSE :=to_date('01.01.2099','DD.MM.YYYY');

 p_merge( l_FIN_PD_NBU);


l_FIN_PD_NBU.IDF :=63;
l_FIN_PD_NBU.FIN :=1;
l_FIN_PD_NBU.VED :=0;
l_FIN_PD_NBU.K_MIN :=.005;
l_FIN_PD_NBU.K_MAX :=.16;
l_FIN_PD_NBU.K_AVER :=.083;
l_FIN_PD_NBU.DATE_BEGIN :=to_date('20.06.2018','DD.MM.YYYY');
l_FIN_PD_NBU.DATE_CLOSE :=to_date('01.01.2099','DD.MM.YYYY');

 p_merge( l_FIN_PD_NBU);


l_FIN_PD_NBU.IDF :=63;
l_FIN_PD_NBU.FIN :=2;
l_FIN_PD_NBU.VED :=0;
l_FIN_PD_NBU.K_MIN :=.17;
l_FIN_PD_NBU.K_MAX :=.4;
l_FIN_PD_NBU.K_AVER :=.285;
l_FIN_PD_NBU.DATE_BEGIN :=to_date('20.06.2018','DD.MM.YYYY');
l_FIN_PD_NBU.DATE_CLOSE :=to_date('01.01.2099','DD.MM.YYYY');

 p_merge( l_FIN_PD_NBU);


l_FIN_PD_NBU.IDF :=63;
l_FIN_PD_NBU.FIN :=3;
l_FIN_PD_NBU.VED :=0;
l_FIN_PD_NBU.K_MIN :=.41;
l_FIN_PD_NBU.K_MAX :=.7;
l_FIN_PD_NBU.K_AVER :=.555;
l_FIN_PD_NBU.DATE_BEGIN :=to_date('20.06.2018','DD.MM.YYYY');
l_FIN_PD_NBU.DATE_CLOSE :=to_date('01.01.2099','DD.MM.YYYY');

 p_merge( l_FIN_PD_NBU);


l_FIN_PD_NBU.IDF :=63;
l_FIN_PD_NBU.FIN :=4;
l_FIN_PD_NBU.VED :=0;
l_FIN_PD_NBU.K_MIN :=.71;
l_FIN_PD_NBU.K_MAX :=.99;
l_FIN_PD_NBU.K_AVER :=.85;
l_FIN_PD_NBU.DATE_BEGIN :=to_date('20.06.2018','DD.MM.YYYY');
l_FIN_PD_NBU.DATE_CLOSE :=to_date('01.01.2099','DD.MM.YYYY');

 p_merge( l_FIN_PD_NBU);


l_FIN_PD_NBU.IDF :=63;
l_FIN_PD_NBU.FIN :=5;
l_FIN_PD_NBU.VED :=0;
l_FIN_PD_NBU.K_MIN :=1;
l_FIN_PD_NBU.K_MAX :=1;
l_FIN_PD_NBU.K_AVER :=1;
l_FIN_PD_NBU.DATE_BEGIN :=to_date('20.06.2018','DD.MM.YYYY');
l_FIN_PD_NBU.DATE_CLOSE :=to_date('01.01.2099','DD.MM.YYYY');

 p_merge( l_FIN_PD_NBU);


l_FIN_PD_NBU.IDF :=64;
l_FIN_PD_NBU.FIN :=1;
l_FIN_PD_NBU.VED :=0;
l_FIN_PD_NBU.K_MIN :=.005;
l_FIN_PD_NBU.K_MAX :=.13;
l_FIN_PD_NBU.K_AVER :=.068;
l_FIN_PD_NBU.DATE_BEGIN :=to_date('20.06.2018','DD.MM.YYYY');
l_FIN_PD_NBU.DATE_CLOSE :=to_date('01.01.2099','DD.MM.YYYY');

 p_merge( l_FIN_PD_NBU);


l_FIN_PD_NBU.IDF :=64;
l_FIN_PD_NBU.FIN :=2;
l_FIN_PD_NBU.VED :=0;
l_FIN_PD_NBU.K_MIN :=.14;
l_FIN_PD_NBU.K_MAX :=.35;
l_FIN_PD_NBU.K_AVER :=.245;
l_FIN_PD_NBU.DATE_BEGIN :=to_date('20.06.2018','DD.MM.YYYY');
l_FIN_PD_NBU.DATE_CLOSE :=to_date('01.01.2099','DD.MM.YYYY');

 p_merge( l_FIN_PD_NBU);


l_FIN_PD_NBU.IDF :=64;
l_FIN_PD_NBU.FIN :=3;
l_FIN_PD_NBU.VED :=0;
l_FIN_PD_NBU.K_MIN :=.36;
l_FIN_PD_NBU.K_MAX :=.68;
l_FIN_PD_NBU.K_AVER :=.52;
l_FIN_PD_NBU.DATE_BEGIN :=to_date('20.06.2018','DD.MM.YYYY');
l_FIN_PD_NBU.DATE_CLOSE :=to_date('01.01.2099','DD.MM.YYYY');

 p_merge( l_FIN_PD_NBU);


l_FIN_PD_NBU.IDF :=64;
l_FIN_PD_NBU.FIN :=4;
l_FIN_PD_NBU.VED :=0;
l_FIN_PD_NBU.K_MIN :=.69;
l_FIN_PD_NBU.K_MAX :=.99;
l_FIN_PD_NBU.K_AVER :=.84;
l_FIN_PD_NBU.DATE_BEGIN :=to_date('20.06.2018','DD.MM.YYYY');
l_FIN_PD_NBU.DATE_CLOSE :=to_date('01.01.2099','DD.MM.YYYY');

 p_merge( l_FIN_PD_NBU);


l_FIN_PD_NBU.IDF :=64;
l_FIN_PD_NBU.FIN :=5;
l_FIN_PD_NBU.VED :=0;
l_FIN_PD_NBU.K_MIN :=1;
l_FIN_PD_NBU.K_MAX :=1;
l_FIN_PD_NBU.K_AVER :=1;
l_FIN_PD_NBU.DATE_BEGIN :=to_date('20.06.2018','DD.MM.YYYY');
l_FIN_PD_NBU.DATE_CLOSE :=to_date('01.01.2099','DD.MM.YYYY');

 p_merge( l_FIN_PD_NBU);


l_FIN_PD_NBU.IDF :=65;
l_FIN_PD_NBU.FIN :=1;
l_FIN_PD_NBU.VED :=0;
l_FIN_PD_NBU.K_MIN :=.005;
l_FIN_PD_NBU.K_MAX :=.17;
l_FIN_PD_NBU.K_AVER :=.088;
l_FIN_PD_NBU.DATE_BEGIN :=to_date('20.06.2018','DD.MM.YYYY');
l_FIN_PD_NBU.DATE_CLOSE :=to_date('01.01.2099','DD.MM.YYYY');

 p_merge( l_FIN_PD_NBU);


l_FIN_PD_NBU.IDF :=65;
l_FIN_PD_NBU.FIN :=2;
l_FIN_PD_NBU.VED :=0;
l_FIN_PD_NBU.K_MIN :=.18;
l_FIN_PD_NBU.K_MAX :=.44;
l_FIN_PD_NBU.K_AVER :=.31;
l_FIN_PD_NBU.DATE_BEGIN :=to_date('20.06.2018','DD.MM.YYYY');
l_FIN_PD_NBU.DATE_CLOSE :=to_date('01.01.2099','DD.MM.YYYY');

 p_merge( l_FIN_PD_NBU);


l_FIN_PD_NBU.IDF :=65;
l_FIN_PD_NBU.FIN :=3;
l_FIN_PD_NBU.VED :=0;
l_FIN_PD_NBU.K_MIN :=.45;
l_FIN_PD_NBU.K_MAX :=.8;
l_FIN_PD_NBU.K_AVER :=.625;
l_FIN_PD_NBU.DATE_BEGIN :=to_date('20.06.2018','DD.MM.YYYY');
l_FIN_PD_NBU.DATE_CLOSE :=to_date('01.01.2099','DD.MM.YYYY');

 p_merge( l_FIN_PD_NBU);


l_FIN_PD_NBU.IDF :=65;
l_FIN_PD_NBU.FIN :=4;
l_FIN_PD_NBU.VED :=0;
l_FIN_PD_NBU.K_MIN :=.81;
l_FIN_PD_NBU.K_MAX :=.99;
l_FIN_PD_NBU.K_AVER :=.9;
l_FIN_PD_NBU.DATE_BEGIN :=to_date('20.06.2018','DD.MM.YYYY');
l_FIN_PD_NBU.DATE_CLOSE :=to_date('01.01.2099','DD.MM.YYYY');

 p_merge( l_FIN_PD_NBU);


l_FIN_PD_NBU.IDF :=65;
l_FIN_PD_NBU.FIN :=5;
l_FIN_PD_NBU.VED :=0;
l_FIN_PD_NBU.K_MIN :=1;
l_FIN_PD_NBU.K_MAX :=1;
l_FIN_PD_NBU.K_AVER :=1;
l_FIN_PD_NBU.DATE_BEGIN :=to_date('20.06.2018','DD.MM.YYYY');
l_FIN_PD_NBU.DATE_CLOSE :=to_date('01.01.2099','DD.MM.YYYY');

 p_merge( l_FIN_PD_NBU);


l_FIN_PD_NBU.IDF :=70;
l_FIN_PD_NBU.FIN :=1;
l_FIN_PD_NBU.VED :=0;
l_FIN_PD_NBU.K_MIN :=.01;
l_FIN_PD_NBU.K_MAX :=.04;
l_FIN_PD_NBU.K_AVER :=.025;
l_FIN_PD_NBU.DATE_BEGIN :=to_date('20.06.2018','DD.MM.YYYY');
l_FIN_PD_NBU.DATE_CLOSE :=to_date('01.01.2099','DD.MM.YYYY');

 p_merge( l_FIN_PD_NBU);


l_FIN_PD_NBU.IDF :=70;
l_FIN_PD_NBU.FIN :=2;
l_FIN_PD_NBU.VED :=0;
l_FIN_PD_NBU.K_MIN :=.05;
l_FIN_PD_NBU.K_MAX :=.14;
l_FIN_PD_NBU.K_AVER :=.095;
l_FIN_PD_NBU.DATE_BEGIN :=to_date('20.06.2018','DD.MM.YYYY');
l_FIN_PD_NBU.DATE_CLOSE :=to_date('01.01.2099','DD.MM.YYYY');

 p_merge( l_FIN_PD_NBU);


l_FIN_PD_NBU.IDF :=70;
l_FIN_PD_NBU.FIN :=3;
l_FIN_PD_NBU.VED :=0;
l_FIN_PD_NBU.K_MIN :=.15;
l_FIN_PD_NBU.K_MAX :=.49;
l_FIN_PD_NBU.K_AVER :=.32;
l_FIN_PD_NBU.DATE_BEGIN :=to_date('20.06.2018','DD.MM.YYYY');
l_FIN_PD_NBU.DATE_CLOSE :=to_date('01.01.2099','DD.MM.YYYY');

 p_merge( l_FIN_PD_NBU);


l_FIN_PD_NBU.IDF :=70;
l_FIN_PD_NBU.FIN :=4;
l_FIN_PD_NBU.VED :=0;
l_FIN_PD_NBU.K_MIN :=.5;
l_FIN_PD_NBU.K_MAX :=.99;
l_FIN_PD_NBU.K_AVER :=.745;
l_FIN_PD_NBU.DATE_BEGIN :=to_date('20.06.2018','DD.MM.YYYY');
l_FIN_PD_NBU.DATE_CLOSE :=to_date('01.01.2099','DD.MM.YYYY');

 p_merge( l_FIN_PD_NBU);


l_FIN_PD_NBU.IDF :=70;
l_FIN_PD_NBU.FIN :=5;
l_FIN_PD_NBU.VED :=0;
l_FIN_PD_NBU.K_MIN :=1;
l_FIN_PD_NBU.K_MAX :=1;
l_FIN_PD_NBU.K_AVER :=1;
l_FIN_PD_NBU.DATE_BEGIN :=to_date('20.06.2018','DD.MM.YYYY');
l_FIN_PD_NBU.DATE_CLOSE :=to_date('01.01.2099','DD.MM.YYYY');

 p_merge( l_FIN_PD_NBU);


l_FIN_PD_NBU.IDF :=80;
l_FIN_PD_NBU.FIN :=1;
l_FIN_PD_NBU.VED :=0;
l_FIN_PD_NBU.K_MIN :=.005;
l_FIN_PD_NBU.K_MAX :=.12;
l_FIN_PD_NBU.K_AVER :=.063;
l_FIN_PD_NBU.DATE_BEGIN :=to_date('20.06.2018','DD.MM.YYYY');
l_FIN_PD_NBU.DATE_CLOSE :=to_date('01.01.2099','DD.MM.YYYY');

 p_merge( l_FIN_PD_NBU);


l_FIN_PD_NBU.IDF :=80;
l_FIN_PD_NBU.FIN :=2;
l_FIN_PD_NBU.VED :=0;
l_FIN_PD_NBU.K_MIN :=.13;
l_FIN_PD_NBU.K_MAX :=.21;
l_FIN_PD_NBU.K_AVER :=.17;
l_FIN_PD_NBU.DATE_BEGIN :=to_date('20.06.2018','DD.MM.YYYY');
l_FIN_PD_NBU.DATE_CLOSE :=to_date('01.01.2099','DD.MM.YYYY');

 p_merge( l_FIN_PD_NBU);


l_FIN_PD_NBU.IDF :=80;
l_FIN_PD_NBU.FIN :=3;
l_FIN_PD_NBU.VED :=0;
l_FIN_PD_NBU.K_MIN :=.22;
l_FIN_PD_NBU.K_MAX :=.36;
l_FIN_PD_NBU.K_AVER :=.29;
l_FIN_PD_NBU.DATE_BEGIN :=to_date('20.06.2018','DD.MM.YYYY');
l_FIN_PD_NBU.DATE_CLOSE :=to_date('01.01.2099','DD.MM.YYYY');

 p_merge( l_FIN_PD_NBU);


l_FIN_PD_NBU.IDF :=80;
l_FIN_PD_NBU.FIN :=4;
l_FIN_PD_NBU.VED :=0;
l_FIN_PD_NBU.K_MIN :=.37;
l_FIN_PD_NBU.K_MAX :=.99;
l_FIN_PD_NBU.K_AVER :=.68;
l_FIN_PD_NBU.DATE_BEGIN :=to_date('20.06.2018','DD.MM.YYYY');
l_FIN_PD_NBU.DATE_CLOSE :=to_date('01.01.2099','DD.MM.YYYY');

 p_merge( l_FIN_PD_NBU);


l_FIN_PD_NBU.IDF :=80;
l_FIN_PD_NBU.FIN :=5;
l_FIN_PD_NBU.VED :=0;
l_FIN_PD_NBU.K_MIN :=1;
l_FIN_PD_NBU.K_MAX :=1;
l_FIN_PD_NBU.K_AVER :=1;
l_FIN_PD_NBU.DATE_BEGIN :=to_date('20.06.2018','DD.MM.YYYY');
l_FIN_PD_NBU.DATE_CLOSE :=to_date('01.01.2099','DD.MM.YYYY');

 p_merge( l_FIN_PD_NBU);


l_FIN_PD_NBU.IDF :=81;
l_FIN_PD_NBU.FIN :=1;
l_FIN_PD_NBU.VED :=0;
l_FIN_PD_NBU.K_MIN :=.0015;
l_FIN_PD_NBU.K_MAX :=.0024;
l_FIN_PD_NBU.K_AVER :=.002;
l_FIN_PD_NBU.DATE_BEGIN :=to_date('20.06.2018','DD.MM.YYYY');
l_FIN_PD_NBU.DATE_CLOSE :=to_date('01.01.2099','DD.MM.YYYY');

 p_merge( l_FIN_PD_NBU);


l_FIN_PD_NBU.IDF :=81;
l_FIN_PD_NBU.FIN :=2;
l_FIN_PD_NBU.VED :=0;
l_FIN_PD_NBU.K_MIN :=.0025;
l_FIN_PD_NBU.K_MAX :=.049;
l_FIN_PD_NBU.K_AVER :=.026;
l_FIN_PD_NBU.DATE_BEGIN :=to_date('20.06.2018','DD.MM.YYYY');
l_FIN_PD_NBU.DATE_CLOSE :=to_date('01.01.2099','DD.MM.YYYY');

 p_merge( l_FIN_PD_NBU);


l_FIN_PD_NBU.IDF :=81;
l_FIN_PD_NBU.FIN :=3;
l_FIN_PD_NBU.VED :=0;
l_FIN_PD_NBU.K_MIN :=.05;
l_FIN_PD_NBU.K_MAX :=.79;
l_FIN_PD_NBU.K_AVER :=.42;
l_FIN_PD_NBU.DATE_BEGIN :=to_date('20.06.2018','DD.MM.YYYY');
l_FIN_PD_NBU.DATE_CLOSE :=to_date('01.01.2099','DD.MM.YYYY');

 p_merge( l_FIN_PD_NBU);


l_FIN_PD_NBU.IDF :=81;
l_FIN_PD_NBU.FIN :=4;
l_FIN_PD_NBU.VED :=0;
l_FIN_PD_NBU.K_MIN :=.8;
l_FIN_PD_NBU.K_MAX :=.99;
l_FIN_PD_NBU.K_AVER :=.895;
l_FIN_PD_NBU.DATE_BEGIN :=to_date('20.06.2018','DD.MM.YYYY');
l_FIN_PD_NBU.DATE_CLOSE :=to_date('01.01.2099','DD.MM.YYYY');

 p_merge( l_FIN_PD_NBU);


l_FIN_PD_NBU.IDF :=81;
l_FIN_PD_NBU.FIN :=5;
l_FIN_PD_NBU.VED :=0;
l_FIN_PD_NBU.K_MIN :=1;
l_FIN_PD_NBU.K_MAX :=1;
l_FIN_PD_NBU.K_AVER :=1;
l_FIN_PD_NBU.DATE_BEGIN :=to_date('20.06.2018','DD.MM.YYYY');
l_FIN_PD_NBU.DATE_CLOSE :=to_date('01.01.2099','DD.MM.YYYY');

 p_merge( l_FIN_PD_NBU);


commit;
END;
/


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Data/patch_data_FIN_PD_NBU.sql =========*** 
PROMPT ===================================================================================== 
