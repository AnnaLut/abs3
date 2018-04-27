
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Data/patch_data_FIN_PD.sql =========*** Run 
PROMPT ===================================================================================== 

declare
l_FIN_PD  FIN_PD%rowtype;

procedure p_merge(p_FIN_PD FIN_PD%rowtype) 
as
Begin
   insert into FIN_PD
      values p_FIN_PD; 
 exception when dup_val_on_index then  
   update FIN_PD
      set row = p_FIN_PD
    where FIN = p_FIN_PD.FIN
      and VNCRR = p_FIN_PD.VNCRR
      and IDF = p_FIN_PD.IDF
      and VED = p_FIN_PD.VED
      and ALG = p_FIN_PD.ALG;
End;
Begin

l_FIN_PD.IDF :=40;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.005;
l_FIN_PD.K2 :=.005;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=40;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=2;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.07;
l_FIN_PD.K2 :=.07;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=40;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=3;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.14;
l_FIN_PD.K2 :=.14;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=40;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.15;
l_FIN_PD.K2 :=.15;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=40;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=11;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.15;
l_FIN_PD.K2 :=.15;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=40;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=12;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.255;
l_FIN_PD.K2 :=.255;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=40;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=13;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.36;
l_FIN_PD.K2 :=.36;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=40;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.37;
l_FIN_PD.K2 :=.37;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=40;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=21;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.37;
l_FIN_PD.K2 :=.37;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=40;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=22;
l_FIN_PD.IP1 :=4;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.505;
l_FIN_PD.K2 :=.505;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=40;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=23;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.64;
l_FIN_PD.K2 :=.64;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=40;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.65;
l_FIN_PD.K2 :=.65;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=40;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=31;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.65;
l_FIN_PD.K2 :=.65;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=40;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=32;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.825;
l_FIN_PD.K2 :=.825;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=40;
l_FIN_PD.FIN :=5;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=1;
l_FIN_PD.K2 :=1;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=40;
l_FIN_PD.FIN :=5;
l_FIN_PD.VNCRR :=33;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=1;
l_FIN_PD.K2 :=1;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=40;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.005;
l_FIN_PD.K2 :=.005;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=40;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=2;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.07;
l_FIN_PD.K2 :=.07;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=40;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=3;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.14;
l_FIN_PD.K2 :=.14;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=40;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.15;
l_FIN_PD.K2 :=.15;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=40;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=11;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.15;
l_FIN_PD.K2 :=.15;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=40;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=12;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.255;
l_FIN_PD.K2 :=.255;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=40;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=13;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.36;
l_FIN_PD.K2 :=.36;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=40;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.37;
l_FIN_PD.K2 :=.37;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=40;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=21;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.37;
l_FIN_PD.K2 :=.37;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=40;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=22;
l_FIN_PD.IP1 :=4;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.505;
l_FIN_PD.K2 :=.505;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=40;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=23;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.64;
l_FIN_PD.K2 :=.64;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=40;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.65;
l_FIN_PD.K2 :=.65;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=40;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=31;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.65;
l_FIN_PD.K2 :=.65;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=40;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=32;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.825;
l_FIN_PD.K2 :=.825;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=40;
l_FIN_PD.FIN :=5;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=1;
l_FIN_PD.K2 :=1;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=40;
l_FIN_PD.FIN :=5;
l_FIN_PD.VNCRR :=33;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=1;
l_FIN_PD.K2 :=1;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=41;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.005;
l_FIN_PD.K2 :=.005;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=41;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=2;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.06;
l_FIN_PD.K2 :=.06;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=41;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=3;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.12;
l_FIN_PD.K2 :=.12;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=41;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.13;
l_FIN_PD.K2 :=.13;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=41;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=11;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.13;
l_FIN_PD.K2 :=.13;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=41;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=12;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.225;
l_FIN_PD.K2 :=.225;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=41;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=13;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.32;
l_FIN_PD.K2 :=.32;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=41;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.33;
l_FIN_PD.K2 :=.33;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=41;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=21;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.33;
l_FIN_PD.K2 :=.33;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=41;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=22;
l_FIN_PD.IP1 :=4;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.475;
l_FIN_PD.K2 :=.475;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=41;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=23;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.62;
l_FIN_PD.K2 :=.62;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=41;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.63;
l_FIN_PD.K2 :=.63;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=41;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=31;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.63;
l_FIN_PD.K2 :=.63;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=41;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=32;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.815;
l_FIN_PD.K2 :=.815;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=41;
l_FIN_PD.FIN :=5;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=1;
l_FIN_PD.K2 :=1;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=41;
l_FIN_PD.FIN :=5;
l_FIN_PD.VNCRR :=33;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=1;
l_FIN_PD.K2 :=1;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=41;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.005;
l_FIN_PD.K2 :=.005;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=41;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=2;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.06;
l_FIN_PD.K2 :=.06;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=41;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=3;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.12;
l_FIN_PD.K2 :=.12;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=41;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.13;
l_FIN_PD.K2 :=.13;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=41;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=11;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.13;
l_FIN_PD.K2 :=.13;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=41;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=12;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.225;
l_FIN_PD.K2 :=.225;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=41;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=13;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.32;
l_FIN_PD.K2 :=.32;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=41;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.33;
l_FIN_PD.K2 :=.33;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=41;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=21;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.33;
l_FIN_PD.K2 :=.33;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=41;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=22;
l_FIN_PD.IP1 :=4;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.475;
l_FIN_PD.K2 :=.475;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=41;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=23;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.62;
l_FIN_PD.K2 :=.62;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=41;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.63;
l_FIN_PD.K2 :=.63;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=41;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=31;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.63;
l_FIN_PD.K2 :=.63;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=41;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=32;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.815;
l_FIN_PD.K2 :=.815;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=41;
l_FIN_PD.FIN :=5;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=1;
l_FIN_PD.K2 :=1;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=41;
l_FIN_PD.FIN :=5;
l_FIN_PD.VNCRR :=33;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=1;
l_FIN_PD.K2 :=1;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=42;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.005;
l_FIN_PD.K2 :=.005;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=42;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=2;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.075;
l_FIN_PD.K2 :=.075;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=42;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=3;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.15;
l_FIN_PD.K2 :=.15;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=42;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.16;
l_FIN_PD.K2 :=.16;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=42;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=11;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.16;
l_FIN_PD.K2 :=.16;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=42;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=12;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.28;
l_FIN_PD.K2 :=.28;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=42;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=13;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.4;
l_FIN_PD.K2 :=.4;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=42;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.41;
l_FIN_PD.K2 :=.41;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=42;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=21;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.41;
l_FIN_PD.K2 :=.41;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=42;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=22;
l_FIN_PD.IP1 :=4;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.585;
l_FIN_PD.K2 :=.585;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=42;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=23;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.76;
l_FIN_PD.K2 :=.76;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=42;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.77;
l_FIN_PD.K2 :=.77;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=42;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=31;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.77;
l_FIN_PD.K2 :=.77;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=42;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=32;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.885;
l_FIN_PD.K2 :=.885;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=42;
l_FIN_PD.FIN :=5;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=1;
l_FIN_PD.K2 :=1;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=42;
l_FIN_PD.FIN :=5;
l_FIN_PD.VNCRR :=33;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=1;
l_FIN_PD.K2 :=1;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=42;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.005;
l_FIN_PD.K2 :=.005;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=42;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=2;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.075;
l_FIN_PD.K2 :=.075;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=42;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=3;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.15;
l_FIN_PD.K2 :=.15;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=42;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.16;
l_FIN_PD.K2 :=.16;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=42;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=11;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.16;
l_FIN_PD.K2 :=.16;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=42;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=12;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.28;
l_FIN_PD.K2 :=.28;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=42;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=13;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.4;
l_FIN_PD.K2 :=.4;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=42;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.41;
l_FIN_PD.K2 :=.41;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=42;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=21;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.41;
l_FIN_PD.K2 :=.41;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=42;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=22;
l_FIN_PD.IP1 :=4;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.585;
l_FIN_PD.K2 :=.585;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=42;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=23;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.76;
l_FIN_PD.K2 :=.76;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=42;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.77;
l_FIN_PD.K2 :=.77;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=42;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=31;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.77;
l_FIN_PD.K2 :=.77;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=42;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=32;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.885;
l_FIN_PD.K2 :=.885;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=42;
l_FIN_PD.FIN :=5;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=1;
l_FIN_PD.K2 :=1;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=42;
l_FIN_PD.FIN :=5;
l_FIN_PD.VNCRR :=33;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=1;
l_FIN_PD.K2 :=1;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=43;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.005;
l_FIN_PD.K2 :=.005;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=43;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=2;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.08;
l_FIN_PD.K2 :=.08;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=43;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=3;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.14;
l_FIN_PD.K2 :=.16;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=43;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.17;
l_FIN_PD.K2 :=.17;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=43;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=11;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.17;
l_FIN_PD.K2 :=.17;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=43;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=12;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.285;
l_FIN_PD.K2 :=.285;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=43;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=13;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.4;
l_FIN_PD.K2 :=.4;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=43;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.41;
l_FIN_PD.K2 :=.41;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=43;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=21;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.41;
l_FIN_PD.K2 :=.41;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=43;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=22;
l_FIN_PD.IP1 :=4;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.555;
l_FIN_PD.K2 :=.555;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=43;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=23;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.7;
l_FIN_PD.K2 :=.7;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=43;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.71;
l_FIN_PD.K2 :=.71;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=43;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=31;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.71;
l_FIN_PD.K2 :=.71;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=43;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=32;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.855;
l_FIN_PD.K2 :=.855;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=43;
l_FIN_PD.FIN :=5;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=1;
l_FIN_PD.K2 :=1;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=43;
l_FIN_PD.FIN :=5;
l_FIN_PD.VNCRR :=33;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=1;
l_FIN_PD.K2 :=1;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=43;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.005;
l_FIN_PD.K2 :=.005;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=43;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=2;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.08;
l_FIN_PD.K2 :=.08;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=43;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=3;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.14;
l_FIN_PD.K2 :=.16;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=43;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.17;
l_FIN_PD.K2 :=.17;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=43;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=11;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.17;
l_FIN_PD.K2 :=.17;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=43;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=12;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.285;
l_FIN_PD.K2 :=.285;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=43;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=13;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.4;
l_FIN_PD.K2 :=.4;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=43;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.41;
l_FIN_PD.K2 :=.41;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=43;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=21;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.41;
l_FIN_PD.K2 :=.41;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=43;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=22;
l_FIN_PD.IP1 :=4;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.555;
l_FIN_PD.K2 :=.555;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=43;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=23;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.7;
l_FIN_PD.K2 :=.7;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=43;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.71;
l_FIN_PD.K2 :=.71;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=43;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=31;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.71;
l_FIN_PD.K2 :=.71;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=43;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=32;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.855;
l_FIN_PD.K2 :=.855;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=43;
l_FIN_PD.FIN :=5;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=1;
l_FIN_PD.K2 :=1;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=43;
l_FIN_PD.FIN :=5;
l_FIN_PD.VNCRR :=33;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=1;
l_FIN_PD.K2 :=1;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=44;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.005;
l_FIN_PD.K2 :=.005;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=44;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=2;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.65;
l_FIN_PD.K2 :=.65;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=44;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=3;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.13;
l_FIN_PD.K2 :=.13;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=44;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.14;
l_FIN_PD.K2 :=.14;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=44;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=11;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.14;
l_FIN_PD.K2 :=.14;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=44;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=12;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.245;
l_FIN_PD.K2 :=.245;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=44;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=13;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.35;
l_FIN_PD.K2 :=.35;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=44;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.36;
l_FIN_PD.K2 :=.36;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=44;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=21;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.36;
l_FIN_PD.K2 :=.36;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=44;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=22;
l_FIN_PD.IP1 :=4;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.52;
l_FIN_PD.K2 :=.52;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=44;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.69;
l_FIN_PD.K2 :=.69;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=44;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=31;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.69;
l_FIN_PD.K2 :=.69;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=44;
l_FIN_PD.FIN :=5;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=1;
l_FIN_PD.K2 :=1;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=44;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=23;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.68;
l_FIN_PD.K2 :=.68;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=44;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=32;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.845;
l_FIN_PD.K2 :=.845;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=44;
l_FIN_PD.FIN :=5;
l_FIN_PD.VNCRR :=33;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=1;
l_FIN_PD.K2 :=1;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=44;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.005;
l_FIN_PD.K2 :=.005;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=44;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=2;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.65;
l_FIN_PD.K2 :=.65;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=44;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=3;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.13;
l_FIN_PD.K2 :=.13;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=44;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.14;
l_FIN_PD.K2 :=.14;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=44;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=11;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.14;
l_FIN_PD.K2 :=.14;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=44;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=12;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.245;
l_FIN_PD.K2 :=.245;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=44;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=13;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.35;
l_FIN_PD.K2 :=.35;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=44;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.36;
l_FIN_PD.K2 :=.36;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=44;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=21;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.36;
l_FIN_PD.K2 :=.36;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=44;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=22;
l_FIN_PD.IP1 :=4;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.52;
l_FIN_PD.K2 :=.52;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=44;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.69;
l_FIN_PD.K2 :=.69;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=44;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=31;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.69;
l_FIN_PD.K2 :=.69;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=44;
l_FIN_PD.FIN :=5;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=1;
l_FIN_PD.K2 :=1;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=44;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=23;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.68;
l_FIN_PD.K2 :=.68;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=44;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=32;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.845;
l_FIN_PD.K2 :=.845;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=44;
l_FIN_PD.FIN :=5;
l_FIN_PD.VNCRR :=33;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=1;
l_FIN_PD.K2 :=1;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=45;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.005;
l_FIN_PD.K2 :=.005;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=45;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=2;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.85;
l_FIN_PD.K2 :=.85;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=45;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.18;
l_FIN_PD.K2 :=.18;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=45;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=11;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.18;
l_FIN_PD.K2 :=.18;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=45;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=13;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.44;
l_FIN_PD.K2 :=.44;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=45;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=21;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.45;
l_FIN_PD.K2 :=.45;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=45;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=22;
l_FIN_PD.IP1 :=4;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.625;
l_FIN_PD.K2 :=.625;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=45;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.81;
l_FIN_PD.K2 :=.81;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=45;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=31;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.81;
l_FIN_PD.K2 :=.81;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=45;
l_FIN_PD.FIN :=5;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=1;
l_FIN_PD.K2 :=1;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=45;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=3;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.17;
l_FIN_PD.K2 :=.17;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=45;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=12;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.31;
l_FIN_PD.K2 :=.31;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=45;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.45;
l_FIN_PD.K2 :=.45;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=45;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=23;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.8;
l_FIN_PD.K2 :=.8;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=45;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=32;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.905;
l_FIN_PD.K2 :=.905;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=45;
l_FIN_PD.FIN :=5;
l_FIN_PD.VNCRR :=33;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=1;
l_FIN_PD.K2 :=1;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=45;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.005;
l_FIN_PD.K2 :=.005;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=45;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=2;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.85;
l_FIN_PD.K2 :=.85;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=45;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.18;
l_FIN_PD.K2 :=.18;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=45;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=11;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.18;
l_FIN_PD.K2 :=.18;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=45;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=13;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.44;
l_FIN_PD.K2 :=.44;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=45;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=21;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.45;
l_FIN_PD.K2 :=.45;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=45;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=22;
l_FIN_PD.IP1 :=4;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.625;
l_FIN_PD.K2 :=.625;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=45;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.81;
l_FIN_PD.K2 :=.81;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=45;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=31;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.81;
l_FIN_PD.K2 :=.81;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=45;
l_FIN_PD.FIN :=5;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=1;
l_FIN_PD.K2 :=1;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=45;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=3;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.17;
l_FIN_PD.K2 :=.17;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=45;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=12;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.31;
l_FIN_PD.K2 :=.31;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=45;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.45;
l_FIN_PD.K2 :=.45;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=45;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=23;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.8;
l_FIN_PD.K2 :=.8;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=45;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=32;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.905;
l_FIN_PD.K2 :=.905;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=45;
l_FIN_PD.FIN :=5;
l_FIN_PD.VNCRR :=33;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=1;
l_FIN_PD.K2 :=1;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=46;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.005;
l_FIN_PD.K2 :=.005;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=46;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=2;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.0625;
l_FIN_PD.K2 :=.0625;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=46;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.13;
l_FIN_PD.K2 :=.13;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=46;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=11;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.13;
l_FIN_PD.K2 :=.13;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=46;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=13;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.21;
l_FIN_PD.K2 :=.21;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=46;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=21;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.22;
l_FIN_PD.K2 :=.22;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=46;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=22;
l_FIN_PD.IP1 :=4;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.29;
l_FIN_PD.K2 :=.29;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=46;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.37;
l_FIN_PD.K2 :=.37;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=46;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=31;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.37;
l_FIN_PD.K2 :=.37;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=46;
l_FIN_PD.FIN :=5;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=1;
l_FIN_PD.K2 :=1;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=46;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=3;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.12;
l_FIN_PD.K2 :=.12;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=46;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=12;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.17;
l_FIN_PD.K2 :=.17;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=46;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.22;
l_FIN_PD.K2 :=.22;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=46;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=23;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.36;
l_FIN_PD.K2 :=.36;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=46;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=32;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.685;
l_FIN_PD.K2 :=.685;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=46;
l_FIN_PD.FIN :=5;
l_FIN_PD.VNCRR :=33;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=1;
l_FIN_PD.K2 :=1;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=46;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.005;
l_FIN_PD.K2 :=.005;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=46;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=2;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.0625;
l_FIN_PD.K2 :=.0625;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=46;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.13;
l_FIN_PD.K2 :=.13;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=46;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=11;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.13;
l_FIN_PD.K2 :=.13;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=46;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=13;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.21;
l_FIN_PD.K2 :=.21;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=46;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=21;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.22;
l_FIN_PD.K2 :=.22;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=46;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=22;
l_FIN_PD.IP1 :=4;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.29;
l_FIN_PD.K2 :=.29;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=46;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.37;
l_FIN_PD.K2 :=.37;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=46;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=31;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.37;
l_FIN_PD.K2 :=.37;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=46;
l_FIN_PD.FIN :=5;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=1;
l_FIN_PD.K2 :=1;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=46;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=3;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.12;
l_FIN_PD.K2 :=.12;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=46;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=12;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.17;
l_FIN_PD.K2 :=.17;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=46;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.22;
l_FIN_PD.K2 :=.22;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=46;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=23;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.36;
l_FIN_PD.K2 :=.36;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=46;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=32;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.685;
l_FIN_PD.K2 :=.685;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=46;
l_FIN_PD.FIN :=5;
l_FIN_PD.VNCRR :=33;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=1;
l_FIN_PD.K2 :=1;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=47;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.0015;
l_FIN_PD.K2 :=.0015;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=47;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=2;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.00195;
l_FIN_PD.K2 :=.00195;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=47;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.0025;
l_FIN_PD.K2 :=.0025;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=47;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=11;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.0025;
l_FIN_PD.K2 :=.0025;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=47;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=13;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.049;
l_FIN_PD.K2 :=.049;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=47;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.05;
l_FIN_PD.K2 :=.05;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=47;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=22;
l_FIN_PD.IP1 :=4;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.42;
l_FIN_PD.K2 :=.42;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=47;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.8;
l_FIN_PD.K2 :=.8;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=47;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=31;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.8;
l_FIN_PD.K2 :=.8;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=47;
l_FIN_PD.FIN :=5;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=1;
l_FIN_PD.K2 :=1;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=47;
l_FIN_PD.FIN :=5;
l_FIN_PD.VNCRR :=33;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=1;
l_FIN_PD.K2 :=1;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=47;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=3;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.0024;
l_FIN_PD.K2 :=.0024;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=47;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=12;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.02575;
l_FIN_PD.K2 :=.02575;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=47;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=21;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.05;
l_FIN_PD.K2 :=.05;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=47;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=23;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.79;
l_FIN_PD.K2 :=.79;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=47;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=32;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.9;
l_FIN_PD.K2 :=.9;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=47;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.0015;
l_FIN_PD.K2 :=.0015;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=47;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=2;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.00195;
l_FIN_PD.K2 :=.00195;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=47;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.0025;
l_FIN_PD.K2 :=.0025;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=47;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=11;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.0025;
l_FIN_PD.K2 :=.0025;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=47;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=13;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.049;
l_FIN_PD.K2 :=.049;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=47;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.05;
l_FIN_PD.K2 :=.05;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=47;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=22;
l_FIN_PD.IP1 :=4;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.42;
l_FIN_PD.K2 :=.42;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=47;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.8;
l_FIN_PD.K2 :=.8;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=47;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=31;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.8;
l_FIN_PD.K2 :=.8;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=47;
l_FIN_PD.FIN :=5;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=1;
l_FIN_PD.K2 :=1;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=47;
l_FIN_PD.FIN :=5;
l_FIN_PD.VNCRR :=33;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=1;
l_FIN_PD.K2 :=1;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=47;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=3;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.0024;
l_FIN_PD.K2 :=.0024;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=47;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=12;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.02575;
l_FIN_PD.K2 :=.02575;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=47;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=21;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.05;
l_FIN_PD.K2 :=.05;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=47;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=23;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.79;
l_FIN_PD.K2 :=.79;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=47;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=32;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.9;
l_FIN_PD.K2 :=.9;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=48;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=2;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.025;
l_FIN_PD.K2 :=.025;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=48;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.05;
l_FIN_PD.K2 :=.05;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=48;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=11;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.05;
l_FIN_PD.K2 :=.05;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=48;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=13;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.14;
l_FIN_PD.K2 :=.14;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=48;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.15;
l_FIN_PD.K2 :=.15;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=48;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=22;
l_FIN_PD.IP1 :=4;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.32;
l_FIN_PD.K2 :=.32;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=48;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.5;
l_FIN_PD.K2 :=.5;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=48;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=31;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.5;
l_FIN_PD.K2 :=.5;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=48;
l_FIN_PD.FIN :=5;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=1;
l_FIN_PD.K2 :=1;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=48;
l_FIN_PD.FIN :=5;
l_FIN_PD.VNCRR :=33;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=1;
l_FIN_PD.K2 :=1;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=48;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.01;
l_FIN_PD.K2 :=.01;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=48;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=3;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.04;
l_FIN_PD.K2 :=.04;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=48;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=12;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.095;
l_FIN_PD.K2 :=.095;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=48;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=21;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.15;
l_FIN_PD.K2 :=.15;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=48;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=23;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.49;
l_FIN_PD.K2 :=.49;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=48;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=32;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.75;
l_FIN_PD.K2 :=.75;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=48;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=2;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.025;
l_FIN_PD.K2 :=.025;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=48;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.05;
l_FIN_PD.K2 :=.05;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=48;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=11;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.05;
l_FIN_PD.K2 :=.05;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=48;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=13;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.14;
l_FIN_PD.K2 :=.14;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=48;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.15;
l_FIN_PD.K2 :=.15;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=48;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=22;
l_FIN_PD.IP1 :=4;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.32;
l_FIN_PD.K2 :=.32;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=48;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.5;
l_FIN_PD.K2 :=.5;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=48;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=31;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.5;
l_FIN_PD.K2 :=.5;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=48;
l_FIN_PD.FIN :=5;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=1;
l_FIN_PD.K2 :=1;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=48;
l_FIN_PD.FIN :=5;
l_FIN_PD.VNCRR :=33;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=1;
l_FIN_PD.K2 :=1;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=48;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.01;
l_FIN_PD.K2 :=.01;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=48;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=3;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.04;
l_FIN_PD.K2 :=.04;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=48;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=12;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.095;
l_FIN_PD.K2 :=.095;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=48;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=21;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.15;
l_FIN_PD.K2 :=.15;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=48;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=23;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.49;
l_FIN_PD.K2 :=.49;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=48;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=32;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.75;
l_FIN_PD.K2 :=.75;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=1;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.005;
l_FIN_PD.K2 :=.006;
l_FIN_PD.VED :=1;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=11;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=1;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.006;
l_FIN_PD.K2 :=.007;
l_FIN_PD.VED :=1;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=21;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=5;
l_FIN_PD.IP5 :=3;
l_FIN_PD.K :=.007;
l_FIN_PD.K2 :=.007;
l_FIN_PD.VED :=1;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=1;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.008;
l_FIN_PD.K2 :=.009;
l_FIN_PD.VED :=1;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=2;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=1;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.009;
l_FIN_PD.K2 :=.01;
l_FIN_PD.VED :=1;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=3;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=1;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.01;
l_FIN_PD.K2 :=.011;
l_FIN_PD.VED :=1;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=11;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=1;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.011;
l_FIN_PD.K2 :=.012;
l_FIN_PD.VED :=1;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=12;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=1;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.012;
l_FIN_PD.K2 :=.013;
l_FIN_PD.VED :=1;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=13;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=1;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.013;
l_FIN_PD.K2 :=.014;
l_FIN_PD.VED :=1;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=21;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=2;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.014;
l_FIN_PD.K2 :=.015;
l_FIN_PD.VED :=1;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=22;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=2;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.015;
l_FIN_PD.K2 :=.016;
l_FIN_PD.VED :=1;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=23;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=2;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.016;
l_FIN_PD.K2 :=.017;
l_FIN_PD.VED :=1;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=31;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=2;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.017;
l_FIN_PD.K2 :=.018;
l_FIN_PD.VED :=1;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=32;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=2;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.018;
l_FIN_PD.K2 :=.019;
l_FIN_PD.VED :=1;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=33;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=5;
l_FIN_PD.IP5 :=3;
l_FIN_PD.K :=.019;
l_FIN_PD.K2 :=.019;
l_FIN_PD.VED :=1;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=2;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.02;
l_FIN_PD.K2 :=.022;
l_FIN_PD.VED :=1;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=2;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=2;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.022;
l_FIN_PD.K2 :=.023;
l_FIN_PD.VED :=1;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=3;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=2;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.023;
l_FIN_PD.K2 :=.025;
l_FIN_PD.VED :=1;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=11;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=2;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.025;
l_FIN_PD.K2 :=.027;
l_FIN_PD.VED :=1;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=12;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=2;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.027;
l_FIN_PD.K2 :=.028;
l_FIN_PD.VED :=1;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=13;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=2;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.028;
l_FIN_PD.K2 :=.03;
l_FIN_PD.VED :=1;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=21;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=2;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.03;
l_FIN_PD.K2 :=.032;
l_FIN_PD.VED :=1;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=22;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=2;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.032;
l_FIN_PD.K2 :=.034;
l_FIN_PD.VED :=1;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=23;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=2;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.034;
l_FIN_PD.K2 :=.036;
l_FIN_PD.VED :=1;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=31;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=2;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.036;
l_FIN_PD.K2 :=.038;
l_FIN_PD.VED :=1;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=32;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=2;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.038;
l_FIN_PD.K2 :=.04;
l_FIN_PD.VED :=1;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=33;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=5;
l_FIN_PD.IP5 :=3;
l_FIN_PD.K :=.04;
l_FIN_PD.K2 :=.04;
l_FIN_PD.VED :=1;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=2;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.05;
l_FIN_PD.K2 :=.053;
l_FIN_PD.VED :=1;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=2;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=2;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.053;
l_FIN_PD.K2 :=.057;
l_FIN_PD.VED :=1;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=3;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=2;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.057;
l_FIN_PD.K2 :=.06;
l_FIN_PD.VED :=1;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=11;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=2;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.06;
l_FIN_PD.K2 :=.063;
l_FIN_PD.VED :=1;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=12;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=2;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.063;
l_FIN_PD.K2 :=.067;
l_FIN_PD.VED :=1;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=13;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=2;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.067;
l_FIN_PD.K2 :=.07;
l_FIN_PD.VED :=1;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=21;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.07;
l_FIN_PD.K2 :=.074;
l_FIN_PD.VED :=1;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=22;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.074;
l_FIN_PD.K2 :=.078;
l_FIN_PD.VED :=1;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=23;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.078;
l_FIN_PD.K2 :=.082;
l_FIN_PD.VED :=1;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=31;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.082;
l_FIN_PD.K2 :=.086;
l_FIN_PD.VED :=1;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=32;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.086;
l_FIN_PD.K2 :=.09;
l_FIN_PD.VED :=1;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=33;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=5;
l_FIN_PD.IP5 :=3;
l_FIN_PD.K :=.09;
l_FIN_PD.K2 :=.09;
l_FIN_PD.VED :=1;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=5;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.1;
l_FIN_PD.K2 :=.105;
l_FIN_PD.VED :=1;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=5;
l_FIN_PD.VNCRR :=2;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.105;
l_FIN_PD.K2 :=.11;
l_FIN_PD.VED :=1;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=5;
l_FIN_PD.VNCRR :=3;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.11;
l_FIN_PD.K2 :=.115;
l_FIN_PD.VED :=1;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=5;
l_FIN_PD.VNCRR :=11;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.115;
l_FIN_PD.K2 :=.12;
l_FIN_PD.VED :=1;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=5;
l_FIN_PD.VNCRR :=12;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.12;
l_FIN_PD.K2 :=.125;
l_FIN_PD.VED :=1;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=5;
l_FIN_PD.VNCRR :=13;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.125;
l_FIN_PD.K2 :=.13;
l_FIN_PD.VED :=1;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=5;
l_FIN_PD.VNCRR :=21;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.13;
l_FIN_PD.K2 :=.136;
l_FIN_PD.VED :=1;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=5;
l_FIN_PD.VNCRR :=22;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.136;
l_FIN_PD.K2 :=.142;
l_FIN_PD.VED :=1;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=5;
l_FIN_PD.VNCRR :=23;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.142;
l_FIN_PD.K2 :=.148;
l_FIN_PD.VED :=1;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=5;
l_FIN_PD.VNCRR :=31;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.148;
l_FIN_PD.K2 :=.154;
l_FIN_PD.VED :=1;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=5;
l_FIN_PD.VNCRR :=32;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.154;
l_FIN_PD.K2 :=.16;
l_FIN_PD.VED :=1;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=5;
l_FIN_PD.VNCRR :=33;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=5;
l_FIN_PD.IP5 :=3;
l_FIN_PD.K :=.16;
l_FIN_PD.K2 :=.16;
l_FIN_PD.VED :=1;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=6;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.17;
l_FIN_PD.K2 :=.173;
l_FIN_PD.VED :=1;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=6;
l_FIN_PD.VNCRR :=2;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.173;
l_FIN_PD.K2 :=.177;
l_FIN_PD.VED :=1;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=6;
l_FIN_PD.VNCRR :=3;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.177;
l_FIN_PD.K2 :=.18;
l_FIN_PD.VED :=1;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=6;
l_FIN_PD.VNCRR :=11;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.18;
l_FIN_PD.K2 :=.183;
l_FIN_PD.VED :=1;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=6;
l_FIN_PD.VNCRR :=12;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.183;
l_FIN_PD.K2 :=.187;
l_FIN_PD.VED :=1;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=6;
l_FIN_PD.VNCRR :=13;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.187;
l_FIN_PD.K2 :=.19;
l_FIN_PD.VED :=1;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=6;
l_FIN_PD.VNCRR :=21;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.19;
l_FIN_PD.K2 :=.194;
l_FIN_PD.VED :=1;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=6;
l_FIN_PD.VNCRR :=22;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.194;
l_FIN_PD.K2 :=.198;
l_FIN_PD.VED :=1;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=6;
l_FIN_PD.VNCRR :=23;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.198;
l_FIN_PD.K2 :=.202;
l_FIN_PD.VED :=1;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=6;
l_FIN_PD.VNCRR :=31;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.202;
l_FIN_PD.K2 :=.206;
l_FIN_PD.VED :=1;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=6;
l_FIN_PD.VNCRR :=32;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.206;
l_FIN_PD.K2 :=.21;
l_FIN_PD.VED :=1;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=6;
l_FIN_PD.VNCRR :=33;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=5;
l_FIN_PD.IP5 :=3;
l_FIN_PD.K :=.21;
l_FIN_PD.K2 :=.21;
l_FIN_PD.VED :=1;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=7;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.22;
l_FIN_PD.K2 :=.227;
l_FIN_PD.VED :=1;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=7;
l_FIN_PD.VNCRR :=2;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.227;
l_FIN_PD.K2 :=.233;
l_FIN_PD.VED :=1;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=7;
l_FIN_PD.VNCRR :=3;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.233;
l_FIN_PD.K2 :=.24;
l_FIN_PD.VED :=1;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=7;
l_FIN_PD.VNCRR :=11;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.24;
l_FIN_PD.K2 :=.247;
l_FIN_PD.VED :=1;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=7;
l_FIN_PD.VNCRR :=12;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.247;
l_FIN_PD.K2 :=.253;
l_FIN_PD.VED :=1;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=7;
l_FIN_PD.VNCRR :=13;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.253;
l_FIN_PD.K2 :=.26;
l_FIN_PD.VED :=1;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=7;
l_FIN_PD.VNCRR :=21;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.26;
l_FIN_PD.K2 :=.268;
l_FIN_PD.VED :=1;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=7;
l_FIN_PD.VNCRR :=22;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.268;
l_FIN_PD.K2 :=.276;
l_FIN_PD.VED :=1;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=7;
l_FIN_PD.VNCRR :=23;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.276;
l_FIN_PD.K2 :=.284;
l_FIN_PD.VED :=1;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=7;
l_FIN_PD.VNCRR :=31;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.284;
l_FIN_PD.K2 :=.292;
l_FIN_PD.VED :=1;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=7;
l_FIN_PD.VNCRR :=32;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.292;
l_FIN_PD.K2 :=.3;
l_FIN_PD.VED :=1;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=7;
l_FIN_PD.VNCRR :=33;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=5;
l_FIN_PD.IP5 :=3;
l_FIN_PD.K :=.3;
l_FIN_PD.K2 :=.3;
l_FIN_PD.VED :=1;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=8;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.31;
l_FIN_PD.K2 :=.315;
l_FIN_PD.VED :=1;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=8;
l_FIN_PD.VNCRR :=2;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.315;
l_FIN_PD.K2 :=.32;
l_FIN_PD.VED :=1;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=8;
l_FIN_PD.VNCRR :=3;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.32;
l_FIN_PD.K2 :=.325;
l_FIN_PD.VED :=1;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=8;
l_FIN_PD.VNCRR :=11;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.325;
l_FIN_PD.K2 :=.33;
l_FIN_PD.VED :=1;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=8;
l_FIN_PD.VNCRR :=12;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.33;
l_FIN_PD.K2 :=.335;
l_FIN_PD.VED :=1;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=8;
l_FIN_PD.VNCRR :=13;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.335;
l_FIN_PD.K2 :=.34;
l_FIN_PD.VED :=1;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=8;
l_FIN_PD.VNCRR :=21;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.34;
l_FIN_PD.K2 :=.346;
l_FIN_PD.VED :=1;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=8;
l_FIN_PD.VNCRR :=22;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.346;
l_FIN_PD.K2 :=.352;
l_FIN_PD.VED :=1;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=8;
l_FIN_PD.VNCRR :=23;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.352;
l_FIN_PD.K2 :=.358;
l_FIN_PD.VED :=1;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=8;
l_FIN_PD.VNCRR :=31;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.358;
l_FIN_PD.K2 :=.364;
l_FIN_PD.VED :=1;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=8;
l_FIN_PD.VNCRR :=32;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.364;
l_FIN_PD.K2 :=.37;
l_FIN_PD.VED :=1;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=8;
l_FIN_PD.VNCRR :=33;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=5;
l_FIN_PD.IP5 :=3;
l_FIN_PD.K :=.37;
l_FIN_PD.K2 :=.37;
l_FIN_PD.VED :=1;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=9;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.38;
l_FIN_PD.K2 :=.431;
l_FIN_PD.VED :=1;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=9;
l_FIN_PD.VNCRR :=2;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.431;
l_FIN_PD.K2 :=.482;
l_FIN_PD.VED :=1;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=9;
l_FIN_PD.VNCRR :=3;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.482;
l_FIN_PD.K2 :=.533;
l_FIN_PD.VED :=1;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=9;
l_FIN_PD.VNCRR :=11;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.533;
l_FIN_PD.K2 :=.583;
l_FIN_PD.VED :=1;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=9;
l_FIN_PD.VNCRR :=12;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.583;
l_FIN_PD.K2 :=.634;
l_FIN_PD.VED :=1;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=9;
l_FIN_PD.VNCRR :=13;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.634;
l_FIN_PD.K2 :=.685;
l_FIN_PD.VED :=1;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=9;
l_FIN_PD.VNCRR :=21;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.685;
l_FIN_PD.K2 :=.746;
l_FIN_PD.VED :=1;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=9;
l_FIN_PD.VNCRR :=22;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.746;
l_FIN_PD.K2 :=.807;
l_FIN_PD.VED :=1;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=9;
l_FIN_PD.VNCRR :=23;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.807;
l_FIN_PD.K2 :=.868;
l_FIN_PD.VED :=1;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=9;
l_FIN_PD.VNCRR :=31;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.868;
l_FIN_PD.K2 :=.929;
l_FIN_PD.VED :=1;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=9;
l_FIN_PD.VNCRR :=32;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.929;
l_FIN_PD.K2 :=.99;
l_FIN_PD.VED :=1;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=9;
l_FIN_PD.VNCRR :=33;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=5;
l_FIN_PD.IP5 :=3;
l_FIN_PD.K :=.99;
l_FIN_PD.K2 :=.99;
l_FIN_PD.VED :=1;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=10;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=5;
l_FIN_PD.IP5 :=3;
l_FIN_PD.K :=1;
l_FIN_PD.K2 :=1;
l_FIN_PD.VED :=1;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=1;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.005;
l_FIN_PD.K2 :=.006;
l_FIN_PD.VED :=2;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=11;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=5;
l_FIN_PD.IP5 :=3;
l_FIN_PD.K :=.006;
l_FIN_PD.K2 :=.006;
l_FIN_PD.VED :=2;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=1;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.007;
l_FIN_PD.K2 :=.01;
l_FIN_PD.VED :=2;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=2;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=1;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.01;
l_FIN_PD.K2 :=.012;
l_FIN_PD.VED :=2;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=3;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=1;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.012;
l_FIN_PD.K2 :=.015;
l_FIN_PD.VED :=2;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=11;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=1;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.015;
l_FIN_PD.K2 :=.018;
l_FIN_PD.VED :=2;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=12;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=1;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.018;
l_FIN_PD.K2 :=.02;
l_FIN_PD.VED :=2;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=13;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=1;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.02;
l_FIN_PD.K2 :=.023;
l_FIN_PD.VED :=2;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=21;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=2;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.023;
l_FIN_PD.K2 :=.026;
l_FIN_PD.VED :=2;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=22;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=2;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.026;
l_FIN_PD.K2 :=.029;
l_FIN_PD.VED :=2;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=23;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=2;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.029;
l_FIN_PD.K2 :=.033;
l_FIN_PD.VED :=2;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=31;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=2;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.033;
l_FIN_PD.K2 :=.036;
l_FIN_PD.VED :=2;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=32;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=2;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.036;
l_FIN_PD.K2 :=.039;
l_FIN_PD.VED :=2;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=33;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=5;
l_FIN_PD.IP5 :=3;
l_FIN_PD.K :=.039;
l_FIN_PD.K2 :=.039;
l_FIN_PD.VED :=2;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=2;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.04;
l_FIN_PD.K2 :=.042;
l_FIN_PD.VED :=2;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=2;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=2;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.042;
l_FIN_PD.K2 :=.043;
l_FIN_PD.VED :=2;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=3;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=2;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.043;
l_FIN_PD.K2 :=.045;
l_FIN_PD.VED :=2;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=11;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=2;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.045;
l_FIN_PD.K2 :=.047;
l_FIN_PD.VED :=2;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=12;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=2;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.047;
l_FIN_PD.K2 :=.048;
l_FIN_PD.VED :=2;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=13;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=2;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.048;
l_FIN_PD.K2 :=.05;
l_FIN_PD.VED :=2;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=21;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=2;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.05;
l_FIN_PD.K2 :=.052;
l_FIN_PD.VED :=2;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=22;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=2;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.052;
l_FIN_PD.K2 :=.054;
l_FIN_PD.VED :=2;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=23;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=2;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.054;
l_FIN_PD.K2 :=.056;
l_FIN_PD.VED :=2;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=31;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=2;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.056;
l_FIN_PD.K2 :=.058;
l_FIN_PD.VED :=2;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=32;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=2;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.058;
l_FIN_PD.K2 :=.06;
l_FIN_PD.VED :=2;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=33;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=5;
l_FIN_PD.IP5 :=3;
l_FIN_PD.K :=.06;
l_FIN_PD.K2 :=.06;
l_FIN_PD.VED :=2;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=2;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.07;
l_FIN_PD.K2 :=.072;
l_FIN_PD.VED :=2;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=2;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=2;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.072;
l_FIN_PD.K2 :=.073;
l_FIN_PD.VED :=2;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=3;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=2;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.073;
l_FIN_PD.K2 :=.075;
l_FIN_PD.VED :=2;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=11;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=2;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.075;
l_FIN_PD.K2 :=.077;
l_FIN_PD.VED :=2;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=12;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=2;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.077;
l_FIN_PD.K2 :=.078;
l_FIN_PD.VED :=2;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=13;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=2;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.078;
l_FIN_PD.K2 :=.08;
l_FIN_PD.VED :=2;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=21;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.08;
l_FIN_PD.K2 :=.082;
l_FIN_PD.VED :=2;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=22;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.082;
l_FIN_PD.K2 :=.084;
l_FIN_PD.VED :=2;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=23;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.084;
l_FIN_PD.K2 :=.086;
l_FIN_PD.VED :=2;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=31;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.086;
l_FIN_PD.K2 :=.088;
l_FIN_PD.VED :=2;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=32;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.088;
l_FIN_PD.K2 :=.09;
l_FIN_PD.VED :=2;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=33;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=5;
l_FIN_PD.IP5 :=3;
l_FIN_PD.K :=.09;
l_FIN_PD.K2 :=.09;
l_FIN_PD.VED :=2;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=5;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.1;
l_FIN_PD.K2 :=.103;
l_FIN_PD.VED :=2;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=5;
l_FIN_PD.VNCRR :=2;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.103;
l_FIN_PD.K2 :=.105;
l_FIN_PD.VED :=2;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=5;
l_FIN_PD.VNCRR :=3;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.105;
l_FIN_PD.K2 :=.108;
l_FIN_PD.VED :=2;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=5;
l_FIN_PD.VNCRR :=11;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.108;
l_FIN_PD.K2 :=.11;
l_FIN_PD.VED :=2;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=5;
l_FIN_PD.VNCRR :=12;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.11;
l_FIN_PD.K2 :=.113;
l_FIN_PD.VED :=2;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=5;
l_FIN_PD.VNCRR :=13;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.113;
l_FIN_PD.K2 :=.115;
l_FIN_PD.VED :=2;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=5;
l_FIN_PD.VNCRR :=21;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.115;
l_FIN_PD.K2 :=.118;
l_FIN_PD.VED :=2;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=5;
l_FIN_PD.VNCRR :=22;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.118;
l_FIN_PD.K2 :=.121;
l_FIN_PD.VED :=2;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=5;
l_FIN_PD.VNCRR :=23;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.121;
l_FIN_PD.K2 :=.124;
l_FIN_PD.VED :=2;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=5;
l_FIN_PD.VNCRR :=31;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.124;
l_FIN_PD.K2 :=.127;
l_FIN_PD.VED :=2;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=5;
l_FIN_PD.VNCRR :=32;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.127;
l_FIN_PD.K2 :=.13;
l_FIN_PD.VED :=2;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=5;
l_FIN_PD.VNCRR :=33;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=5;
l_FIN_PD.IP5 :=3;
l_FIN_PD.K :=.13;
l_FIN_PD.K2 :=.13;
l_FIN_PD.VED :=2;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=6;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.14;
l_FIN_PD.K2 :=.143;
l_FIN_PD.VED :=2;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=6;
l_FIN_PD.VNCRR :=2;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.143;
l_FIN_PD.K2 :=.145;
l_FIN_PD.VED :=2;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=6;
l_FIN_PD.VNCRR :=3;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.145;
l_FIN_PD.K2 :=.148;
l_FIN_PD.VED :=2;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=6;
l_FIN_PD.VNCRR :=11;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.148;
l_FIN_PD.K2 :=.15;
l_FIN_PD.VED :=2;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=6;
l_FIN_PD.VNCRR :=12;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.15;
l_FIN_PD.K2 :=.153;
l_FIN_PD.VED :=2;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=6;
l_FIN_PD.VNCRR :=13;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.153;
l_FIN_PD.K2 :=.155;
l_FIN_PD.VED :=2;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=6;
l_FIN_PD.VNCRR :=21;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.155;
l_FIN_PD.K2 :=.158;
l_FIN_PD.VED :=2;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=6;
l_FIN_PD.VNCRR :=22;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.158;
l_FIN_PD.K2 :=.161;
l_FIN_PD.VED :=2;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=6;
l_FIN_PD.VNCRR :=23;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.161;
l_FIN_PD.K2 :=.164;
l_FIN_PD.VED :=2;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=6;
l_FIN_PD.VNCRR :=31;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.164;
l_FIN_PD.K2 :=.167;
l_FIN_PD.VED :=2;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=6;
l_FIN_PD.VNCRR :=32;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.167;
l_FIN_PD.K2 :=.17;
l_FIN_PD.VED :=2;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=6;
l_FIN_PD.VNCRR :=33;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=5;
l_FIN_PD.IP5 :=3;
l_FIN_PD.K :=.17;
l_FIN_PD.K2 :=.17;
l_FIN_PD.VED :=2;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=7;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.18;
l_FIN_PD.K2 :=.185;
l_FIN_PD.VED :=2;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=7;
l_FIN_PD.VNCRR :=2;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.185;
l_FIN_PD.K2 :=.19;
l_FIN_PD.VED :=2;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=7;
l_FIN_PD.VNCRR :=3;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.19;
l_FIN_PD.K2 :=.195;
l_FIN_PD.VED :=2;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=7;
l_FIN_PD.VNCRR :=11;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.195;
l_FIN_PD.K2 :=.2;
l_FIN_PD.VED :=2;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=7;
l_FIN_PD.VNCRR :=12;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.2;
l_FIN_PD.K2 :=.205;
l_FIN_PD.VED :=2;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=7;
l_FIN_PD.VNCRR :=13;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.205;
l_FIN_PD.K2 :=.21;
l_FIN_PD.VED :=2;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=7;
l_FIN_PD.VNCRR :=21;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.21;
l_FIN_PD.K2 :=.216;
l_FIN_PD.VED :=2;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=7;
l_FIN_PD.VNCRR :=22;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.216;
l_FIN_PD.K2 :=.222;
l_FIN_PD.VED :=2;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=7;
l_FIN_PD.VNCRR :=23;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.222;
l_FIN_PD.K2 :=.228;
l_FIN_PD.VED :=2;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=7;
l_FIN_PD.VNCRR :=31;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.228;
l_FIN_PD.K2 :=.234;
l_FIN_PD.VED :=2;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=7;
l_FIN_PD.VNCRR :=32;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.234;
l_FIN_PD.K2 :=.24;
l_FIN_PD.VED :=2;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=7;
l_FIN_PD.VNCRR :=33;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=5;
l_FIN_PD.IP5 :=3;
l_FIN_PD.K :=.24;
l_FIN_PD.K2 :=.24;
l_FIN_PD.VED :=2;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=8;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.25;
l_FIN_PD.K2 :=.258;
l_FIN_PD.VED :=2;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=8;
l_FIN_PD.VNCRR :=2;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.258;
l_FIN_PD.K2 :=.265;
l_FIN_PD.VED :=2;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=8;
l_FIN_PD.VNCRR :=3;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.265;
l_FIN_PD.K2 :=.273;
l_FIN_PD.VED :=2;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=8;
l_FIN_PD.VNCRR :=11;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.273;
l_FIN_PD.K2 :=.28;
l_FIN_PD.VED :=2;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=8;
l_FIN_PD.VNCRR :=12;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.28;
l_FIN_PD.K2 :=.288;
l_FIN_PD.VED :=2;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=8;
l_FIN_PD.VNCRR :=13;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.288;
l_FIN_PD.K2 :=.295;
l_FIN_PD.VED :=2;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=8;
l_FIN_PD.VNCRR :=21;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.295;
l_FIN_PD.K2 :=.304;
l_FIN_PD.VED :=2;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=8;
l_FIN_PD.VNCRR :=22;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.304;
l_FIN_PD.K2 :=.313;
l_FIN_PD.VED :=2;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=8;
l_FIN_PD.VNCRR :=23;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.313;
l_FIN_PD.K2 :=.322;
l_FIN_PD.VED :=2;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=8;
l_FIN_PD.VNCRR :=31;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.322;
l_FIN_PD.K2 :=.331;
l_FIN_PD.VED :=2;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=8;
l_FIN_PD.VNCRR :=32;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.331;
l_FIN_PD.K2 :=.34;
l_FIN_PD.VED :=2;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=8;
l_FIN_PD.VNCRR :=33;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=5;
l_FIN_PD.IP5 :=3;
l_FIN_PD.K :=.34;
l_FIN_PD.K2 :=.34;
l_FIN_PD.VED :=2;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=9;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.35;
l_FIN_PD.K2 :=.403;
l_FIN_PD.VED :=2;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=9;
l_FIN_PD.VNCRR :=2;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.403;
l_FIN_PD.K2 :=.457;
l_FIN_PD.VED :=2;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=9;
l_FIN_PD.VNCRR :=3;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.457;
l_FIN_PD.K2 :=.51;
l_FIN_PD.VED :=2;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=9;
l_FIN_PD.VNCRR :=11;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.51;
l_FIN_PD.K2 :=.563;
l_FIN_PD.VED :=2;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=9;
l_FIN_PD.VNCRR :=12;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.563;
l_FIN_PD.K2 :=.617;
l_FIN_PD.VED :=2;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=9;
l_FIN_PD.VNCRR :=13;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.617;
l_FIN_PD.K2 :=.67;
l_FIN_PD.VED :=2;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=9;
l_FIN_PD.VNCRR :=21;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.67;
l_FIN_PD.K2 :=.734;
l_FIN_PD.VED :=2;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=9;
l_FIN_PD.VNCRR :=22;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.734;
l_FIN_PD.K2 :=.798;
l_FIN_PD.VED :=2;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=9;
l_FIN_PD.VNCRR :=23;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.798;
l_FIN_PD.K2 :=.862;
l_FIN_PD.VED :=2;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=9;
l_FIN_PD.VNCRR :=31;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.862;
l_FIN_PD.K2 :=.926;
l_FIN_PD.VED :=2;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=9;
l_FIN_PD.VNCRR :=32;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.926;
l_FIN_PD.K2 :=.99;
l_FIN_PD.VED :=2;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=9;
l_FIN_PD.VNCRR :=33;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=5;
l_FIN_PD.IP5 :=3;
l_FIN_PD.K :=.99;
l_FIN_PD.K2 :=.99;
l_FIN_PD.VED :=2;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=10;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=5;
l_FIN_PD.IP5 :=3;
l_FIN_PD.K :=1;
l_FIN_PD.K2 :=1;
l_FIN_PD.VED :=2;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=1;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.005;
l_FIN_PD.K2 :=.007;
l_FIN_PD.VED :=3;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=11;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=1;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.007;
l_FIN_PD.K2 :=.008;
l_FIN_PD.VED :=3;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=21;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=5;
l_FIN_PD.IP5 :=3;
l_FIN_PD.K :=.008;
l_FIN_PD.K2 :=.008;
l_FIN_PD.VED :=3;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=1;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.009;
l_FIN_PD.K2 :=.01;
l_FIN_PD.VED :=3;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=2;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=1;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.01;
l_FIN_PD.K2 :=.011;
l_FIN_PD.VED :=3;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=3;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=1;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.011;
l_FIN_PD.K2 :=.012;
l_FIN_PD.VED :=3;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=11;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=1;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.012;
l_FIN_PD.K2 :=.012;
l_FIN_PD.VED :=3;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=12;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=1;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.012;
l_FIN_PD.K2 :=.013;
l_FIN_PD.VED :=3;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=13;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=1;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.013;
l_FIN_PD.K2 :=.014;
l_FIN_PD.VED :=3;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=21;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=2;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.014;
l_FIN_PD.K2 :=.015;
l_FIN_PD.VED :=3;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=22;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=2;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.015;
l_FIN_PD.K2 :=.016;
l_FIN_PD.VED :=3;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=23;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=2;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.016;
l_FIN_PD.K2 :=.017;
l_FIN_PD.VED :=3;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=31;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=2;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.017;
l_FIN_PD.K2 :=.018;
l_FIN_PD.VED :=3;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=32;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=2;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.018;
l_FIN_PD.K2 :=.019;
l_FIN_PD.VED :=3;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=33;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=5;
l_FIN_PD.IP5 :=3;
l_FIN_PD.K :=.019;
l_FIN_PD.K2 :=.019;
l_FIN_PD.VED :=3;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=2;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.02;
l_FIN_PD.K2 :=.022;
l_FIN_PD.VED :=3;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=2;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=2;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.022;
l_FIN_PD.K2 :=.023;
l_FIN_PD.VED :=3;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=3;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=2;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.023;
l_FIN_PD.K2 :=.025;
l_FIN_PD.VED :=3;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=11;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=2;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.025;
l_FIN_PD.K2 :=.027;
l_FIN_PD.VED :=3;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=12;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=2;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.027;
l_FIN_PD.K2 :=.028;
l_FIN_PD.VED :=3;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=13;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=2;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.028;
l_FIN_PD.K2 :=.03;
l_FIN_PD.VED :=3;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=21;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=2;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.03;
l_FIN_PD.K2 :=.032;
l_FIN_PD.VED :=3;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=22;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=2;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.032;
l_FIN_PD.K2 :=.034;
l_FIN_PD.VED :=3;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=23;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=2;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.034;
l_FIN_PD.K2 :=.036;
l_FIN_PD.VED :=3;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=31;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=2;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.036;
l_FIN_PD.K2 :=.038;
l_FIN_PD.VED :=3;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=32;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=2;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.038;
l_FIN_PD.K2 :=.04;
l_FIN_PD.VED :=3;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=33;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=5;
l_FIN_PD.IP5 :=3;
l_FIN_PD.K :=.04;
l_FIN_PD.K2 :=.04;
l_FIN_PD.VED :=3;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=2;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.05;
l_FIN_PD.K2 :=.051;
l_FIN_PD.VED :=3;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=2;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=2;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.051;
l_FIN_PD.K2 :=.052;
l_FIN_PD.VED :=3;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=3;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=2;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.052;
l_FIN_PD.K2 :=.053;
l_FIN_PD.VED :=3;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=11;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=2;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.053;
l_FIN_PD.K2 :=.053;
l_FIN_PD.VED :=3;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=12;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=2;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.053;
l_FIN_PD.K2 :=.054;
l_FIN_PD.VED :=3;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=13;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=2;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.054;
l_FIN_PD.K2 :=.055;
l_FIN_PD.VED :=3;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=21;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.055;
l_FIN_PD.K2 :=.056;
l_FIN_PD.VED :=3;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=22;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.056;
l_FIN_PD.K2 :=.057;
l_FIN_PD.VED :=3;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=23;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.057;
l_FIN_PD.K2 :=.058;
l_FIN_PD.VED :=3;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=31;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.058;
l_FIN_PD.K2 :=.059;
l_FIN_PD.VED :=3;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=32;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.059;
l_FIN_PD.K2 :=.06;
l_FIN_PD.VED :=3;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=33;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=5;
l_FIN_PD.IP5 :=3;
l_FIN_PD.K :=.06;
l_FIN_PD.K2 :=.06;
l_FIN_PD.VED :=3;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=5;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.07;
l_FIN_PD.K2 :=.073;
l_FIN_PD.VED :=3;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=5;
l_FIN_PD.VNCRR :=2;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.073;
l_FIN_PD.K2 :=.077;
l_FIN_PD.VED :=3;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=5;
l_FIN_PD.VNCRR :=3;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.077;
l_FIN_PD.K2 :=.08;
l_FIN_PD.VED :=3;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=5;
l_FIN_PD.VNCRR :=11;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.08;
l_FIN_PD.K2 :=.083;
l_FIN_PD.VED :=3;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=5;
l_FIN_PD.VNCRR :=12;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.083;
l_FIN_PD.K2 :=.087;
l_FIN_PD.VED :=3;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=5;
l_FIN_PD.VNCRR :=13;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.087;
l_FIN_PD.K2 :=.09;
l_FIN_PD.VED :=3;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=5;
l_FIN_PD.VNCRR :=21;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.09;
l_FIN_PD.K2 :=.094;
l_FIN_PD.VED :=3;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=5;
l_FIN_PD.VNCRR :=22;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.094;
l_FIN_PD.K2 :=.098;
l_FIN_PD.VED :=3;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=5;
l_FIN_PD.VNCRR :=23;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.098;
l_FIN_PD.K2 :=.102;
l_FIN_PD.VED :=3;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=5;
l_FIN_PD.VNCRR :=31;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.102;
l_FIN_PD.K2 :=.106;
l_FIN_PD.VED :=3;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=5;
l_FIN_PD.VNCRR :=32;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.106;
l_FIN_PD.K2 :=.11;
l_FIN_PD.VED :=3;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=5;
l_FIN_PD.VNCRR :=33;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=5;
l_FIN_PD.IP5 :=3;
l_FIN_PD.K :=.11;
l_FIN_PD.K2 :=.11;
l_FIN_PD.VED :=3;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=6;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.12;
l_FIN_PD.K2 :=.124;
l_FIN_PD.VED :=3;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=6;
l_FIN_PD.VNCRR :=2;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.124;
l_FIN_PD.K2 :=.128;
l_FIN_PD.VED :=3;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=6;
l_FIN_PD.VNCRR :=3;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.128;
l_FIN_PD.K2 :=.133;
l_FIN_PD.VED :=3;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=6;
l_FIN_PD.VNCRR :=11;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.133;
l_FIN_PD.K2 :=.137;
l_FIN_PD.VED :=3;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=6;
l_FIN_PD.VNCRR :=12;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.137;
l_FIN_PD.K2 :=.141;
l_FIN_PD.VED :=3;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=6;
l_FIN_PD.VNCRR :=13;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.141;
l_FIN_PD.K2 :=.145;
l_FIN_PD.VED :=3;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=6;
l_FIN_PD.VNCRR :=21;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.145;
l_FIN_PD.K2 :=.15;
l_FIN_PD.VED :=3;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=6;
l_FIN_PD.VNCRR :=22;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.15;
l_FIN_PD.K2 :=.155;
l_FIN_PD.VED :=3;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=6;
l_FIN_PD.VNCRR :=23;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.155;
l_FIN_PD.K2 :=.16;
l_FIN_PD.VED :=3;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=6;
l_FIN_PD.VNCRR :=31;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.16;
l_FIN_PD.K2 :=.165;
l_FIN_PD.VED :=3;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=6;
l_FIN_PD.VNCRR :=32;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.165;
l_FIN_PD.K2 :=.17;
l_FIN_PD.VED :=3;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=6;
l_FIN_PD.VNCRR :=33;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=5;
l_FIN_PD.IP5 :=3;
l_FIN_PD.K :=.17;
l_FIN_PD.K2 :=.17;
l_FIN_PD.VED :=3;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=7;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.18;
l_FIN_PD.K2 :=.185;
l_FIN_PD.VED :=3;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=7;
l_FIN_PD.VNCRR :=2;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.185;
l_FIN_PD.K2 :=.19;
l_FIN_PD.VED :=3;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=7;
l_FIN_PD.VNCRR :=3;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.19;
l_FIN_PD.K2 :=.195;
l_FIN_PD.VED :=3;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=7;
l_FIN_PD.VNCRR :=11;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.195;
l_FIN_PD.K2 :=.2;
l_FIN_PD.VED :=3;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=7;
l_FIN_PD.VNCRR :=12;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.2;
l_FIN_PD.K2 :=.205;
l_FIN_PD.VED :=3;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=7;
l_FIN_PD.VNCRR :=13;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.205;
l_FIN_PD.K2 :=.21;
l_FIN_PD.VED :=3;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=7;
l_FIN_PD.VNCRR :=21;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.21;
l_FIN_PD.K2 :=.216;
l_FIN_PD.VED :=3;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=7;
l_FIN_PD.VNCRR :=22;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.216;
l_FIN_PD.K2 :=.222;
l_FIN_PD.VED :=3;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=7;
l_FIN_PD.VNCRR :=23;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.222;
l_FIN_PD.K2 :=.228;
l_FIN_PD.VED :=3;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=7;
l_FIN_PD.VNCRR :=31;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.228;
l_FIN_PD.K2 :=.234;
l_FIN_PD.VED :=3;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=7;
l_FIN_PD.VNCRR :=32;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.234;
l_FIN_PD.K2 :=.24;
l_FIN_PD.VED :=3;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=7;
l_FIN_PD.VNCRR :=33;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=5;
l_FIN_PD.IP5 :=3;
l_FIN_PD.K :=.24;
l_FIN_PD.K2 :=.24;
l_FIN_PD.VED :=3;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=8;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.25;
l_FIN_PD.K2 :=.258;
l_FIN_PD.VED :=3;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=8;
l_FIN_PD.VNCRR :=2;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.258;
l_FIN_PD.K2 :=.265;
l_FIN_PD.VED :=3;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=8;
l_FIN_PD.VNCRR :=3;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.265;
l_FIN_PD.K2 :=.273;
l_FIN_PD.VED :=3;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=8;
l_FIN_PD.VNCRR :=11;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.273;
l_FIN_PD.K2 :=.28;
l_FIN_PD.VED :=3;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=8;
l_FIN_PD.VNCRR :=12;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.28;
l_FIN_PD.K2 :=.288;
l_FIN_PD.VED :=3;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=8;
l_FIN_PD.VNCRR :=13;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.288;
l_FIN_PD.K2 :=.295;
l_FIN_PD.VED :=3;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=8;
l_FIN_PD.VNCRR :=21;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.295;
l_FIN_PD.K2 :=.304;
l_FIN_PD.VED :=3;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=8;
l_FIN_PD.VNCRR :=22;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.304;
l_FIN_PD.K2 :=.313;
l_FIN_PD.VED :=3;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=8;
l_FIN_PD.VNCRR :=23;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.313;
l_FIN_PD.K2 :=.322;
l_FIN_PD.VED :=3;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=8;
l_FIN_PD.VNCRR :=31;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.322;
l_FIN_PD.K2 :=.331;
l_FIN_PD.VED :=3;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=8;
l_FIN_PD.VNCRR :=32;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.331;
l_FIN_PD.K2 :=.34;
l_FIN_PD.VED :=3;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=8;
l_FIN_PD.VNCRR :=33;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=5;
l_FIN_PD.IP5 :=3;
l_FIN_PD.K :=.34;
l_FIN_PD.K2 :=.34;
l_FIN_PD.VED :=3;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=9;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.35;
l_FIN_PD.K2 :=.403;
l_FIN_PD.VED :=3;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=9;
l_FIN_PD.VNCRR :=2;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.403;
l_FIN_PD.K2 :=.457;
l_FIN_PD.VED :=3;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=9;
l_FIN_PD.VNCRR :=3;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.457;
l_FIN_PD.K2 :=.51;
l_FIN_PD.VED :=3;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=9;
l_FIN_PD.VNCRR :=11;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.51;
l_FIN_PD.K2 :=.563;
l_FIN_PD.VED :=3;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=9;
l_FIN_PD.VNCRR :=12;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.563;
l_FIN_PD.K2 :=.617;
l_FIN_PD.VED :=3;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=9;
l_FIN_PD.VNCRR :=13;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.617;
l_FIN_PD.K2 :=.67;
l_FIN_PD.VED :=3;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=9;
l_FIN_PD.VNCRR :=21;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.67;
l_FIN_PD.K2 :=.734;
l_FIN_PD.VED :=3;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=9;
l_FIN_PD.VNCRR :=22;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.734;
l_FIN_PD.K2 :=.798;
l_FIN_PD.VED :=3;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=9;
l_FIN_PD.VNCRR :=23;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.798;
l_FIN_PD.K2 :=.862;
l_FIN_PD.VED :=3;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=9;
l_FIN_PD.VNCRR :=31;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.862;
l_FIN_PD.K2 :=.926;
l_FIN_PD.VED :=3;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=9;
l_FIN_PD.VNCRR :=32;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.926;
l_FIN_PD.K2 :=.99;
l_FIN_PD.VED :=3;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=9;
l_FIN_PD.VNCRR :=33;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=5;
l_FIN_PD.IP5 :=3;
l_FIN_PD.K :=.99;
l_FIN_PD.K2 :=.99;
l_FIN_PD.VED :=3;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=10;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=5;
l_FIN_PD.IP5 :=3;
l_FIN_PD.K :=1;
l_FIN_PD.K2 :=1;
l_FIN_PD.VED :=3;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=1;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.005;
l_FIN_PD.K2 :=.006;
l_FIN_PD.VED :=4;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=3;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=1;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.006;
l_FIN_PD.K2 :=.007;
l_FIN_PD.VED :=4;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=21;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=1;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.007;
l_FIN_PD.K2 :=.012;
l_FIN_PD.VED :=4;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=22;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=1;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.012;
l_FIN_PD.K2 :=.017;
l_FIN_PD.VED :=4;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=23;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=1;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.017;
l_FIN_PD.K2 :=.023;
l_FIN_PD.VED :=4;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=31;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=1;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.023;
l_FIN_PD.K2 :=.028;
l_FIN_PD.VED :=4;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=32;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=1;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.028;
l_FIN_PD.K2 :=.033;
l_FIN_PD.VED :=4;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=33;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=5;
l_FIN_PD.IP5 :=3;
l_FIN_PD.K :=.033;
l_FIN_PD.K2 :=.033;
l_FIN_PD.VED :=4;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=1;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.034;
l_FIN_PD.K2 :=.035;
l_FIN_PD.VED :=4;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=2;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=1;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.035;
l_FIN_PD.K2 :=.037;
l_FIN_PD.VED :=4;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=3;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=1;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.037;
l_FIN_PD.K2 :=.038;
l_FIN_PD.VED :=4;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=11;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=1;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.038;
l_FIN_PD.K2 :=.039;
l_FIN_PD.VED :=4;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=12;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=1;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.039;
l_FIN_PD.K2 :=.041;
l_FIN_PD.VED :=4;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=13;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=1;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.041;
l_FIN_PD.K2 :=.042;
l_FIN_PD.VED :=4;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=21;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=2;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.042;
l_FIN_PD.K2 :=.043;
l_FIN_PD.VED :=4;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=22;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=2;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.043;
l_FIN_PD.K2 :=.045;
l_FIN_PD.VED :=4;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=23;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=2;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.045;
l_FIN_PD.K2 :=.046;
l_FIN_PD.VED :=4;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=31;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=2;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.046;
l_FIN_PD.K2 :=.048;
l_FIN_PD.VED :=4;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=32;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=2;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.048;
l_FIN_PD.K2 :=.049;
l_FIN_PD.VED :=4;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=33;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=5;
l_FIN_PD.IP5 :=3;
l_FIN_PD.K :=.049;
l_FIN_PD.K2 :=.049;
l_FIN_PD.VED :=4;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=2;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.05;
l_FIN_PD.K2 :=.051;
l_FIN_PD.VED :=4;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=2;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=2;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.051;
l_FIN_PD.K2 :=.052;
l_FIN_PD.VED :=4;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=3;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=2;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.052;
l_FIN_PD.K2 :=.053;
l_FIN_PD.VED :=4;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=11;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=2;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.053;
l_FIN_PD.K2 :=.053;
l_FIN_PD.VED :=4;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=12;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=2;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.053;
l_FIN_PD.K2 :=.054;
l_FIN_PD.VED :=4;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=13;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=2;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.054;
l_FIN_PD.K2 :=.055;
l_FIN_PD.VED :=4;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=21;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=2;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.055;
l_FIN_PD.K2 :=.056;
l_FIN_PD.VED :=4;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=22;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=2;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.056;
l_FIN_PD.K2 :=.057;
l_FIN_PD.VED :=4;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=23;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=2;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.057;
l_FIN_PD.K2 :=.057;
l_FIN_PD.VED :=4;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=31;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=2;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.057;
l_FIN_PD.K2 :=.058;
l_FIN_PD.VED :=4;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=32;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=2;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.058;
l_FIN_PD.K2 :=.059;
l_FIN_PD.VED :=4;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=33;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=5;
l_FIN_PD.IP5 :=3;
l_FIN_PD.K :=.059;
l_FIN_PD.K2 :=.059;
l_FIN_PD.VED :=4;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=2;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.06;
l_FIN_PD.K2 :=.061;
l_FIN_PD.VED :=4;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=2;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=2;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.061;
l_FIN_PD.K2 :=.062;
l_FIN_PD.VED :=4;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=3;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=2;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.062;
l_FIN_PD.K2 :=.063;
l_FIN_PD.VED :=4;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=11;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=2;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.063;
l_FIN_PD.K2 :=.063;
l_FIN_PD.VED :=4;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=12;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=2;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.063;
l_FIN_PD.K2 :=.064;
l_FIN_PD.VED :=4;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=13;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=2;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.064;
l_FIN_PD.K2 :=.065;
l_FIN_PD.VED :=4;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=21;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.065;
l_FIN_PD.K2 :=.066;
l_FIN_PD.VED :=4;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=22;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.066;
l_FIN_PD.K2 :=.067;
l_FIN_PD.VED :=4;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=23;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.067;
l_FIN_PD.K2 :=.068;
l_FIN_PD.VED :=4;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=31;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.068;
l_FIN_PD.K2 :=.069;
l_FIN_PD.VED :=4;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=32;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.069;
l_FIN_PD.K2 :=.07;
l_FIN_PD.VED :=4;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=33;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=5;
l_FIN_PD.IP5 :=3;
l_FIN_PD.K :=.07;
l_FIN_PD.K2 :=.07;
l_FIN_PD.VED :=4;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=5;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.08;
l_FIN_PD.K2 :=.081;
l_FIN_PD.VED :=4;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=5;
l_FIN_PD.VNCRR :=2;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.081;
l_FIN_PD.K2 :=.082;
l_FIN_PD.VED :=4;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=5;
l_FIN_PD.VNCRR :=3;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.082;
l_FIN_PD.K2 :=.083;
l_FIN_PD.VED :=4;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=5;
l_FIN_PD.VNCRR :=11;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.083;
l_FIN_PD.K2 :=.083;
l_FIN_PD.VED :=4;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=5;
l_FIN_PD.VNCRR :=12;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.083;
l_FIN_PD.K2 :=.084;
l_FIN_PD.VED :=4;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=5;
l_FIN_PD.VNCRR :=13;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.084;
l_FIN_PD.K2 :=.085;
l_FIN_PD.VED :=4;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=5;
l_FIN_PD.VNCRR :=21;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.085;
l_FIN_PD.K2 :=.086;
l_FIN_PD.VED :=4;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=5;
l_FIN_PD.VNCRR :=22;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.086;
l_FIN_PD.K2 :=.087;
l_FIN_PD.VED :=4;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=5;
l_FIN_PD.VNCRR :=23;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.087;
l_FIN_PD.K2 :=.088;
l_FIN_PD.VED :=4;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=5;
l_FIN_PD.VNCRR :=31;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.088;
l_FIN_PD.K2 :=.089;
l_FIN_PD.VED :=4;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=5;
l_FIN_PD.VNCRR :=32;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.089;
l_FIN_PD.K2 :=.09;
l_FIN_PD.VED :=4;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=5;
l_FIN_PD.VNCRR :=33;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=5;
l_FIN_PD.IP5 :=3;
l_FIN_PD.K :=.09;
l_FIN_PD.K2 :=.09;
l_FIN_PD.VED :=4;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=6;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.1;
l_FIN_PD.K2 :=.102;
l_FIN_PD.VED :=4;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=6;
l_FIN_PD.VNCRR :=2;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.102;
l_FIN_PD.K2 :=.103;
l_FIN_PD.VED :=4;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=6;
l_FIN_PD.VNCRR :=3;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.103;
l_FIN_PD.K2 :=.105;
l_FIN_PD.VED :=4;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=6;
l_FIN_PD.VNCRR :=11;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.105;
l_FIN_PD.K2 :=.107;
l_FIN_PD.VED :=4;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=6;
l_FIN_PD.VNCRR :=12;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.107;
l_FIN_PD.K2 :=.108;
l_FIN_PD.VED :=4;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=6;
l_FIN_PD.VNCRR :=13;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.108;
l_FIN_PD.K2 :=.11;
l_FIN_PD.VED :=4;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=6;
l_FIN_PD.VNCRR :=21;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.11;
l_FIN_PD.K2 :=.112;
l_FIN_PD.VED :=4;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=6;
l_FIN_PD.VNCRR :=22;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.112;
l_FIN_PD.K2 :=.114;
l_FIN_PD.VED :=4;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=6;
l_FIN_PD.VNCRR :=23;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.114;
l_FIN_PD.K2 :=.116;
l_FIN_PD.VED :=4;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=6;
l_FIN_PD.VNCRR :=31;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.116;
l_FIN_PD.K2 :=.118;
l_FIN_PD.VED :=4;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=6;
l_FIN_PD.VNCRR :=32;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.118;
l_FIN_PD.K2 :=.12;
l_FIN_PD.VED :=4;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=6;
l_FIN_PD.VNCRR :=33;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=5;
l_FIN_PD.IP5 :=3;
l_FIN_PD.K :=.12;
l_FIN_PD.K2 :=.12;
l_FIN_PD.VED :=4;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=7;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.13;
l_FIN_PD.K2 :=.133;
l_FIN_PD.VED :=4;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=7;
l_FIN_PD.VNCRR :=2;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.133;
l_FIN_PD.K2 :=.135;
l_FIN_PD.VED :=4;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=7;
l_FIN_PD.VNCRR :=3;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.135;
l_FIN_PD.K2 :=.138;
l_FIN_PD.VED :=4;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=7;
l_FIN_PD.VNCRR :=11;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.138;
l_FIN_PD.K2 :=.14;
l_FIN_PD.VED :=4;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=7;
l_FIN_PD.VNCRR :=12;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.14;
l_FIN_PD.K2 :=.143;
l_FIN_PD.VED :=4;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=7;
l_FIN_PD.VNCRR :=13;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.143;
l_FIN_PD.K2 :=.145;
l_FIN_PD.VED :=4;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=7;
l_FIN_PD.VNCRR :=21;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.145;
l_FIN_PD.K2 :=.148;
l_FIN_PD.VED :=4;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=7;
l_FIN_PD.VNCRR :=22;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.148;
l_FIN_PD.K2 :=.151;
l_FIN_PD.VED :=4;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=7;
l_FIN_PD.VNCRR :=23;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.151;
l_FIN_PD.K2 :=.154;
l_FIN_PD.VED :=4;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=7;
l_FIN_PD.VNCRR :=31;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.154;
l_FIN_PD.K2 :=.157;
l_FIN_PD.VED :=4;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=7;
l_FIN_PD.VNCRR :=32;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.157;
l_FIN_PD.K2 :=.16;
l_FIN_PD.VED :=4;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=7;
l_FIN_PD.VNCRR :=33;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=5;
l_FIN_PD.IP5 :=3;
l_FIN_PD.K :=.16;
l_FIN_PD.K2 :=.16;
l_FIN_PD.VED :=4;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=8;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.17;
l_FIN_PD.K2 :=.175;
l_FIN_PD.VED :=4;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=8;
l_FIN_PD.VNCRR :=2;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.175;
l_FIN_PD.K2 :=.18;
l_FIN_PD.VED :=4;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=8;
l_FIN_PD.VNCRR :=3;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.18;
l_FIN_PD.K2 :=.185;
l_FIN_PD.VED :=4;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=8;
l_FIN_PD.VNCRR :=11;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.185;
l_FIN_PD.K2 :=.19;
l_FIN_PD.VED :=4;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=8;
l_FIN_PD.VNCRR :=12;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.19;
l_FIN_PD.K2 :=.195;
l_FIN_PD.VED :=4;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=8;
l_FIN_PD.VNCRR :=13;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.195;
l_FIN_PD.K2 :=.2;
l_FIN_PD.VED :=4;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=8;
l_FIN_PD.VNCRR :=21;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.2;
l_FIN_PD.K2 :=.206;
l_FIN_PD.VED :=4;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=8;
l_FIN_PD.VNCRR :=22;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.206;
l_FIN_PD.K2 :=.212;
l_FIN_PD.VED :=4;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=8;
l_FIN_PD.VNCRR :=23;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.212;
l_FIN_PD.K2 :=.218;
l_FIN_PD.VED :=4;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=8;
l_FIN_PD.VNCRR :=31;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.218;
l_FIN_PD.K2 :=.224;
l_FIN_PD.VED :=4;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=8;
l_FIN_PD.VNCRR :=32;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.224;
l_FIN_PD.K2 :=.23;
l_FIN_PD.VED :=4;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=8;
l_FIN_PD.VNCRR :=33;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=5;
l_FIN_PD.IP5 :=3;
l_FIN_PD.K :=.23;
l_FIN_PD.K2 :=.23;
l_FIN_PD.VED :=4;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=9;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.24;
l_FIN_PD.K2 :=.303;
l_FIN_PD.VED :=4;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=9;
l_FIN_PD.VNCRR :=2;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.303;
l_FIN_PD.K2 :=.365;
l_FIN_PD.VED :=4;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=9;
l_FIN_PD.VNCRR :=3;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.365;
l_FIN_PD.K2 :=.428;
l_FIN_PD.VED :=4;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=9;
l_FIN_PD.VNCRR :=11;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.428;
l_FIN_PD.K2 :=.49;
l_FIN_PD.VED :=4;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=9;
l_FIN_PD.VNCRR :=12;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.49;
l_FIN_PD.K2 :=.553;
l_FIN_PD.VED :=4;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=9;
l_FIN_PD.VNCRR :=13;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.553;
l_FIN_PD.K2 :=.615;
l_FIN_PD.VED :=4;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=9;
l_FIN_PD.VNCRR :=21;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.615;
l_FIN_PD.K2 :=.69;
l_FIN_PD.VED :=4;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=9;
l_FIN_PD.VNCRR :=22;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.69;
l_FIN_PD.K2 :=.765;
l_FIN_PD.VED :=4;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=9;
l_FIN_PD.VNCRR :=23;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.765;
l_FIN_PD.K2 :=.84;
l_FIN_PD.VED :=4;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=9;
l_FIN_PD.VNCRR :=31;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.84;
l_FIN_PD.K2 :=.915;
l_FIN_PD.VED :=4;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=9;
l_FIN_PD.VNCRR :=32;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.915;
l_FIN_PD.K2 :=.99;
l_FIN_PD.VED :=4;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=9;
l_FIN_PD.VNCRR :=33;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=5;
l_FIN_PD.IP5 :=3;
l_FIN_PD.K :=.99;
l_FIN_PD.K2 :=.99;
l_FIN_PD.VED :=4;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=10;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=5;
l_FIN_PD.IP5 :=3;
l_FIN_PD.K :=1;
l_FIN_PD.K2 :=1;
l_FIN_PD.VED :=4;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=1;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.005;
l_FIN_PD.K2 :=.006;
l_FIN_PD.VED :=5;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=2;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=1;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.006;
l_FIN_PD.K2 :=.007;
l_FIN_PD.VED :=5;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=3;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=1;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.007;
l_FIN_PD.K2 :=.008;
l_FIN_PD.VED :=5;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=11;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=1;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.008;
l_FIN_PD.K2 :=.009;
l_FIN_PD.VED :=5;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=13;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=1;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.009;
l_FIN_PD.K2 :=.01;
l_FIN_PD.VED :=5;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=21;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=1;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.01;
l_FIN_PD.K2 :=.011;
l_FIN_PD.VED :=5;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=22;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=1;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.011;
l_FIN_PD.K2 :=.012;
l_FIN_PD.VED :=5;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=23;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=1;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.012;
l_FIN_PD.K2 :=.013;
l_FIN_PD.VED :=5;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=31;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=1;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.013;
l_FIN_PD.K2 :=.014;
l_FIN_PD.VED :=5;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=32;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=1;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.014;
l_FIN_PD.K2 :=.015;
l_FIN_PD.VED :=5;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=33;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=5;
l_FIN_PD.IP5 :=3;
l_FIN_PD.K :=.015;
l_FIN_PD.K2 :=.015;
l_FIN_PD.VED :=5;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=1;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.016;
l_FIN_PD.K2 :=.017;
l_FIN_PD.VED :=5;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=2;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=1;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.017;
l_FIN_PD.K2 :=.018;
l_FIN_PD.VED :=5;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=3;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=1;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.018;
l_FIN_PD.K2 :=.02;
l_FIN_PD.VED :=5;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=11;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=1;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.02;
l_FIN_PD.K2 :=.021;
l_FIN_PD.VED :=5;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=12;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=1;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.021;
l_FIN_PD.K2 :=.022;
l_FIN_PD.VED :=5;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=13;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=1;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.022;
l_FIN_PD.K2 :=.023;
l_FIN_PD.VED :=5;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=21;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=2;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.023;
l_FIN_PD.K2 :=.024;
l_FIN_PD.VED :=5;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=22;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=2;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.024;
l_FIN_PD.K2 :=.025;
l_FIN_PD.VED :=5;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=23;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=2;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.025;
l_FIN_PD.K2 :=.027;
l_FIN_PD.VED :=5;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=31;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=2;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.027;
l_FIN_PD.K2 :=.028;
l_FIN_PD.VED :=5;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=32;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=2;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.028;
l_FIN_PD.K2 :=.029;
l_FIN_PD.VED :=5;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=33;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=5;
l_FIN_PD.IP5 :=3;
l_FIN_PD.K :=.029;
l_FIN_PD.K2 :=.029;
l_FIN_PD.VED :=5;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=2;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.03;
l_FIN_PD.K2 :=.031;
l_FIN_PD.VED :=5;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=2;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=2;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.031;
l_FIN_PD.K2 :=.032;
l_FIN_PD.VED :=5;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=3;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=2;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.032;
l_FIN_PD.K2 :=.033;
l_FIN_PD.VED :=5;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=11;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=2;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.033;
l_FIN_PD.K2 :=.033;
l_FIN_PD.VED :=5;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=12;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=2;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.033;
l_FIN_PD.K2 :=.034;
l_FIN_PD.VED :=5;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=13;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=2;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.034;
l_FIN_PD.K2 :=.035;
l_FIN_PD.VED :=5;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=21;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=2;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.035;
l_FIN_PD.K2 :=.036;
l_FIN_PD.VED :=5;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=22;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=2;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.036;
l_FIN_PD.K2 :=.037;
l_FIN_PD.VED :=5;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=23;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=2;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.037;
l_FIN_PD.K2 :=.038;
l_FIN_PD.VED :=5;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=31;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=2;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.038;
l_FIN_PD.K2 :=.039;
l_FIN_PD.VED :=5;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=32;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=2;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.039;
l_FIN_PD.K2 :=.04;
l_FIN_PD.VED :=5;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=33;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=5;
l_FIN_PD.IP5 :=3;
l_FIN_PD.K :=.04;
l_FIN_PD.K2 :=.04;
l_FIN_PD.VED :=5;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=2;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.05;
l_FIN_PD.K2 :=.052;
l_FIN_PD.VED :=5;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=2;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=2;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.052;
l_FIN_PD.K2 :=.053;
l_FIN_PD.VED :=5;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=3;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=2;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.053;
l_FIN_PD.K2 :=.055;
l_FIN_PD.VED :=5;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=11;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=2;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.055;
l_FIN_PD.K2 :=.057;
l_FIN_PD.VED :=5;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=12;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=2;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.057;
l_FIN_PD.K2 :=.058;
l_FIN_PD.VED :=5;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=13;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=2;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.058;
l_FIN_PD.K2 :=.06;
l_FIN_PD.VED :=5;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=21;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.06;
l_FIN_PD.K2 :=.062;
l_FIN_PD.VED :=5;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=22;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.062;
l_FIN_PD.K2 :=.064;
l_FIN_PD.VED :=5;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=23;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.064;
l_FIN_PD.K2 :=.066;
l_FIN_PD.VED :=5;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=31;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.066;
l_FIN_PD.K2 :=.068;
l_FIN_PD.VED :=5;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=32;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.068;
l_FIN_PD.K2 :=.07;
l_FIN_PD.VED :=5;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=33;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=5;
l_FIN_PD.IP5 :=3;
l_FIN_PD.K :=.07;
l_FIN_PD.K2 :=.07;
l_FIN_PD.VED :=5;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=5;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.08;
l_FIN_PD.K2 :=.083;
l_FIN_PD.VED :=5;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=5;
l_FIN_PD.VNCRR :=2;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.083;
l_FIN_PD.K2 :=.085;
l_FIN_PD.VED :=5;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=5;
l_FIN_PD.VNCRR :=3;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.085;
l_FIN_PD.K2 :=.088;
l_FIN_PD.VED :=5;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=5;
l_FIN_PD.VNCRR :=11;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.088;
l_FIN_PD.K2 :=.09;
l_FIN_PD.VED :=5;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=5;
l_FIN_PD.VNCRR :=12;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.09;
l_FIN_PD.K2 :=.093;
l_FIN_PD.VED :=5;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=5;
l_FIN_PD.VNCRR :=13;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.093;
l_FIN_PD.K2 :=.095;
l_FIN_PD.VED :=5;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=5;
l_FIN_PD.VNCRR :=21;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.095;
l_FIN_PD.K2 :=.098;
l_FIN_PD.VED :=5;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=5;
l_FIN_PD.VNCRR :=22;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.098;
l_FIN_PD.K2 :=.101;
l_FIN_PD.VED :=5;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=5;
l_FIN_PD.VNCRR :=23;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.101;
l_FIN_PD.K2 :=.104;
l_FIN_PD.VED :=5;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=5;
l_FIN_PD.VNCRR :=31;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.104;
l_FIN_PD.K2 :=.107;
l_FIN_PD.VED :=5;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=5;
l_FIN_PD.VNCRR :=32;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.107;
l_FIN_PD.K2 :=.11;
l_FIN_PD.VED :=5;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=5;
l_FIN_PD.VNCRR :=33;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=5;
l_FIN_PD.IP5 :=3;
l_FIN_PD.K :=.11;
l_FIN_PD.K2 :=.11;
l_FIN_PD.VED :=5;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=6;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.12;
l_FIN_PD.K2 :=.123;
l_FIN_PD.VED :=5;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=6;
l_FIN_PD.VNCRR :=2;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.123;
l_FIN_PD.K2 :=.127;
l_FIN_PD.VED :=5;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=6;
l_FIN_PD.VNCRR :=3;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.127;
l_FIN_PD.K2 :=.13;
l_FIN_PD.VED :=5;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=6;
l_FIN_PD.VNCRR :=11;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.13;
l_FIN_PD.K2 :=.133;
l_FIN_PD.VED :=5;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=6;
l_FIN_PD.VNCRR :=12;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.133;
l_FIN_PD.K2 :=.137;
l_FIN_PD.VED :=5;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=6;
l_FIN_PD.VNCRR :=13;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.137;
l_FIN_PD.K2 :=.14;
l_FIN_PD.VED :=5;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=6;
l_FIN_PD.VNCRR :=21;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.14;
l_FIN_PD.K2 :=.144;
l_FIN_PD.VED :=5;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=6;
l_FIN_PD.VNCRR :=22;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.144;
l_FIN_PD.K2 :=.148;
l_FIN_PD.VED :=5;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=6;
l_FIN_PD.VNCRR :=23;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.148;
l_FIN_PD.K2 :=.152;
l_FIN_PD.VED :=5;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=6;
l_FIN_PD.VNCRR :=31;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.152;
l_FIN_PD.K2 :=.156;
l_FIN_PD.VED :=5;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=6;
l_FIN_PD.VNCRR :=32;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.156;
l_FIN_PD.K2 :=.16;
l_FIN_PD.VED :=5;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=6;
l_FIN_PD.VNCRR :=33;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=5;
l_FIN_PD.IP5 :=3;
l_FIN_PD.K :=.16;
l_FIN_PD.K2 :=.16;
l_FIN_PD.VED :=5;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=7;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.17;
l_FIN_PD.K2 :=.175;
l_FIN_PD.VED :=5;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=7;
l_FIN_PD.VNCRR :=2;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.175;
l_FIN_PD.K2 :=.18;
l_FIN_PD.VED :=5;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=7;
l_FIN_PD.VNCRR :=3;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.18;
l_FIN_PD.K2 :=.185;
l_FIN_PD.VED :=5;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=7;
l_FIN_PD.VNCRR :=11;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.185;
l_FIN_PD.K2 :=.19;
l_FIN_PD.VED :=5;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=7;
l_FIN_PD.VNCRR :=12;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.19;
l_FIN_PD.K2 :=.195;
l_FIN_PD.VED :=5;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=7;
l_FIN_PD.VNCRR :=13;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.195;
l_FIN_PD.K2 :=.2;
l_FIN_PD.VED :=5;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=7;
l_FIN_PD.VNCRR :=21;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.2;
l_FIN_PD.K2 :=.206;
l_FIN_PD.VED :=5;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=7;
l_FIN_PD.VNCRR :=22;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.206;
l_FIN_PD.K2 :=.212;
l_FIN_PD.VED :=5;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=7;
l_FIN_PD.VNCRR :=23;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.212;
l_FIN_PD.K2 :=.218;
l_FIN_PD.VED :=5;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=7;
l_FIN_PD.VNCRR :=31;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.218;
l_FIN_PD.K2 :=.224;
l_FIN_PD.VED :=5;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=7;
l_FIN_PD.VNCRR :=32;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.224;
l_FIN_PD.K2 :=.23;
l_FIN_PD.VED :=5;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=7;
l_FIN_PD.VNCRR :=33;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=5;
l_FIN_PD.IP5 :=3;
l_FIN_PD.K :=.23;
l_FIN_PD.K2 :=.23;
l_FIN_PD.VED :=5;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=8;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.24;
l_FIN_PD.K2 :=.248;
l_FIN_PD.VED :=5;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=8;
l_FIN_PD.VNCRR :=2;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.248;
l_FIN_PD.K2 :=.255;
l_FIN_PD.VED :=5;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=8;
l_FIN_PD.VNCRR :=3;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.255;
l_FIN_PD.K2 :=.263;
l_FIN_PD.VED :=5;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=8;
l_FIN_PD.VNCRR :=11;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.263;
l_FIN_PD.K2 :=.27;
l_FIN_PD.VED :=5;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=8;
l_FIN_PD.VNCRR :=12;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.27;
l_FIN_PD.K2 :=.278;
l_FIN_PD.VED :=5;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=8;
l_FIN_PD.VNCRR :=13;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.278;
l_FIN_PD.K2 :=.285;
l_FIN_PD.VED :=5;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=8;
l_FIN_PD.VNCRR :=21;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.285;
l_FIN_PD.K2 :=.294;
l_FIN_PD.VED :=5;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=8;
l_FIN_PD.VNCRR :=22;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.294;
l_FIN_PD.K2 :=.303;
l_FIN_PD.VED :=5;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=8;
l_FIN_PD.VNCRR :=23;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.303;
l_FIN_PD.K2 :=.312;
l_FIN_PD.VED :=5;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=8;
l_FIN_PD.VNCRR :=31;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.312;
l_FIN_PD.K2 :=.321;
l_FIN_PD.VED :=5;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=8;
l_FIN_PD.VNCRR :=32;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.321;
l_FIN_PD.K2 :=.33;
l_FIN_PD.VED :=5;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=8;
l_FIN_PD.VNCRR :=33;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=5;
l_FIN_PD.IP5 :=3;
l_FIN_PD.K :=.33;
l_FIN_PD.K2 :=.33;
l_FIN_PD.VED :=5;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=9;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.34;
l_FIN_PD.K2 :=.394;
l_FIN_PD.VED :=5;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=9;
l_FIN_PD.VNCRR :=2;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.394;
l_FIN_PD.K2 :=.448;
l_FIN_PD.VED :=5;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=9;
l_FIN_PD.VNCRR :=3;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.448;
l_FIN_PD.K2 :=.503;
l_FIN_PD.VED :=5;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=9;
l_FIN_PD.VNCRR :=11;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.503;
l_FIN_PD.K2 :=.557;
l_FIN_PD.VED :=5;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=9;
l_FIN_PD.VNCRR :=12;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.557;
l_FIN_PD.K2 :=.611;
l_FIN_PD.VED :=5;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=9;
l_FIN_PD.VNCRR :=13;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.611;
l_FIN_PD.K2 :=.665;
l_FIN_PD.VED :=5;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=9;
l_FIN_PD.VNCRR :=21;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.665;
l_FIN_PD.K2 :=.73;
l_FIN_PD.VED :=5;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=9;
l_FIN_PD.VNCRR :=22;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.73;
l_FIN_PD.K2 :=.795;
l_FIN_PD.VED :=5;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=9;
l_FIN_PD.VNCRR :=23;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.795;
l_FIN_PD.K2 :=.86;
l_FIN_PD.VED :=5;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=9;
l_FIN_PD.VNCRR :=31;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.86;
l_FIN_PD.K2 :=.925;
l_FIN_PD.VED :=5;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=9;
l_FIN_PD.VNCRR :=32;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.925;
l_FIN_PD.K2 :=.99;
l_FIN_PD.VED :=5;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=9;
l_FIN_PD.VNCRR :=33;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=5;
l_FIN_PD.IP5 :=3;
l_FIN_PD.K :=.99;
l_FIN_PD.K2 :=.99;
l_FIN_PD.VED :=5;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=10;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=5;
l_FIN_PD.IP5 :=3;
l_FIN_PD.K :=1;
l_FIN_PD.K2 :=1;
l_FIN_PD.VED :=5;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=3;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=1;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.006;
l_FIN_PD.K2 :=.007;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=11;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=1;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.007;
l_FIN_PD.K2 :=.008;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=13;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=5;
l_FIN_PD.IP5 :=3;
l_FIN_PD.K :=.009;
l_FIN_PD.K2 :=.009;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=1;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.01;
l_FIN_PD.K2 :=.012;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=12;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=1;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.015;
l_FIN_PD.K2 :=.017;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=13;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=1;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.017;
l_FIN_PD.K2 :=.019;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=2;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.02;
l_FIN_PD.K2 :=.023;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=12;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=2;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.023;
l_FIN_PD.K2 :=.025;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=13;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=2;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.025;
l_FIN_PD.K2 :=.028;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=22;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=5;
l_FIN_PD.IP5 :=3;
l_FIN_PD.K :=.03;
l_FIN_PD.K2 :=.03;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=2;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.04;
l_FIN_PD.K2 :=.045;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=21;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=2;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.05;
l_FIN_PD.K2 :=.055;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=22;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=2;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.055;
l_FIN_PD.K2 :=.06;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=5;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.07;
l_FIN_PD.K2 :=.078;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=5;
l_FIN_PD.VNCRR :=13;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.078;
l_FIN_PD.K2 :=.085;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=5;
l_FIN_PD.VNCRR :=22;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.093;
l_FIN_PD.K2 :=.1;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=5;
l_FIN_PD.VNCRR :=23;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=5;
l_FIN_PD.IP5 :=3;
l_FIN_PD.K :=.1;
l_FIN_PD.K2 :=.1;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=6;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.11;
l_FIN_PD.K2 :=.125;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=6;
l_FIN_PD.VNCRR :=22;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.14;
l_FIN_PD.K2 :=.155;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=6;
l_FIN_PD.VNCRR :=23;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.155;
l_FIN_PD.K2 :=.17;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=7;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.18;
l_FIN_PD.K2 :=.215;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=7;
l_FIN_PD.VNCRR :=21;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.215;
l_FIN_PD.K2 :=.25;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=7;
l_FIN_PD.VNCRR :=23;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.285;
l_FIN_PD.K2 :=.32;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=7;
l_FIN_PD.VNCRR :=31;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=5;
l_FIN_PD.IP5 :=3;
l_FIN_PD.K :=.32;
l_FIN_PD.K2 :=.32;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=8;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.33;
l_FIN_PD.K2 :=.395;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=8;
l_FIN_PD.VNCRR :=23;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.46;
l_FIN_PD.K2 :=.525;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=8;
l_FIN_PD.VNCRR :=31;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.525;
l_FIN_PD.K2 :=.59;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=9;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.6;
l_FIN_PD.K2 :=.698;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=9;
l_FIN_PD.VNCRR :=23;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.698;
l_FIN_PD.K2 :=.795;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=9;
l_FIN_PD.VNCRR :=33;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=5;
l_FIN_PD.IP5 :=3;
l_FIN_PD.K :=.99;
l_FIN_PD.K2 :=.99;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=1;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.005;
l_FIN_PD.K2 :=.006;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=12;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=1;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.008;
l_FIN_PD.K2 :=.009;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=11;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=1;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.012;
l_FIN_PD.K2 :=.015;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=21;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=5;
l_FIN_PD.IP5 :=3;
l_FIN_PD.K :=.019;
l_FIN_PD.K2 :=.019;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=21;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=2;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.028;
l_FIN_PD.K2 :=.03;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=13;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=2;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.045;
l_FIN_PD.K2 :=.05;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=23;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=5;
l_FIN_PD.IP5 :=3;
l_FIN_PD.K :=.06;
l_FIN_PD.K2 :=.06;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=5;
l_FIN_PD.VNCRR :=21;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=1;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=1;
l_FIN_PD.K :=.085;
l_FIN_PD.K2 :=.093;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=6;
l_FIN_PD.VNCRR :=21;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.125;
l_FIN_PD.K2 :=.14;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=6;
l_FIN_PD.VNCRR :=31;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=5;
l_FIN_PD.IP5 :=3;
l_FIN_PD.K :=.17;
l_FIN_PD.K2 :=.17;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=7;
l_FIN_PD.VNCRR :=22;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=3;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.25;
l_FIN_PD.K2 :=.285;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=8;
l_FIN_PD.VNCRR :=22;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=2;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.395;
l_FIN_PD.K2 :=.46;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=8;
l_FIN_PD.VNCRR :=32;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=5;
l_FIN_PD.IP5 :=3;
l_FIN_PD.K :=.59;
l_FIN_PD.K2 :=.59;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=9;
l_FIN_PD.VNCRR :=31;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.795;
l_FIN_PD.K2 :=.893;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=10;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=5;
l_FIN_PD.IP5 :=3;
l_FIN_PD.K :=1;
l_FIN_PD.K2 :=1;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=50;
l_FIN_PD.FIN :=9;
l_FIN_PD.VNCRR :=32;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=3;
l_FIN_PD.IP4 :=4;
l_FIN_PD.IP5 :=2;
l_FIN_PD.K :=.893;
l_FIN_PD.K2 :=.99;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=60;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.005;
l_FIN_PD.K2 :=.039;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=60;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=3;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.039;
l_FIN_PD.K2 :=.073;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=60;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=11;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.073;
l_FIN_PD.K2 :=.106;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=60;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=12;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.106;
l_FIN_PD.K2 :=.14;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=60;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=13;
l_FIN_PD.IP1 :=4;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.14;
l_FIN_PD.K2 :=.14;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=60;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.15;
l_FIN_PD.K2 :=.203;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=60;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=11;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.203;
l_FIN_PD.K2 :=.255;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=60;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=12;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.255;
l_FIN_PD.K2 :=.308;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=60;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=13;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.308;
l_FIN_PD.K2 :=.36;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=60;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=21;
l_FIN_PD.IP1 :=4;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.36;
l_FIN_PD.K2 :=.36;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=60;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.37;
l_FIN_PD.K2 :=.438;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=60;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=12;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.438;
l_FIN_PD.K2 :=.505;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=60;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=13;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.505;
l_FIN_PD.K2 :=.573;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=60;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=21;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.573;
l_FIN_PD.K2 :=.64;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=60;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=22;
l_FIN_PD.IP1 :=4;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.64;
l_FIN_PD.K2 :=.64;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=60;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.65;
l_FIN_PD.K2 :=.735;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=60;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=22;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.735;
l_FIN_PD.K2 :=.82;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=60;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=23;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.82;
l_FIN_PD.K2 :=.905;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=60;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=31;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.905;
l_FIN_PD.K2 :=.99;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=60;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=32;
l_FIN_PD.IP1 :=4;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.99;
l_FIN_PD.K2 :=.99;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=60;
l_FIN_PD.FIN :=5;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=4;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=1;
l_FIN_PD.K2 :=1;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=60;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.005;
l_FIN_PD.K2 :=.039;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=60;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=11;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.073;
l_FIN_PD.K2 :=.106;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=60;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=13;
l_FIN_PD.IP1 :=4;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.14;
l_FIN_PD.K2 :=.14;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=60;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=12;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.255;
l_FIN_PD.K2 :=.308;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=60;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=21;
l_FIN_PD.IP1 :=4;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.36;
l_FIN_PD.K2 :=.36;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=60;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=13;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.505;
l_FIN_PD.K2 :=.573;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=60;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=21;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.573;
l_FIN_PD.K2 :=.64;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=60;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=23;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.82;
l_FIN_PD.K2 :=.905;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=60;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=31;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.905;
l_FIN_PD.K2 :=.99;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=60;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=12;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.106;
l_FIN_PD.K2 :=.14;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=60;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.15;
l_FIN_PD.K2 :=.203;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=60;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=13;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.308;
l_FIN_PD.K2 :=.36;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=60;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=12;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.438;
l_FIN_PD.K2 :=.505;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=60;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=22;
l_FIN_PD.IP1 :=4;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.64;
l_FIN_PD.K2 :=.64;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=60;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=22;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.735;
l_FIN_PD.K2 :=.82;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=60;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=32;
l_FIN_PD.IP1 :=4;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.99;
l_FIN_PD.K2 :=.99;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=60;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=3;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.039;
l_FIN_PD.K2 :=.073;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=60;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=11;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.203;
l_FIN_PD.K2 :=.255;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=60;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.37;
l_FIN_PD.K2 :=.438;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=60;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.65;
l_FIN_PD.K2 :=.735;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=60;
l_FIN_PD.FIN :=5;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=4;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=1;
l_FIN_PD.K2 :=1;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=61;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.005;
l_FIN_PD.K2 :=.034;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=61;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=3;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.034;
l_FIN_PD.K2 :=.063;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=61;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=11;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.063;
l_FIN_PD.K2 :=.091;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=61;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=12;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.091;
l_FIN_PD.K2 :=.12;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=61;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=13;
l_FIN_PD.IP1 :=4;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.12;
l_FIN_PD.K2 :=.12;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=61;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.13;
l_FIN_PD.K2 :=.178;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=61;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=11;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.178;
l_FIN_PD.K2 :=.225;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=61;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=12;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.225;
l_FIN_PD.K2 :=.273;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=61;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=13;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.273;
l_FIN_PD.K2 :=.32;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=61;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=21;
l_FIN_PD.IP1 :=4;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.32;
l_FIN_PD.K2 :=.32;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=61;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.33;
l_FIN_PD.K2 :=.403;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=61;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=12;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.403;
l_FIN_PD.K2 :=.475;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=61;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=13;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.475;
l_FIN_PD.K2 :=.548;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=61;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=21;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.548;
l_FIN_PD.K2 :=.62;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=61;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=22;
l_FIN_PD.IP1 :=4;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.62;
l_FIN_PD.K2 :=.62;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=61;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.63;
l_FIN_PD.K2 :=.72;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=61;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=22;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.72;
l_FIN_PD.K2 :=.81;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=61;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=23;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.81;
l_FIN_PD.K2 :=.9;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=61;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=31;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.9;
l_FIN_PD.K2 :=.99;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=61;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=32;
l_FIN_PD.IP1 :=4;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.99;
l_FIN_PD.K2 :=.99;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=61;
l_FIN_PD.FIN :=5;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=4;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=1;
l_FIN_PD.K2 :=1;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=61;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.005;
l_FIN_PD.K2 :=.034;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=61;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=11;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.063;
l_FIN_PD.K2 :=.091;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=61;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.13;
l_FIN_PD.K2 :=.178;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=61;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=12;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.225;
l_FIN_PD.K2 :=.273;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=61;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.33;
l_FIN_PD.K2 :=.403;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=61;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=12;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.403;
l_FIN_PD.K2 :=.475;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=61;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.63;
l_FIN_PD.K2 :=.72;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=61;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=31;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.9;
l_FIN_PD.K2 :=.99;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=61;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=32;
l_FIN_PD.IP1 :=4;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.99;
l_FIN_PD.K2 :=.99;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=61;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=3;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.034;
l_FIN_PD.K2 :=.063;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=61;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=12;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.091;
l_FIN_PD.K2 :=.12;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=61;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=11;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.178;
l_FIN_PD.K2 :=.225;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=61;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=21;
l_FIN_PD.IP1 :=4;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.32;
l_FIN_PD.K2 :=.32;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=61;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=13;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.475;
l_FIN_PD.K2 :=.548;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=61;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=22;
l_FIN_PD.IP1 :=4;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.62;
l_FIN_PD.K2 :=.62;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=61;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=23;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.81;
l_FIN_PD.K2 :=.9;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=61;
l_FIN_PD.FIN :=5;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=4;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=1;
l_FIN_PD.K2 :=1;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=61;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=13;
l_FIN_PD.IP1 :=4;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.12;
l_FIN_PD.K2 :=.12;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=61;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=13;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.273;
l_FIN_PD.K2 :=.32;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=61;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=21;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.548;
l_FIN_PD.K2 :=.62;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=61;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=22;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.72;
l_FIN_PD.K2 :=.81;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=62;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=13;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.15;
l_FIN_PD.K2 :=.15;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=62;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.16;
l_FIN_PD.K2 :=.22;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=62;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=11;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.22;
l_FIN_PD.K2 :=.28;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=62;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=12;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.28;
l_FIN_PD.K2 :=.34;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=62;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=13;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.34;
l_FIN_PD.K2 :=.4;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=62;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=21;
l_FIN_PD.IP1 :=4;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.4;
l_FIN_PD.K2 :=.4;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=62;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.41;
l_FIN_PD.K2 :=.498;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=62;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=12;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.498;
l_FIN_PD.K2 :=.585;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=62;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=13;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.585;
l_FIN_PD.K2 :=.673;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=62;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=21;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.673;
l_FIN_PD.K2 :=.76;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=62;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=22;
l_FIN_PD.IP1 :=4;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.76;
l_FIN_PD.K2 :=.76;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=62;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.77;
l_FIN_PD.K2 :=.825;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=62;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=22;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.825;
l_FIN_PD.K2 :=.88;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=62;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=23;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.88;
l_FIN_PD.K2 :=.935;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=62;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=31;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.935;
l_FIN_PD.K2 :=.99;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=62;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=32;
l_FIN_PD.IP1 :=4;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.99;
l_FIN_PD.K2 :=.99;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=62;
l_FIN_PD.FIN :=5;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=4;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=1;
l_FIN_PD.K2 :=1;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=62;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.005;
l_FIN_PD.K2 :=.041;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=62;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=3;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.041;
l_FIN_PD.K2 :=.078;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=62;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=11;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.078;
l_FIN_PD.K2 :=.114;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=62;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=12;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.114;
l_FIN_PD.K2 :=.15;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=62;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=13;
l_FIN_PD.IP1 :=4;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.15;
l_FIN_PD.K2 :=.15;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=62;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.16;
l_FIN_PD.K2 :=.218;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=62;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=11;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.218;
l_FIN_PD.K2 :=.275;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=62;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=12;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.275;
l_FIN_PD.K2 :=.338;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=62;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=13;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.338;
l_FIN_PD.K2 :=.4;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=62;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=21;
l_FIN_PD.IP1 :=4;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.4;
l_FIN_PD.K2 :=.4;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=62;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.41;
l_FIN_PD.K2 :=.498;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=62;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=12;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.498;
l_FIN_PD.K2 :=.585;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=62;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=13;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.585;
l_FIN_PD.K2 :=.673;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=62;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=21;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.673;
l_FIN_PD.K2 :=.76;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=62;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=22;
l_FIN_PD.IP1 :=4;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.76;
l_FIN_PD.K2 :=.76;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=62;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.77;
l_FIN_PD.K2 :=.825;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=62;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=22;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.825;
l_FIN_PD.K2 :=.88;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=62;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=23;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.88;
l_FIN_PD.K2 :=.935;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=62;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=31;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.935;
l_FIN_PD.K2 :=.99;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=62;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=32;
l_FIN_PD.IP1 :=4;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.99;
l_FIN_PD.K2 :=.99;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=62;
l_FIN_PD.FIN :=5;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=4;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=1;
l_FIN_PD.K2 :=1;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=62;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=11;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.078;
l_FIN_PD.K2 :=.114;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=62;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=3;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.041;
l_FIN_PD.K2 :=.078;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=62;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.005;
l_FIN_PD.K2 :=.041;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=62;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=12;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.114;
l_FIN_PD.K2 :=.15;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=63;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.005;
l_FIN_PD.K2 :=.044;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=63;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=3;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.044;
l_FIN_PD.K2 :=.083;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=63;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=11;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.083;
l_FIN_PD.K2 :=.121;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=63;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=12;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.121;
l_FIN_PD.K2 :=.16;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=63;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=13;
l_FIN_PD.IP1 :=4;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.16;
l_FIN_PD.K2 :=.16;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=63;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.17;
l_FIN_PD.K2 :=.228;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=63;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=11;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.228;
l_FIN_PD.K2 :=.285;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=63;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=12;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.285;
l_FIN_PD.K2 :=.343;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=63;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=13;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.343;
l_FIN_PD.K2 :=.4;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=63;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=21;
l_FIN_PD.IP1 :=4;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.4;
l_FIN_PD.K2 :=.4;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=63;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.41;
l_FIN_PD.K2 :=.488;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=63;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=12;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.483;
l_FIN_PD.K2 :=.555;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=63;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=13;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.555;
l_FIN_PD.K2 :=.628;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=63;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=21;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.628;
l_FIN_PD.K2 :=.7;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=63;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=22;
l_FIN_PD.IP1 :=4;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.7;
l_FIN_PD.K2 :=.7;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=63;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.71;
l_FIN_PD.K2 :=.78;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=63;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=22;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.78;
l_FIN_PD.K2 :=.85;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=63;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=23;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.85;
l_FIN_PD.K2 :=.92;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=63;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=31;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.92;
l_FIN_PD.K2 :=.99;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=63;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=32;
l_FIN_PD.IP1 :=4;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.99;
l_FIN_PD.K2 :=.99;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=63;
l_FIN_PD.FIN :=5;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=4;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=1;
l_FIN_PD.K2 :=1;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=63;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.005;
l_FIN_PD.K2 :=.044;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=63;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=3;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.044;
l_FIN_PD.K2 :=.083;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=63;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=11;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.083;
l_FIN_PD.K2 :=.121;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=63;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=12;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.121;
l_FIN_PD.K2 :=.16;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=63;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=13;
l_FIN_PD.IP1 :=4;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.16;
l_FIN_PD.K2 :=.16;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=63;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.17;
l_FIN_PD.K2 :=.228;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=63;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=11;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.228;
l_FIN_PD.K2 :=.275;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=63;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=12;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.275;
l_FIN_PD.K2 :=.343;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=63;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=13;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.343;
l_FIN_PD.K2 :=.4;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=63;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=21;
l_FIN_PD.IP1 :=4;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.4;
l_FIN_PD.K2 :=.4;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=63;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.41;
l_FIN_PD.K2 :=.483;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=63;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=12;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.483;
l_FIN_PD.K2 :=.555;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=63;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=13;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.555;
l_FIN_PD.K2 :=.628;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=63;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=21;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.628;
l_FIN_PD.K2 :=.7;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=63;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=22;
l_FIN_PD.IP1 :=4;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.7;
l_FIN_PD.K2 :=.7;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=63;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.71;
l_FIN_PD.K2 :=.78;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=63;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=22;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.78;
l_FIN_PD.K2 :=.85;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=63;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=23;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.85;
l_FIN_PD.K2 :=.92;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=63;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=31;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.92;
l_FIN_PD.K2 :=.99;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=63;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=32;
l_FIN_PD.IP1 :=4;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.99;
l_FIN_PD.K2 :=.99;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=63;
l_FIN_PD.FIN :=5;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=4;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=1;
l_FIN_PD.K2 :=1;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=64;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.005;
l_FIN_PD.K2 :=.036;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=64;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=3;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.036;
l_FIN_PD.K2 :=.068;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=64;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=11;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.068;
l_FIN_PD.K2 :=.099;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=64;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=12;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.099;
l_FIN_PD.K2 :=.13;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=64;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=13;
l_FIN_PD.IP1 :=4;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.13;
l_FIN_PD.K2 :=.13;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=64;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.14;
l_FIN_PD.K2 :=.193;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=64;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=11;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.193;
l_FIN_PD.K2 :=.245;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=64;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=12;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.245;
l_FIN_PD.K2 :=.298;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=64;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=13;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.298;
l_FIN_PD.K2 :=.35;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=64;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=21;
l_FIN_PD.IP1 :=4;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.35;
l_FIN_PD.K2 :=.35;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=64;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.36;
l_FIN_PD.K2 :=.44;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=64;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=12;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.44;
l_FIN_PD.K2 :=.52;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=64;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=13;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.52;
l_FIN_PD.K2 :=.6;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=64;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=21;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.6;
l_FIN_PD.K2 :=.68;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=64;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=22;
l_FIN_PD.IP1 :=4;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.68;
l_FIN_PD.K2 :=.68;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=64;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.69;
l_FIN_PD.K2 :=.765;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=64;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=22;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.765;
l_FIN_PD.K2 :=.84;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=64;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=23;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.84;
l_FIN_PD.K2 :=.915;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=64;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=31;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.915;
l_FIN_PD.K2 :=.99;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=64;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=32;
l_FIN_PD.IP1 :=4;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.99;
l_FIN_PD.K2 :=.99;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=64;
l_FIN_PD.FIN :=5;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=4;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=1;
l_FIN_PD.K2 :=1;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=64;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.005;
l_FIN_PD.K2 :=.036;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=64;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=3;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.036;
l_FIN_PD.K2 :=.068;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=64;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=11;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.068;
l_FIN_PD.K2 :=.099;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=64;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=12;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.099;
l_FIN_PD.K2 :=.13;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=64;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=13;
l_FIN_PD.IP1 :=4;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.13;
l_FIN_PD.K2 :=.13;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=64;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.14;
l_FIN_PD.K2 :=.193;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=64;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=11;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.193;
l_FIN_PD.K2 :=.245;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=64;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=12;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.245;
l_FIN_PD.K2 :=.298;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=64;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=13;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.298;
l_FIN_PD.K2 :=.35;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=64;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=21;
l_FIN_PD.IP1 :=4;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.35;
l_FIN_PD.K2 :=.35;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=64;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.36;
l_FIN_PD.K2 :=.44;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=64;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=12;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.44;
l_FIN_PD.K2 :=.52;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=64;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=13;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.52;
l_FIN_PD.K2 :=.6;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=64;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=21;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.6;
l_FIN_PD.K2 :=.68;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=64;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=22;
l_FIN_PD.IP1 :=4;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.68;
l_FIN_PD.K2 :=.68;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=64;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.69;
l_FIN_PD.K2 :=.765;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=64;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=22;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.765;
l_FIN_PD.K2 :=.84;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=64;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=23;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.84;
l_FIN_PD.K2 :=.915;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=64;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=31;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.915;
l_FIN_PD.K2 :=.99;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=64;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=32;
l_FIN_PD.IP1 :=4;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.99;
l_FIN_PD.K2 :=.99;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=64;
l_FIN_PD.FIN :=5;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=4;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=1;
l_FIN_PD.K2 :=1;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=65;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.005;
l_FIN_PD.K2 :=.046;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=65;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=3;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.046;
l_FIN_PD.K2 :=.088;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=65;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=11;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.088;
l_FIN_PD.K2 :=.129;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=65;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=12;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.129;
l_FIN_PD.K2 :=.17;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=65;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=13;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.17;
l_FIN_PD.K2 :=.17;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=65;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.18;
l_FIN_PD.K2 :=.245;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=65;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=11;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.245;
l_FIN_PD.K2 :=.31;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=65;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=12;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.31;
l_FIN_PD.K2 :=.375;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=65;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=13;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.375;
l_FIN_PD.K2 :=.44;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=65;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=21;
l_FIN_PD.IP1 :=4;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.44;
l_FIN_PD.K2 :=.44;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=65;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.45;
l_FIN_PD.K2 :=.538;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=65;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=12;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.538;
l_FIN_PD.K2 :=.625;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=65;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=13;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.625;
l_FIN_PD.K2 :=.713;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=65;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=21;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.713;
l_FIN_PD.K2 :=.8;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=65;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=22;
l_FIN_PD.IP1 :=4;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.8;
l_FIN_PD.K2 :=.8;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=65;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.81;
l_FIN_PD.K2 :=.855;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=65;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=22;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.855;
l_FIN_PD.K2 :=.9;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=65;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=23;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.9;
l_FIN_PD.K2 :=.945;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=65;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=31;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.945;
l_FIN_PD.K2 :=.99;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=65;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=32;
l_FIN_PD.IP1 :=4;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.99;
l_FIN_PD.K2 :=.99;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=65;
l_FIN_PD.FIN :=5;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=4;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=1;
l_FIN_PD.K2 :=1;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=65;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.005;
l_FIN_PD.K2 :=.046;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=65;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=3;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.046;
l_FIN_PD.K2 :=.088;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=65;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=11;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.088;
l_FIN_PD.K2 :=.129;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=65;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=12;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.129;
l_FIN_PD.K2 :=.17;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=65;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=13;
l_FIN_PD.IP1 :=4;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.17;
l_FIN_PD.K2 :=.17;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=65;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.18;
l_FIN_PD.K2 :=.245;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=65;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=11;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.245;
l_FIN_PD.K2 :=.31;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=65;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=12;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.31;
l_FIN_PD.K2 :=.375;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=65;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=13;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.375;
l_FIN_PD.K2 :=.44;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=65;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=21;
l_FIN_PD.IP1 :=4;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.44;
l_FIN_PD.K2 :=.44;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=65;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.45;
l_FIN_PD.K2 :=.538;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=65;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=12;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.538;
l_FIN_PD.K2 :=.625;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=65;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=13;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.625;
l_FIN_PD.K2 :=.713;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=65;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=21;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.713;
l_FIN_PD.K2 :=.8;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=65;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=22;
l_FIN_PD.IP1 :=4;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.8;
l_FIN_PD.K2 :=.8;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=65;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.81;
l_FIN_PD.K2 :=.855;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=65;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=22;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.855;
l_FIN_PD.K2 :=.9;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=65;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=23;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.9;
l_FIN_PD.K2 :=.945;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=65;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=31;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.945;
l_FIN_PD.K2 :=.99;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=65;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=32;
l_FIN_PD.IP1 :=4;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.99;
l_FIN_PD.K2 :=.99;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=65;
l_FIN_PD.FIN :=5;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=4;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=1;
l_FIN_PD.K2 :=1;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=70;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.01;
l_FIN_PD.K2 :=.018;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=70;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=3;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.018;
l_FIN_PD.K2 :=.025;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=70;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=11;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.025;
l_FIN_PD.K2 :=.033;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=70;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=12;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.033;
l_FIN_PD.K2 :=.04;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=70;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=13;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.04;
l_FIN_PD.K2 :=.04;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=70;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.05;
l_FIN_PD.K2 :=.073;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=70;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=11;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.073;
l_FIN_PD.K2 :=.095;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=70;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=12;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.095;
l_FIN_PD.K2 :=.118;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=70;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=13;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.118;
l_FIN_PD.K2 :=.14;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=70;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=21;
l_FIN_PD.IP1 :=4;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.14;
l_FIN_PD.K2 :=.14;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=70;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.15;
l_FIN_PD.K2 :=.235;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=70;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=12;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.235;
l_FIN_PD.K2 :=.32;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=70;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=13;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.32;
l_FIN_PD.K2 :=.405;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=70;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=21;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.405;
l_FIN_PD.K2 :=.49;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=70;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=22;
l_FIN_PD.IP1 :=4;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.49;
l_FIN_PD.K2 :=.49;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=70;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.5;
l_FIN_PD.K2 :=.623;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=70;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=22;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.623;
l_FIN_PD.K2 :=.745;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=70;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=23;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.745;
l_FIN_PD.K2 :=.868;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=70;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=31;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.868;
l_FIN_PD.K2 :=.99;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=70;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=32;
l_FIN_PD.IP1 :=4;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.99;
l_FIN_PD.K2 :=.99;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=70;
l_FIN_PD.FIN :=5;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=4;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=1;
l_FIN_PD.K2 :=1;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=70;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.01;
l_FIN_PD.K2 :=.018;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=70;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=3;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.018;
l_FIN_PD.K2 :=.025;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=70;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=11;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.025;
l_FIN_PD.K2 :=.033;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=70;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=12;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.033;
l_FIN_PD.K2 :=.04;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=70;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=13;
l_FIN_PD.IP1 :=4;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.04;
l_FIN_PD.K2 :=.04;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=70;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.05;
l_FIN_PD.K2 :=.073;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=70;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=11;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.073;
l_FIN_PD.K2 :=.095;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=70;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=12;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.095;
l_FIN_PD.K2 :=.118;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=70;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=13;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.118;
l_FIN_PD.K2 :=.14;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=70;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=21;
l_FIN_PD.IP1 :=4;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.14;
l_FIN_PD.K2 :=.14;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=70;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.15;
l_FIN_PD.K2 :=.235;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=70;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=12;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.235;
l_FIN_PD.K2 :=.32;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=70;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=13;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.32;
l_FIN_PD.K2 :=.405;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=70;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=21;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.405;
l_FIN_PD.K2 :=.49;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=70;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=22;
l_FIN_PD.IP1 :=4;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.49;
l_FIN_PD.K2 :=.49;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=70;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.5;
l_FIN_PD.K2 :=.623;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=70;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=22;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.623;
l_FIN_PD.K2 :=.745;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=70;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=23;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.745;
l_FIN_PD.K2 :=.868;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=70;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=31;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.868;
l_FIN_PD.K2 :=.99;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=70;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=32;
l_FIN_PD.IP1 :=4;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.99;
l_FIN_PD.K2 :=.99;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=70;
l_FIN_PD.FIN :=5;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=4;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=1;
l_FIN_PD.K2 :=1;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=80;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.005;
l_FIN_PD.K2 :=.034;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=80;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=3;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.034;
l_FIN_PD.K2 :=.063;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=80;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=11;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.063;
l_FIN_PD.K2 :=.091;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=80;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=12;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.091;
l_FIN_PD.K2 :=.12;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=80;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=13;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.12;
l_FIN_PD.K2 :=.12;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=80;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.13;
l_FIN_PD.K2 :=.15;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=80;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=11;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.15;
l_FIN_PD.K2 :=.17;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=80;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=12;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.17;
l_FIN_PD.K2 :=.19;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=80;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=13;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.19;
l_FIN_PD.K2 :=.21;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=80;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=21;
l_FIN_PD.IP1 :=4;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.21;
l_FIN_PD.K2 :=.21;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=80;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.22;
l_FIN_PD.K2 :=.255;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=80;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=12;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.255;
l_FIN_PD.K2 :=.29;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=80;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=13;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.29;
l_FIN_PD.K2 :=.325;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=80;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=21;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.325;
l_FIN_PD.K2 :=.36;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=80;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=22;
l_FIN_PD.IP1 :=4;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.36;
l_FIN_PD.K2 :=.36;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=80;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.37;
l_FIN_PD.K2 :=.525;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=80;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=22;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.525;
l_FIN_PD.K2 :=.68;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=80;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=23;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.68;
l_FIN_PD.K2 :=.835;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=80;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=31;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.835;
l_FIN_PD.K2 :=.99;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=80;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=32;
l_FIN_PD.IP1 :=4;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.99;
l_FIN_PD.K2 :=.99;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=80;
l_FIN_PD.FIN :=5;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=4;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=1;
l_FIN_PD.K2 :=1;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=80;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.005;
l_FIN_PD.K2 :=.034;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=80;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=3;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.034;
l_FIN_PD.K2 :=.063;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=80;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=11;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.063;
l_FIN_PD.K2 :=.091;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=80;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=12;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.091;
l_FIN_PD.K2 :=.12;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=80;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=13;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.12;
l_FIN_PD.K2 :=.12;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=80;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.13;
l_FIN_PD.K2 :=.15;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=80;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=11;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.15;
l_FIN_PD.K2 :=.17;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=80;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=12;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.17;
l_FIN_PD.K2 :=.19;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=80;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=13;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.19;
l_FIN_PD.K2 :=.21;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=80;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=21;
l_FIN_PD.IP1 :=4;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.21;
l_FIN_PD.K2 :=.21;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=80;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.22;
l_FIN_PD.K2 :=.255;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=80;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=12;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.255;
l_FIN_PD.K2 :=.29;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=80;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=13;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.29;
l_FIN_PD.K2 :=.325;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=80;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=21;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.325;
l_FIN_PD.K2 :=.36;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=80;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=22;
l_FIN_PD.IP1 :=4;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.36;
l_FIN_PD.K2 :=.36;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=80;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.37;
l_FIN_PD.K2 :=.525;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=80;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=22;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.525;
l_FIN_PD.K2 :=.68;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=80;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=23;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.68;
l_FIN_PD.K2 :=.835;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=80;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=31;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.835;
l_FIN_PD.K2 :=.99;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=80;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=32;
l_FIN_PD.IP1 :=4;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.99;
l_FIN_PD.K2 :=.99;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=80;
l_FIN_PD.FIN :=5;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=4;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=1;
l_FIN_PD.K2 :=1;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=81;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.0015;
l_FIN_PD.K2 :=.0017;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=81;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=3;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.0017;
l_FIN_PD.K2 :=.002;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=81;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=11;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.002;
l_FIN_PD.K2 :=.0022;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=81;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=12;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.0022;
l_FIN_PD.K2 :=.0024;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=81;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=13;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.0024;
l_FIN_PD.K2 :=.0024;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=81;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.0025;
l_FIN_PD.K2 :=.0141;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=81;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=11;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.0141;
l_FIN_PD.K2 :=.0258;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=81;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=12;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.0258;
l_FIN_PD.K2 :=.0374;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=81;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=13;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.0374;
l_FIN_PD.K2 :=.049;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=81;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=21;
l_FIN_PD.IP1 :=4;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.049;
l_FIN_PD.K2 :=.049;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=81;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.05;
l_FIN_PD.K2 :=.235;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=81;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=12;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.235;
l_FIN_PD.K2 :=.42;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=81;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=13;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.42;
l_FIN_PD.K2 :=.605;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=81;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=21;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.605;
l_FIN_PD.K2 :=.79;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=81;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=22;
l_FIN_PD.IP1 :=4;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.79;
l_FIN_PD.K2 :=.79;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=81;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.8;
l_FIN_PD.K2 :=.8475;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=81;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=22;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.8475;
l_FIN_PD.K2 :=.895;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=81;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=23;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.895;
l_FIN_PD.K2 :=.9425;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=81;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=31;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.9425;
l_FIN_PD.K2 :=.99;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=81;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=32;
l_FIN_PD.IP1 :=4;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.99;
l_FIN_PD.K2 :=.99;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=81;
l_FIN_PD.FIN :=5;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=4;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=1;
l_FIN_PD.K2 :=1;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_16';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=81;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.0015;
l_FIN_PD.K2 :=.0017;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=81;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=3;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.0017;
l_FIN_PD.K2 :=.002;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=81;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=11;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.002;
l_FIN_PD.K2 :=.0022;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=81;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=12;
l_FIN_PD.IP1 :=1;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.0022;
l_FIN_PD.K2 :=.0024;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=81;
l_FIN_PD.FIN :=1;
l_FIN_PD.VNCRR :=13;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.0024;
l_FIN_PD.K2 :=.0024;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=81;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.0025;
l_FIN_PD.K2 :=.0141;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=81;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=11;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.0141;
l_FIN_PD.K2 :=.0258;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=81;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=12;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.0258;
l_FIN_PD.K2 :=.0374;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=81;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=13;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=1;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.0374;
l_FIN_PD.K2 :=.049;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=81;
l_FIN_PD.FIN :=2;
l_FIN_PD.VNCRR :=21;
l_FIN_PD.IP1 :=4;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.049;
l_FIN_PD.K2 :=.049;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=81;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.05;
l_FIN_PD.K2 :=.235;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=81;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=12;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.235;
l_FIN_PD.K2 :=.42;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=81;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=13;
l_FIN_PD.IP1 :=2;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.42;
l_FIN_PD.K2 :=.605;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=81;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=21;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.605;
l_FIN_PD.K2 :=.79;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=81;
l_FIN_PD.FIN :=3;
l_FIN_PD.VNCRR :=22;
l_FIN_PD.IP1 :=4;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.79;
l_FIN_PD.K2 :=.79;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=81;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.8;
l_FIN_PD.K2 :=.8475;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=81;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=22;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.8475;
l_FIN_PD.K2 :=.895;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=81;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=23;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.895;
l_FIN_PD.K2 :=.9425;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=81;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=31;
l_FIN_PD.IP1 :=3;
l_FIN_PD.IP2 :=2;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.9425;
l_FIN_PD.K2 :=.99;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=81;
l_FIN_PD.FIN :=4;
l_FIN_PD.VNCRR :=32;
l_FIN_PD.IP1 :=4;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=.99;
l_FIN_PD.K2 :=.99;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


l_FIN_PD.IDF :=81;
l_FIN_PD.FIN :=5;
l_FIN_PD.VNCRR :=1;
l_FIN_PD.IP1 :=4;
l_FIN_PD.IP2 :=3;
l_FIN_PD.IP3 :=null;
l_FIN_PD.IP4 :=null;
l_FIN_PD.IP5 :=null;
l_FIN_PD.K :=1;
l_FIN_PD.K2 :=1;
l_FIN_PD.VED :=0;
l_FIN_PD.ALG :='FIN_351_18';

 p_merge( l_FIN_PD);


commit;
END;
/


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Data/patch_data_FIN_PD.sql =========*** End 
PROMPT ===================================================================================== 
